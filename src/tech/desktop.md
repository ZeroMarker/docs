# 翻墙客户端

代理客户端本身不提供节点，需要用户自行导入订阅链接或手动配置。客户端的核心差异在于**跨平台能力**、**内核支持**、**UI 设计**和**高级功能**（如分流规则、TUN 模式等）。

## 桌面端（Windows / macOS / Linux）

### Clash Verge Rev

- **GitHub**：clash-verge-rev/clash-verge-rev（⭐ 127k）
- **内核**：Clash Meta（Mihomo）
- **UI**：基于 Tauri 框架，体积小、资源占用低，界面现代化
- **特色**：支持 TUN 模式、配置文件编辑、订阅管理、规则分流可视化
- **现状**：社区活跃度高，更新频繁，桌面端最推荐的客户端之一

### Clash Party

- **GitHub**：mihomo-party-org/clash-party（⭐ 24.8k）
- **内核**：Clash Meta（Mihomo）
- **UI**：基于 Electron，偏向 macOS 风格，交互体验流畅
- **现状**：用户群体相对较小

### Clash Nyanpasu

- **GitHub**：libnyanpasu/clash-nyanpasu（⭐ 13k）
- **内核**：Clash Meta（Mihomo）
- **UI**：基于 Tauri，Material You 设计语言，视觉效果精致
- **特色**：支持 Clash Meta 和 Clash RS 双内核切换

### FlClash

- **GitHub**：chen08209/FlClash（⭐ 43k）
- **内核**：Clash Meta（Mihomo）
- **UI**：基于 Flutter，一套代码覆盖桌面和移动端
- **适合**：希望桌面和手机使用同一款客户端体验的用户

### v2rayN

- **GitHub**：2dust/v2rayN（⭐ 110k）
- **平台**：Windows / Linux / macOS
- **内核**：支持 Xray、sing-box、v2fly 等多内核
- **UI**：基于 C# / .NET，Windows 风格
- **特色**：支持 VMess、VLESS、Trojan、Shadowsocks、XTLS 等协议，功能全面
- **现状**：V2Ray 生态最流行的 GUI 客户端，更新极为频繁

### V2rayU

- **GitHub**：yanue/V2rayU（⭐ 20k）
- **平台**：macOS
- **内核**：V2Ray Core
- **UI**：原生 Swift 开发，macOS 风格菜单栏应用
- **特色**：支持订阅、二维码导入、剪贴板导入、二维码分享

### v2rayA

- **GitHub**：v2rayA/v2rayA（⭐ 15.2k）
- **平台**：Linux
- **内核**：支持 Xray-core、sing-box
- **UI**：Web GUI，通过浏览器访问 `http://localhost:2017` 管理
- **特色**：支持 VMess、VLESS、SS、SSR、Trojan、Tuic、Juicity，适合无桌面环境的 Linux 服务器

### Qv2ray

- **GitHub**：Qv2ray/Qv2ray（⭐ 16.9k）
- **平台**：Windows / Linux / macOS
- **内核**：V2Ray Core
- **UI**：C++ / Qt5，插件式架构
- **特色**：支持 VMess、VLESS、SSR、Trojan、Trojan-Go、NaiveProxy
- **现状**：已归档（archived），不再维护，但仍可使用

### Oblivion Desktop

- **GitHub**：bepass-org/oblivion-desktop（⭐ 8.3k）
- **平台**：Windows / macOS / Linux
- **内核**：sing-box
- **特色**：Cloudflare WARP 非官方客户端，基于 WireGuard 协议，免费可用
- **适合**：不想购买机场节点、只需基础翻墙能力的用户

### GUI.for.SingBox

- **GitHub**：GUI-for-Cores/GUI.for.SingBox（⭐ 7.9k）
- **平台**：Windows / macOS / Linux
- **内核**：sing-box
- **UI**：Wails（Go）+ Vue 3，轻量现代
- **特色**：sing-box 专属 GUI，配置灵活

### Throne

- **GitHub**：throneproj/Throne（⭐ 6.2k）
- **平台**：Windows / macOS / Linux
- **内核**：sing-box
- **UI**：C++ 开发，跨平台
- **特色**：支持 REALITY、XHTTP、AnyTLS 等最新协议，NekoBox/nekogui 的桌面继承者

## Android 端

### NekoBox

- **GitHub**：MatsuriDayo/NekoBoxForAndroid（⭐ 21.5k）
- **内核**：sing-box
- **特色**：支持 Shadowsocks、VMess、VLESS、Trojan、Hysteria 2、TUIC 等协议，支持 TUN 模式
- **现状**：Android 端首选客户端之一，替代了早期的 SagerNet

### v2rayNG

- **GitHub**：2dust/v2rayNG（⭐ 58.4k）
- **内核**：Xray-core、v2fly-core
- **特色**：支持 VMess、VLESS、Trojan、Shadowsocks、XTLS，功能与 v2rayN 对齐
- **现状**：Android 端下载量最大的 V2Ray 客户端

## Apple 端（iOS / macOS）

### Clash Mi

- **平台**：iOS / macOS
- **内核**：Clash Meta（Mihomo）
- **特色**：基于 Network Extension 框架的原生 Apple 客户端

### Shadowrocket（小火箭）

- **平台**：iOS / macOS
- **价格**：付费（美区 App Store 约 $2.99）
- **特色**：iOS 上最老牌的代理客户端，支持 SS、VMess、VLESS、Trojan、Hysteria 2 等，分流规则灵活
- **现状**：iOS 端用户量最大的代理客户端

### Quantumult X（圈 X）

- **平台**：iOS / macOS
- **价格**：付费（美区 App Store 约 $7.99）
- **特色**：功能最强大的 iOS 代理客户端，支持脚本、重写、MITM、Task 定时任务
- **适合**：高级用户，需要去广告、脚本自动化等

### Surge

- **平台**：iOS / macOS
- **价格**：付费（按设备数定价，价格较高）
- **特色**：专业级网络调试和代理工具，支持模块化配置、覆写、增强模式
- **适合**：开发者、网络工程师

### Stash

- **平台**：iOS / macOS
- **价格**：付费
- **特色**：Clash Premium 内核的 Apple 原生客户端，支持 Clash YAML 配置格式

## 路由器端

### OpenClash

- **GitHub**：vernesong/OpenClash（⭐ 26.4k）
- **平台**：OpenWrt 路由器
- **内核**：支持 Clash Meta（Mihomo）
- **特色**：通过 LuCI Web 界面管理，实现路由器级别的全局翻墙
- **适合**：有 OpenWrt 路由器、希望全家设备自动翻墙的用户

## 全平台（跨端）

### Hiddify

- **GitHub**：hiddify/hiddify-app（⭐ 30.9k）
- **平台**：Windows / macOS / Linux / Android / iOS
- **内核**：支持 sing-box、Xray、Clash 等多内核
- **特色**：自动检测最优协议，内置免费公共配置，界面简洁，对新手友好
- **适合**：不想折腾配置、希望开箱即用的用户

## 客户端对比

| 客户端 | 平台 | 内核 | UI 框架 | 适合人群 |
| :--- | :--- | :--- | :--- | :--- |
| **Clash Verge Rev** | Win / Mac / Linux | Clash Meta | Tauri | 桌面端主力用户 |
| **Clash Party** | Win / Mac / Linux | Clash Meta | Electron | macOS 风格偏好者 |
| **Clash Nyanpasu** | Win / Mac / Linux | Clash Meta | Tauri | Material You 爱好者 |
| **FlClash** | 全平台 | Clash Meta | Flutter | 跨平台统一体验 |
| **v2rayN** | Win / Mac / Linux | Xray / sing-box | .NET | V2Ray 生态用户 |
| **V2rayU** | macOS | V2Ray Core | Swift | macOS 原生偏好者 |
| **v2rayA** | Linux | Xray / sing-box | Web GUI | 无桌面 Linux 服务器 |
| **Oblivion** | Win / Mac / Linux | sing-box | — | 免费 WARP 用户 |
| **GUI.for.SingBox** | Win / Mac / Linux | sing-box | Wails + Vue | sing-box 专属用户 |
| **Throne** | Win / Mac / Linux | sing-box | C++ | 最新协议支持 |
| **NekoBox** | Android | sing-box | — | Android 主力用户 |
| **v2rayNG** | Android | Xray / v2fly | — | Android V2Ray 用户 |
| **Clash Mi** | iOS / macOS | Clash Meta | 原生 | Apple 设备用户 |
| **Shadowrocket** | iOS / macOS | 多内核 | 原生 | iOS 最主流客户端 |
| **Quantumult X** | iOS / macOS | 多内核 | 原生 | iOS 高级用户 |
| **Surge** | iOS / macOS | 多内核 | 原生 | 开发者 / 网络工程师 |
| **Stash** | iOS / macOS | Clash Premium | 原生 | Clash 配置用户 |
| **Hiddify** | 全平台 | sing-box / Xray | — | 新手，开箱即用 |
| **OpenClash** | OpenWrt | Clash Meta | LuCI | 路由器全局翻墙 |

## TUN 模式

TUN 模式是许多客户端的重要功能。与传统的系统代理（仅接管浏览器等支持代理的应用）不同，TUN 模式通过创建虚拟网卡接管系统所有流量，包括：

- 终端命令行（`curl`、`git`、`apt` 等）
- 不支持代理设置的应用
- UDP 流量（如游戏、视频通话）

**注意**：TUN 模式通常需要管理员/root 权限。

## 订阅格式

主流订阅格式有两种：

- **Clash 格式**：YAML 配置文件，包含代理节点、规则、DNS 等完整配置
- **sing-box 格式**：JSON 配置，sing-box 生态使用

大多数机场（代理服务商）同时提供两种格式的订阅链接，部分客户端支持自动转换。
