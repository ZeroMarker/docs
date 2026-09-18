# Clash / Mihomo 客户端指南

> 更新日期：2026-09-18

Clash 是一套基于规则的网络代理方案。原版 Clash 项目停止维护后，社区通常使用仍在更新的 **Mihomo（原 Clash.Meta）内核**，再配合不同平台的图形客户端。

客户端只负责读取配置、选择节点和转发流量，**不提供代理节点或订阅服务**。订阅地址相当于访问凭证，不应公开分享，也不要导入来源不明的配置。

## 组成与术语

- **内核**：真正处理连接、DNS、规则匹配和流量转发的程序，如 Mihomo。
- **客户端**：管理内核的图形界面，如 Clash Verge Rev、FlClash。
- **配置文件**：通常为 YAML，包含节点、代理组、分流规则和 DNS 设置。
- **订阅**：远程配置地址。客户端可通过它下载及更新配置。
- **系统代理**：让遵循操作系统代理设置的应用通过 Clash；部分应用会绕过它。
- **TUN 模式**：通过虚拟网卡接管更多系统流量，覆盖范围更广，但通常需要管理员权限。

## 客户端选择

| 平台 | 建议客户端 | 特点 |
| --- | --- | --- |
| Windows / macOS / Linux | [Clash Verge Rev](https://huarun.win/apps/clash-verge-rev) | 基于 Tauri 2，内置 Mihomo，支持系统代理、TUN、配置增强与内核切换 |
| Android | [Clash Meta for Android](https://huarun.win/apps/clash-meta-for-android) | MetaCubeX 提供的原生 Android Mihomo 客户端，主要使用 Clash 配置 |
| Android / Windows / macOS / Linux | [FlClash](https://huarun.win/apps/flclash) | Flutter 跨平台界面，支持订阅导入和 WebDAV 同步 |
| macOS | [ClashX Meta](https://huarun.win/apps/clashx-meta) | 菜单栏客户端，适合偏好轻量交互的用户 |
| OpenWrt | [OpenClash](https://huarun.win/apps/openclash) | LuCI 管理界面，可为局域网设备提供透明代理和规则分流 |

[华润赢应用目录](https://huarun.win/)可按平台、内核、代码开放状态和价格筛选客户端。该站只整理信息并链接到官方发布页，不托管安装包、节点或订阅。下载时仍应核对最终链接是否属于项目的官方 GitHub 仓库或应用商店。

### 桌面端安装包怎么选

- Windows 常见的 Intel / AMD 电脑选择 `x64`；Windows on ARM 设备选择 `ARM64`。
- Apple Silicon Mac（M1、M2、M3 等）选择 `aarch64` / `arm64`；Intel Mac 选择 `x64` / `x86_64`。
- Linux 根据发行版选择 `.deb`、`.rpm` 或 AppImage，并确认 CPU 架构。
- 日常使用选择标记为 **Latest / Stable** 的版本，不要把 Alpha 或滚动构建作为首选。

Clash Verge Rev 官方仓库提供 Windows、macOS 和 Linux 安装包：[Releases](https://github.com/clash-verge-rev/clash-verge-rev/releases)。

## 基本使用流程

1. 从项目官方发布页下载并安装客户端。
2. 在“订阅”或“配置”页面粘贴可信服务提供方给出的订阅地址，或导入本地 YAML 文件。
3. 更新订阅，选中刚导入的配置。
4. 在代理组中选择节点；不确定时可先执行延迟测试，再选择自动或延迟较低的节点。
5. 日常优先使用“规则”模式，然后开启“系统代理”。
6. 如果某些应用不遵循系统代理，再按需启用 TUN 模式。
7. 通过客户端日志或连接页面确认规则命中情况，并访问可信的 IP 查询站点验证出口地址。

## 三种运行模式

Mihomo 支持以下常用模式，默认使用 `rule`：

| 模式 | 行为 | 适用场景 |
| --- | --- | --- |
| `rule`（规则） | 按配置中的规则决定直连、代理或拦截 | 日常使用；兼顾访问效果和本地网络性能 |
| `global`（全局） | 流量统一交给 `GLOBAL` 代理组 | 临时排查规则是否导致连接失败 |
| `direct`（直连） | 所有流量不经过代理 | 临时停用代理或排查本地网络 |

规则由上到下匹配，越靠前优先级越高，通常以 `MATCH` 作为最后的兜底规则。完整字段和匹配方式见 [Mihomo 路由规则文档](https://wiki.metacubex.one/config/rules/)；运行模式见 [通用配置文档](https://wiki.metacubex.one/config/general/)。

## 系统代理与 TUN 的区别

| 项目 | 系统代理 | TUN 模式 |
| --- | --- | --- |
| 接管范围 | 主要是遵循系统代理设置的应用 | 大多数经过虚拟网卡的 TCP / UDP 流量 |
| 权限 | 通常不需要额外权限 | 常需要管理员权限或安装服务 |
| 资源占用 | 较低 | 通常略高 |
| 排障难度 | 较低 | DNS、路由或虚拟网卡冲突时更复杂 |

建议先使用系统代理；只有在游戏、命令行工具或特定应用无法被接管时，再启用 TUN。不要同时运行多个会创建 VPN/TUN 接口的客户端。

## 常见问题

### 浏览器可以访问，但其他应用不行

该应用可能没有读取系统代理。先确认客户端正在运行并已开启系统代理；仍无效时，再尝试 TUN 模式。

### 开启后完全无法联网

依次检查：

1. 切换为 `direct`，确认本地网络本身正常。
2. 更新订阅并更换节点。
3. 检查日志中是否出现 DNS、证书、超时或配置解析错误。
4. 关闭其他 VPN、代理软件或虚拟网卡后重试。
5. 退出客户端时确认系统代理已被关闭；必要时在操作系统网络设置中手动恢复。

### 规则模式无法访问，但全局模式可以

通常说明域名命中了错误规则，或规则集没有更新。查看连接详情中的命中规则，更新规则集，或在配置覆写中添加更高优先级的规则。不要直接修改订阅生成的配置，因为下次更新可能覆盖改动。

### 导入订阅失败

确认地址没有多余空格、尚未过期，并能在当前网络访问。不要将订阅地址粘贴到在线“检测”或“转换”网站；如需转换，优先使用服务提供方内置功能或可信的本地工具。

## 安全建议

- 只从官方仓库、官网或应用商店下载，警惕搜索广告和第三方“整合版”。
- 订阅中可能包含服务器凭证；截图、日志和配置文件对外分享前应脱敏。
- 不要随意开启“允许局域网连接”。确需开启时，应设置认证并使用防火墙限制来源。
- 不要把 Mihomo 的外部控制端口直接暴露到公网；如需远程管理，应设置强 `secret`，并通过防火墙或受认证的反向代理限制访问。
- 谨慎安装 HTTPS 解密证书。普通代理使用不需要安装根证书；只有明确需要抓包或重写 HTTPS 流量时才考虑启用。
- 定期更新客户端和内核，但生产设备优先使用稳定版本。
- 使用代理工具时应遵守所在地法律、组织政策和服务条款。

## 参考资料

- [华润赢：代理客户端目录](https://huarun.win/)
- [Mihomo 官方文档](https://wiki.metacubex.one/)
- [Mihomo 源代码](https://github.com/MetaCubeX/mihomo)
- [Clash Verge Rev 官方仓库](https://github.com/clash-verge-rev/clash-verge-rev)
- [FlClash 官方仓库](https://github.com/chen08209/FlClash)
- [Clash Meta for Android 官方仓库](https://github.com/MetaCubeX/ClashMetaForAndroid)
