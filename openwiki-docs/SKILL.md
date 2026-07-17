---
name: openwiki-docs
description: |
  Generate and maintain an OpenWiki-compatible agent documentation layer under
  openwiki/, then wire AGENTS.md / CLAUDE.md so IDE agents read the wiki first.
  Covers init, incremental update from git diffs, and AGENTS block upsert.
  Does not require a separate OpenWiki CLI or API key — runs inside Cursor /
  Claude Code / Codex using the IDE model.

  触发场景：
  - "openwiki"、"openwiki-docs"、"初始化 openwiki"、"更新 openwiki"
  - "给仓库生成 agent wiki / 代码知识库"
  - "把文档挂到 AGENTS.md"
  - "按 git diff 刷新文档"
version: 1.0.0
author: tunsuy
metadata:
  tags: [OpenWiki, Documentation, AGENTS.md, Codebase-Wiki, Knowledge-Base]
  related_skills: []
---

# OpenWiki Docs — IDE Skill

把 OpenWiki **可移植能力**做成 Skill：在仓库生成 `openwiki/` 文档层，并写入 `AGENTS.md` / `CLAUDE.md` 引用块。使用 **IDE 自带模型**，无需额外 API Key / `openwiki` CLI。

> 兼容约定对齐 [langchain-ai/openwiki](https://github.com/langchain-ai/openwiki) code mode（目录名、页面职责、`<!-- OPENWIKI:START -->` 标记）。不是官方 CLI 的完整替代（无 connector / personal brain / DeepAgents）。

## When to Use

- 用户要为当前仓库建立或刷新面向 Agent 的代码 wiki
- 用户提到 openwiki、agent 文档层、把知识库挂到 AGENTS.md
- 用户要用 git 变更做增量文档更新

**触发短语**：`openwiki init`、`openwiki update`、`生成 openwiki`、`刷新 agent 文档`、`挂 AGENTS.md`

## Prerequisites

- 在目标**仓库根目录**执行（有 `.git` 更佳，update 依赖 git）
- 可读写仓库文件
- 无需安装 OpenWiki CLI

## Quick Reference

| 模式 | 用户说法 | 动作 |
|------|----------|------|
| **init** | 初始化 / 生成 openwiki | 全量扫描 → 写 `openwiki/` → upsert AGENTS 块 |
| **update** | 更新 / 刷新 openwiki | diff 定向刷新页面 → 更新 `_meta.md` → 校验 AGENTS 块 |
| **wire-only** | 只挂 AGENTS | 不改 wiki，仅 upsert 引用块 |

默认：已有 `openwiki/quickstart.md` → **update**；否则 → **init**。

## Procedure

复制并跟踪进度：

```
OpenWiki Docs:
- [ ] 0. 路由模式 (init | update | wire-only)
- [ ] 1. 读 INSTRUCTIONS / schema
- [ ] 2. 收集证据 (全量 or diff)
- [ ] 3. 写/更新 openwiki 页面
- [ ] 4. Upsert AGENTS.md + CLAUDE.md
- [ ] 5. 写 _meta.md + 向用户汇报
```

### Step 0 — 路由

1. 用户明确说 init / update / 只挂 AGENTS → 听从
2. 否则：存在 `openwiki/quickstart.md` → update；否则 init
3. 读 [references/wiki-schema.md](references/wiki-schema.md) 与 [references/agents-block.md](references/agents-block.md)

### Step 1 — 尊重用户 brief

- 若 `openwiki/INSTRUCTIONS.md` 存在：**读取并遵守**；init/update **不得覆盖**其内容（除非用户要求改 brief）
- 若不存在：按 schema 模板创建一份短 brief，再继续

### Step 2 — 收集证据

**init（全量）**

1. 读根目录 README、manifest（`package.json` / `pyproject.toml` / `go.mod` / `Cargo.toml` 等）
2. 列出顶层目录，识别模块边界与入口
3. 抽查关键路径（路由、服务、存储、CI、测试）
4. 记录真实命令（build / test / lint / start）

**update（增量）**

1. 优先运行（路径相对本 skill）：

```bash
bash scripts/changed-files.sh --stat
```

若 skill 不在 cwd，用本 skill 的绝对路径调用该脚本；或在仓库内手动：

```bash
BASE=$(grep 'last_sync_commit:' openwiki/_meta.md | head -1 | sed 's/.*: //')
git diff --name-only "${BASE:-HEAD~20}...HEAD"
```

2. 按 schema 的「Update targeting」表决定要刷新的页面
3. 无有效 diff 且 wiki 已完整 → 只刷新 `_meta.md` 时间戳并说明 no-op

### Step 3 — 写 wiki

遵循 [wiki-schema.md](references/wiki-schema.md)：

1. **必须**：`quickstart.md`、`_meta.md`
2. **按需**：`architecture.md`、`workflows.md`、`domain.md`、`operations.md`、`integrations.md`、`testing.md`、`source-map.md`、`api.md`
3. 每页引用真实文件路径；不确定写 `TODO(verify):`
4. `quickstart.md` 必须链接到其他已写页面
5. update 时：只改受影响页；删除已不存在模块的过时描述
6. **禁止**写入密钥、`.env` 内容、token、私钥

### Step 4 — Upsert agent 引用块

对 `AGENTS.md` 与 `CLAUDE.md`（缺则建）执行 [agents-block.md](references/agents-block.md) 的 upsert：

- 仅改 `<!-- OPENWIKI:START -->` … `<!-- OPENWIKI:END -->` 区域
- 区域外内容一律保留

### Step 5 — Meta 与汇报

更新 `openwiki/_meta.md`：`last_sync`、`last_sync_commit`（`git rev-parse HEAD`）、`mode`、`pages`。

向用户简报：

- 模式与生成/更新的页面列表
- AGENTS / CLAUDE 是否已挂上
- 建议下一步（commit `openwiki/` + agent 文件；或以后说「更新 openwiki」）

## Writing Standards

- 面向 coding agent：短句、可执行、可导航
- 不要把整仓文档塞进 `AGENTS.md`（只放引用块）
- 不要手写与源码矛盾的「理想架构」
- 大型 monorepo：先覆盖主应用/包，其余在 `INSTRUCTIONS.md` 标明后续范围

## Pitfalls

| 陷阱 | 规避 |
|------|------|
| 覆盖 `INSTRUCTIONS.md` | 视为用户资产，默认只读 |
| 重写整个 AGENTS.md | 只 upsert OPENWIKI 标记块 |
| 编造模块/命令 | 必须来自仓库证据 |
| 把密钥写进 wiki | 跳过 secret 文件；示例用占位符 |
| 无 git 还硬跑 update | 改为 mini-init：重扫入口文件并改相关页 |
| 与官方 `openwiki` CLI 混用冲突 | 同目录同标记可共存；同一次任务不要两边同时全量生成 |

## Verification

- [ ] `openwiki/quickstart.md` 存在且含到其他页的链接
- [ ] `openwiki/_meta.md` 含 `last_sync` 与 `last_sync_commit`
- [ ] `AGENTS.md` 与 `CLAUDE.md` 含完整 OPENWIKI 标记块
- [ ] 标记块外的原有 AGENTS 内容仍在
- [ ] wiki 中的路径/命令能在仓库中对应到真实文件或 manifest 脚本

## Out of Scope

- OpenWiki personal brain / Notion / Gmail 等 connector
- 官方 CLI 的 provider 配置、遥测、LangSmith
- 替代项目编码规范（那些仍应写在 AGENTS 其他段落或 Rules）

## Additional Resources

- [references/wiki-schema.md](references/wiki-schema.md) — 目录与页面模板
- [references/agents-block.md](references/agents-block.md) — AGENTS 引用块全文
- [scripts/changed-files.sh](scripts/changed-files.sh) — 自上次同步以来的变更文件列表
