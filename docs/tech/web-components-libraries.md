# Web Components 组件库分类与选型

选择 Web Components 路线时，需要先区分“直接使用完整 UI 库”和“构建设计系统基础”。Web Awesome、Carbon、Spectrum 等提供既定视觉与控件；Lion、FAST 和 Lit 更适合承担组件开发或定制基础，具体职责仍有差异。

本文核对日期：2026-10-14。技术基础见 [Lit 框架简介与跨框架组件设计](lit.md)，设计体系与 shadcn/ui 的工作方式见 [现代设计语言与设计体系](design-systems.md)。

## 分类与共同边界

| 类别 | 主要提供什么 | 代表 |
|------|--------------|------|
| 完整 UI 组件库 | 控件、默认视觉、主题与交互接口 | Web Awesome、Fluent UI Web Components、Carbon Web Components、Vaadin、Spectrum Web Components |
| 可扩展组件基础 | 可复用的交互、表单与验证能力，供团队建立自己的视觉 | Lion |
| 组件开发工具 | 模板、响应式更新、组件定义等开发能力 | Lit、FAST |
| 历史项目 | 旧系统维护与迁移参考 | Shoelace |

“不绑定 React/Vue”表示组件使用标准自定义元素接口，不代表库内部没有运行时依赖。Custom Elements、Shadow DOM 属于 Web Components 相关能力，CSS 自定义属性是常用主题机制；不应把它们当成几个互相独立的框架。

跨框架复用也要安排模块加载、组件注册、对象属性、自定义事件、类型声明与 SSR。即使 HTML 标签相同，宿主框架的接入配置仍可能不同，详见 [Lit 的跨框架接入说明](lit.md)。

## 主要组件库

### Web Awesome：通用 UI 与主题

Web Awesome 起源于 Shoelace，提供框架无关的 UI 组件、主题和样式工具。它更接近可直接使用的 UI 库：先加载组件与主题，再通过自定义元素组织页面。[官方介绍](https://webawesome.com/)、[安装文档](https://webawesome.com/docs/)

完成加载后，可以使用以下标记：

```html
<wa-button variant="brand">保存</wa-button>
```

- **常用控件**：按钮、输入框、选择器、弹窗、抽屉、菜单、标签页、卡片与反馈控件。
- **适用方向**：通用 SaaS、内部工具和需要跨框架复用控件的产品。
- **定制方式**：通过主题令牌、CSS 自定义属性及组件开放的接口调整；深度修改要结合 Shadow DOM 边界评估。
- **许可范围**：核心开源组件与 Pro 能力需要区分。当前官方目录将 Date Picker、Combobox 和部分数据可视化能力标为 Pro，不能把整个组件目录视为免费覆盖。[组件与 Pro 标记](https://webawesome.com/)

Web Awesome 可以减少通用控件的实现工作，但默认视觉、组件 API 和分发方式与 shadcn/ui 不同。它是否适合作为替代方案，取决于项目更重视现成控件还是本地源码定制。

### FAST 与 Fluent UI Web Components：开发基础与微软视觉

FAST 提供构建 Web Components 的技术基础；Fluent UI Web Components 提供采用 Fluent 设计语言的具体控件。两者处于不同层级，也都不属于 Lit 的下游组件库。[FAST](https://fast.design/)、[Fluent 官方仓库](https://github.com/microsoft/fluentui/tree/master/packages/web-components)

```text
Fluent 设计语言 → Fluent UI Web Components 的视觉与控件
FAST 技术体系 → 组件实现、模板与相关集成基础
```

完成对应版本的组件注册与主题设置后，可使用：

```html
<fluent-button>保存</fluent-button>
```

- **适用方向**：希望采用 Fluent 表达的企业软件、协作工具和 Microsoft 生态产品。
- **选型重点**：确认目标版本的按钮、表单、菜单、弹层等组件覆盖，以及主题和服务端集成方式。
- **工程区别**：选择 FAST 自建控件和选择 Fluent 成品库是两项决策。不同主要版本的注册方式与组件范围可能变化，不宜混用教程中的安装步骤。[当前使用与主题说明](https://github.com/microsoft/fluentui/tree/master/packages/web-components)

无障碍支持应在真实业务组合中验证，不能仅凭品牌或组件库定位认定应用已经满足全部无障碍要求。

### Carbon Web Components：Carbon 的标准组件实现

Carbon 的 Web Components 实现使用 `@carbon/web-components` 包，当前代码位于 Carbon 主仓库的 `packages/web-components`。旧的 `carbon-web-components` 独立仓库已归档，应从当前入口查看安装和迁移说明。[当前实现](https://github.com/carbon-design-system/carbon/tree/main/packages/web-components)、[旧仓库状态](https://github.com/carbon-design-system/carbon-web-components)

- **定位**：将 Carbon 的组件与企业设计规范用于标准自定义元素。
- **适用方向**：云控制台、数据平台、运营后台，以及已有 Carbon 设计基础的企业产品。
- **选型重点**：核对实际版本中的表单、数据表格、弹层和通知等能力；复杂数据交互仍需业务层实现。
- **版本事项**：注册机制可能随主要版本变化。遵循所用版本的文档，不要假设导入任意组件类文件就一定完成元素注册。[包使用与迁移说明](https://github.com/carbon-design-system/carbon/tree/main/packages/web-components)

Carbon 的场景定位可以作为候选筛选依据，但不意味着所有金融、工业或高密度后台都应默认采用它。

### Lion：可扩展的设计系统基础

Lion 使用 LitElement 作为基础，强调可扩展、无障碍与白标定制。其目标是帮助团队建立设计系统，减少对既定品牌样式的依赖。[官方介绍](https://lion.js.org/)

- **提供的方向**：表单、验证和交互基础；具体组件应按当前目录核对。
- **适用方向**：团队已有品牌规范，并愿意实现和维护自己的组件视觉与 API。
- **取舍**：白标不等于所有组件完全没有样式；团队仍需处理结构、样式、状态与接入规则。

可以将 Lion 与 Radix Primitives 类比为“重视交互基础、便于建立自己的组件体系”，但二者的技术模型、组件覆盖和扩展接口不同，不能直接替换。Lit 与 Lion 也并非两个互相独立的必装层：Lion 本身已经基于 Lit。

### Vaadin Web Components：企业表单与数据控件

Vaadin 提供面向企业 Web 应用的组件，涵盖 Grid、表单和日期输入等方向。其 Web Components 可用于 JavaScript 项目，也可结合 Vaadin 的 Java 应用开发体系；并不要求使用 Java 后端。[官方组件介绍](https://vaadin.com/components)、[Web Components 仓库](https://github.com/vaadin/web-components)

- **适用方向**：复杂表单、数据管理界面，以及已有 Vaadin 技术基础的项目。
- **选型重点**：验证排序、筛选、虚拟滚动、编辑与服务端数据加载是否符合业务需求。
- **许可范围**：核心开源组件与商业组件并存。图表等功能应按具体组件许可核对，不宜把平台能力全部归入免费基础库。[许可说明](https://vaadin.com/components)

### Spectrum Web Components：Adobe 设计体系

Spectrum Web Components 是 Adobe Spectrum 的 Web Components 实现，使用 LitElement 构建，可在不同 Web 框架中使用。[官方介绍](https://opensource.adobe.com/spectrum-web-components/)

- **定位**：通过标准自定义元素呈现 Spectrum 的视觉与交互。
- **适用方向**：创意工具、专业工作台，以及希望采用 Spectrum 规范的产品。
- **选型重点**：核对所需控件的当前实现、主题与密度设置，而不是只比较深色外观。

在加载对应组件与主题后，按钮可以写为：

```html
<sp-button variant="accent">保存</sp-button>
```

### Shoelace：旧项目与迁移

Shoelace 使用 `<sl-*>` 标签，是 Web Awesome 的前身。官方目前明确标注项目已进入 sunset 状态，没有活跃开发，并将后续功能与问题处理引导至 Web Awesome。[Shoelace 官方说明](https://shoelace.style/)

维护已有 Shoelace 项目时，应评估迁移指南中的标签、属性、事件和样式变化，而不是只将 `sl-` 前缀替换为 `wa-`。新项目应优先评估仍在发展的候选方案。

## 与 shadcn/ui 的关系

“像 shadcn”可能指相似的视觉、可组合的接口，或把源码纳入项目的分发方式。三者是不同的目标：

| 目标 | 应关注的能力 | 可评估的方向 |
|------|--------------|--------------|
| 简洁的 SaaS 外观 | 主题令牌、密度、字体与布局 | 现成组件库的主题定制 |
| 自主定义组件 API | 交互基础、扩展方式与类型 | Lion，或用 Lit / FAST 自建 |
| 修改项目内的组件源码 | 源码分发、上游合并与升级策略 | 自建源码体系；不能由采用 Web Components 自动获得 |
| 多技术栈共享控件 | 标准元素接口与宿主适配 | Web Components 组件库或自建元素 |

因此，Web Awesome 是“现成控件”的候选，Lion 是“自建设计系统基础”的候选；没有统一证据可以把它们分别称为最成熟或最像 shadcn 的方案。

## AI WebUI、Agent 与开发工具的方案

下面是基于需求的工程建议，不是市场排名，也不表示这些组合会自动形成 Linear、Vercel 等产品的风格。

### 方案 A：先使用通用控件

```text
宿主应用 + Web Awesome + 主题令牌 + 构建工具
```

适合希望先完成任务面板、设置页和通用操作界面的产品。自定义业务控件可以用 Lit 开发，但仅使用 Web Awesome 时，不必额外选 Lit 作为应用框架。

### 方案 B：建立自己的组件体系

```text
设计令牌 + 交互规范
    ↓
基于 Lit 的组件（按需采用 Lion 基础）
    ↓
组件文档、浏览器测试与宿主适配
```

适合需要长期控制品牌、接口和组件源码的团队。Storybook 可用于展示控件与状态，浏览器测试用于验证焦点、弹层、输入与跨框架行为。Tailwind 可以组织宿主页面样式；组件内部则需明确 CSS 如何加载及令牌如何传入，不能假设全局 Tailwind 类会穿透 Shadow DOM。

### 方案 C：采用已有企业设计规范

```text
Fluent UI Web Components / Carbon / Vaadin
    ↓
产品主题 + 数据与权限层 + 业务组件
```

适合有明确企业风格、已有技术基础，或复杂表格表单需求的产品。Spectrum 则可作为专业工作台方向的候选。

AI 界面还需自行处理流式输出、任务进度、取消重试、工具结果与失败恢复；这些不是采用某个通用控件库后自动具备的产品能力。

## 对比与验证

| 候选 | 主要定位 | 视觉自主程度 | 需要优先验证的事项 |
|------|----------|--------------|--------------------|
| Web Awesome | 通用 UI 成品库 | 通过主题与组件接口调整 | 组件范围、Pro 边界与深度定制 |
| Fluent UI Web Components | Fluent 风格成品库 | 受 Fluent 规范与主题能力影响 | 版本、注册方式与组件覆盖 |
| Carbon Web Components | 企业设计体系实现 | 受 Carbon 规范与主题能力影响 | 当前包入口、数据交互与版本迁移 |
| Spectrum Web Components | Spectrum 设计体系实现 | 受 Spectrum 规范与主题能力影响 | 专业控件、主题与布局密度 |
| Vaadin | 企业表单与数据组件 | 通过主题与组件 API 调整 | 数据能力、性能与组件许可 |
| Lion | 可扩展交互与组件基础 | 由团队建立视觉 | 覆盖范围、扩展成本与无障碍回归 |
| Lit / FAST 自建 | 组件开发基础 | 由团队决定 | 控件实现、测试、维护与分发成本 |
| Shoelace | 历史 UI 库 | 适合已有项目维护 | 停止活跃开发后的迁移安排 |

建议用同一个业务流程比较候选：带验证的表单、含筛选与分页的表格、弹窗、深色主题和键盘操作。如果产品需要多个宿主框架或 SSR，就把这些接入也纳入原型。判断依据应是业务覆盖、实际表现和维护成本，而不是没有统一标准的星级评分。
