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

Assert-Contains 'skills\grill-my-design\SKILL.md' 'Ask exactly one decision question per turn' 'grill-my-design must ask one decision at a time.'
Assert-Contains 'skills\grill-my-design\SKILL.md' 'Do not implement until the user explicitly confirms' 'grill-my-design must wait for shared understanding.'
Assert-Contains 'skills\grill-my-design\SKILL.md' 'Discover facts from the environment' 'grill-my-design must investigate facts.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'explicitly approves' 'Formal lesson promotion must require approval.'
Assert-Contains 'skills\evolve-my-skills\SKILL.md' 'Never update the mattpocock submodule' 'Lesson promotion must not update upstream.'
Assert-Contains 'skills\personal-engineering-principles\SKILL.md' 'project-confidential' 'Global principles must protect project confidentiality.'
Assert-Contains 'skills\my-engineering\SKILL.md' 'Do not edit personal skills' 'The router must not mutate personal skills implicitly.'

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}
Write-Output 'Personal skill behavior checks passed.'
