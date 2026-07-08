# API 设计规范

## API 风格

| 风格 | 说明 | 适用场景 |
|------|------|---------|
| REST | 基于资源的 HTTP 动词 | 通用 CRUD、公开 API |
| GraphQL | 声明式查询语言 | 前端驱动、复杂嵌套数据 |
| gRPC | 基于 HTTP/2 的二进制协议 | 微服务间通信、高性能 |
| WebSocket | 全双工通信 | 实时推送、聊天 |
| tRPC | 端到端类型安全 | 全栈 TypeScript |
| SSE | 服务端推送事件 | AI 流式输出、通知 |

---

## REST API 规范

### URL 设计

```
✅ 正确
GET    /api/v1/users              # 列表
GET    /api/v1/users/123          # 详情
POST   /api/v1/users              # 创建
PUT    /api/v1/users/123          # 全量更新
PATCH  /api/v1/users/123          # 部分更新
DELETE /api/v1/users/123          # 删除

❌ 错误
GET    /api/v1/getUsers           # 动词前缀
POST   /api/v1/user/create        # 包含动词
GET    /api/v1/users/123/delete   # 用 GET 执行删除
```

### 资源命名

| 规则 | 说明 | 示例 |
|------|------|------|
| 复数名词 | 资源用复数 | `/users` 不是 `/user` |
| 小写蛇形 | kebab-case 或 snake_case | `/user-profiles` 或 `/user_profiles` |
| 无动词 | URL 不包含动词 | 用 HTTP 动词表达操作 |
| 层级关系 | 嵌套表示从属 | `/users/123/orders` |

### HTTP 状态码

| 状态码 | 含义 | 使用场景 |
|--------|------|---------|
| 200 OK | 成功 | GET、PUT、PATCH 成功 |
| 201 Created | 已创建 | POST 创建成功 |
| 204 No Content | 无内容 | DELETE 成功 |
| 400 Bad Request | 请求错误 | 参数校验失败 |
| 401 Unauthorized | 未认证 | 缺少/无效 Token |
| 403 Forbidden | 无权限 | 认证通过但权限不足 |
| 404 Not Found | 不存在 | 资源未找到 |
| 409 Conflict | 冲突 | 重复创建、版本冲突 |
| 422 Unprocessable | 语义错误 | 格式正确但逻辑错误 |
| 429 Too Many Requests | 限流 | 超出速率限制 |
| 500 Internal Error | 服务端错误 | 未捕获异常 |
| 503 Unavailable | 服务不可用 | 维护、过载 |

### 响应格式

```json
// 成功 — 单个资源
{
  "data": {
    "id": "123",
    "name": "Alice",
    "email": "alice@example.com",
    "created_at": "2025-01-15T08:30:00Z"
  }
}

// 成功 — 列表（带分页）
{
  "data": [
    { "id": "123", "name": "Alice" },
    { "id": "456", "name": "Bob" }
  ],
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 156,
    "total_pages": 8
  }
}

// 错误
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address"
      }
    ]
  }
}
```

---

## 认证与授权

### 认证方式

| 方式 | 说明 | 适用场景 |
|------|------|---------|
| API Key | 简单密钥 | 服务端调用、低安全需求 |
| Bearer Token (JWT) | 无状态令牌 | 微服务、SPA |
| OAuth 2.0 | 授权框架 | 第三方接入、SSO |
| mTLS | 双向证书认证 | 高安全内部服务 |

### JWT 最佳实践

```
Header:  { "alg": "RS256", "typ": "JWT" }
Payload: { "sub": "user-123", "exp": 1705312200, "scope": "read write" }
Signature: RS256(privateKey)
```

- 使用 RS256（非 HS256）— 密钥不共享
- 短过期时间（15 分钟）+ Refresh Token
- 包含 `exp`、`iss`、`aud` 声明
- 不要放敏感信息在 Payload（JWT 只编码不加密）

### HTTP Header

```
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
Content-Type: application/json
Accept: application/json
X-Request-ID: 550e8400-e29b-41d4-a716-446655440000
X-Idempotency-Key: 6ba7b810-9dad-11d1-80b4-00c04fd430c8
```

---

## 分页

### 方案对比

| 方案 | 优点 | 缺点 |
|------|------|------|
| Offset 分页 | 简单、支持跳页 | 深度分页慢、数据偏移 |
| Cursor 分页 | 稳定、性能好 | 不支持跳页 |
| Keyset 分页 | 高性能 | 实现复杂 |

### Offset 分页

```http
GET /api/v1/users?page=2&per_page=20

{
  "data": [...],
  "pagination": {
    "page": 2,
    "per_page": 20,
    "total": 156,
    "total_pages": 8
  }
}
```

### Cursor 分页

```http
GET /api/v1/users?cursor=eyJpZCI6MTIzfQ==&limit=20

{
  "data": [...],
  "pagination": {
    "next_cursor": "eyJpZCI6MTQzfQ==",
    "has_more": true
  }
}
```

---

## 版本控制

| 策略 | 示例 | 优缺点 |
|------|------|--------|
| URL 路径 | `/api/v1/users` | 直观、最常用 |
| Header | `Accept: application/vnd.api.v1+json` | URL 干净、但不直观 |
| 查询参数 | `/api/users?version=1` | 简单、但不规范 |

**建议**：URL 路径版本控制（`/v1/`、`/v2/`），简单直接。

### 版本演进策略

```
v1 → v2 过渡期：
1. v1 继续运行，标记 deprecated
2. v2 发布，提供迁移指南
3. 设置过渡期（6–12 个月）
4. 过渡期结束，下线 v1
```

---

## 速率限制

### 响应 Header

```
X-RateLimit-Limit: 1000         # 窗口内总限额
X-RateLimit-Remaining: 742      # 剩余次数
X-RateLimit-Reset: 1705312200   # 窗口重置时间（Unix 时间戳）
Retry-After: 30                 # 429 响应时，建议等待秒数
```

### 限流策略

| 策略 | 说明 | 适用场景 |
|------|------|---------|
| 固定窗口 | 每分钟 N 次 | 简单场景 |
| 滑动窗口 | 滚动时间窗口 | 更平滑 |
| 令牌桶 | 按速率填充令牌 | 允许突发 |
| 漏桶 | 恒定速率处理 | 严格限速 |

---

## 幂等性

### 为什么需要

```
客户端 → POST /users → 201 Created
                        ↓ 网络超时，客户端未收到响应
客户端 → POST /users → ???  （重复创建？）
```

### 幂等 Key 机制

```http
POST /api/v1/payments
X-Idempotency-Key: 6ba7b810-9dad-11d1-80b4-00c04fd430c8
Content-Type: application/json

{
  "amount": 99.99,
  "currency": "USD"
}
```

```
服务端逻辑：
1. 收到请求，检查 Idempotency-Key
2. 如果 Key 不存在 → 执行操作，存储结果
3. 如果 Key 存在 → 直接返回之前的结果
4. Key 过期后自动清理（建议 24–48 小时）
```

### 幂等性映射

| HTTP 方法 | 是否幂等 | 说明 |
|-----------|---------|------|
| GET | 是 | 只读 |
| PUT | 是 | 全量替换 |
| DELETE | 是 | 删除后重复调用结果相同 |
| PATCH | 部分 | 取决于实现 |
| POST | 否 | 需要通过 Idempotency-Key 实现 |

---

## 错误处理

### 统一错误格式

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request is invalid",
    "details": [
      {
        "field": "email",
        "code": "INVALID_FORMAT",
        "message": "Must be a valid email address"
      },
      {
        "field": "age",
        "code": "OUT_OF_RANGE",
        "message": "Must be between 0 and 150"
      }
    ],
    "request_id": "550e8400-e29b-41d4-a716-446655440000",
    "doc_url": "https://api.example.com/docs/errors#VALIDATION_ERROR"
  }
}
```

### 错误码设计

```
格式: CATEGORY_SPECIFIC_ERROR

类别前缀:
  AUTH_     — 认证授权
  VALID_    — 参数校验
  NOTFOUND_ — 资源不存在
  RATE_     — 限流
  SYS_      — 系统错误

示例:
  AUTH_TOKEN_EXPIRED
  AUTH_INSUFFICIENT_PERMISSIONS
  VALID_MISSING_REQUIRED_FIELD
  VALID_INVALID_FORMAT
  NOTFOUND_USER
  RATE_LIMIT_EXCEEDED
  SYS_INTERNAL_ERROR
```

---

## API 文档

### OpenAPI (Swagger)

```yaml
openapi: 3.1.0
info:
  title: User API
  version: 1.0.0
paths:
  /users/{id}:
    get:
      summary: Get user by ID
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: User found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          description: User not found
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
        email:
          type: string
          format: email
```

### 文档工具

| 工具 | 说明 |
|------|------|
| Swagger UI | 交互式 API 文档 |
| Redoc | 三栏式文档 |
| Scalar | 现代 API 文档 + 测试客户端 |
| Stoplight Studio | 可视化 OpenAPI 编辑器 |

---

## 性能优化

### 缓存

```
# 服务端响应头
Cache-Control: public, max-age=3600
ETag: "33a64df5"
Last-Modified: Wed, 15 Jan 2025 08:30:00 GMT

# 客户端请求头
If-None-Match: "33a64df5"
If-Modified-Since: Wed, 15 Jan 2025 08:30:00 GMT

# 304 Not Modified — 无变化，不返回 body
```

### 压缩

```
Content-Encoding: gzip
Content-Encoding: br          # Brotli（更小）
Transfer-Encoding: chunked    # 流式传输
```

### 字段筛选

```http
GET /api/v1/users?fields=id,name,email
GET /api/v1/users?include=orders,profile
```

---

## GraphQL vs REST

| 维度 | REST | GraphQL |
|------|------|---------|
| 端点 | 多个端点 | 单一端点 |
| 数据获取 | 服务端决定返回字段 | 客户端精确指定 |
| 过度获取 | 常见 | 不会发生 |
| 缓存 | HTTP 缓存天然支持 | 需要额外方案 |
| 版本控制 | URL 版本 | Schema 演进（无需版本） |
| 学习曲线 | 低 | 中等 |
| 适用场景 | 公开 API、简单 CRUD | 复杂前端、移动端 |

---

## 选型决策

```
场景？
├── 公开 API → REST（最通用）
├── 移动端/复杂前端 → GraphQL（精确获取）
├── 微服务间通信 → gRPC（高性能、强类型）
├── 全栈 TypeScript → tRPC（端到端类型安全）
├── 实时推送 → WebSocket 或 SSE
└── AI 流式输出 → SSE 或 WebSocket
```

---

## 参考资料

- [REST API Design Best Practices](https://restfulapi.net/)
- [GitHub REST API 文档](https://docs.github.com/en/rest)
- [Stripe API 设计参考](https://stripe.com/docs/api)
- [Google API Design Guide](https://cloud.google.com/apis/design)
- [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines)
