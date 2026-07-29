# 前端框架对比

## 框架全景

```
前端框架
├── 元框架 (Meta Framework)
│   ├── Next.js (React)
│   ├── Nuxt (Vue)
│   ├── SvelteKit (Svelte)
│   ├── Angular (Angular)
│   └── Remix (React)
├── UI 框架
│   ├── React
│   ├── Vue
│   ├── Svelte
│   ├── Angular
│   └── SolidJS
└── 跨平台
    ├── React Native
    ├── Flutter
    └── Tauri
```

---

## 核心 UI 框架

### React

| 维度 | 说明 |
|------|------|
| 公司 | Meta (Facebook) |
| 首发 | 2013 |
| 语言 | JSX (JavaScript + XML) |
| 状态管理 | useState / useReducer / Zustand / Jotai / Redux |
| 渲染方式 | 虚拟 DOM → Diff → 真实 DOM |
| 学习曲线 | 中等（Hooks 概念需理解） |
| 生态系统 | 最大（npm 周下载量最高） |

**核心理念**：
- 组件化：一切皆组件
- 单向数据流：Props 向下，Events 向上
- 声明式：描述 "是什么"，不是 "怎么做"

**代码示例**：
```jsx
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <button onClick={() => setCount(c => c + 1)}>
      Count: {count}
    </button>
  );
}
```

---

### Vue

| 维度 | 说明 |
|------|------|
| 作者 | 尤雨溪 (Evan You) |
| 首发 | 2014 (Vue 3: 2020) |
| 语言 | SFC (Single File Component, `<template>` + `<script>` + `<style>`) |
| 状态管理 | ref / reactive / Pinia |
| 渲染方式 | 编译时优化 + 虚拟 DOM |
| 学习曲线 | 低（模板语法直观） |
| 生态系统 | 大（国内占比极高） |

**核心理念**：
- 渐进式：可以从 CDN 引入，也可以用完整构建工具链
- 双向数据流：`v-model` 简化表单绑定
- 组合式 API：Vue 3 Composition API 对标 React Hooks

**代码示例**：
```vue
<script setup>
import { ref } from 'vue';
const count = ref(0);
</script>

<template>
  <button @click="count++">Count: {{ count }}</button>
</template>
```

---

### Svelte

| 维度 | 说明 |
|------|------|
| 作者 | Rich Harris |
| 首发 | 2016 (Svelte 5: 2024) |
| 语言 | 类 HTML + JS |
| 状态管理 | Svelte 5 Runes (`$state` / `$derived` / `$effect`) |
| 渲染方式 | 编译时转换（无虚拟 DOM） |
| 学习曲线 | 极低（几乎就是增强版 HTML） |
| 生态系统 | 小但增长快 |

**核心理念**：
- 编译时框架：构建时将组件编译为原生 DOM 操作
- 无运行时：无虚拟 DOM、无 diff 算法开销
- 代码即框架：框架在编译时消失

**代码示例**：
```svelte
<script>
  let count = $state(0);
</script>

<button onclick={() => count++}>Count: {count}</button>
```

---

### Angular

| 维度 | 说明 |
|------|------|
| 公司 | Google |
| 首发 | 2016 (Angular 2+，重写) |
| 语言 | TypeScript（强制） |
| 状态管理 | RxJS / Signals（19+） |
| 渲染方式 | 增量 DOM + 变更检测 |
| 学习曲线 | 高（依赖注入、模块、装饰器） |
| 生态系统 | 大（企业级首选） |

**核心理念**：
- 全家桶：框架内置路由、表单、HTTP、测试
- 依赖注入：一等公民
- TypeScript 优先：类型安全是强制的

**代码示例**：
```typescript
@Component({
  selector: 'app-counter',
  template: `<button (click)="count++">Count: {{ count }}</button>`
})
export class CounterComponent {
  count = 0;
}
```

---

### SolidJS

| 维度 | 说明 |
|------|------|
| 作者 | Ryan Carniato |
| 首发 | 2021 |
| 语言 | JSX |
| 状态管理 | createSignal / createMemo / createEffect |
| 渲染方式 | 真实 DOM + 细粒度响应式（无虚拟 DOM） |
| 学习曲线 | 低（React 开发者几乎无学习成本） |
| 生态系统 | 小 |

**核心理念**：
- React 语法 + 真实 DOM：像 React 写，但不走 diff
- 细粒度更新：信号（Signal）级别的精确更新
- 无重渲染：组件函数只执行一次

---

## 元框架 (Meta Framework)

| 特性 | Next.js | Nuxt | SvelteKit | Remix | Angular Universal |
|------|---------|------|-----------|-------|-------------------|
| 基础框架 | React | Vue | Svelte | React | Angular |
| SSG | ✅ | ✅ | ✅ | ✅ | ✅ |
| SSR | ✅ | ✅ | ✅ | ✅ | ✅ |
| ISR | ✅ (Pages Router) | ✅ | ✅ | — | — |
| 流式 SSR | ✅ | ✅ | ✅ | ✅ | — |
| 边缘渲染 | ✅ (Edge Runtime) | ✅ | ✅ | ✅ | — |
| 文件路由 | ✅ App Router | ✅ | ✅ | ✅ (文件系统路由) | — |
| API Routes | ✅ | ✅ | ✅ | ✅ (loader/action) | — |
| 图片优化 | ✅ (next/image) | ✅ | ✅ | — | — |

**选型建议**：
- React 生态 → **Next.js**（最大、最多部署支持）
- Vue 生态 → **Nuxt**（Vue 官方推荐）
- 追求性能 → **SvelteKit**（编译时优势）
- 侧重服务端逻辑 → **Remix**（Web 标准优先）

---

## 状态管理方案

### React 生态

| 方案 | 类型 | 特点 | 适用场景 |
|------|------|------|---------|
| useState | 内置 | 简单、局部状态 | 组件内状态 |
| useReducer | 内置 | 复杂状态逻辑 | 表单、多步流程 |
| Zustand | 轻量 | 极简 API、无 Provider | 全局状态（推荐） |
| Jotai | 原子化 | 类似 Recoil、细粒度 | 大量独立状态 |
| Redux Toolkit | 全功能 | 最成熟、中间件丰富 | 大型应用 |
| TanStack Query | 服务端 | 自动缓存、请求去重 | API 状态管理 |

### Vue 生态

| 方案 | 类型 | 特点 |
|------|------|------|
| ref / reactive | 内置 | 响应式基础 |
| Pinia | 官方 | Vue 3 官方状态管理，替代 Vuex |
| VueUse | 工具集 | 300+ Composition Utilities |

### Svelte 生态

| 方案 | 类型 | 特点 |
|------|------|------|
| $state | 内置 Runes | 编译时响应式 |
| Svelte Store | 内置 | writable / readable / derived |

---

## CSS 方案

| 方案 | 类型 | 特点 | 适用场景 |
|------|------|------|---------|
| Tailwind CSS | 原子化 | 按需生成、设计系统约束 | 推荐默认选择 |
| CSS Modules | 局部作用域 | 编译时类名隔离 | 中小型项目 |
| Styled Components | CSS-in-JS | 运行时、动态样式 | React 项目 |
| Emotion | CSS-in-JS | 类似 SC、性能更好 | React 项目 |
| Panda CSS | 原子化 + 类型安全 | 零运行时、类型推导 | 需要类型安全 |
| UnoCSS | 原子化 | 引擎级、按需加载 | 替代 Tailwind |
| Vanilla Extract | 零运行时 | TypeScript 编写样式 | 类型安全 |
| SCSS/Less | 预处理器 | 变量、嵌套、mixin | 传统项目 |

**选型建议**：
- 新项目 → **Tailwind CSS**（行业标准、生态最全）
- 需要类型安全 → **Panda CSS** 或 **Vanilla Extract**
- 追求极致性能 → **UnoCSS**（引擎级，比 Tailwind 快）

---

## 性能对比

### Bundle Size（框架核心）

| 框架 | 压缩后大小 | 说明 |
|------|-----------|------|
| Svelte | ~2 KB | 编译时消失，运行时极小 |
| SolidJS | ~7 KB | 轻量运行时 |
| Vue 3 | ~16 KB | 渐进式，按需引入 |
| React | ~42 KB | 包含 React + ReactDOM |
| Angular | ~65 KB | 全家桶，按需引入 |

### 渲染性能（基准测试）

```
Svelte > Solid > Vue 3 > React > Angular
   ↑                      ↑         ↑
 编译时           虚拟DOM(优化)    变更检测
```

**注意**：实际应用性能差异远小于基准测试，框架选择对 99% 的应用不是性能瓶颈。

---

## 选型决策

```
场景？
├── 已有 React 经验 → Next.js（元框架）+ Zustand + Tailwind
├── 已有 Vue 经验 → Nuxt（元框架）+ Pinia + Tailwind
├── 追求极致性能 → SvelteKit + Tailwind
├── 企业级大型应用 → Angular + NgRx + Angular Material
├── 跨平台移动 → React Native 或 Flutter
├── 不确定 → Next.js（生态最大、招聘最容易）
└── 个人项目 → SvelteKit（开发体验最好）
```

### 按团队规模

| 规模 | 推荐 | 原因 |
|------|------|------|
| 1–3 人 | SvelteKit / Next.js | 快速开发 |
| 5–15 人 | Next.js / Nuxt | 生态成熟、招人容易 |
| 15+ 人 | Angular | 约束多但一致性好、TypeScript 强制 |
| 跨平台 | React Native / Flutter | 一套代码多端运行 |

---

## 新兴趋势

1. **Server Components**：Next.js App Router、React Server Components 将渲染推向服务端，减少客户端 JS
2. **Signals**：Angular 19+ Signals、Svelte 5 Runes、SolidJS Signals — 细粒度响应式成为主流
3. **编译时优化**：Svelte、SolidJS 证明编译时可以大幅减少运行时开销
4. **边缘优先**：Cloudflare Workers、Vercel Edge 让 SSR 推到 CDN 边缘
5. **AI 辅助开发**：v0.dev (Vercel)、Bolt.new 等 AI 生成 UI 工具兴起

---

## 参考资料

- [React 官方文档](https://react.dev/)
- [Vue 官方文档](https://vuejs.org/)
- [Svelte 官方文档](https://svelte.dev/)
- [Angular 官方文档](https://angular.dev/)
- [Next.js 官方文档](https://nextjs.org/docs)
- [Nuxt 官方文档](https://nuxt.com/)
- [SvelteKit 官方文档](https://kit.svelte.dev/)
