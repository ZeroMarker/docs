---
tags: [网络, IPv6, 服务器, 手机, Android]
---

# 手机作为 IPv6服务器

## 概要

在运营商分配全球单播 IPv6 地址、允许入站连接，且 Android 与应用层访问控制均已正确配置时，手机可以临时提供轻量级网络服务。获得 IPv6 地址不代表服务一定能从公网访问；开始前必须实际测试运营商路由、防火墙和端口可达性。

## 原理

### 为什么手机可能有公网 IPv6？

- 许多 4G/5G 网络会向终端分配全球单播 IPv6 地址，但实际情况取决于运营商、APN、套餐、地区和终端配置。
- 全球单播地址通常位于 `2000::/3`；地址属于这一范围仍不能证明入站流量未被运营商或系统防火墙过滤。
- IPv6 通常不依赖 IPv4 式 NAT，但“没有 NAT”不等于“没有防火墙”或“公网一定可达”。

### 与家庭宽带的对比

| 特性 | 手机移动网络 | 家庭宽带 |
| :--- | :--- | :--- |
| IPv4 公网 | 常见 CGNAT，也可能提供公网地址 | 取决于运营商和套餐 |
| IPv6 全球地址 | 可能分配 | 取决于运营商、光猫和路由器配置 |
| IP 稳定性 | 较差（基站切换会变） | 较好（重启光猫会变） |
| 带宽 | 取决于信号（5G 可达数百 Mbps） | 取决于套餐 |
| 入站可达性 | 必须实测，可能被过滤 | 必须实测并检查路由器防火墙 |

## 前置条件

1. **SIM 卡和 APN**：确认当前网络确实分配 IPv6；不要假设所有卡、漫游网络或 APN 都支持
2. **手机系统**：Android 推荐（可 root 更佳），iOS 因系统限制功能有限
3. **确认 IPv6 可用**：通过 [test-ipv6.com](https://test-ipv6.com/) 和 `ip -6 addr show` 确认地址与出站连接
4. **验证入站**：启动临时测试服务后，从另一条 IPv6 网络测试指定端口；同一 Wi-Fi 内测试不能证明公网可达
5. **目标访问端**：访问方也必须具备可用的 IPv6 路由

## 方案一：Termux + SSH（最基础）

### 安装 Termux

从 [F-Droid](https://f-droid.org/packages/com.termux/) 下载安装 Termux（不要用 Play Store 版本，已过时）。

### 配置 SSH 服务

```bash
# 安装 openssh
pkg update && pkg install openssh

# 创建密钥目录；把客户端公钥写入 authorized_keys
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 启动 sshd（默认监听 8022 端口）
sshd
```

### 获取 IPv6 地址

```bash
# 查看手机的 IPv6 地址
ifconfig
# 或
ip -6 addr show
```

找到 `rmnet_data0`（移动数据接口）上的 `scope global` 地址，类似 `2408:xxxx:xxxx::xxxx`。

### 从外部连接

```bash
ssh -p 8022 user@2408:xxxx:xxxx::xxxx
```

> OpenSSH 的 `ssh` 命令直接使用 IPv6 地址，不加方括号。方括号用于 URL、`host:port` 等需要区分地址与端口的语法。首次确认密钥登录成功后，应在 `$PREFIX/etc/ssh/sshd_config` 中设置 `PasswordAuthentication no` 并重启 `sshd`。

## 方案二：Termux + Web 服务器

### Nginx

```bash
pkg install nginx

# 编辑配置，监听 IPv6
nano $PREFIX/etc/nginx/nginx.conf
```

确保 `listen` 指令包含：

```
listen [::]:8080;
```

启动：

```bash
nginx
```

### Python HTTP Server

Python 内置服务器只适合短时调试，不提供生产级认证、TLS 或抗攻击能力。优先绑定到本机 `::1`；只有在确认内容无敏感信息并设置额外访问控制后，才监听所有接口。

```bash
# Python 内置，零依赖
python3 -m http.server 8080 --bind ::1
```

### Node.js

```bash
pkg install nodejs
```

创建 `server.js`：

```javascript
const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end('<h1>Hello from phone!</h1>');
});
server.listen(8080, '::1', () => {
  console.log('Server running on [::1]:8080');
});
```

```bash
node server.js
```

## 方案三：运行各类服务

在 Termux 中可以运行几乎所有 Linux 服务：

```bash
# 文件服务器（FTP/SFTP 已包含在 SSH 中，scp 即可传输）

# 数据库
pkg install mariadb
mariadb-install-db
mysqld_safe &

# Git 服务器（通过 SSH 即可，Git 原生支持 SSH 协议）
# 在手机上创建 bare repo
mkdir ~/git/myrepo.git && cd ~/git/myrepo.git
git init --bare
# 建议先在 ~/.ssh/config 中为地址、用户和 8022 端口设置主机别名，再使用别名克隆
```

## 稳定性与注意事项

### IP 地址变化问题

手机 IPv6 地址可能因以下原因变化：
- 切换基站（移动中）
- 飞行模式开关
- 重启手机
- 运营商重新分配前缀

**解决方案**：
- **DDNS**：使用支持 IPv6 的 DDNS 服务（如 Cloudflare API），配合定时脚本更新 DNS 记录
- **临时方案**：适用于一次性使用、开发调试、临时文件传输等场景

### 防火墙

- Android 网络栈包含 `iptables`、`ip6tables`、`netd` 等防火墙和网络配置机制；设备厂商和运营商也可能过滤入站流量。
- Termux 进程是否能被外部访问必须逐设备、逐网络测试，不能由监听地址单独判断。
- 高位端口可能避开部分端口策略，但不构成安全措施；不需要的服务应停止监听。
- 如需长期远程访问，优先考虑带身份认证和访问控制的组网方案，而不是直接暴露开发服务器。

### 电量与性能

- 长时间运行服务会消耗电量，建议连接充电器
- Termux 在后台可能被系统杀死，可使用 `termux-wake-lock` 保持唤醒：
  ```bash
  termux-wake-lock
  ```
- MIUI/ColorOS/OneUI 等深度定制系统需要在设置中关闭 Termux 的电池优化

### 安全建议

- **优先使用 SSH 密钥并关闭密码登录**
- 不要暴露不必要的端口
- 不要依赖 `fail2ban` 替代密钥认证、最小暴露和网络访问控制
- 定期检查开放端口：`ss -tlnp`

## 进阶：proot 完整 Linux 环境

如果 Termux 原生环境不够用，可以通过 `proot-distro` 安装完整 Linux 发行版：

```bash
pkg install proot-distro
proot-distro install debian
proot-distro login debian

# PRoot 可提供用户态 Debian 工具，但不等同于完整虚拟机
apt update && apt install nginx
```

PRoot 没有真正的 root 权限，也不能正常提供 Docker 所需的内核 namespace、cgroup 和守护进程环境；`systemd` 等系统级服务同样受限。

## 典型使用场景

| 场景 | 说明 |
| :--- | :--- |
| 临时 Web 演示 | 仅在加认证或受控网络内提供短时演示 |
| 远程开发 | SSH 连接手机，用 vim/emacs 写代码 |
| 文件传输 | `scp` 直接传文件，无需微信/QQ 中转 |
| Git 仓库 | 手机作为 Git remote，离线也能 push/pull |
| IoT 网关 | 手机作为中间层；API 需要认证、TLS 和最小权限控制 |

## 参考资料

- [Termux 官方文档](https://wiki.termux.com/wiki/Main_Page)
- [Android 开源项目：网络栈配置工具](https://source.android.com/docs/core/architecture/hidl/network-stack)
- [Termux OpenSSH 包说明](https://github.com/termux/termux-packages/tree/master/packages/openssh)
