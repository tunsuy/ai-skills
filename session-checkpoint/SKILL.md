---
name: session-checkpoint
description: >
  自动判断对话中是否出现值得持久化的结果，并分开写入任务交接（handoff）
  与长期项目知识（knowledge）。用于技术方案定案、排查结论、约束边界、
  未完成交接、踩坑记录等场景；也在用户说「按之前方案」「继续上次」
  「隔天继续」时先检索落盘文件再执行。避免长对话隔天后 Agent 遗忘或跑偏。
version: 1.0.0
author: marshal
license: MIT
metadata:
  tags: [Memory, Checkpoint, Handoff, Context, Agent]
  related_skills: [long-running-agent-guide, self-evolving-skills]
---

# Session Checkpoint — 会话检查点自动落盘

> 聊天不是硬盘。定案、约束、排查结论和未完成进度必须写成可检索文件，
> 否则隔天续聊很容易跑偏。

## When to Use

**主动落盘（Agent 自行判断后执行，无需用户催）：**

- 技术方案 / 架构选型已收敛（「就按这个」「选 A 不选 B」）
- 出现明确约束或反例（「别动 X」「不能上线 Y」）
- 排查得出 root cause 或可复用结论
- 用户表示稍后继续（「先这样」「改天实施」「回头再说」）
- 对话即将结束，但仍有未落地的可执行结论
- 发现可复用的项目约定、偏好或踩坑 workaround

**被动续聊（用户指代历史时必须先读盘）：**

- 「按之前方案实施」「继续上次」「根据我们定的方案」
- 「隔天继续」「接着做」

**不要落盘：**

- 仍在多方案对比、尚未拍板
- 纯问答 / 一次性解释，后续用不到
- 结论已完整写入代码、PR 或既有文档，且无额外决策要保留
- 密钥、token、密码等敏感信息（只记「用哪个配置/环境」，不记秘密本身）

## Prerequisites

- 当前工作区可写文件
- 优先写入项目内路径（见下）；若无明确项目根目录，先确认路径再写

## Quick Reference

| 类型 | 目录 | 生命周期 | 典型内容 |
|------|------|----------|----------|
| **Handoff** | `.agent/handoffs/` | 任务级，完成后可归档 | 方案、步骤、进度、下一步、完成标准 |
| **Knowledge** | `.agent/knowledge/` | 项目级，长期保留 | 约定、约束、踩坑、环境习惯（无密钥） |

| 判定信号 | 写入 |
|----------|------|
| 定案方案 / 未完成任务 / 交接续做 | Handoff |
| 约定、偏好、踩坑、长期约束 | Knowledge |
| 两者都有 | 各写一份，handoff 里链到 knowledge 文件 |

## Procedure

### Step 1: 判断是否值得持久化

每个有意义的回合结束前快速自检（不必每句话都写）：

```
出现任一「可复用结果」？
├─ 否 → 不写，继续对话
└─ 是 → 属于任务交接还是长期知识？（或两者）
         → Step 2
```

**Handoff 信号：** 可执行方案已定、实施步骤清晰、明确暂停点、完成标准可验证。  
**Knowledge 信号：** 跨任务仍成立的约定、约束、环境习惯、踩坑与 workaround。

同一轮两者都出现时：**分开写**，不要混进一个文件。

### Step 2: 选择路径与文件名

```
.agent/
├── handoffs/
│   └── YYYY-MM-DD-<short-slug>.md
└── knowledge/
    └── <topic-slug>.md          # 同主题可更新同一文件，勿无限新建
```

- `short-slug` / `topic-slug`：小写英文或拼音，连字符，≤ 40 字符
- 目录不存在则创建
- Knowledge 已有同主题文件 → **更新/追加**，不要复制粘贴出第三份

若项目已有 `AGENTS.md` / `CLAUDE.md`，且内容是稳定项目约定：  
Knowledge 写完后，把**极短摘要**（1–3 条）upsert 进对应文件；细节仍留在 `.agent/knowledge/`。

### Step 3: 按模板写入

- Handoff → 使用 [templates/handoff.md](templates/handoff.md)
- Knowledge → 使用 [templates/knowledge.md](templates/knowledge.md)

写入要求：

1. **原文级保留**关键约束与完成标准，不要二次摘要到失真
2. 写清「做什么 / 不做什么」
3. Handoff 必须有「下一步」和「完成标准」
4. 禁止写入密钥；凭据只写名称或配置路径

### Step 4: 告知用户

落盘后用简短回复说明：

```
已落盘：
- [handoff|knowledge] path/to/file.md — 一句话摘要
下次续做请说：按 .agent/handoffs/xxx.md 实施
```

不要夸大；没写的类型不要提。

### Step 5: 用户续聊时的强制流程

当用户指代「之前方案 / 上次 / 继续」时：

1. **先搜** `.agent/handoffs/`（按日期与 slug），必要时再搜 `.agent/knowledge/`
2. **先读** 命中的 handoff；向用户复述：目标、关键步骤、不做清单、下一步
3. 复述对齐后，**严格按文件执行**；文件外的大改动先确认
4. 若找不到文件：明确说没找到，请用户给出路径或从记忆重建一版再落盘，**禁止直接开干不相干事项**

## Pitfalls

### ⚠️ 什么都存 → 噪音

只存「离开对话会丢、且后面还要用」的内容。Brainstorm 半成品不要落盘。

### ⚠️ 混目录

任务进度进 handoffs；跨任务真理进 knowledge。混放会导致续聊时检索到过期任务状态。

### ⚠️ 摘要丢失约束

「大概用缓存优化」不够；要写清选用的方案、否决的方案、硬约束。

### ⚠️ 只口头说已记住

没有文件路径就不算完成持久化。

### ⚠️ 续聊时跳过读盘

「按之前方案」若直接动手，等于复现本 Skill 要防止的失败模式。

## Verification

落盘后自检：

- [ ] 文件在正确目录（handoff vs knowledge）
- [ ] 含日期/主题与可检索 slug
- [ ] Handoff 含目标、步骤、不做清单、下一步、完成标准
- [ ] Knowledge 含适用边界与可执行条目
- [ ] 无密钥明文
- [ ] 已向用户给出路径

续聊自检：

- [ ] 已读取 handoff（或明确报告未找到）
- [ ] 已复述关键点并与用户对齐
- [ ] 实施范围未超出文件约定

## Additional Resources

- 模板：[templates/handoff.md](templates/handoff.md)、[templates/knowledge.md](templates/knowledge.md)
- 判定细则与示例：[references/decision-guide.md](references/decision-guide.md)
- 长时间运行上下文策略见 `long-running-agent-guide`
- 可复用流程沉淀为 Skill 见 `self-evolving-skills`
