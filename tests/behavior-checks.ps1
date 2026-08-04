[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-Contains {
    param([string]$Path, [string]$Pattern, [string]$Message)
    $content = Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $root $Path)
    if ($content -notmatch $Pattern) { $failures.Add($Message) }
}

Assert-Contains 'AGENTS.md' 'Treat `skills/` as the source of truth' 'Repository instructions must identify the personal skill source of truth.'
Assert-Contains 'AGENTS.md' 'Do not edit it directly or update it as part of unrelated work' 'Repository instructions must protect the upstream submodule.'
Assert-Contains 'AGENTS.md' 'Do not commit, push, deploy.*unless the user explicitly requests' 'Repository instructions must preserve user control over external changes.'
Assert-Contains 'skills\grill-my-design\SKILL.md' 'Ask exactly one decision question per turn' 'grill-my-design must ask one decision at a time.'
Assert-Contains 'skills\grill-my-design\SKILL.md' 'Do not implement until the user explicitly confirms' 'grill-my-design must wait for shared understanding.'
Assert-Contains 'skills\grill-my-design\SKILL.md' 'Discover facts from the environment' 'grill-my-design must investigate facts.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'explicitly approves' 'Formal lesson promotion must require approval.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'Never update the mattpocock submodule' 'Lesson promotion must not update upstream.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'lessons/rules.md.*stable Rule ID' 'Promoted important rules must enter the lifecycle registry.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'Do not deprecate or supersede.*without explicit user approval' 'Rule retirement must require approval.'
Assert-Contains 'skills\evolve-my-skills\references\rule-lifecycle.md' 'candidate -> active -> deprecated' 'The rule lifecycle must define explicit states.'
Assert-Contains 'skills\evolve-my-skills\references\rule-lifecycle.md' 'Last validated' 'Registered rules must preserve their validation date.'
Assert-Contains 'skills\personal-engineering-principles\SKILL.md' 'project-confidential' 'Global principles must protect project confidentiality.'
Assert-Contains 'skills\my-engineering\SKILL.md' 'Do not edit personal skills' 'The router must not mutate personal skills implicitly.'
Assert-Contains 'skills\my-engineering\SKILL.md' '\$karpathy-guidelines.*writing, reviewing, or refactoring code' 'Code work must apply karpathy-guidelines.'
Assert-Contains 'skills\karpathy-guidelines\SKILL.md' 'Every changed line should trace directly to the user''s request' 'Karpathy guidelines must require surgical changes.'
Assert-Contains 'skills\karpathy-guidelines\SKILL.md' 'Define success criteria. Loop until verified' 'Karpathy guidelines must require verifiable outcomes.'

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}
Write-Output 'Personal skill behavior checks passed.'
