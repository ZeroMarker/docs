# 数据库技术对比

## 数据库分类

```
数据库
├── 关系型 (RDBMS)
│   ├── PostgreSQL
│   ├── MySQL
│   ├── SQLite
│   └── Oracle / SQL Server
├── 文档型 (Document)
│   ├── MongoDB
│   └── CouchDB
├── 键值型 (Key-Value)
│   ├── Redis
│   └── DynamoDB
├── 列族型 (Column-Family)
│   ├── Cassandra
│   └── HBase
├── 时序型 (Time-Series)
│   ├── InfluxDB
│   ├── TimescaleDB
│   └── QuestDB
├── 图数据库 (Graph)
│   ├── Neo4j
│   └── ArangoDB
├── 向量数据库 (Vector)
│   ├── Pinecone
│   ├── Milvus
│   ├── Weaviate
│   └── Chroma
└── NewSQL
    ├── CockroachDB
    ├── TiDB
    └── YugabyteDB
```

---

## 核心对比

### 关系型数据库

| 特性 | PostgreSQL | MySQL | SQLite |
|------|-----------|-------|--------|
| 类型 | 对象-关系型 | 关系型 | 嵌入式 |
| 并发 | MVCC | MVCC | 文件锁（单写） |
| 扩展性 | 读写分离 + 逻辑复制 | 读写分离 + Group Replication | 无（单文件） |
| 数据类型 | 丰富（JSONB、数组、范围、几何） | 基础（JSON 支持较弱） | 弱类型 |
| 扩展生态 | 极强（PostGIS、TimescaleDB、pgvector） | 中等 | 有限 |
| 许可证 | PostgreSQL License（类 MIT） | GPL v2 | 公有领域 |
| 适用场景 | 复杂查询、地理数据、全文搜索 | Web 应用、读多写少 | 移动端、嵌入式、原型 |

**选型建议**：
- 默认选 **PostgreSQL**：功能最全、扩展性最强、社区最活跃
- **MySQL**：已有成熟 MySQL 生态、需要简单读写场景
- **SQLite**：单机、嵌入式、不需要独立服务

---

### 文档型数据库

| 特性 | MongoDB | CouchDB |
|------|---------|---------|
| 数据模型 | BSON 文档（类似 JSON） | JSON 文档 |
| 查询语言 | MQL（MongoDB Query Language） | REST API + Mango Query |
| 复制 | Replica Set（主从） | Master-Master（多主） |
| 索引 | B-Tree、地理空间、文本、哈希 | B-Tree |
| 事务 | 4.0+ 支持多文档事务 | 最终一致性 |
| 适用场景 | 内容管理、实时分析、CMS | 离线优先应用、同步场景 |

---

### 键值数据库

| 特性 | Redis | DynamoDB |
|------|-------|----------|
| 模式 | 内存为主，可持久化 | 全托管，磁盘为主 |
| 数据结构 | String、List、Set、Hash、Sorted Set、Stream | Key-Value、文档 |
| 延迟 | 亚毫秒 | 个位数毫秒 |
| 持久化 | RDB 快照 + AOF 日志 | 自动 |
| 扩展 | Redis Cluster（分片） | 自动扩展 |
| 适用场景 | 缓存、会话、排行榜、消息队列 | 大规模 KV 存储、电商购物车 |

---

### 时序数据库

| 特性 | InfluxDB | TimescaleDB | QuestDB |
|------|----------|-------------|---------|
| 底层 | 自研 TSM 引擎 | PostgreSQL 扩展 | 自研，列式存储 |
| 查询 | Flux / InfluxQL | SQL | SQL |
| 压缩 | 自动 | 自动（原生压缩） | 高压缩比 |
| 保留策略 | 自动过期 | 原生分区 + 自动压缩 | 自动过期 |
| 适用场景 | DevOps 监控、IoT | 已有 PG 生态、需 SQL | 高吞吐金融数据 |

---

### 图数据库

| 特性 | Neo4j | ArangoDB |
|------|-------|----------|
| 模型 | 属性图 | 多模型（图 + 文档 + KV） |
| 查询语言 | Cypher | AQL（ArangoDB Query Language） |
| 集群 | Enterprise 版支持 | 社区版即支持 |
| ACID | 完整支持 | 完整支持 |
| 适用场景 | 知识图谱、推荐、社交网络 | 多模型需求、灵活查询 |

---

### 向量数据库（AI/ML 场景）

| 特性 | Pinecone | Milvus | Weaviate | Chroma |
|------|----------|--------|----------|--------|
| 部署 | 全托管 SaaS | 自部署 / Zilliz Cloud | 自部署 / Cloud | 嵌入式 / 自部署 |
| 索引 | HNSW + proprietary | IVF、HNSW、DiskANN | HNSW | HNSW |
| 混合搜索 | 稀疏+稠密 | 稀疏+稠密 | 稀疏+稠密+关键词 | 稀疏+稠密 |
| 过滤 | 元数据过滤 | 标量过滤 | 标量过滤 | 元数据过滤 |
| 标量存储 | 元数据 | Payload | 原生属性 | 原生 |
| 适用场景 | 快速上手、全托管 | 大规模生产、自部署 | 语义搜索、RAG | 快速原型、本地开发 |

---

### NewSQL

| 特性 | CockroachDB | TiDB | YugabyteDB |
|------|-------------|------|------------|
| 协议兼容 | PostgreSQL | MySQL | PostgreSQL |
| 架构 | 分布式事务 | 分布式事务 + HTAP | 分布式事务 |
| 扩展 | 自动分片、水平扩展 | 自动分片、TiFlash 列存 | 自动分片 |
| 强一致性 | Raft | Raft | Raft |
| 适用场景 | 全球分布式、强一致 | 大规模 OLTP + OLAP | PostgreSQL 兼容分布式 |

---

## 选型决策树

```
需要事务？
├── 是 → 数据量多大？
│   ├── < 1TB → PostgreSQL / MySQL
│   └── > 1TB → 需要分布式？
│       ├── 是 → CockroachDB / TiDB / YugabyteDB
│       └── 否 → PostgreSQL（读写分离）
├── 否 → 数据模型？
│   ├── 灵活文档 → MongoDB
│   ├── KV 缓存 → Redis
│   ├── 时序数据 → TimescaleDB（已有PG）/ InfluxDB（独立时序）
│   ├── 关系+图 → Neo4j / ArangoDB
│   └── 向量/语义 → Milvus（生产）/ Chroma（原型）
```

---

## 趋势

1. **HTAP 混合事务分析**：TiDB、CockroachDB 等 NewSQL 正在模糊 OLTP 和 OLAP 的边界
2. **向量数据库爆发**：RAG / LLM 应用推动向量数据库需求激增
3. **Serverless 数据库**：Aurora Serverless、PlanetScale、Neon 等按需计费模式
4. **多模型数据库**：ArangoDB、Fauna 等试图用一个引擎覆盖多种数据模型
5. **边缘数据库**：SQLite + CRDT（如 LiteFS、Turso）走向边缘部署

---

## 参考资料

- [PostgreSQL 官方文档](https://www.postgresql.org/docs/)
- [MongoDB 官方文档](https://www.mongodb.com/docs/)
- [Redis 官方文档](https://redis.io/docs/)
- [Milvus 官方文档](https://milvus.io/docs)
- [CockroachDB 官方文档](https://www.cockroachlabs.com/docs/)
