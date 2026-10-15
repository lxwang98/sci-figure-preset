<#
.SYNOPSIS
  为「科研绘图模式」预设补齐 4 个未随仓库分发的技能（上游为非宽松许可：CC BY-NC 4.0 ×2、
  作者自定义禁商用 ×1、无许可证 ×1）。脚本只从上游仓库下载，不做任何再分发。

.DESCRIPTION
  前置：仓库内容（preset.yml / agent.cordis.yml / skills/ ）已放到预设目录，通常是
  %USERPROFILE%\.dsh\.agent-presets\sci-figure\

  用法：
    # 1) 先按 README 把仓库放到预设目录，再补齐
    .\install-remaining.ps1

    # 2) 或一步到位：直接从仓库目录安装到预设目录（会连仓库自带的 12 个技能一起复制）
    .\install-remaining.ps1 -Target "$env:USERPROFILE\.dsh\.agent-presets\sci-figure" -FromRepo

  依赖：git（必需）、网络（GitHub）。
#>
[CmdletBinding()]
param(
  # 预设目标目录（默认即 DSH 的本地预设根下的 sci-figure）
  [string]$Target = (Join-Path $env:USERPROFILE '.dsh\.agent-presets\sci-figure'),
  # 下载缓存目录
  [string]$Cache  = (Join-Path $env:TEMP 'sci-figure-src'),
  # 从"仓库目录"整体安装（复制仓库自带的 12 个技能 + 拉取其余 4 个）
  [switch]$FromRepo,
  # 覆盖已存在的技能目录
  [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw '未找到 git，请先安装 Git for Windows: https://git-scm.com/download/win'
}

function Copy-Tree {
  param([string]$From, [string]$To, [string]$Filter = '*', [string[]]$ExcludeNames = @('.git'), [string[]]$SkipDirs = @())
  New-Item -ItemType Directory -Force -Path $To | Out-Null
  Get-ChildItem -LiteralPath $From -Force | Where-Object { $ExcludeNames -notcontains $_.Name -and $SkipDirs -notcontains $_.Name } | ForEach-Object {
    $dst = Join-Path $To $_.Name
    if ($_.PSIsContainer) { Copy-Tree -From $_.FullName -To $dst -Filter $Filter -ExcludeNames $ExcludeNames -SkipDirs $SkipDirs }
    elseif ($_.Name -like $Filter) { Copy-Item -LiteralPath $_.FullName -Destination $dst -Force }
  }
}

function Get-Repo {
  param([string]$Repo)
  $name = ($Repo -split '/')[-1]
  $dir  = Join-Path $Cache $name
  if (Test-Path (Join-Path $dir '.git')) {
    Write-Host "  使用缓存 $name"
  } else {
    Write-Host "  克隆 $Repo ..."
    git clone --depth 1 --filter=blob:none --quiet "https://github.com/$Repo" $dir
    if ($LASTEXITCODE -ne 0) { throw "克隆失败：$Repo" }
  }
  return $dir
}

# 只覆盖 frontmatter 的三个字段，正文原样保留
function Set-Frontmatter {
  param([string]$File, [string]$Name, [string]$Description, [string]$WhenToUse, [string]$SourceLine)
  $raw = Get-Content $File -Raw
  if (-not $raw.StartsWith('---')) { throw "$File 没有 frontmatter" }
  $after  = $raw.Substring(3)
  $endIdx = $after.IndexOf("`n---")
  if ($endIdx -lt 0) { throw "$File frontmatter 未闭合" }
  $body = $after.Substring($endIdx + 4) -replace '^[\r\n]+', ''
  $block = @"
---
name: $Name
description: $Description
whenToUse: $WhenToUse
---

> **来源**：$SourceLine
> 本技能为「科研绘图模式」预设整合内容，正文与随附资源来自上游仓库；署名与许可见同目录 ``SOURCE.md``。

"@
  Set-Content -Path $File -Value ($block + $body) -Encoding UTF8 -NoNewline
}

function Write-SourceNote {
  param([string]$Dir, [string]$Project, [string]$Name, [string]$RelPath, [string]$Extra = '')
  $txt = @"
# 来源与许可

- **上游项目**：$Project
- **技能名**：``$Name``
- **整合位置**：``skills/$RelPath/``

本目录内容由「科研绘图模式」预设从上游项目的 skill bundle 下载整合而来，未随预设仓库分发。
对 ``SKILL.md`` 的改动仅限：YAML frontmatter 规范为 DSH 识别的 ``name`` / ``description`` /
``whenToUse``，并在正文开头加一行来源标注。其余脚本、参考文档、素材保持上游原状。

上游项目的许可证与版权声明归原作者所有；如上游提供了 LICENSE 文件，已随本目录一并保留。
请遵守上游许可条款（见上表），尤其注意其中禁止商业用途的项目。
$Extra
"@
  Set-Content -Path (Join-Path $Dir 'SOURCE.md') -Value $txt -Encoding UTF8
}

# ── 准备目标目录 ────────────────────────────────────────────────────────────
New-Item -ItemType Directory -Force -Path (Join-Path $Target 'skills') | Out-Null

if ($FromRepo) {
  Write-Host "从仓库安装自带技能到 $Target ..."
  Copy-Item (Join-Path $repoRoot 'preset.yml')       $Target -Force
  Copy-Item (Join-Path $repoRoot 'agent.cordis.yml') $Target -Force
  Copy-Item (Join-Path $repoRoot 'README.md')        $Target -Force
  New-Item -ItemType Directory -Force -Path (Join-Path $Target 'docs') | Out-Null
  Copy-Item (Join-Path $repoRoot 'docs\SOURCES.md') (Join-Path $Target 'docs') -Force
  Get-ChildItem (Join-Path $repoRoot 'skills') -Directory | ForEach-Object {
    $dst = Join-Path (Join-Path $Target 'skills') $_.Name
    if ((Test-Path $dst) -and -not $Force) { Write-Host "  跳过已存在: $($_.Name)"; return }
    if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
    Copy-Item $_.FullName $dst -Recurse -Force
    Write-Host "  已复制: $($_.Name)"
  }
}

New-Item -ItemType Directory -Force -Path $Cache | Out-Null
$skillsDir = Join-Path $Target 'skills'

# ── 1) academic-paper-figures（Imbad0202/academic-research-skills，CC BY-NC 4.0）──
Write-Host '[1/4] academic-paper-figures'
$dst = Join-Path $skillsDir 'academic-paper-figures'
if ((Test-Path $dst) -and -not $Force) { Write-Host '  已存在，跳过' } else {
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  New-Item -ItemType Directory -Force -Path (Join-Path $dst 'references') | Out-Null
  # 整合方撰写的技能正文随仓库分发
  Copy-Item (Join-Path $repoRoot 'overrides\academic-paper-figures\SKILL.md') (Join-Path $dst 'SKILL.md') -Force
  $src = Get-Repo 'Imbad0202/academic-research-skills'
  $ap  = Join-Path $src 'academic-paper'
  Copy-Item (Join-Path $ap 'agents\visualization_agent.md')                     (Join-Path $dst 'references\visualization-agent.md') -Force
  Copy-Item (Join-Path $ap 'references\statistical_visualization_standards.md') (Join-Path $dst 'references\statistical-visualization-standards.md') -Force
  Copy-Item (Join-Path $ap 'references\vlm_figure_verification.md')             (Join-Path $dst 'references\vlm-figure-verification.md') -Force
  Copy-Item (Join-Path $src 'LICENSE') (Join-Path $dst 'LICENSE') -Force
  Write-SourceNote -Dir $dst -Name 'academic-paper-figures' -RelPath 'academic-paper-figures' `
    -Project 'Imbad0202/academic-research-skills · academic-paper/agents/visualization_agent.md + academic-paper/references/* · CC BY-NC 4.0（禁止商业用途）'
  Write-Host '  完成'
}

# ── 2) scientific-figure-making（ChenLiu-1996/figures4papers，CC BY-NC 4.0）──────
Write-Host '[2/4] scientific-figure-making'
$dst = Join-Path $skillsDir 'scientific-figure-making'
if ((Test-Path $dst) -and -not $Force) { Write-Host '  已存在，跳过' } else {
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  $src = Get-Repo 'ChenLiu-1996/figures4papers'
  Copy-Tree -From (Join-Path $src 'scientific-figure-making') -To $dst
  Copy-Item (Join-Path $src 'LICENSE') (Join-Path $dst 'LICENSE') -Force
  Set-Frontmatter -File (Join-Path $dst 'SKILL.md') -Name 'scientific-figure-making' `
    -Description 'figures4papers 家族（Yale 刘晨）的 matplotlib 论文配图规范：分组柱状、趋势线、散点、热图、多面板网格，统一 house style（字体、调色板、脊线、图例、留白）与 PDF/SVG/高 DPI 导出约定，并与仓库 figure_* 示例保持视觉一致。' `
    -WhenToUse '要求按 figures4papers 风格出图、复现该仓库示例风格、投稿图要统一版式时' `
    -SourceLine 'ChenLiu-1996/figures4papers · scientific-figure-making · 8,590★ · CC BY-NC 4.0（禁止商业用途）'
  Write-SourceNote -Dir $dst -Name 'scientific-figure-making' -RelPath 'scientific-figure-making' `
    -Project 'ChenLiu-1996/figures4papers · scientific-figure-making · CC BY-NC 4.0（禁止商业用途）'
  Write-Host '  完成'
}

# ── 3) mathmodel-figure-templates（jihe520/MathModelAgent，作者自定义条款）──────
Write-Host '[3/4] mathmodel-figure-templates'
$dst = Join-Path $skillsDir 'mathmodel-figure-templates'
if ((Test-Path $dst) -and -not $Force) { Write-Host '  已存在，跳过' } else {
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  $src = Get-Repo 'jihe520/MathModelAgent'
  # 跳过 assets/previews（9.9 MB 纯展示图，技能流程未引用）
  Copy-Tree -From (Join-Path $src 'skills\mathmodel-figure-templates') -To $dst -SkipDirs @('previews')
  Copy-Item (Join-Path $src 'skills\3coding-visual\SKILL.md') (Join-Path $dst 'references\coding-visual.md') -Force
  Copy-Item (Join-Path $src 'skills\4drawio\SKILL.md')        (Join-Path $dst 'references\drawio.md') -Force
  $lic = git -C $src show HEAD:docs/md/License.md
  Set-Content -Path (Join-Path $dst 'LICENSE.md') -Value $lic -Encoding UTF8
  Set-Frontmatter -File (Join-Path $dst 'SKILL.md') -Name 'mathmodel-figure-templates' `
    -Description '可直接运行的科研/数模绘图模板库：SHAP 蜂群柱状图、配对云雨图、交叉验证 ROC、泰勒图、相关矩阵组合图、预测-真实值边缘分布图、TPE 调参 3D 曲面、半边小提琴相关矩阵、分组环形热图、城市公园降温组合图、Nature 和弦图，附图型目录与渲染脚本。' `
    -WhenToUse '要复刻某类高级科研图型（数模与机器学习论文常用）、需要现成可跑的 Python 绘图脚本时' `
    -SourceLine 'jihe520/MathModelAgent · skills/mathmodel-figure-templates · 6,209★ · 作者自定义条款（个人免费、禁止商业用途、禁止闭源分发）'
  Write-SourceNote -Dir $dst -Name 'mathmodel-figure-templates' -RelPath 'mathmodel-figure-templates' `
    -Project 'jihe520/MathModelAgent · skills/mathmodel-figure-templates · 作者自定义条款（个人免费、禁止商业用途、禁止闭源分发）' `
    -Extra "- 已省略 ``assets/previews/``（9.9 MB 展示图，技能流程未引用）`n"
  Write-Host '  完成'
}

# ── 4) plot-from-data（Trae1ounG/paper-plot-skills，上游未提供许可证）─────────
Write-Host '[4/4] plot-from-data'
$dst = Join-Path $skillsDir 'plot-from-data'
if ((Test-Path $dst) -and -not $Force) { Write-Host '  已存在，跳过' } else {
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  $src = Get-Repo 'Trae1ounG/paper-plot-skills'
  Copy-Tree -From (Join-Path $src 'plot-from-data') -To $dst -SkipDirs @('agents')
  Copy-Item (Join-Path $src 'plot-from-image\SKILL.md')                        (Join-Path $dst 'references\plot-from-image.md') -Force
  Copy-Item (Join-Path $src 'plot-from-image\references\reproduction_guide.md') (Join-Path $dst 'references\reproduction_guide.md') -Force
  Copy-Item (Join-Path $src 'plot-from-image\scripts\classwise_iou_table.py')  (Join-Path $dst 'scripts\classwise_iou_table.py') -Force
  Set-Frontmatter -File (Join-Path $dst 'SKILL.md') -Name 'plot-from-data' `
    -Description '选风格→填数据的论文出图：内置 8 套顶会图风格模板（分组柱状、配对增量柱、置信带折线、训练曲线、内嵌小图折线、t-SNE 聚类散点、断轴散点、双序列雷达），替换数据即出 300dpi 成图并附可复现脚本。references/plot-from-image.md 整合同一项目的"照图复现"工作流：从论文图截图反推 matplotlib 代码。' `
    -WhenToUse '有数据要套论文风格出图、或上传论文里的图要求复现同样式时' `
    -SourceLine 'Trae1ounG/paper-plot-skills · plot-from-data + plot-from-image · 886★ · 上游未提供 LICENSE'
  Write-SourceNote -Dir $dst -Name 'plot-from-data' -RelPath 'plot-from-data' `
    -Project 'Trae1ounG/paper-plot-skills · plot-from-data + plot-from-image · 886★ · 上游未提供 LICENSE（使用前请自行联系作者确认）'
  Write-Host '  完成'
}

# ── 汇总 ────────────────────────────────────────────────────────────────────
$count = (Get-ChildItem $skillsDir -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }).Count
Write-Host ''
Write-Host "完成。$Target\skills 下现有 $count 个技能。"
Write-Host '在 DSH Web GUI 的预设选择器里选「科研绘图模式」即可（花名册不缓存，无需重启）。'
