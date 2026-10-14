# 现代设计语言与设计体系

除了 Google Material Design、Microsoft Fluent Design 和 Apple Human Interface Guidelines（HIG），软件与硬件领域还有许多面向不同生态、任务和设备的设计体系。本文按应用场景整理它们的定位、特征和选型思路。

三大平台的详细介绍见 [谷歌、微软、苹果的设计语言](ui.md)。本文核对日期：2026-10-14；产品名称与技术实现可能继续变化。

## 概念与分类

讨论“设计语言”时，常会把视觉规范、交互原则与开发工具放在一起。它们承担的职责不同：

| 类型 | 主要解决的问题 | 代表 |
|------|----------------|------|
| 设计语言与平台指南 | 产品应如何表达品牌、组织交互并适配设备 | Material Design、Fluent、Apple HIG、One UI |
| 设计系统 | 如何用规范、设计令牌、组件和模式保持一致性 | Carbon、Spectrum、Atlassian、Polaris、Ant Design、TDesign |
| 组件库与组件原语 | 如何实现可复用的控件和交互行为 | Chakra UI、Radix Primitives、Headless UI |
| 样式工具与界面资源 | 如何编写样式、复用界面代码和模板 | Tailwind CSS、Tailwind Plus、shadcn/ui |
| 产品界面与设计趋势 | 特定设备或新型任务如何组织体验 | PlayStation、Nintendo、BMW iDrive、Tesla、AI-native 界面 |

这些类别可以交叉：设计系统通常包含组件库，组件工具也可以成为自建设计系统的基础。选型需要同时考虑交互规范、视觉表达和工程实现。

## 企业软件与专业工具

### IBM Carbon Design System

Carbon 是基于 IBM Design Language 建立的开源设计系统，定位于企业级产品。它提供基础规范、组件、交互模式和数据可视化资源。[官方介绍](https://www.carbondesignsystem.com/)

- **重点**：复杂业务、数据展示与一致的工作流程。
- **风格概括**：严谨的网格、清晰的层级和偏专业的工具界面；中性色常用于承载内容，颜色承担状态与强调作用。
- **适用场景**：云控制台、数据平台、开发工具和企业 SaaS。
- **取舍**：适合信息密集的界面，但密度仍需按用户任务调整，不能直接等同于“黑白灰”或“越密越好”。

### Adobe Spectrum

Spectrum 为 Adobe 产品提供共享的设计基础、令牌、组件与模式，强调跨产品的一致性和可扩展性。[官方介绍](https://spectrum.adobe.com/)

- **重点**：专业工具中复杂控件与内容之间的协调。
- **风格概括**：工具台式布局、明确的控件状态和可调整的界面结构。
- **适用场景**：编辑器、资产管理、创作工具和专业工作台。
- **取舍**：深色面板是部分创意工具的常见体验，不能概括 Spectrum 的全部视觉方案。

### Atlassian Design System

Atlassian 的设计系统提供基础规范、组件和模式，用于构建其产品生态中的一致体验。[官方介绍](https://atlassian.design/)

- **重点**：团队协作、任务管理与清晰的信息结构。
- **风格概括**：现代 B2B SaaS，强调导航、状态、反馈和协作上下文。
- **适用场景**：项目管理、知识库、工单系统和团队工作空间。
- **取舍**：Jira、Confluence 等产品可作为体验参考；同属 Atlassian 的产品不一定使用完全相同的组件和布局。

### Shopify Polaris

Polaris 服务于 Shopify 应用与平台体验，当前官方文档以 Web Components 为基础，并按 App Home、Admin、Checkout、Customer accounts 和 POS 等界面划分可用能力。[官方文档](https://shopify.dev/docs/api/polaris)

- **重点**：商家操作、业务信息表达与平台一致性。
- **风格概括**：清晰、实用，重视表单、列表和操作反馈。
- **适用场景**：Shopify 应用、商品与订单管理、商家后台。
- **取舍**：可以借鉴其后台设计模式；具体组件与 API 的适用范围要按 Shopify 界面核对。商家后台效率也不等同于店铺前台转化率。

### Ant Design

Ant Design 面向企业级产品，结合设计价值观、模式和 React 组件，常用于中后台界面。[官方介绍](https://ant.design/docs/spec/introduce/)

- **重点**：业务操作效率、复杂表单、表格和一致的反馈。
- **风格概括**：结构明确、组件丰富，适合快速形成完整的业务界面。
- **适用场景**：管理系统、运营平台和企业应用。
- **取舍**：直接使用默认样式容易产生相似外观；品牌差异化需要主题令牌、布局和内容设计共同完成。
- **相关方案**：Ant Design Pro 可作为中后台应用脚手架与实践参考；它和 Ant Design 设计系统的层级不同。

### Tencent TDesign

TDesign 是腾讯开源协同建设的企业级设计体系与组件库，提供 Web、移动端和小程序等方向的实现。[官方仓库](https://github.com/Tencent/tdesign)

- **重点**：企业应用、多端一致性与设计开发协作。
- **风格概括**：简洁的业务界面，强调组件复用和主题定制。
- **适用场景**：企业后台、移动业务应用和小程序。
- **取舍**：应按目标框架与平台核对组件覆盖程度；TDesign 不能代表腾讯所有产品的视觉风格。

## 移动设备与跨设备生态

### Samsung One UI

One UI 是 Samsung Galaxy 生态的界面体系。其设计思路包括区分查看区域与交互区域，改善大屏设备上的单手操作体验。[Samsung 设计介绍](https://design.samsung.com/global/contents/one-ui/)

- **重点**：设备日常使用、易读性和触控可达性。
- **风格概括**：大标题、明确的触控区域和卡片式内容组织。
- **适用场景**：手机及 Galaxy 设备体验参考。

| 维度 | Material Design | One UI |
|------|-----------------|--------|
| 定位 | 可复用的设计规范与组件体系 | Galaxy 设备上的具体系统体验 |
| 布局 | 提供不同窗口尺寸下的适配模式 | 强调设备使用习惯与触控可达性 |
| 视觉 | 通过主题、颜色和组件建立一致性 | 在 Android 基础上形成 Samsung 的表达 |
| 使用方式 | 可用于自建应用的设计与实现 | 更适合作为设备交互的参考 |

两者处于不同层级，不能简单比较为“Material 紧凑、One UI 宽松”；实际密度与触控区域取决于设备、版本和页面任务。

### Huawei HarmonyOS 设计

HarmonyOS 的设计规范面向鸿蒙应用与设备体验，涉及布局、组件、动效和多设备适配。[官方设计入口](https://developer.huawei.com/consumer/cn/design/)

- **重点**：跨设备体验、内容组织和服务的便捷访问。
- **风格概括**：卡片化信息、连贯的转场与适配不同设备的界面结构。
- **适用场景**：鸿蒙应用、服务卡片和多设备协作。
- **取舍**：卡片、服务入口和跨设备能力分别涉及界面模式与平台能力；不能只凭外观将其等同于 iOS Widget、Material You 或其他手机系统。

## Web 开发中的组件与样式工具

这些工具可以帮助建立产品自己的设计系统，但提供的视觉与交互约束各不相同。

| 工具 | 类型 | 提供什么 | 团队仍需决定什么 |
|------|------|----------|------------------|
| Tailwind CSS | 实用类 CSS 框架 | 样式工具与主题配置能力 | 视觉语言、交互模式与组件结构 |
| Tailwind Plus（原 Tailwind UI） | 界面代码与模板资源 | 有既定视觉样式的组件示例与模板 | 品牌适配和业务流程 |
| Headless UI | 无样式组件 | 交互与无障碍基础 | 样式与布局 |
| Chakra UI | React 组件体系 | 可定制组件、主题与样式能力 | 产品主题和业务模式 |
| Radix Primitives | 无样式 React 组件原语 | 组合式交互、焦点与键盘行为 | 样式与完整业务组件 |
| shadcn/ui | 可直接纳入项目的组件源码 | 可修改、组合和扩展的组件代码 | 定制后的维护与一致性 |

Tailwind UI 已于 2025 年更名为 Tailwind Plus。它提供带样式的界面资源，不能与无样式的 Headless UI 混为一谈。[更名公告](https://tailwindcss.com/blog/tailwind-plus)、[界面示例](https://tailwindcss.com/plus/ui-blocks/application-ui)、[Headless UI](https://headlessui.com/)

Radix 需要区分 **Primitives** 与带视觉样式的 **Themes**。这里讨论的是无样式的 Primitives。[Radix Primitives 文档](https://www.radix-ui.com/primitives/docs/overview/introduction)

Chakra UI 提供可定制的组件体系；shadcn/ui 强调把组件源码纳入项目并由团队掌控。[Chakra UI](https://chakra-ui.com/)、[shadcn/ui 文档](https://ui.shadcn.com/docs)

无样式组件提高视觉自由度，也意味着团队要自行建立颜色、间距、字体、状态和组件规范。组件提供无障碍基础，最终体验仍需结合内容、组合方式和真实交互验证。

## 游戏、汽车与硬件界面

以下例子主要是具体产品的界面与交互实践，公开资料的完整程度与可复用组件覆盖不同于 Carbon、Ant Design 等设计系统。表中的风格与借鉴方向是对产品体验的归纳。

| 生态或产品 | 界面重点 | 可借鉴的方向 | 参考资料 |
|------------|----------|--------------|----------|
| Sony PlayStation | 游戏内容、控制中心与手柄导航 | 大屏内容入口、快捷操作与焦点反馈 | [PS5 控制中心](https://www.playstation.com/en-gb/support/games/customize-ps5-control-center/) |
| Nintendo Switch | 启动游戏与常用系统功能 | 清晰的主菜单与较少的操作层级 | [HOME 菜单说明](https://en-americas-support.nintendo.com/app/answers/detail/a_id/22308/~/home-menu-overview) |
| BMW iDrive | 车载信息娱乐与多种输入方式 | 常用功能入口、信息分层与设备适配 | [BMW iDrive 介绍](https://www.press.bmwgroup.com/usa/article/detail/T0410518EN_US/bmw-presents-the-new-bmw-idrive?language=en_US) |
| Tesla 车载界面 | 集中式触屏与车辆功能整合 | 统一信息布局和情境化控件 | [Model 3 触屏说明](https://www.tesla.com/ownersmanual/model3/en_ie/GUID-518C51C1-E9AC-4A68-AE12-07F4FF8C881E.html) |

车载界面还需要考虑驾驶中的可读性、操作负担和反馈。大屏、极简或减少实体控件都是设计选择，不能单独作为“低干扰”的证据；不同车型、硬件与软件版本也会影响体验。

## AI-native 界面趋势

“AI-native Design”可用来描述围绕 AI 能力组织产品体验的趋势，目前更适合作为设计思路，而非统一的设计系统名称。下面是交互模式的概括，并非产品普及度排名。

- **目标表达**：用户可以通过自然语言提出任务，也可以从按钮、表单和模板开始。
- **Agent 工作流**：界面需要表达计划、进度、中间结果、失败原因和用户可干预的步骤。
- **工作区与产物**：对话可与编辑器、预览、画布或结构化结果结合，支持持续修改。
- **情境化界面**：根据任务提供适合的控件与信息，同时保持稳定的导航和可预测的操作。

```text
传统交互的常见路径：菜单 → 页面 → 操作 → 结果
AI 辅助交互的一种路径：目标 → 计划／执行 → 产物 → 检查与修改
```

两种路径可以共存。设计重点是让用户理解系统正在做什么、结果来自哪里，以及何时可以修改、停止或撤销。视觉层仍可以建立在 Carbon、Fluent 或自建组件体系上。Carbon 已提供面向聊天、Agent 和自动化体验的 AI 设计方向。[Carbon for AI 入口](https://www.carbondesignsystem.com/)

## 按场景选型

以下是基于定位与实现方式的建议，不代表市场份额或流行度排名。

| 场景 | 可考虑的体系或组合 | 主要理由 |
|------|--------------------|----------|
| Apple 原生应用 | Apple HIG 与系统组件 | 符合平台交互与设备习惯 |
| 希望采用 Material 表达的应用 | Material Design 与目标框架的对应实现 | 使用统一的组件、主题和交互规则 |
| Microsoft 生态与协作产品 | Fluent / Fluent UI | 与该生态的视觉和组件模式协调 |
| 数据密集的企业平台 | Carbon | 企业模式与数据可视化资源 |
| 创作工具与专业工作台 | Spectrum | 可扩展的工具界面基础 |
| React 中后台 | Ant Design；需要应用框架时评估 Ant Design Pro | 表格、表单与业务界面支持 |
| Web、移动端与小程序业务 | TDesign | 多端实现与设计资源 |
| Shopify 应用 | Polaris | 对应平台界面和应用规范 |
| 需要品牌定制的 React SaaS / AI 产品 | shadcn/ui + Tailwind CSS，或 Radix Primitives + 自有样式 | 便于掌控组件代码与视觉表达 |
| 希望从可定制 React 组件体系起步 | Chakra UI | 组件与主题能力可统一使用 |

Material Design 与 Tailwind CSS 可以配合使用，但 Tailwind 只是样式实现工具，不会自动落实 Material 的组件行为和交互规范。同样，采用 shadcn/ui 也不意味着产品已经具备完整的设计系统。

实际评估时，可以选取一个包含表格、表单、弹窗、错误反馈和键盘操作的业务流程制作原型，对比组件覆盖、主题定制成本、无障碍表现与团队维护能力。AI 产品还应加入任务进度、结果编辑和失败恢复等场景。
