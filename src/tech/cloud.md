# 云服务对比

## 主流云平台概览

| 平台 | 厂商 | 全球区域数 | 总部 | 强项 |
|------|------|-----------|------|------|
| AWS | Amazon | 34 | 美国 | 服务最全、生态最成熟 |
| Azure | Microsoft | 60+ | 美国 | 企业集成、混合云、AI |
| GCP | Google | 40+ | 美国 | 数据分析、AI/ML、Kubernetes |
| 阿里云 | 阿里巴巴 | 29 | 中国 | 国内市场、出海东南亚 |
| 腾讯云 | 腾讯 | 21 | 中国 | 游戏、社交、微信生态 |
| 华为云 | 华为 | 33 | 中国 | 政企、昇腾 AI、鸿蒙 |

---

## 核心服务对比

### 计算

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| 虚拟机 | EC2 | Virtual Machines | Compute Engine | ECS |
| 容器 | EKS / ECS / Fargate | AKS / Container Apps | GKE / Cloud Run | ACK / ASK |
| Serverless | Lambda | Functions | Cloud Functions | FC 函数计算 |
| 弹性伸缩 | Auto Scaling | Autoscale | Managed Instance Group | 弹性伸缩 |

**选型建议**：
- K8s 原生 → **GKE**（Google 是 K8s 创始者，托管质量最高）
- Serverless 容器 → **Cloud Run / Fargate**（免运维、按请求计费）
- 国内合规 → **阿里云 ECS / ACK**

---

### 存储

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| 对象存储 | S3 | Blob Storage | Cloud Storage | OSS |
| 块存储 | EBS | Managed Disks | Persistent Disk | 云盘 |
| 文件存储 | EFS | Azure Files | Filestore | NAS |
| 数据湖 | S3 + Lake Formation | Data Lake Storage | BigLake | OSS + MaxCompute |

---

### 数据库

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| 关系型 | RDS / Aurora | SQL Database | Cloud SQL / AlloyDB | RDS / PolarDB |
| NoSQL | DynamoDB | Cosmos DB | Firestore / Bigtable | Table Store |
| 缓存 | ElastiCache | Cache for Redis | Memorystore | Tair (Redis) |
| 图数据库 | Neptune | Cosmos DB (Gremlin) | — | GDB |
| 向量 | OpenSearch Serverless | Cosmos DB (vCore) | Vertex AI Vector Search | AnalyticDB PostgreSQL |

**选型建议**：
- 全球分布式强一致 → **Cosmos DB**（多模型、多区域写入）
- PostgreSQL 兼容 + 性能 → **Aurora / PolarDB**（AWS 和阿里云的旗舰）
- 需要原生向量搜索 → **AlloyDB / PolarDB**（PG 兼容 + 向量扩展）

---

### AI / ML

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| 模型服务 | Bedrock | Azure OpenAI / AI Foundry | Vertex AI / Model Garden | 百炼 / PAI |
| 训练平台 | SageMaker | Azure ML | Vertex AI Training | PAI-DLC |
| LLM 托管 | Bedrock (Claude, Llama) | Azure OpenAI (GPT-4) | Vertex AI (Gemini) | 通义千问 / Llama |
| 向量搜索 | OpenSearch kNN | Cosmos DB Vector | Vertex AI Vector Search | AnalyticDB |
| RAG 工具 | Bedrock Knowledge Bases | Azure AI Search | Vertex AI Search | 百炼 RAG |

**选型建议**：
- 需要 GPT-4 级模型 → **Azure OpenAI**（唯一正规渠道）
- 需要多模型选择 → **Bedrock**（Claude、Llama、Mistral 多家模型）
- 国内合规 → **阿里云百炼**（通义千问 + 开源模型）

---

### 网络

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| CDN | CloudFront | Azure CDN / Front Door | Cloud CDN | CDN |
| 负载均衡 | ALB / NLB | Azure Load Balancer | Cloud Load Balancing | SLB / ALB |
| DNS | Route 53 | Azure DNS | Cloud DNS | DNS 解析 |
| VPN/专线 | VPN Gateway / Direct Connect | VPN Gateway / ExpressRoute | Cloud Interconnect | VPN / 专线 |
| WAF | AWS WAF | Azure WAF | Cloud Armor | WAF |

---

### 安全与身份

| 服务 | AWS | Azure | GCP | 阿里云 |
|------|-----|-------|-----|--------|
| IAM | IAM | Entra ID (Azure AD) | Cloud IAM | RAM |
| 密钥管理 | KMS / Secrets Manager | Key Vault | Cloud KMS | KMS |
| 合规认证 | SOC, PCI, HIPAA, ISO | SOC, PCI, HIPAA, ISO | SOC, PCI, HIPAA, ISO | 等保三级、ISO |

---

## 定价模式对比

| 模式 | 说明 | 适用场景 |
|------|------|---------|
| 按需 (On-Demand) | 按秒/小时计费，无承诺 | 开发测试、不可预测负载 |
| 预留 (Reserved) | 1–3 年承诺，折扣 30–70% | 稳定生产负载 |
| 竞价 (Spot) | 使用闲置资源，折扣 60–90% | 容错任务、批处理、CI/CD |
| Savings Plan | 灵活消费承诺，跨服务通用 | 长期稳定但需灵活切换实例 |
| Serverless | 按请求/执行时间计费 | 事件驱动、流量波动大 |

**省钱技巧**：
- 生产环境用 **预留/Savings Plan**
- CI/CD 和批处理用 **Spot/竞价实例**
- 数据传输费用是最大陷阱 — **同区域内免费，跨区域/跨出口收费**

---

## 混合云与多云

| 策略 | 说明 | 代表方案 |
|------|------|---------|
| 混合云 | 本地 + 一个云 | AWS Outposts、Azure Stack、Google Distributed Cloud |
| 多云 | 多个云同时使用 | Terraform、Pulumi、Crossplane |
| 边缘 | 计算推到终端设备 | AWS Wavelength、Azure Stack Edge、GCP Distributed Cloud |

**多云工具链**：
- **Terraform / Pulumi**：IaC 跨云编排
- **Kubernetes**：容器化应用天然跨云
- **Cloudflare / Fastly**：CDN 层屏蔽底层云差异

---

## 国内 vs 海外选型

| 维度 | 海外业务 | 国内业务 |
|------|---------|---------|
| 推荐 | AWS / GCP / Azure | 阿里云 / 腾讯云 |
| 合规 | 通用 | 等保、ICP 备案、数据本地化 |
| 生态 | 国际 SaaS 集成丰富 | 微信/支付宝/钉钉集成 |
| 网络 | 全球骨干网 | 国内骨干网 + 国际出口 |

---

## 选型决策

```
业务场景？
├── 全球化 SaaS → AWS（最全）或 GCP（数据强）
├── 企业级 + 微软生态 → Azure
├── 国内合规 → 阿里云 / 腾讯云
├── AI/ML 优先 → GCP（Vertex AI）或 Azure（OpenAI）
├── 成本敏感 → 多云 + Spot + Savings Plan
└── 不确定 → 先上 AWS，后续可迁移（生态最大）
```

---

## 参考资料

- [AWS 官方定价](https://aws.amazon.com/pricing/)
- [Azure 官方定价](https://azure.microsoft.com/pricing/)
- [GCP 官方定价](https://cloud.google.com/pricing)
- [阿里云定价](https://www.aliyun.com/price)
- [各平台 Free Tier 对比](https://free tier.dev/)
