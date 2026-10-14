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

### shadcn/ui 详细介绍

#### 定位与工作方式

shadcn/ui 提供具有默认样式的组件，以及将代码分发到项目的工具。其核心是让团队掌控组件的上层源码：添加组件后，可以直接修改结构、样式和接口，并逐步形成自己的组件体系。[官方介绍](https://ui.shadcn.com/docs)

典型流程如下：

```text
选择组件与预设 → CLI 写入组件源码并安装依赖
→ 应用从本地文件导入 → 按产品需求修改 → 团队维护
```

例如，页面通常从 `@/components/ui/button` 导入按钮。这个文件属于项目，可以进入版本控制；底层交互库、图标等仍可作为 npm 依赖安装。因此，“源码可控”指的是可以定制的组件层，并不意味着全部依赖都复制进仓库。[Button 文档](https://ui.shadcn.com/docs/components/button)

#### 与 React、Tailwind 和组件原语的关系

| 层次 | 负责的内容 | 示例 |
|------|------------|------|
| React | 组件组织、状态与界面渲染 | 页面与业务组件 |
| 组件原语 | 焦点管理、键盘操作、弹层等交互基础 | Base UI、Radix UI、React Aria |
| Tailwind CSS | 样式类与主题令牌映射 | 间距、布局、颜色与状态样式 |
| shadcn/ui 组件 | 可修改的结构、默认样式与组合接口 | Button、Dialog、Select、Card |
| 产品业务层 | 数据、权限、任务流程与业务反馈 | 订单筛选、Agent 任务面板 |

早期常见组合是 Radix UI + Tailwind CSS；当前官方 CLI 已支持选择 Base UI、Radix UI 和 React Aria 等基础方案，不能将 shadcn/ui 固定理解为 Radix 的样式包装。不同方案的组件接口与组合方式可能不同，应以项目实际生成的代码为准。[CLI 文档](https://ui.shadcn.com/docs/cli)、[组件实现选项](https://ui.shadcn.com/docs/components/button)

官方提供 Next.js、Vite、React Router、Astro 等安装路径。这里介绍的是 React 组件体系；某个框架有安装指南，不代表其所有渲染模式都能直接使用交互组件。在 React Server Components 项目中，仍需处理客户端组件边界。[安装文档](https://ui.shadcn.com/docs/installation)、[项目配置](https://ui.shadcn.com/docs/components-json)

#### 视觉风格与主题定制

默认界面通常呈现简洁的表面、明确的边框、圆角和清晰的文字层级，适合作为 SaaS 的起点；这些是可修改的默认选择，不是产品必须遵守的品牌语言。

官方推荐通过 CSS 变量定义语义令牌，再由 Tailwind 映射为样式类。例如 `primary` 与 `primary-foreground` 分别表达主操作表面及其上的文字颜色；组件使用 `bg-primary`、`text-primary-foreground` 等类。深色主题覆盖同一套令牌，无需逐个重写控件。[主题文档](https://ui.shadcn.com/docs/theming)

| 定制层次 | 调整内容 | 实际用途 |
|----------|----------|----------|
| 主题令牌 | 品牌色、背景、文字、边框、焦点环与圆角 | 统一改变产品视觉 |
| 组件变体 | 按钮强调程度、尺寸和不同状态 | 建立稳定的控件规范 |
| 组件结构 | 子元素、布局、组合方式与交互接口 | 适配更具体的任务 |
| 页面模式 | 导航、表单流程、空状态与错误恢复 | 形成产品自己的体验 |

团队实践上，公共颜色与尺寸应优先放入令牌或统一变体。若每个页面都通过零散的 `className` 覆盖同一组件，后续统一调整会更加困难。

#### 入门示例

在已经完成对应框架、Tailwind 和导入别名配置的项目中，可以初始化并添加组件：

```bash
npx shadcn@latest init
npx shadcn@latest add button card
```

`init` 配置项目基础，`add` 按配置写入所选组件并处理依赖。`components.json` 记录样式、CSS 路径和导入别名等信息，供 CLI 使用；手动复制组件时不一定需要它。新项目也可以通过官方可视化入口选择预设并生成安装命令。[CLI 文档](https://ui.shadcn.com/docs/cli)、[配置说明](https://ui.shadcn.com/docs/components-json)、[安装入口](https://ui.shadcn.com/docs/installation)

下面展示本地按钮组件的使用方式，假设 `@/` 已映射到正确目录：

```tsx
import { Button } from "@/components/ui/button"

export function TaskActions() {
  return (
    <div className="flex gap-2">
      <Button type="button">创建任务</Button>
      <Button type="button" variant="outline">查看历史</Button>
    </div>
  )
}
```

示例只展示控件与样式，业务事件由应用接入。安装命令中的 `@latest` 会随发布变化；正式项目应记录所用 CLI、依赖版本和预设，便于团队复现。[Button 用法](https://ui.shadcn.com/docs/components/button)

#### 组件、组合示例与 Registry

按钮、输入框和卡片是基础积木；弹窗、菜单和选择器还依赖交互原语。复杂界面通常需要继续组合：例如官方 Data Table 指南通过 Table 与 TanStack Table 构建排序、筛选、分页和选择能力，而不是一个已包办所有业务需求的数据表格组件。[Data Table 指南](https://ui.shadcn.com/docs/components/data-table)

Registry 是代码分发机制，可以发布自定义组件、Hooks、页面、配置及其他文件。团队可以借此向多个项目分发统一的业务组件；Registry 机制本身也不限于 React。[Registry 文档](https://ui.shadcn.com/docs/registry)

这使 shadcn/ui 可以作为内部设计系统的起点，但组件说明、版本管理、变更记录和跨项目升级策略仍需要团队建设。

#### 优势与维护成本

以下取舍是基于源码分发与本地定制方式的工程判断：

| 维度 | 带来的价值 | 团队承担的工作 |
|------|------------|----------------|
| 定制 | 可以直接修改组件源码 | 维护修改后的行为与接口 |
| 组合 | 可逐步抽取业务组件 | 统一组合规则与状态表达 |
| 升级 | 可以选择性吸收上游变化 | 对比本地修改、合并修复并验证 |
| 无障碍 | 交互原语提供基础能力 | 验证标签、对比度、焦点和键盘流程 |
| 多项目复用 | Registry 可分发公共代码 | 管理版本、兼容性与项目间差异 |

已经复制并修改的组件不会仅因更新 CLI 或底层依赖就自动获得全部上游改动。建议把通用组件与业务组件分层，记录定制原因，并在接入上游修复时检查受影响的交互。

#### 适用场景与 AI 产品

如果团队使用 React，需要品牌定制，并愿意维护组件源码，shadcn/ui 可以作为 SaaS、管理工具和 AI 工作区的起点。若项目更看重完整的企业组件覆盖与统一升级，可以同时评估 Ant Design 或其他组件体系，而不是只比较默认外观。

源码开放、组合接口和现成组件便于 AI 辅助工具读取并修改界面，这是官方强调的设计方向；它并不能直接证明某种市场占有率或流行度排名。[官方设计原则](https://ui.shadcn.com/docs)

对 AI 产品而言，组件可以承载消息、任务状态、工具结果和编辑区。产品仍需设计取消与重试、长任务进度、结果检查和失败恢复；使用 shadcn/ui 不会自动补齐这些工作流。

如果希望构建跨框架的标准组件体系，可以参考 [Lit 框架简介与跨框架组件设计](lit.md)，其中讨论了用 Web Components 实现组件时的 API、主题与适配成本。

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
