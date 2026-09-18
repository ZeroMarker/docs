---
tags: [网络, IPv6, 服务器, 手机, Android]
---

# 手机作为 IPv6服务器

## 概要

利用手机的移动网络（4G/5G）天然拥有公网 IPv6 地址的特性，将手机变成一台轻量级服务器，无需内网穿透、无需公网 IPv4，即可对外提供服务。

## 原理

### 为什么手机有公网 IPv6？

- 中国三大运营商（移动/联通/电信）在 4G/5G 网络中已全面部署 IPv6
- 每张 SIM 卡分配的 IPv6 地址通常是**全球单播地址**（2400:/2001: 开头），而非 NAT 后的地址
- 这意味着手机直接暴露在公网上（仅 IPv6），任何 IPv6 网络均可直接访问

### 与家庭宽带的对比

| 特性 | 手机移动网络 | 家庭宽带 |
| :--- | :--- | :--- |
| IPv4 公网 | 无（运营商 NAT） | 通常无（需申请） |
| IPv6 公网 | 有（默认分配） | 有（需路由器支持） |
| IP 稳定性 | 较差（基站切换会变） | 较好（重启光猫会变） |
| 带宽 | 取决于信号（5G 可达数百 Mbps） | 取决于套餐 |
| 需要内网穿透 | 否 | 是（IPv4） |

## 前置条件

1. **SIM 卡**：开通了 IPv6 的手机卡（目前三大运营商默认已支持）
2. **手机系统**：Android 推荐（可 root 更佳），iOS 因系统限制功能有限
3. **确认 IPv6 可用**：浏览器访问 [ipv6.test-ipv6.com](https://ipv6.test-ipv6.com/) 确认获得公网 IPv6 地址
4. **目标访问端**：访问方也需要 IPv6 网络（家庭宽带 + 光猫开启 IPv6，或手机流量）

## 方案一：Termux + SSH（最基础）

### 安装 Termux

从 [F-Droid](https://f-droid.org/packages/com.termux/) 下载安装 Termux（不要用 Play Store 版本，已过时）。

### 配置 SSH 服务

```bash
# 安装 openssh
pkg update && pkg install openssh

# 设置密码
passwd

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
ssh -p 8022 user@[2408:xxxx:xxxx::xxxx]
```

> **注意**：方括号是 IPv6 地址的必需格式。

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

```bash
# Python 内置，零依赖
python3 -m http.server 8080 --bind ::
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
server.listen(8080, '::', () => {
  console.log('Server running on [::]:8080');
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
# 外部通过 git clone ssh://[2408:xxxx::xxxx]:8022/~/git/myrepo.git 克隆
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

- Android 系统本身没有入站防火墙（非 root 情况下），Termux 的服务默认可被外部访问
- 部分运营商可能对入站流量做了过滤（尤其是常用端口如 80/443），建议使用**高位端口**（如 8080、8443）
- 如需精细控制，root 后可使用 `iptables` / `ip6tables`

### 电量与性能

- 长时间运行服务会消耗电量，建议连接充电器
- Termux 在后台可能被系统杀死，可使用 `termux-wake-lock` 保持唤醒：
  ```bash
  termux-wake-lock
  ```
- MIUI/ColorOS/OneUI 等深度定制系统需要在设置中关闭 Termux 的电池优化

### 安全建议

- **必须设置强密码**或使用 SSH 密钥认证
- 不要暴露不必要的端口
- 考虑使用 `fail2ban` 防暴力破解（需 proot 完整 Linux 环境）
- 定期检查开放端口：`ss -tlnp`

## 进阶：proot 完整 Linux 环境

如果 Termux 原生环境不够用，可以通过 `proot-distro` 安装完整 Linux 发行版：

```bash
pkg install proot-distro
proot-distro install debian
proot-distro login debian

# 在 Debian 环境中可以安装完整的 nginx、docker（部分）、systemd 服务等
apt update && apt install nginx
```

## 典型使用场景

| 场景 | 说明 |
| :--- | :--- |
| 临时 Web 演示 | 在手机上跑一个 Web 服务，发链接给别人直接访问 |
| 远程开发 | SSH 连接手机，用 vim/emacs 写代码 |
| 文件传输 | `scp` 直接传文件，无需微信/QQ 中转 |
| Git 仓库 | 手机作为 Git remote，离线也能 push/pull |
| IoT 网关 | 手机作为中间层，连接本地设备并对外暴露 API |
| 翻墙出口 | 手机作为代理服务器，利用运营商 IPv6 出口 |

## 参考资料

- [Termux 官方文档](https://wiki.termux.com/wiki/Main_Page)
- [中国运营商 IPv6 部署现状](https://www.ipv6.org.cn/)
- [Android IPv6 配置](https://developer.android.com/develop/connectivity/ipv6)
