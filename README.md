# AI Skills

> 工作生活中提炼的 AI Skills 合集。

## 简介

这个仓库收录了我在日常工作和生活中沉淀下来的 AI Skills —— 把反复遇到的场景、摸索出来的工作流，整理成可复用的 Skill，方便自己和他人直接使用。

每个 Skill 都是一套完整的指令集，包含触发条件、操作流程、陷阱规避等，可以被 AI Agent 加载并执行。

## 目录结构

```
ai-skills/
├── self-evolving-skills/      # Agent 自我进化机制
│   ├── SKILL.md               # 主指令文件
│   ├── references/            # 参考文档
│   ├── scripts/               # 辅助脚本
│   └── templates/             # 模板文件
├── trump-news-tracker/        # 新闻动态追踪
│   ├── SKILL.md               # 主指令文件
│   └── references/            # 参考文档
└── README.md
```

## Skills 索引

| Skill | 简介 |
|-------|------|
| [self-evolving-skills](self-evolving-skills/) | Agent 自我进化机制 —— 将成功的复杂任务沉淀为可复用的 Skill，实现持续学习和知识积累 |
| [trump-news-tracker](trump-news-tracker/) | 新闻动态追踪 —— 多源聚合、去重分类、生成中文简报 |

## Skill 规范

每个 Skill 遵循统一的目录结构：

- `SKILL.md` — **必须**，主指令文件，包含 frontmatter 元数据和完整操作流程
- `references/` — 可选，参考文档、API 手册等
- `templates/` — 可选，配置模板、文件模板等
- `scripts/` — 可选，辅助脚本、自动化工具等

详细的 Skill 编写规范见 [self-evolving-skills](self-evolving-skills/SKILL.md)。

## License

MIT
