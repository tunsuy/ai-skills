---
name: github-trending
description: |
  统计 GitHub 上增长最快的开源项目，抓取 Trending 页面并结合 GitHub API 补充详细数据，
  生成带趋势分析的中文报告。支持按时间范围（daily/weekly/monthly）和编程语言筛选，
  自定义展示数量。

  触发场景：
  - 用户想了解 GitHub 最近热门/趋势项目："GitHub trending"、"GitHub 热门项目"、"最近什么开源项目火了"
  - 用户想按语言查看热门项目："Python 最近有什么热门项目"、"Rust trending"
  - 用户想了解开源社区动态："开源社区最近在关注什么"、"最近 star 增长最快的项目"
  - 用户直接说 "github-trending"、"gh trending"、"GitHub 趋势"
version: 1.0.0
author: tunsuy
metadata:
  tags: [GitHub, Trending, Open-Source, Analytics, Star-Growth]
  related_skills: [ai-blog-tracker]
---

# GitHub Trending — 开源项目趋势追踪

**追踪 GitHub 上增长最快的开源项目**，结合 Trending 页面数据与 GitHub API 详情，生成结构化的中文趋势分析报告。

> 核心指标：**Star 增长数**
> 数据来源：GitHub Trending 页面 + GitHub API（gh CLI）

## When to Use

当用户需要了解以下内容时触发本 Skill：

- GitHub 上最近最火/增长最快的开源项目
- 特定编程语言的热门项目趋势
- 开源社区的技术热点和方向
- 某个时间段内的项目排行

**触发短语示例**：
- "GitHub 最近有什么热门项目"
- "看看这周 trending 的项目"
- "Python 最近有什么火的开源项目"
- "最近 star 增长最快的是什么"
- "github trending monthly"
- "开源社区最近在关注什么"

## Prerequisites

- 需要能访问互联网的 `web_search` 和 `web_fetch` 工具（用于抓取 GitHub Trending 页面）
- **推荐**：已安装并登录 `gh` CLI（用于通过 GitHub API 获取项目详情）
  - 如未安装 gh CLI，将仅使用 Trending 页面数据，报告详细度会降低
  - 安装方式：`brew install gh && gh auth login`

## Procedure

### Step 1: 解析用户参数

从用户的输入中解析以下参数，未指定的使用默认值：

| 参数 | 说明 | 可选值 | 默认值 |
|------|------|--------|--------|
| `period` | 统计时间范围 | `daily` / `weekly` / `monthly` | `weekly` |
| `count` | 展示项目数量 | 任意正整数 | `5` |
| `language` | 编程语言筛选 | 参考 `references/sources.md` 中的语言对照表 | 不限（全部语言） |

**参数识别规则**：
- 时间范围："今天/今日/daily" → daily；"这周/本周/weekly" → weekly；"这个月/本月/monthly" → monthly
- 数量："top 10"、"前 10"、"10 个" → count=10
- 语言："Python 热门"、"Rust trending" → language=python / language=rust

### Step 2: 抓取 GitHub Trending 页面

#### 2.1 构造 Trending URL

根据解析的参数构造 URL：

```
基础 URL：https://github.com/trending
带语言：  https://github.com/trending/{language}?since={period}
不带语言：https://github.com/trending?since={period}

示例：
- 本周全部语言：https://github.com/trending?since=weekly
- 本月 Python：  https://github.com/trending/python?since=monthly
- 今日 Rust：    https://github.com/trending/rust?since=daily
```

#### 2.2 抓取并解析页面

使用 `web_fetch` 抓取上述 URL，提取以下信息：

| 字段 | 说明 |
|------|------|
| `repo_full_name` | 仓库全名（owner/repo） |
| `description` | 项目描述 |
| `language` | 编程语言 |
| `stars_gained` | 统计周期内新增 Star 数 |
| `total_stars` | 总 Star 数（如页面提供） |
| `forks` | Fork 数（如页面提供） |
| `contributors` | 贡献者头像列表（如页面提供） |

**提取提示**：页面中每个项目通常包含在 `article.Box-row` 元素中，Star 增长数在页面上显示为 "{N} stars today/this week/this month"。

#### 2.3 数据校验

- 确认抓取到的项目数量 >= 用户请求的 `count`
- 如果 Trending 页面返回不完整或为空：
  1. 尝试重新抓取一次
  2. 如仍失败，使用 `web_search` 搜索 `"github trending {period} {language} {current_date}"` 作为备用
  3. 在报告中注明数据来源异常

### Step 3: 通过 gh CLI / GitHub API 补充详细数据

> 此步骤依赖 gh CLI。如果 gh 不可用，跳过此步骤，直接使用 Step 2 的数据。

对 Step 2 中排名前 `{count}` 的项目，逐个调用 GitHub API 获取详细信息：

#### 3.1 获取仓库详情

```bash
gh api repos/{owner}/{repo} --jq '{
  full_name: .full_name,
  description: .description,
  stargazers_count: .stargazers_count,
  forks_count: .forks_count,
  language: .language,
  topics: .topics,
  license: .license.spdx_id,
  created_at: .created_at,
  updated_at: .updated_at,
  pushed_at: .pushed_at,
  open_issues_count: .open_issues_count,
  homepage: .homepage
}'
```

#### 3.2 获取贡献者数量（可选）

```bash
gh api repos/{owner}/{repo}/contributors --jq 'length'
```

> 注意：此接口对大型项目可能较慢，如果 contributor 数 > 500 可以跳过精确统计。

#### 3.3 获取最近提交活跃度（可选）

```bash
gh api repos/{owner}/{repo}/commits --jq '.[0].commit.committer.date'
```

#### 3.4 API 限流处理

- GitHub API 对已认证用户限制 5000 次/小时
- 每个项目约需 1-3 次 API 调用，5 个项目约 5-15 次，远低于限制
- 如遇到 403 限流响应，在报告中注明并使用 Trending 页面原始数据

### Step 4: 数据分析与分类

#### 4.1 项目分类

根据项目的 `topics`、`description`、`language` 等信息，将每个项目归入以下类别：

| 类别 | Emoji | 典型特征 |
|------|-------|---------|
| AI / 机器学习 | 🤖 | LLM、diffusion、transformer、machine-learning、ai、deep-learning |
| Web 开发 | 🌐 | framework、frontend、backend、react、vue、nextjs、api |
| 开发工具 | 🛠️ | cli、editor、devtools、developer-tools、productivity |
| 基础设施 | 🏗️ | database、cloud、kubernetes、docker、infrastructure |
| 安全 | 🔒 | security、vulnerability、encryption、privacy |
| 移动开发 | 📱 | android、ios、mobile、flutter、react-native |
| 数据/可视化 | 📊 | data、analytics、visualization、dashboard |
| 其他 | 📦 | 不属于以上任何类别 |

#### 4.2 重要性评级

基于以下维度为每个项目标注等级：

- ⭐⭐⭐ **爆火**：Star 增长数远超平均值（>2x）、或来自知名组织、或具有突破性意义
- ⭐⭐ **热门**：Star 增长数高于平均、或具有独特价值
- ⭐ **关注**：进入 Trending 榜单，值得了解

#### 4.3 火爆原因分析

对每个项目简要分析其增长原因，可能的因素包括：
- 解决了某个痛点问题
- 被知名人物/组织推荐
- 与当前技术热点契合（如 AI、Rust 等）
- 竞品的替代方案
- 开源化/发布新版本
- 媒体/社交网络传播

### Step 5: 生成中文趋势报告

按照以下模板生成结构化报告：

```markdown
# 🔥 GitHub Trending 趋势报告

> 📅 报告日期：{date}
> ⏱ 统计周期：{period_display}（daily=今日 / weekly=本周 / monthly=本月）
> 🔤 语言筛选：{language | "全部语言"}
> 📊 展示数量：Top {count}

---

## 📌 本期亮点

1. ⭐⭐⭐ **{repo_name}** — {一句话概述}（📈 +{stars_gained} stars）
2. ⭐⭐ **{repo_name}** — {一句话概述}（📈 +{stars_gained} stars）
...
（按 Star 增长数排序，最多 5 条亮点）

---

## 📋 项目详情

### #{rank} {repo_full_name} {importance_stars}

> ⭐ {total_stars} (+{stars_gained}) | 🍴 {forks} | 📝 {language} | 📄 {license}
> 🔗 https://github.com/{repo_full_name}

**项目简介**：{description_cn}

**关键特点**：
- {feature_1}
- {feature_2}
- {feature_3}

**技术标签**：{topics 以逗号分隔}

**活跃度**：最后提交 {pushed_at}，{contributors_count} 位贡献者，{open_issues} 个 Open Issue

**火爆原因**：{analysis}

---
（重复每个项目，共 {count} 个）

## 📊 趋势分析

### 领域分布

| 领域 | Emoji | 项目数 | 代表项目 |
|------|-------|--------|---------|
| {category_name} | {emoji} | {count} | {repo_names} |
...

### 本期观察

{2-3 段深度分析，涵盖：}
- 本期 Trending 的整体特点和主题
- 与上期相比有哪些变化趋势
- 对开发者社区的启示和值得关注的方向
- 哪些技术栈/领域持续升温或降温

---

## 📈 完整排行

| # | 项目 | 语言 | ⭐ 总数 | 📈 新增 | 🍴 Fork | 分类 |
|---|------|------|--------|---------|---------|------|
| 1 | [{repo}](https://github.com/{repo}) | {lang} | {stars} | +{gained} | {forks} | {category} |
...

---
*报告生成时间：{datetime}*
*数据来源：GitHub Trending + GitHub API*
*统计口径：{period} Star 增长数排名*
```

### Output Guidelines

- **语言**：所有输出使用中文，项目名和技术术语保留英文原文
- **风格**：客观分析为主，兼顾可读性和趣味性
- **精度**：数据尽量精确，如有不确定标注数据来源
- **长度**：亮点 + 详情 + 分析，5 个项目控制在 1500-2500 字

## Handling Edge Cases

| 场景 | 处理方式 |
|------|----------|
| Trending 页面无法访问 | 使用 `web_search` 搜索近期 trending 信息，注明数据来源 |
| gh CLI 未安装/未认证 | 跳过 API 补充步骤，仅使用 Trending 页面数据，报告中注明 |
| 指定语言无结果 | 提示用户该语言近期无 Trending 项目，建议查看全部语言或换一个时间范围 |
| 用户指定数量 > 25 | Trending 页面最多约 25 个项目，告知用户上限并展示可用最大数量 |
| 项目描述为空 | 使用 README 首行或 GitHub API 返回的 description |
| API 限流 | 使用 Trending 页面数据兜底，在报告中注明 |
| 同一项目多次出现 | 去重，保留排名最高的一条 |

## Pitfalls

| 陷阱 | 症状 | 解决方案 |
|------|------|----------|
| Trending 页面 HTML 结构变化 | 解析不到项目或字段缺失 | web_fetch 获取原始内容后灵活解析，不硬编码选择器；失败时用 web_search 兜底 |
| Star 数据统计口径不一致 | Trending 显示"+1,234 stars this week" 但 API 无此字段 | 以 Trending 页面的增长数据为准，API 仅补充总量和详情 |
| 新项目 vs 成熟项目 | 新项目短期爆发但可能昙花一现 | 在分析中注明项目创建时间，区分"新星崛起"和"持续热门" |
| 语言名称不匹配 | 用户输入 "JS" 但 URL 参数需要 "javascript" | 参考 `references/sources.md` 中的语言对照表做映射 |
| 国内网络访问 GitHub 慢 | 页面加载超时 | 适当增加超时时间，必要时分多次抓取 |
| Fork/Star 刷量项目 | 短期异常增长但非真实热度 | 结合项目活跃度（Commit 频率、Issue 讨论）综合判断 |

## Verification

报告生成后，按以下检查清单验证质量：

- [ ] 展示的项目数量符合用户请求（默认 5 个）
- [ ] 时间范围和语言筛选正确应用
- [ ] 每个项目都有 Star 增长数据
- [ ] 项目链接可点击且指向正确的 GitHub 仓库
- [ ] 分类标签合理，未出现明显归类错误
- [ ] 趋势分析有理有据，基于实际数据
- [ ] 中文表述流畅，技术术语准确
- [ ] 排行表数据与详情一致
- [ ] 无重复项目
- [ ] 数据来源已注明

## Resources

### references/sources.md

详细的数据源参考文件，包含 GitHub Trending URL 构造规则、gh CLI API 端点参考、编程语言名称对照表（用户常见叫法 → URL 参数）、API 限流处理策略，以及当 Trending 页面不可用时的备用数据获取方式。
