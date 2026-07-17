# AGENTS.md / CLAUDE.md OpenWiki Block

Use these exact markers so the official OpenWiki CLI and this skill share the same injection region:

```
<!-- OPENWIKI:START -->
<!-- OPENWIKI:END -->
```

## Canonical block (insert or replace between markers)

```markdown
<!-- OPENWIKI:START -->

## OpenWiki

This repository uses OpenWiki for recurring code documentation. Start with `openwiki/quickstart.md`, then follow its links to architecture, workflows, domain concepts, operations, integrations, testing guidance, and source maps.

When you need repo context, read the OpenWiki pages first instead of scanning the entire codebase. Prefer updating source code and regenerating docs over hand-editing generated OpenWiki pages unless explicitly asked.

<!-- OPENWIKI:END -->
```

## Upsert rules

1. Target files (create if missing): `AGENTS.md`, `CLAUDE.md`
2. If both markers exist: replace everything from `<!-- OPENWIKI:START -->` through `<!-- OPENWIKI:END -->` (inclusive) with the canonical block
3. If file exists but markers are missing: append the canonical block at the end (leave existing content untouched)
4. If file is missing: create it containing only the canonical block (optionally preceded by a one-line `# Agent Instructions` heading)
5. Never rewrite content outside the marker region
6. Keep both `AGENTS.md` and `CLAUDE.md` in sync for cross-tool agents

## Optional Chinese variant

Only use when the user explicitly asks for Chinese agent instructions. Keep markers identical:

```markdown
<!-- OPENWIKI:START -->

## OpenWiki

本仓库使用 OpenWiki 维护面向 Agent 的代码文档。请先阅读 `openwiki/quickstart.md`，再按其中链接进入架构、工作流、领域概念、运维、集成、测试与源码地图。

需要仓库上下文时，优先读 OpenWiki 页面，而不是全库扫描。除非用户明确要求，不要手改生成页；应改源码后重新生成文档。

<!-- OPENWIKI:END -->
```
