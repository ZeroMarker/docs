# Flatpak 与 Flathub

Flatpak 是 Linux 桌面应用的沙箱化打包格式，Flathub 是目前最大的 Flatpak 应用仓库。二者关系类似「包格式 + 应用商店」：Flatpak 负责运行环境、依赖共享与隔离，Flathub 负责应用索引、运行时和下载源。

本文核对日期：2026-11-17。命令以 Flatpak 1.14 及以上版本为准；发行版仓库、镜像地址与应用 ID 可能变化，操作前请对照官方文档。相关笔记：[Unix 包管理器](unix.md)、[包管理器总览](../README.md)。

## 适用场景

Flatpak 主要面向桌面 GUI 应用，适合以下情况：

- 需要较新版本的应用，而发行版仓库版本偏旧。
- 希望应用与系统库隔离，避免依赖冲突。
- 同一应用需要 stable / beta 多分支并存。

不适合的场景：服务器、容器基础镜像、需要深度集成系统服务或内核模块的软件；这类需求优先使用发行版包管理器或容器。

| 维度 | Flatpak / Flathub | Snap | 发行版仓库（apt/dnf） |
| --- | --- | --- | --- |
| 依赖 | 共享 runtime，按需下载 | 每个 snap 自带 base | 链接系统库 |
| 隔离 | bubblewrap 沙箱 + portal | AppArmor 沙箱 | 基本无隔离 |
| 应用来源 | Flathub 及第三方仓库 | Snap Store | 发行版官方仓库 |
| 桌面集成 | 通过 portal，需桌面后端支持 | 较好 | 原生 |
| 磁盘占用 | runtime 可被多个应用共享 | 通常更大 | 最小 |
| 更新方式 | 手动或桌面商店触发 | 默认自动刷新 | 随系统更新 |
| 典型用途 | 桌面应用 | 桌面与部分服务端软件 | 系统组件与通用软件 |

## 安装 Flatpak

| 发行版 | 安装命令 |
| --- | --- |
| Ubuntu / Debian | `sudo apt install flatpak` |
| Fedora | `sudo dnf install flatpak` |
| Arch / Manjaro | `sudo pacman -S flatpak` |
| openSUSE | `sudo zypper install flatpak` |
| NixOS | 在配置中启用 `services.flatpak.enable = true;` |

安装后注销并重新登录（或重启），让会话环境变量 `XDG_DATA_DIRS` 生效，应用菜单里才会出现 Flatpak 应用。

如果使用图形商店，还需要对应插件：

```bash
# Ubuntu 上的 GNOME Software
sudo apt install gnome-software-plugin-flatpak
```

KDE 的 Discover 通常已带 Flatpak 后端；若没有，安装发行版提供的 Discover Flatpak 插件包。

## 添加 Flathub 源

系统级安装（所有用户可用）：

```bash
flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
```

只给当前用户添加：

```bash
flatpak remote-add --user --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
```

若提示权限不足，在系统级命令前加 `sudo`。查看结果：

```bash
flatpak remotes -d          # 名称、URL、子集、优先级
flatpak remote-list         # 仅名称
```

### Beta 仓库与子集

Flathub Beta 提供应用的测试分支，可能不稳定：

```bash
flatpak remote-add --if-not-exists flathub-beta \
  https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak install flathub-beta <app-id>
```

只允许安装经过验证（verified）或开源（floss）的应用，可用仓库子集过滤：

```bash
flatpak remote-add --if-not-exists --subset=verified \
  flathub-verified https://flathub.org/repo/flathub.flatpakrepo

# 已有源改为只显示验证应用
flatpak remote-modify --subset=verified flathub

# 取消子集过滤
flatpak remote-modify --subset= flathub
```

可用子集：`verified`、`floss`、`verified_floss`。

## 常用命令

| 操作 | 命令 |
| --- | --- |
| 搜索应用 | `flatpak search <关键词>` |
| 安装 | `flatpak install flathub <app-id>` |
| 从网页安装 | `flatpak install <xxx.flatpakref 的 URL>` |
| 运行 | `flatpak run <app-id>` |
| 列出已安装应用 | `flatpak list --app` |
| 列出 runtime | `flatpak list --runtime` |
| 查看详情 | `flatpak info <app-id>` |
| 卸载（保留数据） | `flatpak uninstall <app-id>` |
| 卸载并删数据 | `flatpak uninstall --delete-data <app-id>` |
| 更新全部 | `flatpak update` |
| 刷新元数据 | `flatpak update --appstream` |
| 查看可更新 | `flatpak remote-ls --updates` |
| 查看仓库应用 | `flatpak remote-ls --app flathub` |
| 已安装应用占用的空间 | `flatpak list --columns=application,size,installation` |
| 正在运行的应用 | `flatpak ps` |
| 结束应用 | `flatpak kill <app-id>` |
| 事务历史 | `flatpak history` |

常用示例：

```bash
# 安装并运行 Firefox
flatpak install flathub org.mozilla.firefox
flatpak run org.mozilla.firefox

# 只装给当前用户
flatpak install --user flathub md.obsidian.Obsidian

# 指定版本分支运行
flatpak run --branch=beta <app-id>

# 在沙箱内打开 shell 排查问题
flatpak run --command=sh <app-id>

# 进入指定进程的沙箱（需 root）
sudo flatpak enter <pid>
```

首次安装会同时下载 runtime（如 `org.freedesktop.Platform`、`org.gnome.Platform`），体积可能明显大于应用本身；多个应用会复用同一 runtime。

## 安装位置与数据目录

| 内容 | 用户级（`--user`） | 系统级（默认） |
| --- | --- | --- |
| 应用与 runtime | `~/.local/share/flatpak` | `/var/lib/flatpak` |
| 应用数据 | `~/.var/app/<app-id>` | `~/.var/app/<app-id>` |
| 用户覆盖配置 | `~/.local/share/flatpak/overrides` | 同左 |
| 缓存 | `~/.cache/flatpak` | 随 `/var/lib/flatpak` 一并管理 |

要点：

- 应用数据始终按用户存放在 `~/.var/app/<app-id>`，系统级安装也一样。
- 同一应用可以同时存在用户级和系统级两份，卸载时会要求选择具体 ref。
- 用 `flatpak info <app-id>` 可以确认安装位置和分支。

## 权限与沙箱

应用权限由 manifest 声明，用户可以通过图形工具或 `flatpak override` 增删。修改前先看默认权限：

```bash
# 应用声明的权限
flatpak info --show-permissions org.mozilla.firefox

# 当前用户的覆盖项
flatpak override --user --show org.mozilla.firefox

# 全局覆盖（不指定应用）
flatpak override --user --show

# 系统级覆盖
sudo flatpak override --system --show org.mozilla.firefox
```

常见覆盖操作：

```bash
# 只读访问下载目录
flatpak override --user --filesystem=~/Downloads:ro org.mozilla.firefox

# 取消主目录访问
flatpak override --user --nofilesystem=home org.mozilla.firefox

# 允许访问所有设备（谨慎）
flatpak override --user --device=all <app-id>

# 允许智能卡
flatpak override --user --socket=pcsc org.mozilla.firefox

# 注入环境变量（例如代理）
flatpak override --user --env=HTTPS_PROXY=http://127.0.0.1:7890 <app-id>

# 重置某个应用的全部覆盖
flatpak override --user --reset org.mozilla.firefox

# 重置全局覆盖
flatpak override --user --reset
```

常用权限项：

| 类别 | 示例 | 说明 |
| --- | --- | --- |
| 文件系统 | `--filesystem=home`、`--filesystem=/mnt/data:ro` | 读写主机路径；`:ro` 为只读 |
| 网络 | `--share=network`、`--unshare=network` | 是否允许联网 |
| 显示 | `--socket=wayland`、`--socket=fallback-x11` | Wayland / X11 访问 |
| 声音 | `--socket=pulseaudio` | 音频输出 |
| 设备 | `--device=dri`、`--device=all` | GPU、输入设备等 |
| D-Bus | `--talk-name=org.freedesktop.secrets` | 访问指定会话总线服务 |

图形化工具：**Flatseal**（`com.github.tchx84.Flatseal`）可以逐项开关权限；GNOME 设置和 KDE 系统设置里也有 Flatpak 权限入口。

注意：

- 不要为了「修好某个功能」直接给 `--filesystem=host` 或 `--device=all`，优先确认应用是否真的需要。
- 文件选择器、截图、通知等依赖 `xdg-desktop-portal` 及对应桌面后端（`xdg-desktop-portal-gnome` / `xdg-desktop-portal-kde`）。
- `--nofilesystem` 只能取消默认权限；要恢复默认，用 `--reset`。

## 更新、回退与固定版本

```bash
flatpak update                    # 更新所有已安装应用与 runtime
flatpak update --user             # 只更新用户级
flatpak update --appstream        # 只刷新应用元数据
flatpak remote-ls --updates       # 列出可更新的应用
flatpak install --reinstall flathub <app-id>   # 重装当前版本
```

回退到历史版本：

```bash
# 查看提交历史，找到目标 commit
flatpak remote-info --log flathub com.github.tchx84.Flatseal

# 系统级回退需要 sudo；用户级安装直接执行
sudo flatpak update \
  --commit=<commit-hash> \
  com.github.tchx84.Flatseal
```

临时阻止更新：

```bash
flatpak mask com.github.tchx84.Flatseal
flatpak mask --remove com.github.tchx84.Flatseal
```

回退前备份应用数据：旧版本可能无法读取新版本写入的数据。`flatpak pin` 可以固定 runtime，避免被 `--unused` 自动清理：

```bash
flatpak pin --runtime org.freedesktop.Platform
flatpak pin --remove --runtime org.freedesktop.Platform
```

## 国内网络与镜像

Flathub 官方源在国内可能较慢。上海交大、中科大等镜像提供 Flathub 缓存，但**它们不是完整镜像**：

- 元数据（`config`、`summary`、`summaries/`）完整同步。
- 应用包体（`objects/`、`deltas/`）按访问热度动态缓存；未命中时会 302 跳回 `dl.flathub.org`。
- 因此仍然需要能连通 Flathub 官方站点，镜像主要加速索引刷新和热门包体。
- manifest 中标记为 `extra-data` 的文件不经过镜像，直接从原始站点下载。

以中科大镜像为例（系统级）：

```bash
# 先添加官方源
flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo

# 切换仓库地址到镜像
sudo flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub

# 恢复官方地址
sudo flatpak remote-modify flathub --url=https://dl.flathub.org/repo
```

用户级源不要加 `sudo`，并补上 `--user`：

```bash
flatpak remote-modify --user flathub --url=https://mirrors.ustc.edu.cn/flathub
```

其他镜像：

| 镜像 | 地址 | 说明 |
| --- | --- | --- |
| 中科大 | `https://mirrors.ustc.edu.cn/flathub` | 缓存型，文档见 <https://mirrors.ustc.edu.cn/help/flathub.html> |
| 上海交大 | `https://mirror.sjtu.edu.cn/flathub` | 智能缓存，文档见 <https://mirror.sjtu.edu.cn/docs/flathub> |

排查下载问题时可以打开 libcurl 调试输出：

```bash
OSTREE_DEBUG_HTTP=1 flatpak install com.github.tchx84.Flatseal
```

由于镜像会随上游调整，若命令失效，先访问镜像站文档确认最新的仓库地址和配置方式。

## 清理与维护

```bash
# 删除不再被任何应用引用的 runtime
flatpak uninstall --unused

# 修复本地仓库元数据与对象（系统级需要 sudo）
flatpak repair --user
sudo flatpak repair

# 卸载应用并删除其数据
flatpak uninstall --delete-data <app-id>

# 删除残留数据（确认应用已卸载）
rm -rf ~/.var/app/<app-id>
```

临时缓存和下载残留可以清理：

```bash
rm -rf ~/.cache/flatpak
sudo rm -rf /var/tmp/flatpak-cache-*
```

不要手工删除 `/var/lib/flatpak` 或 `~/.local/share/flatpak` 下的文件，除非已经确认没有安装记录；异常删除会留下无法卸载的 ref，此时用 `flatpak repair` 修复。

## 故障排查

应用启动失败或行为异常时，先在终端里直接运行并收集输出：

```bash
flatpak run <app-id>
flatpak --version
flatpak info <app-id>
```

同时检查权限覆盖，确认问题不是自己改出来的：

```bash
flatpak info --show-permissions <app-id>
flatpak override --user --show <app-id>
sudo flatpak override --system --show <app-id>
```

常见问题：

| 现象 | 排查方向 |
| --- | --- |
| 更新后应用崩溃 | `flatpak info` 记录版本与 commit；按上文回退或 `mask` 暂停更新 |
| 文件选择器、截图、剪贴板失效 | 安装 `xdg-desktop-portal` 与桌面后端，重启会话 |
| 中文输入法不可用 | 确认输入法框架与 portal 正常；Wayland 下检查 `--socket=wayland` |
| 界面主题、字体异常 | 应用使用 runtime 内的主题；安装匹配的主题包或用 Flatseal 调整 |
| 代理不生效 | 用 `flatpak override --user --env=` 注入 `HTTP_PROXY`/`HTTPS_PROXY`，或配置桌面代理 |
| 提示 `bwrap: ... Permission denied` | Ubuntu 24.04+ 默认限制非特权用户命名空间；升级 flatpak 与 portal，必要时按发行版说明调整 AppArmor / `kernel.apparmor_restrict_unprivileged_userns` |
| 下载很慢或卡住 | 参考上文镜像配置，并用 `OSTREE_DEBUG_HTTP=1` 观察请求 |
| 同一应用出现两份 | `flatpak list --columns=application,installation` 确认用户级与系统级，按需卸载其中一个 |

排查具体版本回归时，可以用 `flatpak remote-info --log` 找到可疑 commit，回退验证后再向应用或 Flathub 报告。

## 常用应用 ID

| 应用 | ID |
| --- | --- |
| Firefox | `org.mozilla.firefox` |
| Thunderbird | `org.mozilla.Thunderbird` |
| Chromium | `org.chromium.Chromium` |
| Visual Studio Code | `com.visualstudio.code` |
| Obsidian | `md.obsidian.Obsidian` |
| LibreOffice | `org.libreoffice.LibreOffice` |
| ONLYOFFICE | `org.onlyoffice.desktopeditors` |
| GIMP | `org.gimp.GIMP` |
| Inkscape | `org.inkscape.Inkscape` |
| Krita | `org.kde.krita` |
| VLC | `org.videolan.VLC` |
| OBS Studio | `com.obsproject.Studio` |
| Spotify | `com.spotify.Client` |
| Discord | `com.discordapp.Discord` |
| Telegram | `org.telegram.desktop` |
| Steam | `com.valvesoftware.Steam` |
| Bottles | `com.usebottles.bottles` |
| Flatseal（权限管理） | `com.github.tchx84.Flatseal` |
| Warehouse（安装管理） | `io.github.flattool.Warehouse` |

应用 ID 可以在 Flathub 应用页面的安装命令中看到，也可以在 `flatpak search` 结果里确认。

## 参考资料

- Flathub 用户文档：<https://docs.flathub.org/docs/category/for-users>
- Flathub 安装说明：<https://flathub.org/setup>
- Flatpak 官方文档：<https://docs.flatpak.org/>
- Flatseal：<https://github.com/tchx84/Flatseal>
- Warehouse：<https://github.com/flattool/warehouse>
- 中科大 Flathub 缓存说明：<https://mirrors.ustc.edu.cn/help/flathub.html>
- 上海交大 Flathub 镜像说明：<https://mirror.sjtu.edu.cn/docs/flathub>
