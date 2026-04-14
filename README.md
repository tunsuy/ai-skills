# AI Skills

> 工作生活中提炼的 AI Skills 合集 —— 让 AI Agent 更聪明地工作。

## 简介

这个仓库收录了我在日常工作和生活中沉淀下来的 AI Skills —— 把反复遇到的场景、摸索出来的工作流，整理成可复用的 Skill，方便自己和他人直接使用。

每个 Skill 都是一套完整的指令集，包含触发条件、操作流程、陷阱规避等，可以被 AI Agent 加载并执行。

## 特性

- 🧩 **模块化设计** — 每个 Skill 独立成目录，按需加载
- 📐 **统一规范** — 遵循 SKILL.md frontmatter 元数据 + Markdown 正文的标准格式
- 🔄 **自我进化** — 内置 Agent 自我进化机制，持续沉淀新知识
- 🛠 **即插即用** — 将 Skill 目录放入项目或全局配置即可使用

## 目录结构

```
ai-skills/
├── design-md/                     # 品牌风格 UI 构建
│   ├── SKILL.md                   # 主指令文件
│   └── references/                # 参考文档
│       └── brand-catalog.md       # 品牌设计目录
├── self-evolving-skills/          # Agent 自我进化机制
│   ├── SKILL.md                   # 主指令文件
│   ├── references/                # 参考文档
│   ├── scripts/                   # 辅助脚本
│   └── templates/                 # 模板文件
├── trump-news-tracker/            # 新闻动态追踪
│   ├── SKILL.md                   # 主指令文件
│   ├── _meta.json                 # 元信息
│   └── references/                # 参考文档
│       └── sources.md             # 信息源列表
├── .gitignore
└── README.md
```

## Skills 索引

| Skill | 简介 | 版本 |
|-------|------|------|
| [design-md](design-md/) | 品牌风格 UI 构建 —— 使用 DESIGN.md 让 AI 生成匹配知名品牌设计风格的 UI（Claude、Vercel、Notion、Stripe、Apple 等） | v1.0.0 |
| [self-evolving-skills](self-evolving-skills/) | Agent 自我进化机制 —— 将成功的复杂任务沉淀为可复用的 Skill，实现持续学习和知识积累 | v1.0.0 |
| [trump-news-tracker](trump-news-tracker/) | 新闻动态追踪 —— 多源聚合、去重分类、生成中文简报 | v1.0.0 |

## 快速使用

### 1. 克隆仓库

```bash
git clone <repo-url> ai-skills
```

### 2. 在项目中引用

将需要的 Skill 目录复制到你的项目中，或配置 AI Agent 指向本仓库：

```
# 项目级别
your-project/
├── .agent/skills/
│   └── design-md/          ← 从本仓库复制
└── ...

# 用户级别
~/.agent/skills/
└── self-evolving-skills/   ← 全局可用
```

### 3. 触发 Skill

在与 AI Agent 对话时，满足 Skill 的触发条件即可自动加载：

- 说 **"构建一个像 Vercel 一样的页面"** → 触发 `design-md`
- 完成复杂任务后 Agent 自动评估 → 触发 `self-evolving-skills`
- 说 **"Trump 最新动态"** → 触发 `trump-news-tracker`

## Skill 规范

每个 Skill 遵循统一的目录结构和文件格式：

### 目录结构

| 文件/目录 | 必要性 | 说明 |
|-----------|--------|------|
| `SKILL.md` | **必须** | 主指令文件，包含 frontmatter 元数据和完整操作流程 |
| `references/` | 可选 | 参考文档、API 手册等 |
| `templates/` | 可选 | 配置模板、文件模板等 |
| `scripts/` | 可选 | 辅助脚本、自动化工具等 |
| `assets/` | 可选 | 其他资源文件 |

### SKILL.md 格式

```yaml
---
name: skill-name                    # 必须：小写、连字符、最多 64 字符
description: Brief description      # 必须：简短描述，最多 1024 字符
version: 1.0.0                      # 推荐：语义化版本
author: Author Name                 # 推荐：作者信息
metadata:
  tags: [Category, Keywords]        # 推荐：标签便于搜索
  related_skills: [other-skill]     # 可选：相关 Skill
---
```

正文推荐包含以下章节：

1. **When to Use** — 触发条件
2. **Prerequisites** — 前置条件
3. **Quick Reference** — 快速参考
4. **Procedure** — 操作流程（核心）
5. **Pitfalls** — 陷阱与规避
6. **Verification** — 验证方法

详细的 Skill 编写规范见 [self-evolving-skills](self-evolving-skills/SKILL.md)。

## 贡献指南

欢迎提交新的 Skill！请遵循以下步骤：

1. 在根目录下创建新的 Skill 目录（小写、连字符命名）
2. 编写 `SKILL.md` 文件，遵循上述格式规范
3. 按需添加 `references/`、`templates/`、`scripts/` 等支撑文件
4. 更新本 README 的 **Skills 索引** 表格
5. 提交 PR

### 质量检查清单

- [ ] `SKILL.md` 包含有效的 frontmatter（name、description）
- [ ] 有明确的触发条件（When to Use）
- [ ] 有编号的操作步骤（Procedure）
- [ ] 有陷阱与规避说明（Pitfalls）
- [ ] 有验证方法（Verification）

## License

MIT
