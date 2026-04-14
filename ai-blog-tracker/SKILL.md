---
name: ai-blog-tracker
description: "抓取 Anthropic、OpenAI、Google DeepMind、Meta AI、智谱AI、MiniMax、通义千问、DeepSeek、Mistral、xAI、月之暗面等知名 AI 公司的官方博客最新文章，生成分类聚合的中文技术简报。触发词包括 'AI博客', 'AI公司最新文章', 'AI前沿动态', 'AI blog', 'latest AI papers', '大模型最新进展' 等。"
version: 1.0.0
author: tunsuy
metadata:
  tags: [AI, Blog, Research, News, Aggregation, Technology-Tracking]
  related_skills: [trump-news-tracker]
---

# AI Blog Tracker — AI 公司官方博客追踪

**严格只抓取**全球顶尖 AI 公司**官方博客/官方新闻页面**的文章，去重分类后生成结构化中文技术简报，帮助快速掌握 AI 前沿动态。

> ⚠️ **核心原则：仅限官方来源**
> - 只抓取各公司**官方博客、官方新闻页面、官方 GitHub** 上发布的内容
> - **严禁**使用第三方媒体报道（如 TechCrunch、InfoQ、机器之心、AI 新智元、36kr 等）
> - 如果某公司近期在官方渠道无任何发布，直接标注"近期无官方发布"，**不得**用第三方报道替代
> - 搜索引擎仅用于**发现官方文章的链接**，最终内容必须来自官方域名

## When to Use

当用户需要了解以下内容时触发本 Skill：

- 各大 AI 公司最近发布了什么博客/文章
- AI 领域最新的技术进展和模型发布
- 特定 AI 公司（如 Anthropic、OpenAI 等）的最新动态
- AI 前沿研究汇总和趋势分析
- 用户说 "AI 博客"、"AI 前沿动态"、"大模型最新进展"、"AI blog tracker" 等

**触发短语示例**：
- "帮我看看各大 AI 公司最近发了什么博客"
- "Anthropic/OpenAI 最近有什么新文章"
- "AI 前沿动态汇总"
- "最近有什么大模型新进展"
- "track AI blogs"

## Prerequisites

- 需要能访问互联网的 web_search 和 web_fetch 工具
- 无需 API Key，所有信息源均为公开博客

## Quick Reference

### 覆盖的 AI 公司及博客地址

| 公司 | 博客地址 | 分类 | 更新频率 |
|------|----------|------|----------|
| Anthropic | `anthropic.com/news` / `anthropic.com/research` / `anthropic.com/engineering` | 海外头部 | 每周数篇 |
| OpenAI | `openai.com/blog` / `openai.com/research` | 海外头部 | 每周数篇 |
| Google DeepMind | `deepmind.google/blog` / `blog.google/technology/ai/` | 海外头部 | 每周数篇 |
| Meta AI | `ai.meta.com/blog/` | 海外头部 | 每周 1-3 篇 |
| Mistral AI | `mistral.ai/news` | 海外新锐 | 每月数篇 |
| xAI | `x.ai/blog` | 海外新锐 | 不定期 |
| 智谱 AI (GLM) | `z.ai/blog` / `zhipuai.cn` | 国内头部 | 每月数篇 |
| 通义千问 (Qwen) | `qwen.ai/blog` / `qwenlm.github.io` | 国内头部 | 每月数篇 |
| DeepSeek | `deepseek.com` (API/News) / `github.com/deepseek-ai` | 国内头部 | 不定期 |
| MiniMax | `minimaxi.com` / `minimax.io` | 国内新锐 | 不定期 |
| 月之暗面 (Moonshot) | `platform.moonshot.cn/blog` / `kimi.com` | 国内新锐 | 每月数篇 |

## Procedure

### Step 1: 确定追踪范围

根据用户请求确定范围：

- **全量追踪**（默认）：抓取所有已覆盖 AI 公司的最新博客
- **指定公司**：仅抓取用户指定的公司（如 "只看 Anthropic 和 OpenAI"）
- **指定主题**：侧重搜索特定主题（如 "最近的开源模型发布"）
- **时间范围**：默认最近 7 天，用户可指定（如 "最近一个月"）

### Step 2: 多源信息采集

#### 2.1 Web 搜索（限定官方域名）

> ⚠️ **搜索原则**：所有搜索查询必须使用 `site:` 操作符限定官方域名，或直接 web_fetch 官方博客页面。**禁止使用不带 site: 的通用搜索**，防止第三方媒体内容混入。

执行 3-5 组搜索查询，每组严格限定官方域名：

```
搜索组 1 — 海外头部公司（site 限定）:
  site:anthropic.com blog {current_month} {current_year}
  site:openai.com blog {current_month} {current_year}
  site:deepmind.google OR site:blog.google/technology/ai {current_month} {current_year}
  site:ai.meta.com blog {current_month} {current_year}

搜索组 2 — 海外新锐（site 限定）:
  site:mistral.ai news {current_month} {current_year}
  site:x.ai blog {current_month} {current_year}

搜索组 3 — 国内公司（site 限定）:
  site:zhipuai.cn OR site:z.ai {current_month}
  site:qwen.ai OR site:qwenlm.github.io blog {current_month}
  site:deepseek.com {current_month}
  site:minimaxi.com OR site:minimax.io {current_month}
  site:moonshot.cn OR site:kimi.com {current_month}

搜索组 4（可选）— 用户指定主题（仍需 site 限定）:
  site:{company_official_domain} {user_specified_topic} {current_date}
```

> 🚫 **禁止的搜索方式**（以下写法会混入第三方内容）:
> - ~~"Anthropic blog April 2025 latest"~~（缺少 site: 限定）
> - ~~"AI model release announcement April 2025"~~（通用聚合搜索）
> - ~~"大模型 最新发布 4月"~~（会返回媒体转载）

#### 2.2 直接抓取官方博客页面（精准采集，推荐方式）

> ✅ **首选方式**：直接 web_fetch 各公司官方博客列表页面，这是最可靠的方式，能确保 100% 为官方内容。

**必须抓取的官方页面**（全量追踪时逐一访问）：

| 公司 | 必抓页面 |
|------|----------|
| Anthropic | `https://www.anthropic.com/news` |
| OpenAI | `https://openai.com/blog` |
| Google DeepMind | `https://deepmind.google/blog/` |
| Meta AI | `https://ai.meta.com/blog/` |
| Mistral AI | `https://mistral.ai/news` |
| xAI | `https://x.ai/blog` |
| 智谱 AI | `https://www.zhipuai.cn` / `https://z.ai/blog` |
| 通义千问 | `https://qwen.ai/blog` |
| DeepSeek | `https://www.deepseek.com` |
| MiniMax | `https://www.minimaxi.com` |
| 月之暗面 | `https://platform.moonshot.cn/blog` |

**优先抓取规则**：
1. 先直接 web_fetch 上述官方博客列表页，获取最近文章标题和链接
2. 对发布时间在追踪范围内的文章，再 web_fetch 文章详情页获取详细内容
3. 如官方页面返回不完整，尝试备用 URL（参考 sources.md）

**抓取时注意**：
- 提取文章标题、发布日期、作者、核心内容
- 如果页面返回不完整内容，尝试备用 URL
- **只处理域名属于该公司官方的链接**，忽略任何第三方域名的内容

#### 2.3 来源多样性保障

- 至少覆盖 5 家不同 AI 公司的官方页面
- 海外与国内公司均有涉及
- **如果某公司近期官方渠道无新文章，在报告中明确注明"近期无官方发布"，不得引用第三方媒体替代**
- **URL 域名校验**：报告中收录的每篇文章 URL 都必须属于该公司的官方域名（参考 Quick Reference 中的域名列表）

### Step 3: 内容分析与去重

#### 3.1 去重与来源过滤

- 识别同一事件被多个来源报道的情况，**仅保留官方来源**
- **严格过滤非官方来源**：丢弃所有来自第三方媒体的搜索结果（如 TechCrunch、The Verge、InfoQ、机器之心、36kr、新智元等）
- 以官方博客原文 URL 为唯一标识
- 同一公司关于同一主题的多篇官方文章（如博客+论文+GitHub），合并为一个条目但保留所有官方链接

#### 3.2 分类

将每篇文章/主题归入以下类别：

| 类别 | Emoji | 说明 |
|------|-------|------|
| 模型发布 | 🚀 | 新模型发布、版本更新、性能提升 |
| 研究论文 | 📄 | 学术研究、技术报告、白皮书 |
| 工程实践 | 🛠️ | 工程博客、最佳实践、架构分享 |
| 产品更新 | 📦 | 产品功能更新、API 变更、平台升级 |
| 安全与对齐 | 🛡️ | AI 安全、对齐研究、负责任 AI |
| 开源项目 | 🌐 | 开源模型、工具、框架发布 |
| 行业洞察 | 💡 | 行业分析、趋势展望、战略动态 |

#### 3.3 重要性评级

为每篇文章/主题标注重要性：

- ⭐⭐⭐ **重磅**：新一代旗舰模型发布、重大技术突破、行业格局变化
- ⭐⭐ **重要**：显著性能提升、重要功能更新、高影响力研究
- ⭐ **关注**：常规更新、增量改进、技术细节分享

### Step 4: 生成中文技术简报

按照以下模板输出报告：

```markdown
# 🤖 AI 前沿博客追踪简报

> 📅 报告日期：{date}
> 🕐 追踪时段：{start_date} — {end_date}
> 🔄 覆盖来源：{number} 家 AI 公司，{total_articles} 篇文章
> 📊 数据来源：**仅限官方博客/官方页面直接抓取**

---

## 📌 本期要点

1. ⭐⭐⭐ **{headline_1}** — {一句话概述}
2. ⭐⭐⭐ **{headline_2}** — {一句话概述}
3. ⭐⭐ **{headline_3}** — {一句话概述}
（最多 5 条要点，按重要性排序）

---

## 📋 详细报道

### {category_emoji} {category_name}

#### {importance_stars} {article_title}

> 🏢 {company_name} | 📅 {publish_date} | 🔗 [{official_blog_name}]({official_url})

{3-5 句话的详细摘要，包含：}
- 发布了什么（核心内容）
- 关键技术亮点 / 性能指标
- 对行业或开发者的影响

**关键数据**：{如有量化指标，列出}

---
（按类别组织，每个类别内按重要性排序）

## 📊 趋势分析

### 本期观察

{2-3 段分析，涵盖：}
- 各家 AI 公司的发力方向
- 技术趋势和竞争格局变化
- 对开发者和行业的潜在影响

### 公司动态矩阵

| 公司 | 近期焦点 | 活跃度 | 值得关注的方向 |
|------|----------|--------|---------------|
| Anthropic | {focus} | {activity} | {direction} |
| OpenAI | {focus} | {activity} | {direction} |
| ... | ... | ... | ... |

---

## 📚 完整文章索引

| # | 公司 | 标题 | 类别 | 日期 | 链接 |
|---|------|------|------|------|------|
| 1 | {company} | {title} | {category} | {date} | [官方原文]({official_url}) |
| ... | ... | ... | ... | ... | ... |

---

*报告生成时间：{datetime}*
*覆盖公司：{company_list}*
*免责声明：本报告仅聚合各公司官方博客/新闻页面内容，不含任何第三方媒体报道*
```

### Step 5: 补充互动

报告生成后，主动提供以下选项：

1. **深入某篇文章**："需要我详细解读某篇文章的技术细节吗？"
2. **扩展某家公司**："需要我深入追踪某家公司的更多历史文章吗？"
3. **主题深入**："需要我就某个技术方向做更深入的调研吗？"
4. **设置定期追踪**："需要设置定期自动追踪吗？（可配合 automation 实现）"

## Pitfalls

| 陷阱 | 症状 | 解决方案 |
|------|------|----------|
| 第三方内容混入 | 搜索结果中包含 TechCrunch/InfoQ/机器之心等第三方报道 | **严格校验域名**，只保留官方域名下的链接，丢弃所有非官方内容 |
| 博客 URL 变更 | web_fetch 返回 404 或空内容 | 使用 web_search + `site:` 搜索该公司最新官方博客地址，参考 sources.md 中的备用 URL |
| 内容被墙/需登录 | 页面返回不完整内容或登录提示 | 标注"官方页面需登录，内容不完整"，**不得用第三方转载替代** |
| 国内公司博客访问慢 | 超时或加载失败 | 尝试备用官方 URL（如 GitHub 发布页），仍不可达则标注"官方页面暂不可达" |
| 重复内容泛滥 | 同一新闻被大量自媒体转载 | 严格只抓取官方博客原文，以 URL 域名为准过滤 |
| 搜索结果过时 | 返回数月前的旧文章 | 搜索查询必须包含明确的时间限定词 |
| 中英文信息不一致 | 同一发布在中英文博客描述不同 | 以官方英文版为准，中文版作为补充（两者都是官方） |
| 某公司近期无更新 | 搜索不到任何近期官方文章 | 在报告中明确注明"近期无官方发布"，**绝不强行用第三方内容补充** |

## Verification

报告生成后，按以下检查清单验证质量：

- [ ] 至少覆盖 5 家 AI 公司的官方页面
- [ ] **所有文章链接均指向官方域名（非第三方媒体）**
- [ ] **无任何来自 TechCrunch、InfoQ、机器之心、36kr 等第三方媒体的内容**
- [ ] 每篇文章都有明确的官方来源链接
- [ ] 日期信息准确，未混入超出追踪范围的旧文
- [ ] 分类标签正确，未出现明显归类错误
- [ ] 摘要忠实原文，未添加主观臆断
- [ ] 中文表述流畅，专业术语准确
- [ ] 趋势分析有理有据，不空洞（仅基于官方发布内容分析）
- [ ] 完整索引表中所有链接可点击跳转至官方页面
- [ ] 无官方发布的公司已标注"近期无官方发布"

## Resources

### references/sources.md

详细的信息源列表，包含每家 AI 公司的博客 URL、RSS 地址、GitHub 发布页、备用抓取路径，以及推荐的搜索查询模板。当官方博客 URL 变更或访问异常时，参考此文件获取备用方案。
