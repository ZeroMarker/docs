# 谷歌、微软、苹果的设计语言

## Google — Material Design

### 起源与演进

| 版本 | 年份 | 关键变化 |
|------|------|----------|
| Material Design | 2014 | 首次提出，建立纸墨隐喻 |
| Material Design 2 (MDC) | 2018 | 引入主题化（Theming），强调品牌定制 |
| Material Design 3 (Material You) | 2021 | 个性化配色（dynamic color）、更大圆角、可变形状系统 |

### 核心理念

- **纸墨隐喻**：界面元素是有高度（elevation）的纸片，通过阴影表达层级
- **运动即沟通**：转场动画（shared element transition）不是装饰，是导航线索
- **响应式**：同一套规范覆盖手机、平板、桌面、可穿戴、车载

### 视觉特征

- 强调 **颜色系统**：primary / secondary / tertiary / surface / error 五大色阶
- 圆角随版本递增（MD2: 4dp → MD3: 16–28dp）
- 大量使用 **FAB**（Floating Action Button）作为核心操作锚点
- Typography Scale 使用 13 级 type scale（Display → Label）

### 设计工具

- [Material Theme Builder](https://m3.material.io/theme-builder)
- [Figma UI Kit](https://www.figma.com/community)（官方维护）
- [material-web](https://github.com/nickreese/material-web) — Web Components 实现

---

## Microsoft — Fluent Design System

### 起源与演进

| 版本 | 年份 | 关键变化 |
|------|------|----------|
| Fluent Design | 2017 | 伴随 Windows 10 Fall Creators Update 发布 |
| Fluent UI | 2020 | 统一为 Web 组件库，跨平台 |
| Fluent UI React v9 | 2022 | 完整 token 化、Griffel CSS-in-JS |
| Fluent UI React v9.6+ | 2025 | Copilot 设计融合、AI 可适应性 |

### 核心理念

- **五要素**：光（Light）、深度（Depth）、运动（Motion）、材质（Material）、缩放（Scale）
- **系统优先**：为 Microsoft 365（Teams、Outlook、Edge、Windows）的庞大生态服务
- **无障碍**：从第一天就内建 WCAG 2.1 AA 合规

### 视觉特征

- **中性、克制**：大面积留白，强调信息密度而非视觉冲击
- 圆角：MD 4–8px（保守），突出专业感
- **Dark Mode** 是一等公民，不是附加
- 大量使用 **Persona**（人头像 + 名字）在协作场景

### 设计工具

- [Fluent UI 官方文档](https://fluent2.microsoft.design/)
- [Figma Fluent UI Kit](https://www.figma.com/community)（官方）
- [react-components](https://react.fluentui.dev/) — React 实现

---

## Apple — Human Interface Guidelines (HIG)

### 起源与演进

| 版本 | 年份 | 关键变化 |
|------|------|----------|
| 经典 HIG | 1987 | 最早的 GUI 设计规范之一 |
| iOS 7 重设计 | 2013 | 扁平化（flat design），去掉拟物纹理 |
| SF Pro / SF Symbols | 2017–2019 | 自研字体 + 矢量图标库 |
| visionOS HIG | 2023 | 空间计算设计范式，引入 volumetric UI |

### 核心理念

- **内容优先**：UI 是内容的容器，不是主角
- **一致性 > 新颖性**：跨平台体验要让用户感觉 "这是同一个 app"
- **直接操控**：多点触控、手势是自然交互，不是快捷方式

### 视觉特征

- **SF Pro / SF Rounded / SF Compact**：三种字体变体，可变字重
- 配色：不强调主色调，而是依赖系统语义色（label, separator, systemGray）
- 圆角：统一使用 **continuous corner**（squircle），比普通圆角更自然
- **毛玻璃**（vibrancy / material blur）是标志性视觉语言
- 大量使用 **SF Symbols**（5000+ 矢量图标，4 权重自适应）

### 设计工具

- [HIG 官方文档](https://developer.apple.com/design/human-interface-guidelines/)
- [Apple Design Resources](https://developer.apple.com/design/resources/)（Figma / Sketch）
- [SF Symbols App](https://developer.apple.com/sf-symbols/)

---

## 三者对比

| 维度 | Material Design | Fluent Design | Apple HIG |
|------|----------------|---------------|-----------|
| 设计哲学 | 开放、表达性 | 系统化、效率 | 克制、内容优先 |
| 标志性元素 | FAB、卡片、底部导航 | 人头像、侧边栏、Ribbon | 毛玻璃、Tab Bar、持续圆角 |
| 动效风格 | 弹性曲线、共享元素 | 克制、功能性 | 缓入缓出、物理模拟 |
| 颜色系统 | 强调品牌色 + dynamic color | 中性为主，accent 克制 | 语义色，不强调主色 |
| 字体 | Roboto / Google Sans | Segoe UI | SF Pro |
| 最佳实践场景 | 消费级、创意类应用 | 企业级、协作工具 | iOS/macOS 原生体验 |

---

## 关键趋势

1. **Token 化**：三者都已将颜色、间距、圆角抽象为 design tokens，支持跨平台同步
2. **Dark Mode 一等公民**：不再是附加功能，从第一天就内建
3. **无障碍**：WCAG 2.1 AA 成为底线要求，高对比度模式被纳入核心
4. **AI 可适应性**：Microsoft 已开始探索 Copilot 风格的 AI-first 界面；Material You 的 dynamic color 本身就是个性化的雏形
5. **空间计算**：Apple 的 visionOS HIG 是目前唯一系统的空间 UI 规范

---

## 参考资料

- [Material Design 3 官方文档](https://m3.material.io/)
- [Fluent UI 官方文档](https://fluent2.microsoft.design/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
