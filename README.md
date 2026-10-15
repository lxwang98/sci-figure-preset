# 科研绘图模式 · DSH Agent 预设（sci-figure）

一个把 **16 个科研绘图 Skill** 整合在一起的 DSH Agent 预设。装上它，会话里的 Agent
就是一名科研绘图工程师：能写并运行 Python/R 出图脚本、能读回成图做视觉自检、能按目标期刊
规格交付矢量与位图、能画数据图与论文框架图，也能用 AI 生图。

> **这是 Agent 预设，不是 Skill。**
> `preset.yml` + `agent.cordis.yml` 定义一个 Agent 的身份（persona）、工具集与技能路由；
> `skills/` 下的技能是这个 Agent 按需加载的能力包。

## 仓库内容与许可边界

本仓库**只分发可以再分发的内容**：

| 内容 | 是否入库 | 说明 |
|------|---------|------|
| `preset.yml`、`agent.cordis.yml`、`README.md`、`docs/SOURCES.md` | ✅ | 本项目的组合与人设，作者原创 |
| `overrides/academic-paper-figures/SKILL.md` | ✅ | 本项目的整合正文，作者原创 |
| 12 个采用宽松许可（MIT / Apache-2.0 / MIT-0）的技能 | ✅ | 完整入库，各带 `LICENSE` 与 `SOURCE.md` |
| 4 个非宽松许可的技能 | 由脚本拉取 | CC BY-NC 4.0 ×2、作者自定义禁商用 ×1、上游无许可证 ×1 |

入库的 12 个技能及其上游许可：

| 技能 | 上游项目 | 许可 |
|------|---------|------|
| `sci-visualization` | K-Dense-AI/scientific-agent-skills | MIT |
| `nature-figure` | Yuan1z0825/nature-skills | Apache-2.0 |
| `paper-figure` | wanshuiyin/Auto-claude-code-research-in-sleep | MIT |
| `researchclaw-visualization` | aiming-lab/AutoResearchClaw | MIT |
| `gpt-image` | wuyoscar/GPT-Image2-Skill | MIT |
| `scientific-toolkit` | zLanqing/codex-claude-academic-skills | MIT |
| `academicforge-figures` | HughYau/AcademicForge | MIT |
| `scipilot-figure` | Haojae/scipilot-figure-skill | MIT |
| `academic-figure-prompt` | LigphiDonk/academic-figure-generator | MIT |
| `paper-framework-studio` | c-narcissus/paper-framework-figure-studio-pro | MIT-0 |
| `visio-figure-rebuild` | pengjunchi0/codex-visio-paper-figure-skill | MIT |
| `academic-figure-skill` | TingxiYu/academic-figure-skill | Apache-2.0 |

未入库、由 `install-remaining.ps1` 从上游拉取的 4 个：`academic-paper-figures`（CC BY-NC 4.0）、
`scientific-figure-making`（CC BY-NC 4.0）、`mathmodel-figure-templates`（作者自定义：个人免费、
禁商用、禁闭源分发）、`plot-from-data`（上游未提供许可证）。

每个技能目录内的 `SOURCE.md` 记录上游地址、技能名与改动范围；完整清单、Star 数与整合口径见
[`docs/SOURCES.md`](docs/SOURCES.md)。

## 安装

**要求**：Windows + PowerShell，已安装 [Git](https://git-scm.com/download/win)，并且已经装了 DSH。

```powershell
# 1) 克隆到 DSH 的本地预设根（目录名必须正好是 sci-figure —— 它就是 preset id）
git clone https://github.com/<你的用户名>/<仓库名>.git "$env:USERPROFILE\.dsh\.agent-presets\sci-figure"

# 2) 补齐另外 4 个技能（从上游下载，不在本仓库分发）
cd "$env:USERPROFILE\.dsh\.agent-presets\sci-figure"
powershell -ExecutionPolicy Bypass -File .\install-remaining.ps1
```

装完在 DSH Web GUI 的预设/模式选择器里选 **科研绘图模式** 即可（花名册不缓存，无需重启）。

也可以一步到位（把仓库内容与那 4 个技能一起装到预设目录）：

```powershell
git clone https://github.com/<你的用户名>/<仓库名>.git "$env:TEMP\sci-figure"
powershell -ExecutionPolicy Bypass -File "$env:TEMP\sci-figure\install-remaining.ps1" -FromRepo
```

## 怎么用

开新会话后直接说需求，Agent 会按 persona 里的路由挑技能：

- 「这批数据帮我出一张方法对比图，投 ICML」→ `plot-from-data` / `paper-figure`
- 「我不知道这些数据该用什么图」→ `scipilot-figure`
- 「画一个方法总览框架图，先给我三个候选」→ `paper-framework-studio`
- 「复刻这张云雨图 / 泰勒图」→ `mathmodel-figure-templates`
- 「我要投稿的图，按 APA 格式检查一遍」→ `academic-paper-figures`
- 「做一个四面板主图，闭环自审」→ `academicforge-figures`
- 「写一段 NanoBanana 提示词」→ `academic-figure-prompt`；「直接生成图」→ `gpt-image`
- 「这张图用 Visio 重画成可编辑的」→ `visio-figure-rebuild`（需本机装 Visio）

## 行为约定（persona 里的硬规则）

- 不改数据、不编造：不得为好看而隐藏/增强数据点或静默截断坐标轴。
- 动手前先确定目标期刊、这张图的科学结论、统计口径与交付格式。
- 默认 300 dpi + 矢量（PDF/SVG，文字可编辑）、单栏 3.5 in / 双栏 7 in、字号 6–10 pt、
  色盲友好配色；图内文字默认英文。
- **出图后必须用 `read_image` 读回成图自检**（裁切、刻度重叠、图例遮挡、子图对齐），
  不合格就回改重渲——不交付没看过的图。
- 图与可复现脚本一起交付；误差棒含义、样本量、检验方法必须写进图注或交付说明。

## 依赖

- Python 3.11+：`matplotlib` / `seaborn` / `numpy` / `pandas` / `scipy` / `Pillow`
  （`scienceplots`、`plotly` 按需 `pip install`）。
- R 4.x + `ggplot2`（可选，`nature-figure` 的 R 分支用）。
- PowerShell（Windows）；`visio-figure-rebuild` 的 `.ps1` 脚本需要本机安装 Visio 桌面版。
- `gpt-image` 需要 `OPENAI_API_KEY` 与 `gpt-image` / `uv` CLI，调用会产生 OpenAI 费用。

## 体积

约 **82.5 MB / 4700+ 文件**，其中绝大部分来自两个技能自带的素材：
`nature-figure/assets`（28 MB，第三方 figures4papers 参考图）与
`paper-framework-studio/assets`（35 MB，3976 个矢量素材 + 子类型图集）。
如需瘦身可删除这两处 `assets/`（技能正文仍可用，只是正文里指向图片的引用会失效），
或改用 Git LFS：

```powershell
git lfs install
git lfs track "*.png" "*.pptx"
git add .gitattributes
```

## 许可

- 本项目原创部分（组合、persona、文档、`overrides/`）：**MIT**，见 [`LICENSE`](LICENSE)。
- `skills/` 下每个技能的内容版权归各自上游作者所有，许可见该目录内的 `LICENSE` 与 `SOURCE.md`；
  再分发或商用前请逐一核对。
- 特别注意：脚本拉取的 4 个技能中含 **CC BY-NC 4.0（禁止商业用途）** 与
  **作者自定义禁商用条款**，请勿用于商业项目。
