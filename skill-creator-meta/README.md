# Skill Creator: Meta（元生成器）

> **MethodCraft** 系列 — 将方法论编译为可执行 AI Skill

**Meta Creator** 是一个能够**生成 Creator 的 Creator**。你只需描述一个领域的工作流程或方法论，它会通过结构化对话提炼其核心模式，最终生成一个完整的、可独立运行的 Creator。

---

## 🎯 核心价值

现有的三个 Creator（Learning / Design / Build）覆盖了"学→设计→做"，但世界上有无数领域和流程。

**Meta Creator 解决的问题**：让任何人都能把自己的领域经验编译成 AI Creator，而不需要理解底层的 Skill 编写规范。

```
你的领域经验 → Meta Creator → 定制 Creator → 定制 Skill → 持续引导项目
```

---

## ✨ 核心特性

### 🧬 四种流程模式

不同领域的工作流有不同的拓扑结构，Meta Creator 能识别并匹配最合适的模式：

| 模式 | 图示 | 适用领域 |
|------|------|----------|
| **Linear** | A → B → C → D | 学习、培训、入职 |
| **Linear + Gate** | A →[✓]→ B →[✓]→ C | 设计、写作、方案制定 |
| **Directed + Backtrack** | A → B → C ←[回退]← D | 工程、科研、迭代 |
| **Parallel Convergent** | [A,B,C] → Merge → D | 研究、调研、多线协作 |

### 🧠 Memory 系统原生

生成的每个 Creator 都自带文件级持久化记忆：
- **plan.md**：进度追踪，跨对话恢复
- **decisions.md**：决策追溯，只增不减
- **领域特定文件**：根据领域自动设计

### ⚖️ 双模式 + 自适应

每个生成的 Creator 都具备：
- **轻量模式**：适合小型/短期项目
- **完整模式**：适合大型/长期项目
- **自适应**：轻量遇到复杂自动加深，完整遇到简单自动精简

### 🔗 跨 Creator 桥接

结项时自动生成 `handoff.md`，让一个 Creator 的产出可以无缝流入下一个 Creator。

---

## 🚀 快速开始

### 安装

将 `meta/` 目录放到你的 Skill 目录下即可。

### 使用

安装后，用以下方式触发 Meta Creator：

```
"帮我做一个投资研究 Creator"
"把我的写作流程变成 AI Skill"
"我想设计一个 AI 助手来引导代码审查"
```

### 交互流程

Meta Creator 会通过 **3-4 轮对话**收集信息：

| 轮次 | 内容 | 时间 |
|------|------|------|
| 第 1 轮 | 领域定位 + 核心目标 | ~1 分钟 |
| 第 2 轮 | 流程拆解 + 关键阶段 | ~3 分钟 |
| 第 3 轮 | 记忆策略 + 流程特性 | ~2 分钟 |
| 第 4 轮 | 汇总确认 | ~1 分钟 |

确认后自动生成 Creator（含 SKILL.md + references/），可直接安装或打包下载。

---

## 📁 文件结构

```
meta/
├── SKILL.md                                    # 元生成器主控逻辑
├── README.md                                   # 本文件
└── references/
    ├── templates/
    │   ├── creator_checklist.md                 # Creator 质量检查清单
    │   └── methodology_extraction_guide.md      # 方法论提炼指南
    └── strategies/
        ├── flow_patterns.md                     # 四种流程模式参考
        └── memory_patterns.md                   # Memory 系统设计模式
```

---

## 📚 领域模式快速参考

以下是常见领域的推荐配置，Meta Creator 会在对话中作为启发式建议使用：

| 领域 | 流程类型 | 建议阶段数 | 核心记忆 | 最终沉淀 |
|------|----------|-----------|----------|----------|
| 写作/创作 | linear_with_gate | 5 | 大纲、草稿、反馈 | 完稿+写作心得 |
| 投资研究 | parallel_convergent | 4 | 投资论点、数据、风险 | 研究报告 |
| 科研项目 | directed_with_backtrack | 5 | 假设、实验日志、发现 | 论文+方法论 |
| 职业发展 | linear | 4 | 技能矩阵、里程碑 | 成长路线图 |
| 项目复盘 | linear_with_gate | 4 | 时间线、根因、Action | 经验手册 |
| 新人入职 | linear | 5 | 进度、问题、导师笔记 | 入职总结 |
| 健康管理 | directed_with_backtrack | 4 | 基线、日志、检查结果 | 健康档案 |
| 旅行规划 | linear_with_gate | 5 | 行程、预订、费用 | 旅行回忆录 |
| 代码审查 | linear_with_gate | 3 | 检查清单、问题记录 | 团队知识库 |
| 法律案件 | directed_with_backtrack | 5 | 事实、法律引用、策略 | 案件档案 |

---

## 🏗️ 设计原则

Meta Creator 的设计基于从现有三个 Creator 中提炼的四个核心原则：

1. **方法论可编译**：任何结构化的人类经验都可以编码为 AI 可执行的指令
2. **文件即记忆**：用纯文件读写实现持久化，不依赖任何外部基础设施
3. **生成器模式**：不给固定模板，通过对话定制生成，一个 Creator 产出无数 Skill
4. **阶段性引导**：复杂长期任务拆解为有序阶段，每阶段有明确的输入-动作-产出

### 相比现有 Creator 的改进

| 改进点 | 说明 |
|--------|------|
| **新增 parallel_convergent 流程** | 支持并行工作线，解决纯串行的局限 |
| **跨 Creator 桥接** | handoff.md 协议打通 Creator 之间的数据流 |
| **流程模式决策树** | 自动推荐最合适的流程类型 |
| **Memory 分层设计** | 明确的 P0-P3 优先级策略，优化上下文窗口利用 |
| **质量检查清单** | 标准化的 Creator 质量保障机制 |
| **领域模式库** | 常见领域的快速参考配置 |

---

## 🔄 版本历史

- **v1.0.0** — 首次发布
  - 四种流程模式（linear / linear_with_gate / directed_with_backtrack / parallel_convergent）
  - Memory 系统设计模式
  - 方法论提炼指南
  - Creator 质量检查清单
  - 跨 Creator 桥接协议（handoff.md）

---

## 🤝 兼容性

主要为 [OpenClaw](https://github.com/nicepkg/OpenClaw) 设计，同时兼容能操作本地文件系统的 AI Agent 产品：
- Claude Code
- CodeBuddy
- Cursor
- Windsurf
- 其他支持文件读写的 Agent

---

## 📄 License

MIT
