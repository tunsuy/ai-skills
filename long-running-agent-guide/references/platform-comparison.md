# 长时间运行 Agent 平台对比参考

本文档对比当前主流的长时间运行 Agent 运行时/平台方案，帮助你做出技术选型决策。

---

## 平台概览

### Google Agent Platform (Agent Engine + Memory Bank + Sessions)

```
定位：企业级 Agent 托管平台
核心组件：
├─ Agent Engine — Agent 运行时（管理循环、工具调用、错误处理）
├─ Memory Bank — 托管的持久化记忆服务（可查询、可索引）
├─ Sessions — 会话管理（支持暂停/恢复/上下文重置）
├─ Identity — 内置身份认证和权限管理
└─ Audit Trail — 完整的审计追踪

优势：
✅ 开箱即用的企业特性（身份、审计、合规）
✅ Memory Bank 是托管服务，无需自建存储
✅ 原生集成 Google Cloud 生态
✅ 大脑/双手/会话三者解耦

劣势：
❌ 锁定在 Google Cloud 生态
❌ 模型选择主要限于 Gemini 系列
❌ 定价随使用量增长可能昂贵
❌ 自定义程度受限于平台能力边界
```

### Claude Managed Agents

```
定位：Anthropic 运行框架的托管版本
核心特性：
├─ 基于 Anthropic 运行框架文章中描述的最佳实践
├─ 内置上下文管理和重置机制
├─ 沙箱化的代码执行环境
├─ 安全第一的设计（大脑/双手分离）
└─ 结构化的会话日志

优势：
✅ 与 Claude 模型深度优化
✅ 安全设计经过 Anthropic 内部验证
✅ 沙箱环境开箱即用
✅ 运行框架实践直接内置

劣势：
❌ 模型绑定为 Claude 系列
❌ 相对较新，生态还在发展中
❌ 企业特性（身份、审计）可能不如 Google 完整
❌ 文档和社区资源相对有限
```

### 自建方案（ADK / Claude Agent SDK / Codex SDK）

```
定位：自主控制的 Agent 运行时
可选基础设施：
├─ ADK (Agent Development Kit) — Google 的开源 Agent 框架
├─ Claude Agent SDK — Anthropic 的 Agent 开发套件
├─ Codex SDK — OpenAI 的 Agent 开发套件
├─ LangGraph — LangChain 的状态化 Agent 框架
└─ 完全自研 — 从零构建

优势：
✅ 完全控制架构和实现细节
✅ 可以混合使用不同模型（如 Cursor 的模式）
✅ 不锁定任何云平台或模型提供商
✅ 可以针对特定场景深度优化

劣势：
❌ 需要自行实现状态管理、会话日志、安全沙箱
❌ 运维负担重
❌ 需要深厚的分布式系统经验
❌ 可观测性、告警等需要自建或集成
```

---

## 功能矩阵对比

| 功能 | Google Agent Platform | Claude Managed Agents | 自建 (ADK/SDK) |
|------|----------------------|----------------------|----------------|
| **运行时管理** | ✅ 托管 | ✅ 托管 | ⚙️ 自建 |
| **模型选择** | Gemini 为主 | Claude 为主 | 任意模型 |
| **混合模型** | 有限支持 | 不支持 | ✅ 完全支持 |
| **Memory Bank** | ✅ 内置托管 | 有限支持 | ⚙️ 自建 |
| **会话管理** | ✅ 内置 | ✅ 内置 | ⚙️ 自建 |
| **上下文重置** | ✅ 内置 | ✅ 内置 | ⚙️ 自建 |
| **沙箱执行** | ✅ 内置 | ✅ 内置（强调安全） | ⚙️ 自建 |
| **身份认证** | ✅ 内置（Google IAM） | 基础支持 | ⚙️ 自建 |
| **审计追踪** | ✅ 内置 | 基础支持 | ⚙️ 自建 |
| **可观测性** | ✅ 集成 Cloud Monitoring | 基础支持 | ⚙️ 自建 |
| **成本控制** | ✅ 内置预算管理 | 基础支持 | ⚙️ 自建 |
| **多 Agent 编排** | ✅ 原生支持 | 有限支持 | ⚙️ 完全自定义 |
| **定价** | 按量付费 ($$-$$$) | 按量付费 ($$$) | 基础设施成本 ($-$$) |
| **锁定风险** | 高（Google Cloud） | 中（Claude 模型） | 低 |
| **上手难度** | 中 | 中 | 高 |
| **定制自由度** | 中 | 中 | 高 |

---

## 场景匹配推荐

### 场景 A：开发者编码 Agent

```
推荐：直接使用 Claude Code / Cursor / Codex

不需要自建运行时，运行框架已经存在。
你的工作是写好 AGENTS.md 和配置钩子。

如果需要多小时运行：
├─ Claude Code → 在 worktree 中运行
├─ Cursor → 使用后台 Agent 功能
└─ Codex → 云端异步执行
```

### 场景 B：托管 Agent 产品

```
决策流程：

Q1: 你的用户群体？
├─ 企业用户（需要合规、审计） → Google Agent Platform
├─ 开发者用户（需要灵活性） → 自建 (ADK + 自托管)
└─ 通用用户（需要安全性） → Claude Managed Agents

Q2: 是否需要混合模型？
├─ 是 → 自建（可以为不同角色搭配不同模型）
└─ 否 → 托管方案

Q3: 团队的基础设施能力？
├─ 强（有 SRE/DevOps 团队） → 自建
└─ 有限 → 托管方案

最常见的正确起点：
托管运行时负责底层（状态/调度/沙箱），
你自己的 ADK 或 SDK 代码负责实际的业务循环。
```

### 场景 C：自主运维 Agent

```
推荐技术栈：ADK + Memory Bank + Cloud Run + Cloud Scheduler

替代方案：
├─ LangGraph + Redis + Kubernetes CronJob
├─ Claude Agent SDK + 自建 Memory + AWS Lambda + EventBridge
└─ Temporal + 自定义 Agent Worker

关键选型因素：
├─ 调度可靠性 → Cloud Scheduler / K8s CronJob / Temporal
├─ 状态持久化 → Memory Bank / Redis / PostgreSQL
├─ 可观测性 → OpenTelemetry + Jaeger/Prometheus
└─ 告警通知 → PagerDuty / 飞书/企微 Webhook
```

---

## 自建方案的组件选型

如果选择自建，以下是各组件的推荐技术：

| 组件 | 推荐方案 | 备选方案 | 考虑因素 |
|------|---------|---------|---------|
| **Agent 框架** | ADK / LangGraph | Autogen / CrewAI | 社区活跃度、文档完整性 |
| **状态存储** | PostgreSQL + Redis | MongoDB + Memcached | 查询灵活性 vs 性能 |
| **事件日志** | JSONL 文件 / Kafka | ClickHouse / Elasticsearch | 吞吐量 vs 查询能力 |
| **沙箱执行** | Docker / gVisor | Firecracker / WASM | 隔离级别 vs 启动速度 |
| **调度** | Cloud Scheduler / Temporal | K8s CronJob / APScheduler | 可靠性 vs 简单性 |
| **可观测性** | OpenTelemetry | Datadog / New Relic | 成本 vs 开箱即用 |
| **告警** | Prometheus + Alertmanager | PagerDuty | 自定义需求 |
| **向量存储** | pgvector / Qdrant | Pinecone / Weaviate | 自托管 vs 托管 |

### Go 技术栈推荐

对于 Go 开发者，推荐的自建技术栈：

```
Agent 循环:      自建（基于 goroutine + channel）
HTTP 框架:       tRPC-Go / gin / echo
状态存储:        PostgreSQL (sqlx/pgx) + Redis (go-redis)
事件日志:        zerolog + JSONL 文件 / Kafka (sarama)
沙箱执行:        Docker SDK (docker/docker) / exec.CommandContext
调度:            robfig/cron / cloud scheduler API
可观测性:        OpenTelemetry Go SDK
配置管理:        viper
依赖注入:        wire / fx
```

---

## 成本估算参考

### 模型调用成本（截至 2025 年中）

| 模型 | 输入价格 ($/1M tokens) | 输出价格 ($/1M tokens) | 适用角色 |
|------|----------------------|----------------------|---------|
| GPT-4o | ~2.50 | ~10.00 | 规划器、评判器 |
| GPT-4o-mini | ~0.15 | ~0.60 | 工作者（简单任务） |
| Claude Sonnet | ~3.00 | ~15.00 | 规划器、评判器 |
| Claude Haiku | ~0.25 | ~1.25 | 工作者（简单任务） |
| Gemini Pro | ~1.25 | ~5.00 | 通用 |
| Gemini Flash | ~0.075 | ~0.30 | 工作者（大量调用） |

### 24 小时运行估算

```
假设：
- 每分钟 2 次 API 调用
- 平均每次输入 2000 tokens，输出 1000 tokens
- 混合使用：70% 便宜模型 + 30% 贵模型

计算：
- 24 小时 = 1440 分钟 × 2 次 = 2880 次调用
- 总输入 tokens: 2880 × 2000 = 5.76M tokens
- 总输出 tokens: 2880 × 1000 = 2.88M tokens

成本范围：
- 全用便宜模型 (GPT-4o-mini): ~$1.44 + $1.73 ≈ $3.2
- 全用贵模型 (Claude Sonnet): ~$17.3 + $43.2 ≈ $60.5
- 混合策略: 大约 $10 - $25

结论：
- 不贵，但没有预算控制可以轻松 10x
- 如果 Agent 陷入循环，每分钟调用可能飙到 10+，成本线性增长
- 必须有断路器
```

---

## 趋势与展望

```
正在趋同的方向：
1. 模型循环、执行沙箱、会话日志 → 三者解耦
2. 规划、生成、评估 → 角色分离
3. 上下文压缩和重置 → 内置能力
4. 记忆 → 可查询的托管服务

尚未解决的难题：
1. 共享代码库上多个 Agent 的协调
2. Agent 自我修复运行框架的能力
3. 运行时动态组装工具和上下文
4. 跨提供商的 Agent 互操作性标准
```

---

*本对比文档基于 2025 年 5 月的公开信息，平台功能和定价可能已更新，请参考各平台官方文档获取最新信息。*
