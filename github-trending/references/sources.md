# GitHub Trending 数据源参考

## 1. GitHub Trending 页面

### URL 格式

```
基础格式：https://github.com/trending[/{language}][?since={period}]

参数说明：
- language（路径参数）：编程语言，小写，空格用连字符替换
- since（查询参数）：时间范围，可选值 daily / weekly / monthly
```

### URL 示例

| 场景 | URL |
|------|-----|
| 本周全部语言 | `https://github.com/trending?since=weekly` |
| 今日 Python | `https://github.com/trending/python?since=daily` |
| 本月 TypeScript | `https://github.com/trending/typescript?since=monthly` |
| 本周 Rust | `https://github.com/trending/rust?since=weekly` |
| 本周 C++ | `https://github.com/trending/c++?since=weekly` |
| 本周 C# | `https://github.com/trending/c%23?since=weekly` |
| 本月 Jupyter Notebook | `https://github.com/trending/jupyter-notebook?since=monthly` |

### 页面数据字段

Trending 页面每个项目条目通常包含以下信息：

| 字段 | 位置/格式 | 示例 |
|------|----------|------|
| 仓库全名 | `h2 > a` 的 href | `/owner/repo` |
| 项目描述 | `p.col-9` 文本 | "A fast, lightweight..." |
| 编程语言 | 带语言色块的 span | "Python" |
| 总 Star 数 | SVG star 图标旁的链接 | "12,345" |
| 总 Fork 数 | SVG fork 图标旁的链接 | "1,234" |
| 周期 Star 增长 | 最后一个 span | "1,234 stars this week" |
| 贡献者头像 | 头像链接列表 | 最多 5 个头像 |

## 2. GitHub API (gh CLI) 端点参考

### 仓库详情

```bash
# 获取仓库基本信息
gh api repos/{owner}/{repo}

# 常用字段（使用 --jq 筛选）
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
  homepage: .homepage,
  archived: .archived,
  default_branch: .default_branch
}'
```

### 贡献者信息

```bash
# 获取贡献者列表（默认前 30 个）
gh api repos/{owner}/{repo}/contributors --jq 'length'

# 获取前 5 个贡献者
gh api repos/{owner}/{repo}/contributors --jq '.[0:5] | .[] | {login, contributions}'
```

### 最近提交

```bash
# 获取最近一次提交时间
gh api repos/{owner}/{repo}/commits --jq '.[0].commit.committer.date'

# 获取最近 5 次提交摘要
gh api repos/{owner}/{repo}/commits --jq '.[0:5] | .[] | {date: .commit.committer.date, message: .commit.message[0:80]}'
```

### README 内容（当描述为空时备用）

```bash
# 获取 README 内容（Base64 编码）
gh api repos/{owner}/{repo}/readme --jq '.content' | base64 -d | head -5
```

## 3. 编程语言名称对照表

用户可能使用的名称（左）→ GitHub Trending URL 参数（右）：

| 用户输入 | URL 参数 | 备注 |
|---------|---------|------|
| Python / python / py | `python` | |
| JavaScript / JS / js | `javascript` | |
| TypeScript / TS / ts | `typescript` | |
| Rust / rust | `rust` | |
| Go / go / golang | `go` | |
| Java / java | `java` | |
| C++ / cpp / c++ | `c++` | |
| C / c | `c` | |
| C# / csharp / c# | `c%23` | 需要 URL 编码 |
| Swift / swift | `swift` | |
| Kotlin / kotlin | `kotlin` | |
| Ruby / ruby | `ruby` | |
| PHP / php | `php` | |
| Dart / dart | `dart` | |
| Scala / scala | `scala` | |
| Shell / shell / bash | `shell` | |
| Lua / lua | `lua` | |
| R / r | `r` | |
| Julia / julia | `julia` | |
| Elixir / elixir | `elixir` | |
| Haskell / haskell | `haskell` | |
| Zig / zig | `zig` | |
| Vue / vue | `vue` | |
| Jupyter Notebook / jupyter | `jupyter-notebook` | 含空格需连字符 |
| HTML / html | `html` | |
| CSS / css | `css` | |
| Objective-C / objc / oc | `objective-c` | |
| Perl / perl | `perl` | |
| CUDA / cuda | `cuda` | |

## 4. API 限流处理策略

### GitHub API 限制

| 认证状态 | 限制 | 检查方式 |
|---------|------|---------|
| 已认证（gh auth） | 5,000 次/小时 | `gh api rate_limit --jq '.rate'` |
| 未认证 | 60 次/小时 | 不适用（gh CLI 需认证） |

### 限流应对

1. **正常情况**：每次报告约需 5-15 次 API 调用（5 个项目 × 1-3 次/项目），远低于限制
2. **遇到 403 响应**：
   - 先检查剩余配额：`gh api rate_limit --jq '.rate.remaining'`
   - 如果配额不足，跳过 API 补充步骤，使用 Trending 页面数据
   - 在报告中注明："部分详细数据因 API 配额限制暂不可用"
3. **降级策略**：Trending 页面数据 → 仅展示基础信息（项目名、描述、Star 增长数、语言）

## 5. 备用数据获取方式

当 GitHub Trending 页面无法正常访问时，按以下优先级获取数据：

### 备选方案 1：Web 搜索

```
搜索查询：
- "github trending {period} {language} {current_date}"
- "github most starred repos {current_month} {current_year}"
- "top github repositories {language} {current_month}"
```

### 备选方案 2：GitHub Search API

```bash
# 按 Star 数排序搜索最近创建/活跃的项目
gh api search/repositories \
  --method GET \
  -f q='stars:>100 pushed:>{date_7_days_ago}' \
  -f sort='stars' \
  -f order='desc' \
  -f per_page='{count}' \
  --jq '.items[] | {full_name, description, stargazers_count, language, topics}'

# 按语言筛选
gh api search/repositories \
  --method GET \
  -f q='language:{language} stars:>100 pushed:>{date_7_days_ago}' \
  -f sort='stars' \
  -f order='desc' \
  -f per_page='{count}'
```

> 注意：GitHub Search API 按总 Star 数排序，不完全等同于 Trending 的增长排名，需在报告中注明口径差异。

### 备选方案 3：第三方 Trending 数据

如以上方式均不可用，可搜索以下第三方整理的 Trending 数据：
- `github-trending-repos` 相关的 GitHub 仓库
- OSS Insight (ossinsight.io) 的趋势数据
- 在报告中需注明数据来自第三方聚合
