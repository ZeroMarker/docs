# Web 原生开发路线与选型

Web 原生开发以 HTML、CSS、JavaScript 和浏览器 API 为基础，可以直接实现页面，也可以配合小型库、标准组件或服务端渲染。选型的重点是哪些能力由平台承担、哪些能力仍需应用实现，以及团队是否愿意维护这些边界。

本文核对日期：2026-10-14。本文依据平台与项目文档整理，不将“无框架重新成为主流”作为已证实的市场结论。相关内容见 [前端框架对比](frontend.md)、[Lit 框架简介](lit.md)和 [Web Components 组件库选型](web-components-libraries.md)。

## 先区分三个概念

| 概念 | 含义 | 例子 |
|------|------|------|
| 不采用大型客户端 UI 框架 | 页面不依赖 React、Vue、Angular 等组织全部 UI | DOM 操作、Web Components、服务端 HTML 增强 |
| 零第三方运行时依赖 | 浏览器中只运行项目代码与平台能力 | 手写 JavaScript 和原生自定义元素 |
| 无构建开发（buildless） | 开发阶段不要求打包或预编译全部代码 | 浏览器直接加载 JavaScript ES Modules |

三者并不等同：Lit、HTMX、Alpine 或 Signals 库都有第三方运行时代码；Vite、TypeScript 等开发工具也可以用于不采用大型 UI 框架的项目。

浏览器支持 JavaScript 模块，不代表可以直接执行 TypeScript、JSX 或解析所有 npm 包名。包名导入需要 Import Maps、开发服务器解析或构建工具等配合。[模块文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)、[Import Maps](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/script/type/importmap)

## 路线一：Vanilla JavaScript 与 Web API

直接使用 DOM、事件与浏览器 API 是依赖最少的起点。

| 能力 | 可用基础 | 应用仍需处理的内容 |
|------|----------|--------------------|
| 模块组织 | ES Modules | 模块边界、加载与依赖解析 |
| 页面更新 | DOM API、事件 | 状态到界面的同步规则 |
| 数据请求 | Fetch API | 错误、取消、缓存与请求竞态 |
| 导航 | 链接、History API、Navigation API | 页面匹配、数据加载、错误与滚动恢复 |
| 持久化 | Web Storage、IndexedDB | 数据结构、过期、迁移与同步 |
| 后台计算 | Web Workers | 消息传递、结果同步与任务取消 |

这些 API 提供机制，不会自动组成完整的应用架构。

### 最小模块示例

创建 `hello.js`：

```js
export function hello(name) {
  return `Hello, ${name}`;
}
```

页面中使用模块与 DOM 更新：

```html
<h1 id="greeting"></h1>

<script type="module">
  import { hello } from "./hello.js";

  document.querySelector("#greeting").textContent = hello("World");
</script>
```

通过 HTTP 开发服务器访问这些文件。示例使用 `textContent` 表达文本，不把字符串拼接成 HTML；处理真正的 HTML 内容时，应单独设计其可信来源与插入方式。[JavaScript 模块](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)

### 适用场景与成本

内容站、浏览器工具、嵌入控件、局部交互和流程较简单的应用，可以从这条路线开始。管理后台也可以采用，但筛选、表单联动、权限和异步操作越复杂，越需要明确的数据流与组件规范。

减少依赖可以缩小升级范围，却不保证长期维护成本一定更低。若团队反复手写状态同步、路由和控件行为，就需要比较自建基础的成本与采用成熟工具的成本。

## 路线二：Web Components

Web Components 是一组平台技术，包括自定义元素、Shadow DOM，以及 HTML 模板和插槽。它们允许通过标准标签定义可复用组件，不要求宿主页面采用某个 UI 框架。[平台概览](https://developer.mozilla.org/en-US/docs/Web/API/Web_components)

下面是不引入组件库的示例：

```html
<my-button></my-button>

<script type="module">
  class MyButton extends HTMLElement {
    constructor() {
      super();
      const root = this.attachShadow({ mode: "open" });
      const button = document.createElement("button");
      button.type = "button";
      button.textContent = "点击";
      root.append(button);
    }
  }

  customElements.define("my-button", MyButton);
</script>
```

这只展示自定义元素与 Shadow DOM。公开属性、状态更新、事件协议、样式主题与表单行为，仍需继续实现。

### Lit、Open Web Components 与现成 UI 库

| 项目方向 | 承担的职责 | 进一步阅读 |
|----------|------------|------------|
| Lit | 用响应式属性与模板简化自定义元素开发 | [Lit 框架简介](lit.md) |
| Open Web Components | 提供开发、测试、发布等实践与工具建议 | [Open WC 开发指南](https://open-wc.org/guides/developing-components/going-buildless/) |
| Web Awesome、Carbon、Spectrum 等 | 提供可直接使用的控件及主题 | [组件库分类与选型](web-components-libraries.md) |

Open WC 展示了利用浏览器模块加载与开发服务器进行 buildless 开发的路线。实际项目仍可能需要转换 TypeScript、解析依赖和优化生产产物；无构建开发不等于没有开发工具。

Shoelace 已停止活跃开发，新项目应结合 Web Awesome 等当前候选评估。不要将旧教程中的组件清单视为现行 API，具体范围见组件库文档。

### 设计系统与微前端

标准元素可以成为跨技术栈的组件接口，例如 `<company-button>` 或 `<company-dialog>`。团队仍需管理对象属性、自定义事件、注册冲突、类型、主题与宿主适配。

Web Components 可以用于微前端边界，但不会自动解决应用间的路由、依赖版本、权限、通信和部署问题。共享控件与独立应用整合是不同层面的工作。

## 路线三：服务端 HTML 与渐进增强

页面或局部内容由服务器生成，客户端通过少量代码增强操作。这样可以将部分页面状态留在服务端，也可以保留标准链接与表单作为基础。

### HTMX：通过 HTML 属性组织请求与局部替换

HTMX 是第三方库，可通过 `hx-*` 属性发起请求并将返回内容放入指定区域。[官方文档](https://htmx.org/docs/)

在已加载 HTMX 的页面中：

```html
<button type="button" hx-post="/save" hx-target="#result">
  保存
</button>
<div id="result" aria-live="polite"></div>
```

服务器需要实现 `/save`，并返回适合该目标区域的 HTML。鉴权、表单验证、加载反馈、失败处理和请求保护仍属于应用职责。适合列表、表单、后台流程等可以清楚划分服务端请求边界的场景；网络延迟和高频本地交互也应纳入评估。

### Alpine.js：在 HTML 中组织局部状态

Alpine 通过 HTML 指令表达状态、事件和显示逻辑，适合在已有页面中加入局部交互。[官方入门](https://alpinejs.dev/start-here)

在已加载 Alpine 的页面中：

```html
<div x-data="{ open: false }">
  <button type="button" @click="open = !open" :aria-expanded="open">
    展开说明
  </button>
  <p x-show="open">这里是补充信息。</p>
</div>
```

HTMX 与 Alpine 可以结合：前者处理请求和 HTML 替换，后者处理局部客户端状态。必须约定哪一层拥有某个 DOM 区域、替换后如何初始化，以及状态是否需要保留，避免多个工具同时管理同一段界面。

## 路线四：按需引入响应式能力

响应式库可以减少手工同步状态的工作，但自动追踪数据与自动渲染 UI 不是同一件事。

| 方案 | 提供什么 | 边界与注意事项 |
|------|----------|----------------|
| Preact Signals Core | Signal、派生值与副作用 | 可以单独评估核心包；DOM 更新与副作用清理仍需安排 |
| Solid 的响应式 API | Signal 与响应式计算等能力 | 属于 Solid 技术体系；采用它并不等于使用浏览器内置响应式 |
| Alpine.js | HTML 指令与局部响应式状态 | 是页面增强库，也承担部分渲染职责 |
| petite-vue | 面向渐进增强的 Vue 子集 | 有运行时依赖；范围不同于完整 Vue 应用框架 |

参考：[Preact Signals](https://preactjs.com/guide/v10/signals/)、[Solid Signals](https://docs.solidjs.com/concepts/signals)、[petite-vue](https://github.com/vuejs/petite-vue)。

截至本文核对日期，TC39 Signals 仓库仍将其标记为提案，不能将它当作已普遍可用的浏览器内置 API。生产项目使用的 Signals 通常来自具体库或实现，应核对其接口与运行时依赖。[Signals 提案](https://github.com/tc39/proposal-signals)

## 原生能力与应用架构的边界

### 原生导航 API 不是完整应用路由

History API 提供历史记录与地址相关机制；Navigation API 进一步提供导航事件和拦截等能力。页面匹配、数据加载、缓存、错误界面与滚动恢复仍需应用或路由库安排，并核对目标浏览器的支持情况。[History API](https://developer.mozilla.org/en-US/docs/Web/API/History_API)、[Navigation API](https://developer.mozilla.org/en-US/docs/Web/API/Navigation_API)

因此，技术栈中应写明“基于 History / Navigation API 的导航实现”或具体路由库，而不是用 `native router` 暗示浏览器已提供完整 SPA 路由器。

### 原生 UI 与样式能力按需使用

`<dialog>` 与 Popover API 可以承担部分弹层能力，但应用仍需设计标签、焦点、键盘行为与完整操作流程。[Dialog 文档](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dialog)、[Popover API](https://developer.mozilla.org/en-US/docs/Web/API/Popover_API)

CSS Modules 是开发工具处理的样式方案，不是仅因浏览器支持 ES Modules 就自动可用的 CSS 能力。与 Shadow DOM 结合时，需要确认样式实际加载在哪个 DOM 范围。[Vite CSS Modules](https://vite.dev/guide/features.html#css-modules)

## 按任务选择组合

以下是工程判断，不代表“简单项目只能原生、大型应用只能框架”的限制。

| 任务 | 可从什么组合开始 | 核心判断 |
|------|------------------|----------|
| 内容站与少量交互 | 服务端或静态 HTML + CSS + ES Modules | 初始内容、加载成本与渐进增强 |
| 独立浏览器工具 | Vanilla JS 或 Lit + 按需数据工具 | 状态复杂度与控件复用 |
| 表单、列表为主的后台 | 服务端 HTML + HTMX；按需加入 Alpine 或标准控件 | 请求边界、延迟与局部状态归属 |
| 跨框架设计系统 | Web Components + Lit / FAST 或现成组件库 | API、主题、接入和长期维护 |
| 复杂工作台与高频客户端交互 | React / Vue / Svelte / Angular，或有明确架构的原生方案 | 数据流、工具链、控件与团队经验 |

应用框架及其生态可以提供已有的组件组织、路由、数据工具与实践，减少团队自建基础的工作。它们也有依赖升级、运行时和学习成本，应通过实际业务比较，而不是单凭包大小、招聘印象或流行度判断。

一个面向标准组件的组合可以是：

```text
开发：Vite + TypeScript
组件：Lit + Web Components
样式：CSS 自定义属性 + 组件内部样式
数据：Fetch API + 明确的数据与缓存策略
导航：普通链接，或按需实现客户端路由
```

也可以不使用 Lit 或 Vite，直接开发 JavaScript 模块；只有确实需要某项能力时再增加工具。浏览器 API、组件库、服务端增强与应用框架可以共存，不能用时间线将它们解释为必然的替代顺序。

评估时应选择一个真实流程，验证初始加载、表单错误、异步请求、后退恢复、键盘操作与部署方式。衡量的是最终产品的复杂度与维护成本，而不是工具名称中的“原生”或“无框架”。
