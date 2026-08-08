# Decision Guide — 何时落盘、落哪边

## 一句话标准

> 若两天后在新对话里只说「继续」，没有这份文件就会做错或重做 —— 就该落盘。

## Handoff vs Knowledge

| 问自己 | Handoff | Knowledge |
|--------|---------|-----------|
| 这件事做完还可以删吗？ | 通常可以归档 | 通常应保留 |
| 换一个无关任务还需要吗？ | 否 | 是 |
| 核心是「进度/方案/下一步」吗？ | 是 | 否 |
| 核心是「约定/坑/约束」吗？ | 否 | 是 |

## 场景示例

### 应写 Handoff

- 用户与 Agent 讨论后确定「用消息队列削峰，不引入新服务」；用户说「改天再写」
- 实现做到一半，用户关电脑；已完成迁移脚本，下一步是改 API
- Code review 达成修改清单，尚未改完

### 应写 Knowledge

- 「本仓库测试必须用 `make test-unit`，不要直接 `go test ./...`」
- 「支付回调不能同步调第三方，必须进 outbox」
- 「某依赖 v2 有死锁，钉在 v1.9.x」

### 两边都写

- 定下支付改造方案（handoff），同时提炼「回调必须异步」为团队约束（knowledge）
- handoff 的 `Related knowledge` 字段链到 knowledge 文件

### 不应写

- 「Redis 和 Memcached 各有什么优缺点？」纯科普
- 三个方案还在比，用户没表态
- 已经合并的 PR 里写清了全部决策，聊天无增量

## 续聊话术（给用户）

落盘后建议提示用户下次这样说：

```text
读 .agent/handoffs/2026-08-08-payment-outbox.md，按其中方案实施；
先复述步骤，确认后再改代码。
```

## 与其他机制的边界

| 机制 | 职责 |
|------|------|
| session-checkpoint | 对话中的任务交接 + 项目事实落盘 |
| self-evolving-skills | 把可复用**流程**沉淀成 Skill |
| AGENTS.md / CLAUDE.md | 稳定、短小的项目操作手册；细节仍放 knowledge |
| Mem0 等记忆产品 | 可选增强；本 Skill 不依赖它们 |
