#!/bin/bash
# ====================================================
#  Rclone PikPak 挂载脚本（优化版）
#  功能：自动刷新目录、流畅播放、安全缓存
#  适用场景：日常观影、文件管理、自动同步
#
#  ▸ 使用方式
#    手动挂载（后台守护进程，脚本立即返回）：
#      bash mount.sh
#    开机自启（推荐，由 systemd 托管）：
#      systemctl enable --now rclone-pikpak   # 启用并立即启动
#      systemctl status rclone-pikpak          # 查看状态
#      systemctl restart rclone-pikpak         # 重启
#      systemctl stop rclone-pikpak            # 停止
#      journalctl -u rclone-pikpak -f          # 查看服务日志
#
#  ▸ 自启动说明
#    - 由 systemd 服务 rclone-pikpak.service 托管（/etc/systemd/system/），
#      开机自动挂载；进程异常退出时按 Restart=on-failure 自动拉起。
#    - 脚本靠 systemd 自动注入的环境变量 INVOCATION_ID 区分运行方式：
#      systemd 启动 → rclone 以【前台】方式运行（服务主进程存活，才能被
#      检测与拉起）；手动执行 → 自动追加 --daemon 转后台守护进程。
#    - OOMScoreAdjust=-500：本机仅 1.6G 内存，内存耗尽触发 OOM killer 时
#      rclone 的分数低于一般进程，优先存活（2026-08-03 曾因 OOM 被杀，
#      且重启后无自启动导致挂载长时间缺失）。
#    - 死挂载清理：进程被强杀(SIGKILL)可能残留 "Transport endpoint is not
#      connected" 的死挂载，阻塞下次挂载；rclone 1.73 无 --auto-unmount，
#      由服务单元 ExecStartPre 在每次启动前 fusermount3 -u 清理兜底。
#
#  ▸ 日志：$HOME/rclone_pikpak.log（tail -f 实时查看）
# ====================================================

# 挂载源和目标（systemd 服务环境下 $HOME 为空，用 ${HOME:-/root} 兜底）
REMOTE="pik:"                # PikPak 远程名称（请确保已配置）
MOUNT_POINT="${HOME:-/root}/pik"      # 本地挂载目录
LOG_FILE="${HOME:-/root}/rclone_pikpak.log"   # 日志路径

# 创建挂载点（如果不存在）；残留死挂载会导致 mkdir 报 ENOTCONN，
# 忽略该错误，交给 rclone 报真正的错误
mkdir -p "$MOUNT_POINT" 2>/dev/null || true

# 运行模式：systemd 启动 → 前台（服务主进程，可被 Restart 拉起）；
# 手动执行 → --daemon 后台守护进程（脚本立即返回）
DAEMON_OPTS=()
if [ -n "$INVOCATION_ID" ]; then
    echo "systemd 环境（INVOCATION_ID=$INVOCATION_ID），以前台方式运行 rclone"
else
    DAEMON_OPTS=(--daemon)                  # 后台守护进程运行
fi

# 构建 rclone 参数数组（每行一个参数，末尾带注释）
OPTS=(
    # ---------- 缓存模式 ----------
    --vfs-cache-mode full               # 全缓存模式：本地缓存完整文件，读性能最佳
    --vfs-cache-max-size 10G            # 缓存目录最大占用 10GB，防止磁盘爆满
    --vfs-cache-max-age 12h             # 缓存文件最长保留 48 小时，自动清理旧块

    # ---------- 读取优化 ----------
    --vfs-read-chunk-size 32M           # 每次请求的块大小（32MB），平衡首帧延迟
    --vfs-read-chunk-size-limit 1G      # 单次顺序预读上限 1GB，防止拖动进度条时无限下载
    --vfs-read-ahead 256M               # 预读缓冲区 256MB，提升连续播放流畅度
    --buffer-size 128M                  # 内存传输缓冲区 128MB，加速大文件拷贝

    # ---------- 目录刷新（核心） ----------
    --dir-cache-time 5m                 # 目录列表缓存 5 分钟，自动过期后重新拉取
    --poll-interval 30s                 # 每 30 秒轮询远端变更，配合缓存时间实现自动刷新
    --attr-timeout 1s                   # 文件属性（大小/修改时间）缓存仅 1 秒，`ls` 能立即看到最新信息

    # ---------- 权限与后台 ----------
    --allow-other                       # 允许系统其他用户（如 SMB/Docker）访问挂载点
    --umask 000                         # 挂载目录权限为 777，读写无限制
    "${DAEMON_OPTS[@]}"                 # 手动: --daemon 后台运行；systemd: 前台运行

    # ---------- 日志 ----------
    --log-file "$LOG_FILE"              # 日志保存路径
    --log-level INFO                    # 日志等级（INFO/WARNING/ERROR/DEBUG）
)

# 执行挂载命令（注意：数组展开时每个元素视为独立参数）
rclone mount "$REMOTE" "$MOUNT_POINT" "${OPTS[@]}"

# 检查挂载是否成功（前台模式下 rclone 持续运行，直到被卸载/停止服务）
if [ $? -eq 0 ]; then
    echo "✅ PikPak 已成功挂载到 $MOUNT_POINT"
    echo "📁 目录缓存时间为 5 分钟，文件变动将在 5 分钟内自动显示"
    echo "🔍 查看实时日志：tail -f $LOG_FILE"
else
    echo "❌ 挂载失败，请检查日志：$LOG_FILE"
fi
