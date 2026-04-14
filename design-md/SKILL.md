---
name: design-md
description: 构建品牌风格 UI/网页（Claude、Vercel、Notion、Stripe、Apple、Tesla 等知名品牌）。当用户说"XX风格的网页"、"像XX一样的页面"、"仿XX设计"、"构建一个看起来像XX的页面"时触发此 Skill。
version: 1.0.0
---

# DESIGN.md - AI 可读的设计系统文档

本 Skill 帮助你使用 **DESIGN.md** 文件让 AI 编码代理生成匹配知名品牌设计风格的 UI。

## 核心概念

**DESIGN.md** 是由 Google Stitch 推出的一种纯文本设计系统文档格式：

```
┌─────────────────────────────────────────────────────────────────┐
│                    AI 辅助开发的两个关键文件                      │
├─────────────────────────────────────────────────────────────────┤
│  AGENTS.md                    │  DESIGN.md                      │
│  ────────────────────────     │  ────────────────────────       │
│  告诉编码代理如何构建项目       │  告诉设计代理项目应该长什么样     │
│  • 项目结构                    │  • 视觉主题与氛围                │
│  • 技术栈                      │  • 色彩板与角色                  │
│  • 编码规范                    │  • 排版规则                      │
│  • 工具配置                    │  • 组件样式                      │
└─────────────────────────────────────────────────────────────────┘
```

## When to Use

触发条件 — 在以下情况下使用本 Skill：

- 用户要求 "构建一个看起来像 [品牌名] 的页面"
- 用户要求 "使用 [品牌名] 的设计风格"
- 用户要求 "应用 DESIGN.md"
- 需要快速复刻知名品牌的 UI 风格
- 需要为项目建立一致的设计系统
- 想要让 AI 生成像素级完美的品牌匹配 UI

## Prerequisites

- 网络访问（用于获取 DESIGN.md 文件）
- 前端项目（React、Vue、HTML 等）

## Quick Reference

| 操作 | 方法 |
|------|------|
| 获取设计文件 | 从 awesome-design-md 仓库复制 |
| 应用设计 | 将 DESIGN.md 放到项目根目录 |
| 生成 UI | 告诉 AI "按照 DESIGN.md 构建页面" |

### 热门品牌设计文件

| 类别 | 品牌 | 文件路径 |
|------|------|---------|
| AI 平台 | Claude | `designs/claude/DESIGN.md` |
| AI 平台 | OpenAI (x.ai) | `designs/xai/DESIGN.md` |
| 开发工具 | Cursor | `designs/cursor/DESIGN.md` |
| 开发工具 | Vercel | `designs/vercel/DESIGN.md` |
| SaaS | Notion | `designs/notion/DESIGN.md` |
| SaaS | Linear | `designs/linear/DESIGN.md` |
| 设计工具 | Figma | `designs/figma/DESIGN.md` |
| 金融科技 | Stripe | `designs/stripe/DESIGN.md` |
| 科技巨头 | Apple | `designs/apple/DESIGN.md` |
| 汽车 | Tesla | `designs/tesla/DESIGN.md` |

## Procedure

### Step 1: 选择目标设计风格

确定要复刻的品牌设计风格。可以从以下分类中选择：

**AI & LLM 平台**
- Claude, Cohere, OpenAI (x.ai), Ollama, Replicate

**开发者工具 & IDE**
- Cursor, Expo, Raycast, Vercel, Warp

**后端、数据库 & DevOps**
- MongoDB, PostHog, Supabase, Sentry

**生产力 & SaaS**
- Notion, Linear, Zapier, Intercom

**设计 & 创意工具**
- Figma, Framer, Webflow, Miro

**金融科技 & 加密货币**
- Stripe, Coinbase, Binance, Wise

**电商 & 零售**
- Airbnb, Nike, Shopify

**媒体 & 消费科技**
- Apple, IBM, NVIDIA, Spotify, Tesla

**汽车**
- BMW, Ferrari, Tesla, Bugatti

### Step 2: 获取 DESIGN.md 文件

**推荐方式：使用 npx 命令（最新）**

```bash
# 在项目根目录运行，自动下载并创建 DESIGN.md 文件
npx getdesign@latest add {brand}
```

例如获取 Claude 的设计文件：

```bash
npx getdesign@latest add claude
```

例如获取 Vercel 的设计文件：

```bash
npx getdesign@latest add vercel
```

**备选方式：从 GitHub 仓库获取**

```bash
# 克隆仓库
git clone https://github.com/VoltAgent/awesome-design-md.git

# 注意：部分设计文件已迁移到 getdesign.md 网站，优先使用 npx 命令
```

**在线预览**

可以在 https://getdesign.md/{brand}/design-md 预览设计规范（支持亮色/暗色模式）

### Step 3: 将 DESIGN.md 放入项目

将下载的 `DESIGN.md` 文件放到项目根目录：

```
my-project/
├── DESIGN.md          ← 设计系统文件
├── AGENTS.md          ← 项目构建指南（可选）
├── src/
├── package.json
└── ...
```

### Step 4: 让 AI 生成 UI

现在你可以这样指示 AI：

```
"按照 DESIGN.md 中的设计规范，构建一个登录页面"
```

```
"使用 DESIGN.md 的风格，创建一个定价表格组件"
```

```
"参考 DESIGN.md，设计一个响应式导航栏"
```

AI 编码代理会读取 DESIGN.md 文件，理解设计规范，然后生成匹配的 UI 代码。

## DESIGN.md 文件结构

每个 DESIGN.md 文件包含以下 9 个标准化部分：

### 1. Visual Theme & Atmosphere（视觉主题与氛围）
定义整体视觉风格、情感基调、设计理念。

### 2. Color Palette & Roles（色彩板与角色）
```markdown
## Color Palette

| Role | Light Mode | Dark Mode |
|------|-----------|-----------|
| Primary | #000000 | #FFFFFF |
| Background | #FAFAFA | #0A0A0A |
| Accent | #0070F3 | #0070F3 |
```

### 3. Typography Rules（排版规则）
字体系列、大小层级、行高、字重规则。

### 4. Component Stylings（组件样式）
按钮、卡片、输入框等核心组件的样式定义。

### 5. Layout Principles（布局原则）
间距系统、网格、容器宽度等布局规范。

### 6. Depth & Elevation（深度与层级）
阴影、z-index 层级、视觉深度处理。

### 7. Do's and Don'ts（注意事项）
设计时应该做和不应该做的事项。

### 8. Responsive Behavior（响应式行为）
不同屏幕尺寸下的适配规则。

### 9. Agent Prompt Guide（代理提示指南）
给 AI 代理的特殊提示和注意事项。

## 自定义 DESIGN.md

如果要创建自己的 DESIGN.md，遵循以下模板：

```markdown
# Design System: [项目名称]

## Visual Theme & Atmosphere
[描述整体视觉风格]

## Color Palette & Roles

| Role | Value | Usage |
|------|-------|-------|
| Primary | #XXXXXX | 主要操作、链接 |
| Secondary | #XXXXXX | 次要元素 |
| Background | #XXXXXX | 页面背景 |
| Surface | #XXXXXX | 卡片、面板 |
| Text Primary | #XXXXXX | 主要文本 |
| Text Secondary | #XXXXXX | 次要文本 |
| Border | #XXXXXX | 边框、分割线 |
| Success | #XXXXXX | 成功状态 |
| Warning | #XXXXXX | 警告状态 |
| Error | #XXXXXX | 错误状态 |

## Typography Rules

| Element | Font | Size | Weight | Line Height |
|---------|------|------|--------|-------------|
| H1 | Inter | 48px | 700 | 1.2 |
| H2 | Inter | 36px | 600 | 1.25 |
| H3 | Inter | 24px | 600 | 1.3 |
| Body | Inter | 16px | 400 | 1.5 |
| Small | Inter | 14px | 400 | 1.5 |

## Component Stylings

### Buttons
- Border radius: 8px
- Padding: 12px 24px
- Primary: bg-primary, text-white
- Secondary: bg-transparent, border, text-primary

### Cards
- Border radius: 12px
- Shadow: 0 4px 6px rgba(0,0,0,0.1)
- Padding: 24px

### Inputs
- Border radius: 8px
- Border: 1px solid border-color
- Padding: 12px 16px
- Focus: ring-2 ring-primary

## Layout Principles

- Container max-width: 1200px
- Spacing scale: 4, 8, 12, 16, 24, 32, 48, 64, 96
- Grid: 12 columns, 24px gap

## Depth & Elevation

| Level | Shadow |
|-------|--------|
| 0 | none |
| 1 | 0 1px 3px rgba(0,0,0,0.1) |
| 2 | 0 4px 6px rgba(0,0,0,0.1) |
| 3 | 0 10px 15px rgba(0,0,0,0.1) |

## Do's and Don'ts

✅ Do:
- 保持一致的间距
- 使用设计系统中的颜色
- 遵循排版层级

❌ Don't:
- 使用系统外的颜色
- 混合不同的圆角值
- 忽略响应式设计

## Responsive Behavior

| Breakpoint | Width | Adjustments |
|------------|-------|-------------|
| Mobile | < 640px | 单列布局，减小字体 |
| Tablet | 640-1024px | 双列布局 |
| Desktop | > 1024px | 完整布局 |

## Agent Prompt Guide

构建 UI 时请注意：
- 优先使用 Tailwind CSS
- 所有交互元素需要 hover 状态
- 确保深色模式兼容
```

## Pitfalls

| 陷阱 | 症状 | 解决方案 |
|------|------|----------|
| 文件路径错误 | AI 找不到 DESIGN.md | 确保文件在项目根目录 |
| 设计规范过于简略 | 生成的 UI 不一致 | 补充详细的组件样式定义 |
| 颜色值不准确 | 视觉效果与目标品牌不符 | 使用颜色提取工具验证 |
| 缺少响应式规则 | 移动端显示异常 | 添加 Responsive Behavior 部分 |
| 字体未安装 | 排版效果不对 | 确保引入了正确的 Web 字体 |

## Verification

确认成功的标志：

1. ✅ DESIGN.md 文件存在于项目根目录
2. ✅ AI 能够读取并引用 DESIGN.md 中的规范
3. ✅ 生成的 UI 代码使用了 DESIGN.md 中定义的颜色、字体、间距
4. ✅ 组件样式与目标品牌视觉一致
5. ✅ 响应式行为符合设计规范

## 资源链接

- **getdesign.md 官网**: https://getdesign.md （推荐，最新设计文件）
- **awesome-design-md 仓库**: https://github.com/VoltAgent/awesome-design-md
- **Google Stitch**: DESIGN.md 概念的来源
- **在线预览**: https://getdesign.md/{brand}/design-md （支持亮色/暗色模式预览）

## 与其他 Skill 配合

| Skill | 配合方式 |
|-------|---------|
| frontend-development | 使用 DESIGN.md 规范生成组件代码 |
| test-driven-development | 为生成的 UI 编写视觉回归测试 |
| plan | 在项目规划阶段选择设计风格 |
