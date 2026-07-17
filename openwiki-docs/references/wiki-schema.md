# OpenWiki Directory Schema

Compatible with [langchain-ai/openwiki](https://github.com/langchain-ai/openwiki) code-mode layout. All paths are relative to the repository root.

## Layout

```
openwiki/
├── INSTRUCTIONS.md          # User brief (DO NOT overwrite on init/update)
├── quickstart.md            # Agent entry point (required)
├── architecture.md          # System shape and module boundaries
├── workflows.md             # Important end-to-end flows
├── domain.md                # Domain concepts and terminology
├── operations.md            # Build, run, deploy, debug
├── integrations.md          # External services / APIs
├── testing.md               # How to test and what to trust
├── source-map.md            # Key files and where to look
├── api.md                   # Optional: public API / CLI surface
└── _meta.md                 # Skill metadata (last sync, scope notes)
```

Small repos may omit optional pages. Always keep `quickstart.md` and `_meta.md`.

## Page rules

1. Cite real paths like `src/auth/session.ts` — no invented modules
2. Prefer short sections + links between wiki pages over one giant file
3. Use Mermaid only when it clarifies structure (keep diagrams small)
4. Write in the language of existing repo docs (default: English if unclear)
5. Mark uncertainty as `TODO(verify):` rather than guessing

## `INSTRUCTIONS.md` (user-authored)

Created once if missing. Never regenerate contents on routine init/update unless the user asks to revise the brief.

Template:

```markdown
# OpenWiki Instructions

## Scope
- Focus areas:
- Skip / deprioritize:

## Terminology
- Prefer:
- Avoid:

## Audience
- Primary: coding agents (Cursor, Claude Code, Codex)
- Secondary: human onboarding

## Update preferences
- Prefer incremental updates from git diffs
- Keep pages under ~200 lines when possible
```

## `quickstart.md` (required entry)

Must include:

1. One-paragraph project summary
2. How to build / run / test (commands from real manifests)
3. Link list to other wiki pages
4. "Start here when…" routing table (task → page)

## `_meta.md`

```markdown
# OpenWiki Meta

- generated_by: openwiki-docs skill
- last_sync: YYYY-MM-DD
- last_sync_commit: <git sha or unknown>
- mode: init | update
- pages: [list]
```

## Update targeting

When refreshing from a diff:

| Changed paths | Likely pages to refresh |
|---|---|
| `src/**`, `app/**`, `pkg/**` | architecture, source-map, workflows, api |
| CI / Dockerfile / deploy | operations |
| `*test*`, e2e, fixtures | testing |
| README / docs | quickstart, domain |
| clients / SDK / webhooks | integrations |
