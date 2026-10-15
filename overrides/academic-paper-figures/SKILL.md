---
name: academic-paper-figures
description: 学术论文配图的 APA 7.0 规范与成图核验：图型选择、图注与编号规则、可及性与色盲友好配色、尺寸与字体、LaTeX 插图代码，并附一套基于视觉模型（VLM）的成图核验流程——逐项检查截断标签、文字重叠、数据渲染错误与误导性坐标轴。
whenToUse: 论文图需要符合 APA 7.0 或期刊图注/编号规范、要求成图后逐项核验、或要让 Agent 产出可直接进稿的图注与插图代码时
---

> **来源**：Imbad0202/academic-research-skills · academic-paper/agents/visualization_agent.md 与 academic-paper/references/* · 见同目录 `SOURCE.md`
> 本技能由「科研绘图模式」预设整合：上游项目本身是论文写作流水线（12 个 agent），其中
> **Visualization Agent** 与两份规范文档是科研绘图相关的部分，这里把它们收成一个独立技能，
> 三份上游文档按原文保留在 `references/` 下，未作改写。

# 学术论文配图（APA 7.0 + 成图核验）

上游的 Visualization Agent 负责"解析论文数据与统计结果 → 生成发表级配图代码（Python/R）
→ 输出符合 APA 7.0 的图注、标签与尺寸 → 给出可嵌入论文的 LaTeX 代码"。本技能把这条链路
和它的两份规范、一份核验协议放在一起用。

## 五条上游核心原则（原样照做）

1. **数据驱动选型** —— 按数据结构与研究问题选图型，而不是按个人喜好。
2. **APA 7.0 合规** —— 所有图遵循 APA 第 7 版第 7 章（图注在图下方、编号与正文引用规则等）。
3. **可及性优先** —— 色盲安全配色、足够对比度、可读字号。
4. **可复现** —— 生成的代码自包含、有注释、无需修改即可运行。
5. **可直接嵌入** —— 输出包含 LaTeX `\includegraphics` 代码。

## 用法

按需读取 `references/` 下的三份文档，不要一次全读：

| 文件 | 什么时候读 |
|------|-----------|
| `references/visualization-agent.md` | 需要完整角色定义、输入输出契约、流程图与产出格式时（这是上游 agent 的完整提示词） |
| `references/statistical-visualization-standards.md` | 需要 APA 7.0 逐条规则、可及性配色、图型选择对照表、常见陷阱与代码模板时 |
| `references/vlm-figure-verification.md` | 成图后要做视觉核验时：用带视觉能力的模型对照数据与 APA 规范逐项检查 |

## 与本预设其它技能的分工

- 规范类问题（APA 图注、编号、期刊格式细节）→ 用本技能。
- 具体画法（matplotlib/seaborn 版式、配色、多面板）→ 用 `sci-visualization`、
  `figure-composer`、`figure-style`。
- 成图后的"读图复核"在本机用 `read_image` 直接做；`references/vlm-figure-verification.md`
  给出的是可复用的检查清单与判定标准，照着逐项过一遍即可。

## 硬性约束（来自上游规范，不得放宽）

- 每张图都必须增加信息量：能用一句话或一张表说清的数据，不要画成图。
- 图按正文首次提及顺序连续编号（Figure 1、Figure 2 …），且正文中必须引用。
- 图注位于图的下方（表注在上方，两者不要搞混）。
- 不得为了美观改动数据；坐标轴不得截断或做视觉夸大而不标注。
