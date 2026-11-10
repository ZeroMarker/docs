# 容器技术演进：从进程隔离到微虚拟机与 WebAssembly

容器并不是由 Docker 单独发明出来的。它建立在操作系统几十年的进程隔离、资源限制和文件系统技术之上；Docker 的贡献是把这些能力组合成一套可用的镜像与分发流程。今天所说的“容器”，已经同时指打包格式、运行时、编排系统和隔离手段四件不同的事。

本文核对日期：2026-11-10。版本号与项目状态变化较快，涉及选型时请以官方文档为准。相关页面：[开发工具链对比](devtools.md)、[云服务对比](cloud.md)、[手机 IPv6 服务器](手机IPv6服务器.md)。

## 先区分四个层次

“容器”一词被混用，先分清层次可以避免很多争论：

| 层次 | 解决的问题 | 代表实现 |
|------|-----------|---------|
| 隔离机制 | 让进程看不见其他进程、文件系统和网络 | namespaces、cgroups、seccomp、虚拟机 |
| 运行与生命周期 | 拉镜像、挂载根文件系统、启动和回收进程 | containerd、CRI-O、runc、crun |
| 镜像与分发 | 内容寻址、分层复用、跨仓库传输 | OCI Image、Registry、BuildKit |
| 编排 | 调度、扩缩容、服务发现、网络 | Kubernetes、Nomad |

Docker 主要覆盖的是前三层的开发体验，以及把三者串起来的工作流。把 Docker 等同于容器技术，在 2015 年大致成立，现在不再成立。

## 时间线

| 时间 | 技术 | 作用 | 备注 |
|------|------|------|------|
| 1979 | Unix `chroot` | 改变进程看到的根目录 | 在 Version 7 Unix 中出现，1980 年代进入 BSD |
| 2000 | FreeBSD Jails | 隔离进程、文件系统和网络 | 随 FreeBSD 4.0 发布，可视为操作系统级容器的雏形 |
| 2001 | Linux VServer | 在同一内核上划分虚拟服务器 | 未进入主线内核，影响有限 |
| 2002 | Linux namespaces | 让进程拥有独立的挂载、UTS、IPC 视图 | 起始于挂载 namespace；PID、网络随后加入，用户 namespace 迟至 3.8（2013） |
| 2004 | Solaris Zones | 提供较完整的操作系统环境隔离 | 随 Solaris 10 发布，常被时间线误归入 1990 年代 |
| 2006 | Google 的 process containers | 限制与统计进程组资源 | 后更名为 cgroups，2008 年合入 Linux 2.6.24 |
| 2008 | LXC | 把 namespaces 与 cgroups 组合成可用容器 | 提供接近虚拟机的操作体验 |
| 2013 | Docker | 标准化镜像、容器、仓库与构建流程 | 3 月在 PyCon 上首次公开演示 |
| 2014—2015 | Kubernetes、OCI、runc | 编排标准化、运行时标准化 | Kubernetes 2014 年公布，1.0 于 2015 年 7 月发布；OCI 成立于 2015 年 6 月 |
| 2017 | containerd、CRI-O、Kata Containers | 运行时分层，安全容器出现 | Kata 由 Intel Clear Containers 与 Hyper runV 合并而来 |
| 2018 | gVisor、Firecracker | 用户态内核、轻量虚拟机 | Firecracker 于 2018 年 11 月开源，源自 Chromium 的 crosvm |
| 2019 | WASI、Wasmtime | 让 WebAssembly 访问受控的系统资源 | WASI 作为标准提案提出，服务端 WASM 开始成型 |
| 2022 | Kubernetes 1.24 | 移除 dockershim | 1.20 起弃用，1.24（2022 年 5 月）正式移除 |
| 2024 | WASI 0.2 | 基于 Component Model 的稳定接口 | 组件模型开始成为跨语言组合的基础 |
| 2026 | Kata 4.0、WASI 0.3 | Rust 运行时成为默认；异步进入标准 | Kata 4.0.0 于 2026 年 7 月发布；WASI 0.3.0 于 2026 年 6 月 11 日发布 |

早期方案解决的是“如何让一个进程看不到系统其余部分”；cgroups 解决的是“如何限制它用多少资源”；镜像解决的是“如何把应用和依赖一起搬走”。这三条线索分别对应今天的隔离、运行时和分发。

## 现代容器技术栈

```
应用层
  应用程序 / 微服务 / AI Agent / 数据库
镜像与分发层
  OCI Image / Registry / BuildKit / 镜像缓存与懒加载
容器运行时层
  containerd / CRI-O ── runc / crun（传统容器）
                     └─ shim ── gVisor / Kata / runwasi（沙箱与新型执行环境）
编排层
  Kubernetes / CRI
操作系统与硬件
  Linux / Windows / CPU / GPU / 虚拟化硬件
```

不同执行环境通过不同的 shim 接入同一套上层接口，这是当前架构的关键：Kubernetes 不必知道底层是 runc、微虚拟机还是 WASM 运行时。

### 各组件的职责

| 组件 | 职责 | 常见误解 |
|------|------|---------|
| Docker Engine | 开发体验、镜像构建、单机容器管理 | 不是 Kubernetes 的必需依赖 |
| containerd | 镜像管理、容器生命周期、快照 | 不是“低级 runc”，它本身也是完整守护进程 |
| runc / crun | 按 OCI 规范创建并运行单个容器进程 | 不负责拉镜像，也不常驻 |
| CRI-O | 只实现 CRI 的轻量运行时 | 功能范围比 containerd 窄，专为 Kubernetes 设计 |
| CRI | Kubernetes 与运行时之间的接口 | 是接口约定，不是某个程序 |
| Kubernetes | 调度、编排、服务发现 | 1.24 起不再经由 Docker Engine 运行容器 |

dockershim 的移除常被误读为“Kubernetes 不支持 Docker 镜像”。实际变化是：kubelet 直接通过 CRI 与 containerd 或 CRI-O 通信，Docker 构建的 OCI 镜像照常运行；受影响的是依赖 Docker Engine 特有行为的运维脚本，以及仍然调用 `/var/run/docker.sock` 的周边工具。

## 隔离强度：共享内核的边界

传统容器的隔离来自内核本身：所有容器共享宿主机内核，namespaces 决定“看得见什么”，cgroups 决定“能用多少”，seccomp、capabilities、LSM 决定“能做什么”。这套机制的性能开销很低，但边界只有一个——内核。

内核漏洞、配置错误（如挂载了 docker socket、使用了 `--privileged`）或不必要的 capability，都可能让容器逃逸影响宿主机。这一点无法通过“更严格的 Docker 配置”彻底消除，只能换隔离层。

| 技术 | 隔离方式 | 兼容性 | 主要限制 |
|------|---------|--------|---------|
| runc / crun | 共享宿主机内核 | 最高，标准 OCI 容器 | 内核即攻击面 |
| gVisor | 用户态内核（Sentry）拦截系统调用 | 较高，但系统调用覆盖不全 | 部分应用和驱动不兼容，系统调用密集负载有额外开销 |
| Firecracker | 每负载一个微虚拟机 | 仅支持 Linux guest，设备模型精简 | 不支持 GPU 直通等复杂设备，需 KVM |
| Kata Containers | 每 Pod 一个虚拟机，内跑 OCI 容器 | 很高，保留镜像与 CRI 体验 | 需要硬件虚拟化，资源开销高于 runc |

几点容易被忽略的约束：

- gVisor 不是“更安全的 runc”，它是一个用 Go 重新实现的系统调用层，兼容性取决于应用实际调用了哪些接口。
- Firecracker 只支持 Linux guest，且刻意不支持大量设备；它适合函数计算和沙箱，不适合当作通用虚拟机。
- Kata 的隔离单位通常是 Pod 或容器，不是节点；它把“容器体验”和“虚拟机边界”拼接起来，代价是启动与内存开销。

### Kata Containers 4.0 的变化

Kata Containers 4.0.0 于 2026 年 7 月发布，最重要的变化是 Rust 实现的 `runtime-rs` 成为默认运行时，原 Go 运行时进入弃用状态。官方给出的方向是更好的内存安全、更小的内存占用和更快的启动；Go 运行时仍可选用，但不再接受新功能，移除时间不早于 5.0（官方预计在 2028 年第一季度）。

实践上的影响是 RuntimeClass 名称发生变化：默认类从 `kata-qemu` 变为 `kata-qemu-runtime-rs`，依赖 Go 运行时专有配置的部署需要按迁移文档调整。这也说明安全容器的竞争点已经从“有没有虚拟机”转向“运行时本身的实现质量”。

## WebAssembly：另一种执行环境

WebAssembly 最初为浏览器设计，其沙箱模型是“默认无系统权限”，这与容器的默认模型正好相反。服务端使用它，看中的是可移植性和启动成本，而不是“比容器更轻的 Docker”。

代表性项目：

| 项目 | 定位 |
|------|------|
| Wasmtime | Bytecode Alliance 的参考运行时，组件模型的主要实现 |
| WasmEdge | 面向云原生、边缘与 AI 推理的运行时 |
| Spin | 以组件为单位构建和运行 WASM 应用 |
| runwasi | containerd 的 shim，让 WASM 工作负载以容器方式被调度 |

与 Linux 容器相比的实际差异：

| 维度 | WASM | Linux 容器 |
|------|------|-----------|
| 启动 | 毫秒级，接近函数调用 | 数十毫秒到数秒，取决于镜像与存储 |
| 产物大小 | 通常几 MB | 通常几十 MB 到数 GB |
| 隔离 | 语言级沙箱，默认无系统调用 | 内核 namespaces，共享内核 |
| 跨架构 | 同一份 `.wasm` 可在不同 CPU 上运行 | 镜像与架构绑定 |
| 系统接口 | WASI，能力受限且仍在演进 | 完整 POSIX/Linux 接口 |
| 生态 | 语言支持不均，原生库需重新编译 | 任意 Linux 程序 |

WASI 的版本状态值得注意：WASI 0.2（2024 年 1 月）确立了基于 Component Model 的接口形式；WASI 0.3（2026 年 6 月）把异步原语下沉到组件模型，`wasi:io` 被移除，Wasmtime 46 起默认支持。也就是说，服务端 WASM 的“异步与网络”能力是最近两年才稳定下来的，生态仍在跟随。

不适合迁移到 WASM 的情况很明确：需要完整 Linux 系统调用、依赖未移植的原生库、需要 GPU 驱动或内核特性的应用，继续用容器或虚拟机的成本更低。

## Unikernel：把应用和操作系统编译到一起

传统栈是“应用 → 发行版 → 系统服务 → 虚拟机”，Unikernel 则把应用与必需的内核组件编译成单一镜像，直接跑在 hypervisor 或裸机上。

| 维度 | 说明 |
|------|------|
| 优势 | 镜像小、启动快、组件少、攻击面窄 |
| 代价 | 通用性差，调试与可观测性工具有限，生态兼容性弱 |
| 适用 | 单一职责的网络服务、专用设备、研究场景 |
| 项目 | Unikraft、MirageOS |

它和容器的关系不是替代：Unikernel 往往需要 hypervisor 提供边界，容器则依赖内核提供边界。对大多数业务系统，改造成本高于收益；在需要极致精简的嵌入式或边缘场景，它才有实际意义。

## 镜像分发：从完整下载到按需读取

镜像越大，拉取时间越接近启动时间的全部。AI 模型镜像动辄数十 GB，这一问题尤其明显，于是出现了“懒加载”方案：

| 方案 | 来源 | 是否改动镜像格式 | 数据路径 | 特点 |
|------|------|-----------------|---------|------|
| eStargz / stargz-snapshotter | containerd 子项目，源自 Google CRFS | 是，重新压缩为可寻址的 gzip 成员 | FUSE | 兼容标准 OCI 仓库，可按运行 profile 预取 |
| Nydus | 蚂蚁集团 / Dragonfly（CNCF） | 是，转换为 RAFS | FUSE 或内核 EROFS | 块级去重，冷启动快，需要转换与专用仓库支持 |
| SOCI | AWS | 否，索引作为独立 artifact | FUSE + 后台预取 | 不改镜像摘要，适合标准仓库与 ECR/EKS 场景 |

懒加载不是免费的：它把下载成本从启动阶段转移到首次读取，或者用后台预取把成本提前。对访问密度高的镜像，完整拉取反而更快；对启动时只读取少量文件的镜像，收益明显。选型时更应关注“首次请求的延迟”，而不只是“容器 Ready 的时间”。

## AI Agent 推动的沙箱需求

Agent 类负载与传统服务的区别在于：它会动态执行用户或模型生成的代码、安装依赖、读写文件、调用命令，而且生命周期短、数量多。

这带来几个新要求：

- 隔离强度要高于普通容器，因为代码不可信。
- 每个实例需要独立的文件系统与网络策略。
- 启动与销毁要足够快，才能支撑高频创建。
- 资源计量要准确，沙箱自身的开销也要计入。

目前的常见组合是 Firecracker 或 Kata 提供边界，上面再套一层生命周期管理。E2B、Daytona 这类产品把这一层封装成 API；它们并非新内核技术，价值在于调度、快照和会话管理。

## 横向比较

下表只反映典型形态，具体表现取决于内核版本、存储、网络和负载特征。

| 技术路线 | 启动速度 | 隔离强度 | 兼容性 | 典型用途 |
|---------|---------|---------|--------|---------|
| Docker / Podman（runc） | 快 | 中，共享内核 | 很高 | 通用应用部署、开发环境 |
| gVisor | 较快 | 较高，用户态内核 | 中，受系统调用覆盖限制 | 不可信代码、多租户 |
| Firecracker | 很快 | 高，硬件虚拟化 | VM 级，仅 Linux guest | Serverless、Agent 沙箱 |
| Kata Containers | 较快 | 高，每 Pod 一 VM | 很高，支持 OCI 与 CRI | 多租户 Kubernetes、合规场景 |
| WebAssembly | 极快 | 高，取决于宿主授予的能力 | 受 WASI 与语言生态限制 | 边缘计算、插件、轻量服务 |
| Unikernel | 快 | 高，依赖 VMM | 低，需专门构建 | 专用网络服务、嵌入式 |

这些方案是分层而非替代关系：同一集群里完全可以 runc 跑普通服务、Kata 跑不可信任务、WASM 跑边缘函数。

## 在个人服务器与自建环境中的选择

结合常见的 VPS 与自建环境，可以按三类处理：

| 类别 | 方案 | 适用场景 | 前提 |
|------|------|---------|------|
| 通用容器 | Docker / Podman + Compose + 反向代理 | Web 服务、数据库、开发工具、自建应用 | 能运行 Linux 内核与 cgroups |
| 安全执行环境 | Firecracker / Kata / gVisor | 执行不可信代码、多租户开发环境 | 通常需要 KVM 与嵌套虚拟化 |
| 新型运行时 | Wasmtime / WasmEdge | 跨架构的小型服务、插件系统 | 应用能编译为 WASM |

需要核实的几个前提：

- 多数廉价 VPS 不提供嵌套虚拟化，`/dev/kvm` 不存在，Kata 与 Firecracker 无法直接运行；gVisor 的 ptrace 模式可用但性能有限。
- WASM 运行时对硬件要求最低，在没有 KVM 的环境里反而是可选项。
- `dockur/windows` 这类项目虽然用 Docker 命令管理，实际运行的是 QEMU 虚拟机中的 Windows，不是 Windows 容器。镜像、编排接口和底层执行环境可以彼此独立，这也正是 Kata 与 Firecracker 的思路。

更一般地说：容器提供的是“交付与调度接口”，隔离强度由底层执行环境决定。把这两件事分开看，选型会清晰很多。

## 值得跟进的项目

| 项目 | 定位 | 仓库 |
|------|------|------|
| containerd | 容器运行时基础设施 | [containerd/containerd](https://github.com/containerd/containerd) |
| runc | OCI 运行时参考实现 | [opencontainers/runc](https://github.com/opencontainers/runc) |
| Firecracker | 微虚拟机 | [firecracker-microvm/firecracker](https://github.com/firecracker-microvm/firecracker) |
| Kata Containers | 容器与虚拟机融合 | [kata-containers/kata-containers](https://github.com/kata-containers/kata-containers) |
| gVisor | 用户态内核 | [google/gvisor](https://github.com/google/gvisor) |
| Wasmtime | WASM 参考运行时 | [bytecodealliance/wasmtime](https://github.com/bytecodealliance/wasmtime) |
| WasmEdge | 云原生 WASM 运行时 | [WasmEdge/WasmEdge](https://github.com/WasmEdge/WasmEdge) |
| runwasi | 以容器方式运行 WASM | [containerd/runwasi](https://github.com/containerd/runwasi) |
| Nydus | 镜像懒加载与加速 | [dragonflyoss/nydus](https://github.com/dragonflyoss/nydus) |

## 小结

容器技术的演进可以概括为三条同时进行的线：

1. 隔离层不断加厚：从共享内核到用户态内核，再到微虚拟机。
2. 交付层不断变薄：从完整镜像下载到按需加载，从整机交付到单一函数。
3. 接口层趋于统一：OCI 与 CRI 让不同隔离技术可以互换。

Docker 仍然重要，但它更像“入口”而非“全部”。真正的变化发生在运行时、隔离边界和镜像分发这些不太显眼的地方。

下一个值得单独讨论的问题是：这类执行环境是否会取代传统 VPS，成为个人云计算与开发环境的基本单位。这取决于隔离成本、持久化存储和网络模型能否同时满足，而不只是启动速度。
