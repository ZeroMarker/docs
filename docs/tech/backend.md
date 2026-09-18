# 后端框架对比

## 框架全景

```
后端框架
├── JavaScript / TypeScript
│   ├── Express
│   ├── Fastify
│   ├── NestJS
│   ├── Hono
│   └── Elysia (Bun)
├── Python
│   ├── FastAPI
│   ├── Django
│   └── Flask
├── Go
│   ├── Gin
│   ├── Echo
│   ├── Fiber
│   └── Chi
├── Rust
│   ├── Axum
│   ├── Actix Web
│   └── Rocket
├── Java
│   ├── Spring Boot
│   └── Quarkus
├── Ruby
│   └── Rails
└── PHP
    └── Laravel
```

---

## Node.js / TypeScript

### Express

| 维度 | 说明 |
|------|------|
| 定位 | 最经典的 Node.js 框架 |
| 性能 | 中等 |
| 中间件 | 最丰富（事实标准） |
| 学习曲线 | 低 |
| 适用场景 | 传统 API、微服务、快速原型 |

```typescript
import express from 'express';
const app = express();

app.get('/users/:id', (req, res) => {
  res.json({ id: req.params.id });
});

app.listen(3000);
```

---

### Fastify

| 维度 | 说明 |
|------|------|
| 定位 | Express 替代品，高性能 |
| 性能 | 快（基于 schema 验证和序列化） |
| 插件系统 | 封装式，推荐替代全局中间件 |
| Schema 验证 | 原生 JSON Schema 集成 |
| 适用场景 | 需要高性能、类型安全的 API |

```typescript
import Fastify from 'fastify';
const app = Fastify();

app.get('/users/:id', async (request, reply) => {
  return { id: request.params.id };
});

app.listen({ port: 3000 });
```

---

### NestJS

| 维度 | 说明 |
|------|------|
| 定位 | 企业级全功能框架（Angular 风格） |
| 性能 | 中等 |
| 架构 | 依赖注入 + 装饰器 + 模块化 |
| ORM 集成 | TypeORM / Prisma / Drizzle |
| 适用场景 | 大型应用、团队协作、需要严格架构 |

```typescript
@Controller('users')
export class UserController {
  constructor(private userService: UserService) {}

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.userService.findOne(id);
  }
}
```

---

### Hono

| 维度 | 说明 |
|------|------|
| 定位 | 超轻量、多运行时 |
| 性能 | 极快（路由匹配 > 100 万次/秒） |
| 运行时 | Cloudflare Workers / Deno / Bun / Node.js |
| 体积 | ~14KB（含路由） |
| 适用场景 | 边缘计算、Serverless、轻量 API |

```typescript
import { Hono } from 'hono';
const app = new Hono();

app.get('/users/:id', (c) => {
  return c.json({ id: c.req.param('id') });
});

export default app;
```

---

### Node.js 框架选型

```
Express  — 遗留项目 / 中间件生态依赖
Fastify  — 高性能 / Schema 驱动
NestJS   — 大团队 / 企业级 / 需要架构约束
Hono     — 边缘 / Serverless / 极致轻量
Elysia   — Bun 生态 / TypeScript 极致体验
```

---

## Python

### FastAPI

| 维度 | 说明 |
|------|------|
| 定位 | 现代高性能 API 框架 |
| 性能 | 极快（接近 Go/Rust，基于 Starlette） |
| 类型安全 | 原生 Pydantic 数据验证 |
| 文档 | 自动生成 OpenAPI (Swagger) |
| 异步 | 原生 async/await |
| 适用场景 | AI/ML 服务、微服务、数据 API |

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    id: int
    name: str

@app.get("/users/{user_id}")
async def get_user(user_id: int) -> User:
    return User(id=user_id, name="Alice")
```

---

### Django

| 维度 | 说明 |
|------|------|
| 定位 | 全功能 Web 框架（"batteries included"） |
| 性能 | 中等 |
| ORM | 功能最强的 Python ORM |
| Admin | 自动生成管理后台 |
| 异步 | 3.1+ 支持（部分） |
| 适用场景 | 内容管理、电商、复杂业务系统 |

```python
from django.http import JsonResponse
from django.urls import path

def user_view(request, user_id):
    return JsonResponse({"id": user_id})

urlpatterns = [
    path("users/<int:user_id>", user_view),
]
```

---

### Flask

| 维度 | 说明 |
|------|------|
| 定位 | 微框架（极简） |
| 性能 | 中等 |
| 扩展 | 按需组合（Jinja2、SQLAlchemy 等） |
| 学习曲线 | 极低 |
| 适用场景 | 原型、微服务、教学 |

---

### Python 框架选型

```
FastAPI  — 新项目首选 / AI 服务 / 高性能 API
Django   — 全栈 Web / 复杂业务 / 需要 Admin
Flask    — 微服务 / 轻量 API / 原型
```

---

## Go

### Gin

| 维度 | 说明 |
|------|------|
| 定位 | 最流行的 Go Web 框架 |
| 性能 | 极快（基于 httprouter） |
| 中间件 | 丰富（日志、CORS、认证等） |
| 学习曲线 | 低 |
| 适用场景 | REST API、微服务、高并发 |

```go
r := gin.Default()

r.GET("/users/:id", func(c *gin.Context) {
    c.JSON(200, gin.H{"id": c.Param("id")})
})

r.Run(":3000")
```

---

### Echo

| 维度 | 说明 |
|------|------|
| 定位 | 高性能、极简 |
| 性能 | 极快（略快于 Gin） |
| API 设计 | 更优雅、更一致 |
| 适用场景 | 追求性能和代码简洁 |

---

### Fiber

| 维度 | 说明 |
|------|------|
| 定位 | Express 风格的 Go 框架 |
| 性能 | 极快（基于 fasthttp） |
| API 风格 | 类似 Express（对 JS 开发者友好） |
| 注意 | 不完全兼容 net/http（扩展性受限） |
| 适用场景 | JS 开发者转 Go、追求极致性能 |

---

### Chi

| 维度 | 说明 |
|------|------|
| 定位 | 轻量级路由器 |
| 特点 | 完全兼容 net/http、可组合 |
| 中间件 | 标准库风格 |
| 适用场景 | 保持标准库风格、渐进式引入 |

---

### Go 框架选型

```
Gin    — 通用首选 / 招人容易
Echo   — 追求 API 美学 / 性能
Fiber  — JS 转 Go / 极致性能
Chi    — 标准库兼容 / 轻量
```

---

## Rust

### Axum

| 维度 | 说明 |
|------|------|
| 维护者 | Tokio 团队 |
| 性能 | 极快 |
| 类型安全 | 提取器（Extractor）编译时保证 |
| 生态 | 与 Tower 中间件、Tokio 深度集成 |
| 适用场景 | 高性能服务、系统级 API |

```rust
use axum::{routing::get, Router};

async fn get_user(axum::extract::Path(id): axum::extract::Path<u32>) -> String {
    format!("User {id}")
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/users/:id", get(get_user));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
```

---

### Actix Web

| 维度 | 说明 |
|------|------|
| 性能 | 极快（历史基准测试王者） |
| 成熟度 | 比 Axum 更早，生产验证更多 |
| 学习曲线 | 较高（Actor 模型） |
| 适用场景 | 高并发、已有 Actix 经验 |

---

### Rust 框架选型

```
Axum     — 新项目首选 / Tokio 生态 / 类型安全
Actix    — 已有经验 / 需要 Actor 模型
Rocket   — 易用性优先 / 宏驱动
```

---

## Java

### Spring Boot

| 维度 | 说明 |
|------|------|
| 定位 | Java 企业级事实标准 |
| 生态 | 最大（Spring Cloud、Spring Security、Spring Data） |
| 性能 | 中等（GraalVM 原生编译可提升） |
| 学习曲线 | 高（注解驱动、自动配置） |
| 适用场景 | 大型企业系统、微服务、金融 |

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        return new User(id, "Alice");
    }
}
```

---

### Quarkus

| 维度 | 说明 |
|------|------|
| 定位 | 云原生 Java 框架 |
| 启动时间 | 毫秒级（GraalVM 原生编译） |
| 内存占用 | 极低（~50MB） |
| 与 Spring 兼容 | 部分兼容 |
| 适用场景 | Serverless、容器、Knative |

---

### Java 框架选型

```
Spring Boot — 企业标准 / 最大生态 / 招人容易
Quarkus    — 云原生 / Serverless / 极致启动速度
```

---

## Ruby / PHP

### Ruby on Rails

| 维度 | 说明 |
|------|------|
| 定位 | 全栈 Web 框架（约定优于配置） |
| 特点 | 开发速度极快、DRY 原则 |
| 适用场景 | MVP、SaaS、内容管理 |

### Laravel

| 维度 | 说明 |
|------|------|
| 定位 | PHP 现代框架 |
| 特点 | 优雅语法、丰富生态（Livewire、Filament） |
| 适用场景 | Web 应用、CMS、电商 |

---

## 性能对比（请求/秒，基准测试参考）

```
Rust (Axum/Actix) > Go (Gin/Fiber) > Node.js (Fastify) > Python (FastAPI) > Java (Spring Boot) > Ruby (Rails) > PHP (Laravel)
      500K+              200K+            80K+              50K+              30K+              15K+           10K+
```

**注意**：基准测试仅供参考，实际性能取决于业务逻辑、数据库、网络等。框架选择对大多数应用不是性能瓶颈。

---

## 选型决策

```
场景？
├── AI/ML 服务 → FastAPI（Python 生态、类型安全）
├── 高并发 API → Go (Gin) 或 Rust (Axum)
├── 企业级系统 → Spring Boot（最大生态）
├── 全栈 Web → Rails 或 Laravel（快速开发）
├── 边缘/Serverless → Hono 或 Quarkus
├── 微服务网关 → Go (Fiber) 或 Node.js (Fastify)
└── 不确定 → FastAPI（AI 时代）或 Spring Boot（企业时代）
```

### 按团队技术栈

| 技术栈 | 推荐 |
|--------|------|
| JavaScript/TypeScript | Fastify 或 Hono |
| Python | FastAPI |
| Go | Gin |
| Rust | Axum |
| Java | Spring Boot |
| Ruby | Rails |
| PHP | Laravel |

---

## 参考资料

- [Express 官方文档](https://expressjs.com/)
- [Fastify 官方文档](https://fastify.dev/)
- [NestJS 官方文档](https://docs.nestjs.com/)
- [FastAPI 官方文档](https://fastapi.tiangolo.com/)
- [Django 官方文档](https://www.djangoproject.com/)
- [Gin 官方文档](https://gin-gonic.com/docs/)
- [Axum 官方文档](https://docs.rs/axum/latest/axum/)
- [Spring Boot 官方文档](https://spring.io/projects/spring-boot)
