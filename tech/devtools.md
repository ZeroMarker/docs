# 开发工具链对比

## 工具链全景

```
开发工具链
├── 编辑器 / IDE
├── 版本控制
├── 包管理
├── 构建工具
├── 语言运行时
├── 格式化 / Lint
├── 测试框架
├── CI/CD
├── 容器化
├── API 工具
├── 监控 / APM
└── AI 编程助手
```

---

## 编辑器 / IDE

| 特性 | VS Code | JetBrains (IntelliJ) | Neovim | Cursor | Zed |
|------|---------|---------------------|--------|--------|-----|
| 类型 | 轻量编辑器 | 全功能 IDE | 终端编辑器 | AI-first 编辑器 | 高性能编辑器 |
| 启动速度 | 快 | 慢 | 极快 | 快 | 极快 |
| 内存占用 | 中等 | 高 | 极低 | 中等 | 低 |
| 语言支持 | 插件驱动 | 原生深度支持 | 插件驱动 | 插件驱动 | 插件驱动 |
| AI 集成 | Copilot / Cline | AI Assistant | Avante / Codeium | 原生（多模型） | 原生（多模型） |
| 远程开发 | Remote SSH / Dev Containers | Gateway / Remote Dev | SSH 原生 | SSH | SSH |
| 价格 | 免费 | 付费（订阅） | 免费 | 付费 | 免费（开源） |
| 扩展生态 | 最丰富（50K+） | 丰富（7K+） | Lua 插件 | 兼容 VS Code | 兼容 VS Code |

**选型建议**：
- 日常开发 → **VS Code**（生态最全）或 **Cursor**（AI 增强）
- Java / Kotlin / Go 深度开发 → **JetBrains**
- 终端重度用户 / 追求速度 → **Neovim** 或 **Zed**
- AI-first 体验 → **Cursor**（最成熟的 AI 编辑器）

---

## 版本控制

| 特性 | Git | GitHub | GitLab | Gitee |
|------|-----|--------|--------|-------|
| 类型 | 分布式 VCS | 托管平台 | 托管平台（自建） | 托管平台（国内） |
| CI/CD | — | GitHub Actions | GitLab CI（内置） | Gitee Go |
| 包管理 | — | GitHub Packages | GitLab Package Registry | — |
| 安全扫描 | — | Dependabot / CodeQL | SAST/DAST 内置 | — |
| 自托管 | — | GitHub Enterprise | 社区版免费 | — |
| 国内访问 | 正常 | 慢/不稳 | 正常 | 快 |

**选型建议**：
- 开源项目 → **GitHub**（社区最大）
- 企业私有部署 → **GitLab**（自建完整 DevOps 平台）
- 国内合规 → **Gitee** 或 **GitLab 中国版**

---

## 包管理器

| 特性 | npm | pnpm | yarn | bun |
|------|-----|------|------|-----|
| 语言 | Node.js | Node.js | Node.js | 多语言 |
| 安装速度 | 慢 | 快 | 中等 | 极快 |
| 磁盘占用 | 高（重复安装） | 低（硬链接 + store） | 中等 | 低 |
| Lock 文件 | package-lock.json | pnpm-lock.yaml | yarn.lock | bun.lockb（二进制） |
| Monorepo | workspaces | workspaces（原生） | workspaces | bun workspaces |
| 严格模式 | 否 | 是（默认隔离） | 否 | 是（默认隔离） |
| Node 兼容性 | 100% | 高 | 高 | 高（大部分） |

**选型建议**：
- 新项目 → **pnpm**（速度快、严格、磁盘省）
- 已有 npm 生态 → **npm**（兼容性最好）
- 追求极致速度 → **bun install**

---

## 构建工具

| 特性 | Webpack | Vite | esbuild | Turbopack | Bun |
|------|---------|------|---------|-----------|-----|
| 类型 | 打包器 | 开发服务器 + 打包器 | 编译器 | 打包器 | 运行时 + 打包器 |
| 开发速度 | 慢 | 极快（ESM） | 极快 | 极快 | 极快 |
| 生态 | 最成熟 | 快速增长 | 作为底层 | Next.js 默认 | 新兴 |
| 插件 | 丰富 | 兼容 Rollup | 少 | 有限 | Bun 插件 |
| 适用场景 | 复杂 legacy | 现代前端 | 底层编译 | Next.js 项目 | 全栈 |

**选型建议**：
- 新前端项目 → **Vite**（开发体验最好）
- 底层编译需求 → **esbuild**（Go 编写，极快）
- Next.js → **Turbopack**（官方默认）
- 复杂 legacy 项目 → **Webpack**（兼容性最强）

---

## 语言运行时

| 特性 | Node.js | Deno | Bun |
|------|---------|------|-----|
| 语言 | JavaScript / TypeScript | JavaScript / TypeScript | JavaScript / TypeScript |
| TypeScript | 需编译或 tsx | 原生支持 | 原生支持 |
| 安全 | 无沙箱 | 默认沙箱 | 无沙箱 |
| 包管理 | npm | npm（兼容） | 内置（npm 兼容） |
| API 兼容 | 最广 | Node 兼容层逐步完善 | Node 兼容层（大部分） |
| 性能 | 成熟 | 快 | 极快（JSC 引擎） |
| 生态 | 最大 | 中等 | 快速增长 |
| 工具链 | 需额外安装（prettier、jest） | 内置 fmt、test、lint | 内置 fmt、test、bench |

**选型建议**：
- 生产环境 → **Node.js**（稳定性、生态最好）
- 全栈应用 → **Deno**（安全、TypeScript 原生、Deploy 平台）
- 个人项目 / 追求速度 → **Bun**（启动快、All-in-One）

---

## 格式化 / Lint

| 特性 | Prettier | Biome | ESLint | Ruff |
|------|----------|-------|--------|------|
| 语言 | JS/TS/CSS/HTML/MD | JS/TS/CSS/HTML | JS/TS | Python |
| 速度 | 中等 | 极快（Rust） | 中等 | 极快（Rust） |
| 功能 | 格式化 | 格式化 + Lint | Lint | Lint + 格式化 |
| 替代 | — | Prettier + ESLint | — | Black + isort + flake8 |
| 适用场景 | 格式化 | JS/TS 全栈工具 | JS/TS Lint | Python 全栈工具 |

**选型建议**：
- JS/TS 项目 → **Biome**（一个工具替代 Prettier + ESLint，快 10–35 倍）
- Python 项目 → **Ruff**（替代 Black + isort + flake8，快 10–100 倍）
- 需要复杂 Lint 规则 → **ESLint**（规则最丰富）

---

## 测试框架

| 特性 | Jest | Vitest | Playwright | Cypress |
|------|------|--------|-----------|---------|
| 类型 | 单元测试 | 单元测试 | E2E 测试 | E2E 测试 |
| 速度 | 中等 | 极快（Vite） | 快 | 中等 |
| 浏览器 | jsdom / happy-dom | jsdom / happy-dom | 真实浏览器 | 真实浏览器 |
| 并行 | 是 | 是 | 是 | 付费功能 |
| 多语言 | Node.js | Node.js | Node.js / Python / Java / .NET | Node.js |
| 适用场景 | 稳定项目 | 新项目（Vite 生态） | 跨浏览器 E2E | 中小规模 E2E |

**选型建议**：
- 单元测试 → **Vitest**（与 Vite 无缝集成，Jest 兼容 API）
- E2E 测试 → **Playwright**（多浏览器、多语言、速度快）
- 已有 Jest 生态 → **Jest**（稳定、生态最全）

---

## CI/CD

| 特性 | GitHub Actions | GitLab CI | Jenkins | CircleCI |
|------|---------------|-----------|---------|----------|
| 托管 | GitHub 云 | 自建 / SaaS | 自建 | SaaS |
| 配置格式 | YAML | YAML | Jenkinsfile (Groovy) | YAML |
| Runner | 云 / 自建 | 自建 / SaaS | 自建 | 云 / 自建 |
| 免费额度 | 2000 min/月 | 400 min/月 | — | 6000 min/月 |
| 生态 | Actions Marketplace | 内置模板 | 插件 1800+ | Orbs |
| 学习曲线 | 低 | 低 | 高 | 中 |

**选型建议**：
- GitHub 项目 → **GitHub Actions**（零配置集成）
- GitLab 自建 → **GitLab CI**（与 GitLab 深度集成）
- 复杂企业流程 → **Jenkins**（插件最多、最灵活）

---

## 容器化

| 特性 | Docker | Podman | containerd |
|------|--------|--------|------------|
| 架构 | C/S（daemon） | 无 daemon | daemon |
| 根权限 | 默认需要 | 无需 root | 无需 root |
| 兼容性 | Docker CLI 标准 | 兼容 Docker CLI | 低级运行时 |
| Kubernetes | — | 原生 Pod 支持 | K8s 默认运行时 |
| 适用场景 | 开发环境 | 安全要求高 | 生产 K8s 集群 |

---

## API 开发工具

| 特性 | Postman | Insomnia | Bruno | Thunder Client |
|------|---------|----------|-------|----------------|
| 类型 | API 平台 | API 客户端 | API 客户端 | VS Code 插件 |
| 协议 | REST / GraphQL / gRPC / WebSocket | REST / GraphQL / gRPC | REST / GraphQL / gRPC | REST |
| 协作 | 强（团队工作区） | 中 | 弱（Git 集成） | 弱 |
| Mock | 内置 Mock Server | 有限 | 有限 | 无 |
| CI 集成 | Newman | — | CLI | — |
| 开源 | 否 | 否 | 是（MIT） | 否 |
| 价格 | 免费+付费 | 免费+付费 | 免费 | 免费 |

**选型建议**：
- 团队协作 → **Postman**（功能最全）
- 隐私/开源优先 → **Bruno**（数据存在本地 Git）
- 轻量级 → **Thunder Client**（VS Code 内直接用）

---

## 监控 / APM

| 特性 | Datadog | Grafana + Prometheus | Sentry | New Relic |
|------|---------|---------------------|--------|-----------|
| 类型 | 全栈 APM | 开源监控栈 | 错误追踪 | APM |
| 指标 | 全面 | 全面（自建） | 错误为主 | 全面 |
| 日志 | 支持 | Loki | — | 支持 |
| 追踪 | 支持 | Tempo | 支持 | 支持 |
| 价格 | 高 | 免费（自建） | 免费+付费 | 免费额度 |

**选型建议**：
- 预算充足 → **Datadog**（一站式）
- 成本控制 → **Grafana 全家桶**（Prometheus + Loki + Tempo，开源免费）
- 错误追踪 → **Sentry**（前端 + 后端错误聚合）

---

## AI 编程助手

| 特性 | GitHub Copilot | Cursor | Claude Code | Cline / Continue |
|------|---------------|--------|-------------|-----------------|
| 类型 | 补全插件 | 独立编辑器 | CLI Agent | 编辑器插件 |
| 模型 | GPT-4o / Claude | 多模型（GPT-4、Claude、自定义） | Claude Sonnet/Opus | 多模型 |
| 功能 | 行/块补全 | 补全 + Chat + Agent | 终端内 Agent（读写文件、执行命令） | Chat + Agent |
| 价格 | $10–39/月 | $20/月 | 按 token 计费 | 免费（自带 API Key） |
| 适用场景 | 日常编码 | 全流程 AI 编码 | 复杂重构、多文件任务 | 灵活自定义 |

**选型建议**：
- 日常补全 → **GitHub Copilot**（集成最好）
- 深度 AI 编码 → **Cursor**（Agent 模式强大）
- 终端重度用户 → **Claude Code**（命令行 Agent）
- 自由度最高 → **Cline / Continue**（可选任意模型）

---

## 选型决策

```
需求？
├── 前端开发 → VS Code/Cursor + Vite + Biome + Vitest + Playwright
├── 后端开发 → VS Code/JetBrains + Node.js/Deno + Docker
├── Python → VS Code + uv + Ruff + Pytest
├── 全栈 → Cursor + Vite + Bun + Docker + GitHub Actions
├── 企业级 → JetBrains + GitLab + Jenkins + Docker + Datadog
└── AI 辅助 → Cursor 或 Claude Code + Copilot
```

---

## 参考资料

- [VS Code 官方文档](https://code.visualstudio.com/docs)
- [JetBrains 官方文档](https://www.jetbrains.com/help/)
- [Vite 官方文档](https://vitejs.dev/)
- [Biome 官方文档](https://biomejs.dev/)
- [Ruff 官方文档](https://docs.astral.sh/ruff/)
