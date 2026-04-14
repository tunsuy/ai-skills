# DESIGN.md 品牌设计目录

本文档列出 [awesome-design-md](https://github.com/VoltAgent/awesome-design-md) 仓库中所有可用的品牌设计文件。

## 如何使用

```bash
# 获取特定品牌的 DESIGN.md
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/{brand}/DESIGN.md
```

## 品牌分类

### AI & LLM 平台

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Claude | `claude` | Anthropic 的 AI 助手 |
| Cohere | `cohere` | 企业级 NLP 平台 |
| OpenAI (x.ai) | `xai` | xAI 的设计风格 |
| Ollama | `ollama` | 本地运行 LLM 的工具 |
| Replicate | `replicate` | ML 模型托管平台 |

### 开发者工具 & IDE

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Cursor | `cursor` | AI-first 代码编辑器 |
| Expo | `expo` | React Native 开发平台 |
| Raycast | `raycast` | macOS 生产力启动器 |
| Vercel | `vercel` | 前端部署平台 |
| Warp | `warp` | 现代终端 |

### 后端、数据库 & DevOps

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| MongoDB | `mongodb` | 文档数据库 |
| PostHog | `posthog` | 产品分析平台 |
| Supabase | `supabase` | 开源 Firebase 替代 |
| Sentry | `sentry` | 错误监控平台 |

### 生产力 & SaaS

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Notion | `notion` | 笔记和知识管理 |
| Linear | `linear` | 项目管理工具 |
| Zapier | `zapier` | 自动化平台 |
| Intercom | `intercom` | 客户沟通平台 |

### 设计 & 创意工具

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Figma | `figma` | 协作设计工具 |
| Framer | `framer` | 网站设计工具 |
| Webflow | `webflow` | 可视化网站构建器 |
| Miro | `miro` | 在线白板协作 |

### 金融科技 & 加密货币

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Stripe | `stripe` | 在线支付平台 |
| Coinbase | `coinbase` | 加密货币交易所 |
| Binance | `binance` | 加密货币交易所 |
| Wise | `wise` | 国际汇款服务 |

### 电商 & 零售

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Airbnb | `airbnb` | 住宿预订平台 |
| Nike | `nike` | 运动品牌 |
| Shopify | `shopify` | 电商平台 |

### 媒体 & 消费科技

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| Apple | `apple` | 科技巨头 |
| IBM | `ibm` | 企业科技 |
| NVIDIA | `nvidia` | GPU 和 AI 计算 |
| Spotify | `spotify` | 音乐流媒体 |
| Tesla | `tesla` | 电动汽车 |

### 汽车

| 品牌 | 目录名 | 描述 |
|------|--------|------|
| BMW | `bmw` | 豪华汽车 |
| Ferrari | `ferrari` | 超级跑车 |
| Tesla | `tesla` | 电动汽车 |
| Bugatti | `bugatti` | 超级跑车 |

## 文件结构

每个品牌目录通常包含：

```
designs/{brand}/
├── DESIGN.md           # 主设计规范文件
├── preview.html        # 浅色模式预览
└── preview-dark.html   # 深色模式预览
```

## 快速获取命令

```bash
# Claude 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/claude/DESIGN.md

# Vercel 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/vercel/DESIGN.md

# Stripe 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/stripe/DESIGN.md

# Apple 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/apple/DESIGN.md

# Linear 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/linear/DESIGN.md

# Notion 风格
curl -o DESIGN.md https://raw.githubusercontent.com/VoltAgent/awesome-design-md/main/designs/notion/DESIGN.md
```

## 自定义设计

如果需要自定义设计，可以：

1. 复制一个现有的 DESIGN.md 作为模板
2. 修改颜色、字体、组件样式
3. 添加项目特定的设计规范

详见 SKILL.md 中的"自定义 DESIGN.md"部分。
