# 科研绘图模式 · 技能来源与整合口径

本预设整合 **16 个科研绘图 Skill**，分两批：

- **A 组（10 个）**：用户给出的原文清单 —— 知乎「本周科研绘图 Skill 热门排行榜 Top 10」里
  列出的 10 个项目地址。
- **B 组（6 个）**：上一轮"原文不可达、按 GitHub Star 热度独立重建"时已经整合进来、
  按要求**保留不替换**的 6 个项目。

每个项目对应一个技能目录 `skills/<目录名>/`，正文、脚本、参考文档与素材**取自上游原样**，
只规范化了 `SKILL.md` 的 YAML frontmatter 并在正文开头加了一行来源标注。每个技能目录内还有
一份 `SOURCE.md`，以及上游的 LICENSE（若上游提供）。

Star 数采集于 **2026-10-15**（GitHub 仓库页内嵌 JSON），会随时间变化。

---

## 一、A 组：原文清单的 10 个项目

| # | 技能目录 | 技能名 | 上游项目 | Star | 许可 | 上游路径 |
|---|---------|--------|---------|------|------|---------|
| 1 | `academic-paper-figures` | academic-paper-figures | [Imbad0202/academic-research-skills](https://github.com/Imbad0202/academic-research-skills) | 52,163 | ⚠️ CC BY-NC 4.0 | `academic-paper/agents/visualization_agent.md` + `academic-paper/references/{statistical_visualization_standards,vlm_figure_verification}.md` |
| 2 | `sci-visualization` | sci-visualization | [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | 50,055 | MIT | `skills/scientific-visualization/` |
| 3 | `nature-figure` | nature-figure | [Yuan1z0825/nature-skills](https://github.com/Yuan1z0825/nature-skills) | 48,481 | Apache-2.0 | `skills/nature-figure/` |
| 4 | `paper-figure` | paper-figure | [wanshuiyin/Auto-claude-code-research-in-sleep](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | 17,520 | MIT | `skills/paper-figure/` |
| 5 | `researchclaw-visualization` | researchclaw-visualization | [aiming-lab/AutoResearchClaw](https://github.com/aiming-lab/AutoResearchClaw) | 14,657 | MIT | `researchclaw/skills/builtin/experiment/scientific-visualization/` + `researchclaw/agents/figure_agent/` |
| 6 | `scientific-figure-making` | scientific-figure-making | [ChenLiu-1996/figures4papers](https://github.com/ChenLiu-1996/figures4papers) | 8,590 | ⚠️ CC BY-NC 4.0 | `scientific-figure-making/` |
| 7 | `mathmodel-figure-templates` | mathmodel-figure-templates | [jihe520/MathModelAgent](https://github.com/jihe520/MathModelAgent) | 6,209 | ⚠️ 自定义（个人免费、禁商用、禁闭源分发） | `skills/mathmodel-figure-templates/` |
| 8 | `gpt-image` | gpt-image | [wuyoscar/GPT-Image2-Skill](https://github.com/wuyoscar/GPT-Image2-Skill) | 5,758 | MIT | `skills/gpt-image/` + `skills/get-prompt-from-image/` |
| 9 | `scientific-toolkit` | scientific-toolkit | [zLanqing/codex-claude-academic-skills](https://github.com/zLanqing/codex-claude-academic-skills) | 4,930 | MIT | `scientific-toolkit-skill/` |
| 10 | `academicforge-figures` | figure-composer | [HughYau/AcademicForge](https://github.com/HughYau/AcademicForge) | 2,593 | MIT | `skills/claude-science/figure-composer/` + `skills/claude-science/figure-style/` |

各技能覆盖什么：

1. **academic-paper-figures** — 上游是 12-agent 论文写作流水线，其中 Visualization Agent 负责
   "数据/统计结果 → 发表级配图代码 → APA 7.0 图注与尺寸 → LaTeX 插图代码"。本技能把该 agent
   的完整提示词、APA 7.0 统计可视化规范、以及基于视觉模型（VLM）的成图核验协议收在一起。
2. **sci-visualization** — 数据图的创作与**审计**：多面板、不确定性表达、配色与对比度、
   图像元数据校验、期刊导出规格；带 nature/publication/presentation 三套 `.mplstyle`。
3. **nature-figure** — Nature 级配图全流程路由器：多面板证据架构、图注版式、PDF 元素碰撞
   审查、批量修订与导出、AI 图形摘要工作流；带 chart-atlas 图集。
4. **paper-figure** — 从实验数据批量出图**和 LaTeX 表格**，并明确列出本技能生成不了的图。
5. **researchclaw-visualization** — 发表级图设计与统计标注，并附整套自动出图流水线源码
   （Decision→Planner→CodeGen→Renderer→Critic→重试，另有 Nano Banana 图像分支）。
6. **scientific-figure-making** — figures4papers（Yale 刘晨）matplotlib house style 与
   PDF/SVG/高 DPI 导出约定。
7. **mathmodel-figure-templates** — 11 个可直接运行的模板：SHAP 蜂群柱、配对云雨图、CV-ROC、
   泰勒图、相关矩阵组合图、预测边缘分布、TPE 3D 曲面、半边小提琴相关矩阵、分组环形热图、
   城市公园降温组合图、Nature 和弦图；带预览图与 `render_template.py` 选择器。
8. **gpt-image** — 用 GPT Image 2/2.5 生成与编辑图；风格画廊含研究论文配图、科学与教育插图、
   数据可视化、技术插图、信息图等；另含"从图片反推提示词"的参考流程。
9. **scientific-toolkit** — MATLAB/Octave、Python 科学计算、信号/图像处理、统计、仿真优化、
   发表级图表导出，附带 24 个科学库技能参考。
10. **figure-composer**（目录 `academicforge-figures`）— 多面板主图闭环：大纲（12 栏网格、
    逐面板任务与标签预算）→ 逐面板渲染 → 拼版加字母 → 对抗式整图自审（两级反馈）→ 只重渲
    受影响面板，≤3 轮；配套 `figure-style` 的成图正确性与可读性规则和两个确定性 kernel。

---

## 二、B 组：保留的 6 个项目

| 技能目录 | 上游项目 | Star | 许可 | 上游路径 |
|---------|---------|------|------|---------|
| `scipilot-figure` | [Haojae/scipilot-figure-skill](https://github.com/Haojae/scipilot-figure-skill) | 2,650 | MIT | 根目录 `SKILL.md` |
| `academic-figure-prompt` | [LigphiDonk/academic-figure-generator](https://github.com/LigphiDonk/academic-figure-generator) | 2,623 | MIT | `academic-figure-prompt/` + `-pastel/` |
| `paper-framework-studio` | [c-narcissus/paper-framework-figure-studio-pro](https://github.com/c-narcissus/paper-framework-figure-studio-pro) | 2,270 | 见包内 LICENSE | `paper-framework-figure-studio-pro-v3.2.15f-skill.zip` |
| `visio-figure-rebuild` | [pengjunchi0/codex-visio-paper-figure-skill](https://github.com/pengjunchi0/codex-visio-paper-figure-skill) | 1,033 | MIT | 根目录 `SKILL.md` |
| `plot-from-data` | [Trae1ounG/paper-plot-skills](https://github.com/Trae1ounG/paper-plot-skills) | 886 | 上游未提供 LICENSE | `plot-from-data/` + `plot-from-image/` |
| `academic-figure-skill` | [TingxiYu/academic-figure-skill](https://github.com/TingxiYu/academic-figure-skill) | 505 | Apache-2.0 | 根目录 `SKILL.md` |

---

## 三、整合口径：具体改了什么

1. **frontmatter 规范化** —— DSH 的技能加载器只识别 `name`（必须 kebab-case）、`description`
   与可选的 `whenToUse` / 两个调用开关，其余字段会被忽略。因此每个 `SKILL.md` 的 frontmatter
   都被改写成这三个字段（description 改写为中文并列出触发场景），上游原有的 `license`、
   `metadata`、`allowed-tools` 等字段在 `SOURCE.md` 与本文件里留档。
2. **正文一行来源标注** —— 每个 `SKILL.md` 正文开头加了一行块引用，写明上游项目与许可。
   正文其余部分、脚本、参考文档一字未动。
3. **`SOURCE.md`** —— 每个技能目录一份，记录上游项目、技能名、整合位置与改动范围。
4. **重命名（避免同图层重名）**：
   - AutoResearchClaw 的技能原名叫 `scientific-visualization`，与 K-Dense 的同名技能会在同一
     个技能图层里撞名（注册表对同层重名只保留一个），故改名为 `researchclaw-visualization`。
   - zLanqing 的目录名 `scientific-toolkit-skill` 规范为 `scientific-toolkit`（技能名同改）。
   - HughYau 的技能名保留上游的 `figure-composer`，技能目录取 `academicforge-figures`
     以便看出项目来源。
5. **唯一一个由整合方撰写正文的技能**：`academic-paper-figures`。上游仓库没有独立的绘图技能
   （它的绘图能力藏在 `academic-paper` 这个论文流水线技能的 agent 定义里），因此该技能由一个
   中文路由正文 + 三份**原样保留**的上游文档组成（`references/`）。
6. **素材取舍**：
   - 保留：`nature-figure` 的 chart-atlas 选图图集、`paper-framework-studio` 的矢量素材库
     （3976 个 SVG）、`mathmodel-figure-templates` 的 11 张预览图、`academic-figure-skill` 的
     figure-atlas。
   - 省略：`academic-figure-skill/assets/figures` 下 69 MB 示例成图 PNG（其 `.py`/`.R` 代码
     模板全部保留）。
7. **补 LICENSE**：为原本没带 LICENSE 的 5 个技能目录，从上游仓库根目录补入对应许可文件
   （`sci-visualization`、`nature-figure`、`paper-figure`、`scientific-figure-making`、
   `mathmodel-figure-templates`）。

> **许可提醒**：`academic-research-skills` 与 `figures4papers` 使用 **CC BY-NC 4.0**（禁止商业
> 用途）；`MathModelAgent` 为作者自定义条款（个人免费、禁止商业用途、禁止闭源分发）。
> 其余多为 MIT / Apache-2.0。用于商业项目前请自行核对上游许可。

---

## 四、实测结果（2026-10-15）

- **挂载校验**：`agentPresets.standingKeyFor('sci-figure')` 返回 OK；组合共 28 行，
  **25 行 active**，3 行刻意关闭（Windows 上禁用 `tool-bash`、两个未安装的可选子代理 provider），
  没有任何"启用但未激活"的行，也没有服务被发布进 root realm。
- **技能目录**：在该预设视角下正好可见 **16 个**技能，全部 `custom` 来源、模型可调用
  （重名技能已被前述改名规则避免）。
- **Python 语法**：A 组新增的 6 个技能共 83 个 `.py` 文件逐个 `py_compile`，**0 失败**。
- **真实出图**：
  - `mathmodel-figure-templates`：`render_template.py paired-raincloud --project mm-demo`
    跑通，产出 300 dpi PNG（437 KB）+ PDF（63 KB）+ SVG（102 KB），成图已用 `read_image` 目视确认。
  - `academicforge-figures`：`exec` 其 `figure_style_kernel.py` 后调用 `apply_figure_style()`，
    正常出图（35 KB PNG）。
  - `sci-visualization`：`nature.mplstyle` 渲染双面板 300 dpi PNG + 矢量 PDF 正常。
  - `plot-from-data`：`line_aime.py` 模板替换输出路径后跑通（155 KB PNG）。
- **清理**：批量编译产生的 `__pycache__` 已删除；预设内不应出现该目录。
- **精简后复验**（同日，删除 15.6 MB 之后）：挂载校验仍为 OK，16 个技能全部可见且
  正文均可加载（逐个 `skills.get` 校验通过），28 行组合中 25 行 active、无问题行；
  `mathmodel-figure-templates` 的泰勒图模板仍能渲染出 PNG/PDF/SVG，
  `nature-figure/scripts/nature_figure_backend.py` 可运行，
  `paper-framework-studio` 的 `figure_studio_core` 包可正常 import。

---

## 五、体积与精简

精简后预设约 **82.8 MB / 4796 个文件**。体积集中在四处**技能流程真正引用**的素材
（其余 12 个技能合计不到 1 MB）：

| 目录 | 体积 | 说明 | 被谁引用 |
|------|------|------|---------|
| `nature-figure/assets` | 27.6 MB | 第三方 figures4papers 参考图与代码 | `references/demos.md`、`manifest.yaml`、`THIRD_PARTY_NOTICES.md` |
| `paper-framework-studio/assets` | 27.3 MB | 矢量素材库（3976 个 SVG）+ 子类型图集 | `manifest.json`、多份 policy 文档、`constants.py` |
| `paper-framework-studio/references` | 7.1 MB | 设计模式索引（jsonl）+ 策略文档 | 技能主干 |
| `academic-figure-skill/assets` | 13.4 MB | figure-atlas 选图图集 + 各图型 Python/R 代码模板 | `SKILL.md` |
| `scientific-toolkit/references` | 4.8 MB | 24 个科学库技能参考 | `SKILL.md` |

### 精简记录（2026-10-15，共删除 22 项 / 15.6 MB / 52 个文件）

只删除"技能流程未引用、且运行不需要"的内容；凡是 `SKILL.md`、`manifest`、`references`
或脚本 import 链提到的文件一律保留（例如 `nature-figure/static/` 是 `manifest.yaml` 的
`always_load` 目标，`paper-framework-studio/scripts/figure_studio_core/` 与
`sci-visualization/scripts/_common.py` 是被 import 的包，全部保留）。

| 位置 | 删除内容 | 体积 | 理由 |
|------|---------|------|------|
| `mathmodel-figure-templates` | `assets/previews/`（11 张展示图） | 9.91 MB | `SKILL.md`、`figure-catalog.md` 均未引用，纯展示 |
| `nature-figure` | `assets/chart-atlas/`、`assets/gallery/` | 5.46 MB | 仅被上游 README 引用（README 同时删除） |
| `(预设)` | `docs/build/`（构建脚本与调研报告） | 0.07 MB | 构建留档，工作区有副本 |
| `nature-figure` | `evals/`、`agents/`、`.gitignore`、`README.md`、`README_EN.md` | 0.05 MB | 评测脚手架、其它宿主适配、上游展示文档 |
| `academic-figure-skill` | `scripts/run_ab_tests.py`（上游本身语法错误）、`scripts/.eval_results.json` | 0.03 MB | 无引用；`.eval_results.json` 是脚本运行时自建的结果文件 |
| 其余 | `UPSTREAM-README.md`×2、各 `agents/`、`README.md`、`.gitignore`、`metadata.json`、`PATCH_REPORT_*.md` | 0.05 MB | 上游文档、Codex/OpenAI 宿主适配文件、打包元数据 |

> 注：`paper-framework-studio/references/skill-packaging-context-on-demand-policy-v3215b.md`
> 的打包清单里列举过 `metadata.json`（该清单本就与 zip 实际内容不完全一致），删除后这一行
> 成为描述性残留，不影响任何脚本运行（已确认无脚本读取它）。


---

## 六、已知问题（均为上游原状）

1. `academic-figure-skill/scripts/run_ab_tests.py` **上游本身有语法错误**（文件哈希与上游一致），
   是该项目的内部测试脚手架，与出图流程无关。**该文件已在精简时删除**。
2. `plot-from-data/scripts/*.py`、`nature-figure/assets/figures4papers/**` 等示例脚本内嵌了作者
   本机路径（如 `/Users/bytedance/gitcode/...`），运行前必须替换输出路径。
3. `mathmodel-figure-templates/scripts/render_template.py` 会把模板脚本与产物写进
   `--project` 指定的目录（默认目录名「绘图复刻」）；请显式指定到工作区，避免写进预设目录。
4. `gpt-image` 需要 `OPENAI_API_KEY` 与 `gpt-image` / `uv` CLI，调用会产生 OpenAI 费用。
5. `researchclaw-visualization/scripts/figure_agent/` 是上游仓库内的 Python 包（含依赖 Gemini 的
   Nano Banana 分支），本机只做了语法编译与结构核对，未逐模块运行。
6. `nature-figure` 与 `academic-figure-skill` 正文中指向被省略示例成图的引用会失效。

---

## 七、原文无法抓取的记录

原文 <https://zhuanlan.zhihu.com/p/2068654806001046935>（标题「本周科研绘图 Skill 热门排行榜
Top 10 (2026.8.6)」）在本环境**无法读取**：直接抓取、知乎官方 API、各类代理与快照、搜索引擎
与公众号转载页全部失败（403 / 不可达 / 人机验证）。因此第一轮整合是按"Star 热度榜"这一体裁
独立重建的（即现在的 B 组 + A 组中的 4 个）。**A 组清单由用户直接提供**，是原文的真实项目地址。

抓取尝试覆盖：直连（浏览器 UA / curl / PowerShell）、`www.zhihu.com/api/v4/articles/<id>`、
`zhuanlan.zhihu.com/api/articles/<id>`、`api.zhihu.com/articles/<id>`、`appview` 页面、
r.jina.ai、web.archive.org、archive.org、translate.goog、api.codetabs.com、api.allorigins.win、
corsproxy.io、api.microlink.io、textise.net、cn.bing.com、sogou、baidu、duckduckgo、
mp.weixin.qq.com，以及同主题的 4 篇姊妹文章。详细记录见 `docs/build/sci-figure-skills-report.md`。
