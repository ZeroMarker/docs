# Lit 框架简介与跨框架组件设计

Lit 是起源于 Google Web Components 技术工作的轻量级开源 UI 库，用响应式属性、声明式模板和组件基类，简化标准 Web Components 的开发。它可以开发独立控件、设计系统，也可以构建完整的 Web 应用。[官方介绍](https://lit.dev/docs/)

本文核对日期：2026-10-14。相关比较见 [前端框架对比](frontend.md)，设计体系与 shadcn/ui 介绍见 [现代设计语言与设计体系](design-systems.md)。

## 定位：标准组件与开发体验

Web Components 是一组浏览器能力，主要包括 Custom Elements、Shadow DOM，以及模板与插槽相关机制。Lit 在这些能力之上提供开发便利，不会把它们替换成专属的浏览器标准。

```text
组件实现：LitElement + 响应式属性 + Lit 模板
    ↓
组件边界：Custom Element + 默认 Shadow DOM
    ↓
使用环境：普通 HTML / React / Vue / 其他 Web 应用
```

例如，注册后的 `<my-button>` 是浏览器认识的自定义元素。使用方不需要采用 Lit 编写页面，但仍须加载组件 JavaScript 及其 Lit 运行时依赖。“原生组件”描述的是组件边界与浏览器机制，不等于“没有运行时”。[组件定义](https://lit.dev/docs/components/defining/)

Lit 与 React、Vue 的职责存在重叠：都能组织组件并更新界面。差异在于 Lit 以浏览器自定义元素作为组件边界，尤其适合跨技术栈分发；因此可以和应用框架一起使用，也可以独立构建应用。

## 一个完整的基础组件

下面用 JavaScript 和 `static properties` 展示响应式行为，避免示例依赖特定 TypeScript 装饰器配置。在已经配置模块解析的项目中安装依赖：

```bash
npm install lit
```

创建 `src/components/my-button.js`：

```js
import { LitElement, html, css } from "lit";

export class MyButton extends LitElement {
  static properties = {
    name: { type: String },
    count: { state: true },
  };

  static styles = css`
    button {
      padding: 0.5rem 1rem;
      border: 1px solid currentColor;
      border-radius: 0.5rem;
      color: var(--ui-button-color, #1d4ed8);
      background: transparent;
      font: inherit;
      cursor: pointer;
    }

    button:focus-visible {
      outline: 2px solid currentColor;
      outline-offset: 2px;
    }
  `;

  constructor() {
    super();
    this.name = "World";
    this.count = 0;
  }

  render() {
    return html`
      <button type="button" @click=${() => this.count++}>
        Hello ${this.name} · ${this.count}
      </button>
    `;
  }
}

customElements.define("my-button", MyButton);
```

在入口模块中加载组件，再在页面中使用：

```js
import "./components/my-button.js";
```

```html
<my-button name="Alice"></my-button>
```

浏览器会在注册后将匹配元素升级为组件；点击内部按钮改变 `count`，Lit 会安排界面更新。示例保留原生 `<button>` 的基本交互语义，但没有实现表单提交或完整组件库功能。[响应式属性](https://lit.dev/docs/components/properties/)、[模板表达式](https://lit.dev/docs/templates/expressions/)

## 核心机制

### 响应式属性与内部状态

公开属性是组件 API，内部状态用于组件自己的显示逻辑。上例的 `name` 默认关联同名 HTML attribute，而 `count` 使用 `state: true`，不会作为 HTML attribute 暴露。

属性赋值触发的是异步、可合并的更新，不是每次赋值立即重建 DOM。需要读取更新后的界面时，可以等待 `element.updateComplete`。数组或对象的原地修改通常不会改变引用，应采用重新赋值等方式触发更新。[属性机制](https://lit.dev/docs/components/properties/)、[更新生命周期](https://lit.dev/docs/components/lifecycle/)

TypeScript 也可以通过 `@property()` 和 `@state()` 声明属性。使用时要区分实验性装饰器与标准装饰器配置；标准写法通常使用 `accessor`，不能把不同配置下的字段语法直接混用。[装饰器文档](https://lit.dev/docs/components/decorators/)

### 模板与真实 DOM 更新

`html` 是 JavaScript 标签模板函数。它产生由 Lit 渲染系统处理的模板结果，而不是浏览器直接执行的 HTML 字符串。Lit 跟踪动态位置并更新 DOM，不需要构建整棵虚拟 DOM 树进行比较。[模板概览](https://lit.dev/docs/templates/overview/)

```js
html`
  <user-card .user=${user}></user-card>
  <button ?disabled=${busy} @click=${save}>保存</button>
`;
```

| 写法 | 含义 | 适用数据 |
|------|------|----------|
| `name=${value}` | HTML attribute 绑定 | 字符串或可序列化值 |
| `.user=${user}` | DOM property 绑定 | 对象、数组等 JavaScript 值 |
| `?disabled=${busy}` | 布尔 attribute 的存在与移除 | 布尔状态 |
| `@click=${save}` | 事件监听器绑定 | 回调函数 |

区分 attribute 和 property 对跨框架组件尤其重要：HTML attribute 本质上是字符串，不能直接承载任意 JavaScript 对象。[表达式文档](https://lit.dev/docs/templates/expressions/)

### Shadow DOM 与样式边界

LitElement 默认在 Shadow DOM 中渲染，将组件内部结构与样式选择器隔离。页面上的普通 CSS 选择器不会直接匹配内部按钮，组件自己的样式也不会泄漏到外部。[Shadow DOM 文档](https://lit.dev/docs/components/shadow-dom/)

样式边界仍允许有意设计的主题入口，例如继承的 CSS 自定义属性、`::part()` 和插槽。上例可以由宿主页面设置颜色：

```css
my-button {
  --ui-button-color: #047857;
}
```

Shadow DOM 的隔离也有成本：宿主页面的 Tailwind 类或全局重置样式不会自动作用于组件内部。组件体系需要明确哪些令牌、部件和插槽属于公共 API。[样式文档](https://lit.dev/docs/components/styles/)

## 与 React、Vue 的比较

| 维度 | Lit | React / Vue |
|------|-----|-------------|
| 组件边界 | 浏览器 Custom Elements | 框架组件模型；也可与自定义元素结合 |
| 模板 | JavaScript 标签模板 | React 常用 JSX；Vue 常用模板或渲染函数 |
| 更新方式 | 更新模板中的动态 DOM 位置 | 使用各自的渲染与更新机制 |
| 运行时 | 需要 Lit 运行时代码 | 需要对应框架运行时 |
| 样式 | 默认 Shadow DOM 隔离 | 由框架与所选样式方案决定 |
| 跨框架分发 | 自定义元素可作为共同接口 | 通常需要适配或转换组件边界 |
| 应用级能力 | 路由、数据与构建方案按需组合 | 可结合对应的应用框架与生态 |
| 原生移动端 | 本身面向 Web | React Native 是独立的原生应用技术栈；Vue 本身也不是原生移动运行时 |

包体积应比较相同业务、依赖与生产构建，不能用固定大小或星级代替选型。Lit 的组件模型偏轻量，但复杂控件、图标、国际化与适配层都会增加最终产物。

### 跨框架接入并非完全相同

简单的标签、字符串属性与插槽内容可以共享，但完整接入还涉及模块注册、对象属性、自定义事件、类型和服务端渲染。

- **React**：React 19 改进了 Custom Elements 支持。需要明确的属性、事件映射与类型接口时，可以评估 `@lit/react` 包装器。[React 19 说明](https://react.dev/blog/2024/12/05/react-19)、[Lit React 集成](https://lit.dev/docs/frameworks/react/)
- **Vue**：通常需要通过编译器的 `isCustomElement` 配置识别自定义元素；遇到属性判断不符合预期时，可以显式指定 property 绑定。[Vue Web Components 指南](https://vuejs.org/guide/extras/web-components.html)
- **普通 HTML / CMS**：需要加载注册组件的模块；对象数据和复杂事件往往由额外 JavaScript 接入。

### SSR 与水合

Lit 提供服务端渲染方案，但官方仍将相关能力置于 Lit Labs，需关注实验状态、组件编写限制与框架集成。服务端输出 HTML、浏览器恢复交互以及自定义元素注册是不同步骤，不能只标注“支持 SSR”就认为可直接接入任意应用框架。[SSR 概览](https://lit.dev/docs/ssr/overview/)

## 用 Lit 构建类似 shadcn/ui 的组件体系

这个方向指的是借鉴 shadcn/ui 的源码可控、主题令牌与组件组合方式，用 Lit 重新实现标准自定义元素。它不意味着 shadcn/ui 的 React 源码可以直接变成 Lit 组件。

```text
设计令牌 + 组件 API + 交互规范
    ↓
Lit 自定义元素：按钮、弹窗、菜单、表单控件
    ↓
React / Vue / 其他宿主的接入与类型适配
    ↓
各产品的业务组件与页面
```

需要自行完成的工作包括：

1. **设计 API**：区分属性、事件、插槽和公开方法，避免暴露内部实现。
2. **实现交互**：焦点管理、键盘导航、弹层关闭和表单行为需要完整设计；React 组件原语不能直接在 Lit 中使用。
3. **建立主题**：定义 CSS 变量与部件入口，处理 Shadow DOM 和宿主样式之间的边界。
4. **提供适配**：补充框架包装器、类型声明、SSR 说明和使用示例。
5. **管理分发**：决定发布预构建组件包，还是分发源码；Lit 本身没有规定必须采用 shadcn/ui 的分发方式。

可将项目组织为以下结构；这是工程建议，不是 Lit 强制的目录规范：

```text
my-ui/
├── src/
│   ├── components/
│   │   ├── button.ts
│   │   ├── dialog.ts
│   │   └── card.ts
│   ├── styles/tokens.css
│   └── index.ts
├── adapters/
├── examples/
├── package.json
└── vite.config.ts
```

Vite、TypeScript、Storybook 和 Playwright 可以分别承担开发构建、类型检查、组件展示和浏览器验证。应按产品需要组合，而不是把工具数量当作成熟度标准。

## 相关生态

| 项目 | 定位与关系 | 参考资料 |
|------|------------|----------|
| Shoelace / Web Awesome | Web Components UI 组件生态；Web Awesome 延续 Shoelace 的项目方向，可作为现成控件与设计实践参考 | [Web Awesome](https://webawesome.com/)、[安装文档](https://webawesome.com/docs/) |
| FAST | 面向 Web Components 的另一套工具体系，与 Lit 是可比较的技术路线，不是 Lit 的下游库 | [FAST 官方站点](https://fast.design/) |
| Fluent UI Web Components | Fluent 的 Web Components 实现方向，选型时要核对具体版本与依赖，不宜将整个 Fluent 等同于 Lit | [官方仓库](https://github.com/microsoft/fluentui/tree/master/packages/web-components) |

## 适用场景与选型

以下建议来自组件边界与集成成本的分析，不代表框架能力的绝对限制。

| 场景 | 评估理由与取舍 |
|------|----------------|
| 跨框架设计系统 | 多产品需要共享控件时有价值；要把适配、测试和主题协议计入成本 |
| CMS、静态站与嵌入式控件 | 可以逐步增强现有页面；要安排模块加载、初始内容与加载失败体验 |
| 浏览器扩展 | 组件隔离有帮助；仍需遵守扩展权限、内容安全策略和宿主页面限制 |
| Electron / Tauri 的 Web 界面 | 可以作为 Web 视图中的 UI 方案；桌面能力由宿主提供 |
| 大型 SPA 或复杂工作台 | 技术上可实现；应比较路由、数据层、团队经验和第三方控件的整合成本 |
| 原生移动应用 | Lit 不提供原生控件运行时；若使用 WebView，仍需评估桥接、性能与平台体验 |

如果主要目标是“让不同技术栈共用组件”，Lit 值得重点评估；如果主要目标是快速开发单一技术栈的业务应用，则应连同现有应用框架和组件生态一起比较。React、shadcn/ui、Web Components 和 Lit 是不同层面的工具与方案，不能把它们排列成必然的技术演进顺序。
