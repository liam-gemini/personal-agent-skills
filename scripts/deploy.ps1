[CmdletBinding()]
param([switch]$Apply)

. (Join-Path $PSScriptRoot 'common.ps1')

$root = Get-RepositoryRoot
$config = Get-SkillsConfig
$destinationRoot = [System.IO.Path]::GetFullPath($config.deployment.codexSkillsPath)
$expectedParent = Join-Path $env:USERPROFILE '.codex'
if ((Split-Path $destinationRoot -Leaf) -ne 'skills' -or
    [System.IO.Path]::GetFullPath((Split-Path $destinationRoot -Parent)).TrimEnd('\') -ne [System.IO.Path]::GetFullPath($expectedParent).TrimEnd('\')) {
    throw "Refusing to deploy outside the configured Codex skills directory: $destinationRoot"
}

& (Join-Path $PSScriptRoot 'validate.ps1')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$skills = @(Get-ManagedSkills)
$statePath = Join-Path $root 'config\deployment-state.json'
$previousNames = @()
if (Test-Path -LiteralPath $statePath) {
    $previousNames = @((Get-Content -Raw -Encoding utf8 -LiteralPath $statePath | ConvertFrom-Json).managedNames)
}
$currentNames = @($skills.Name)
$obsoleteNames = @($previousNames | Where-Object { $_ -notin $currentNames })

foreach ($skill in $skills) {
    $target = Join-Path $destinationRoot $skill.Name
    $action = if (Test-Path -LiteralPath $target) { 'UPDATE' } else { 'ADD' }
    Write-Output ("{0,-7} {1} ({2})" -f $action, $skill.Name, $skill.Kind)
}
foreach ($name in $obsoleteNames) {
    Write-Output ("REMOVE  {0} (no longer managed)" -f $name)
}

if (-not $Apply) {
    Write-Output 'Preview only. Re-run with -Apply to deploy.'
    exit 0
}

New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupRoot = Join-Path (Join-Path $root $config.deployment.backupPath) $timestamp
New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null

$touchedNames = @($currentNames + $obsoleteNames | Sort-Object -Unique)
$existedNames = @()
foreach ($name in $touchedNames) {
    $target = Join-Path $destinationRoot $name
    Assert-DirectChildPath -Root $destinationRoot -Target $target
    if (Test-Path -LiteralPath $target) {
        Copy-Item -LiteralPath $target -Destination (Join-Path $backupRoot $name) -Recurse
        $existedNames += $name
    }
}

foreach ($name in $obsoleteNames) {
    $target = Join-Path $destinationRoot $name
    Assert-DirectChildPath -Root $destinationRoot -Target $target
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
}

foreach ($skill in $skills) {
    $target = Join-Path $destinationRoot $skill.Name
    Assert-DirectChildPath -Root $destinationRoot -Target $target
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    Copy-Item -LiteralPath $skill.Source -Destination $target -Recurse
}

$backupIndex = [ordered]@{
    createdAt = (Get-Date).ToString('o')
    destinationRoot = $destinationRoot
    touchedNames = $touchedNames
    existedNames = $existedNames
}
$backupIndex | ConvertTo-Json -Depth 5 | Set-Content -Encoding utf8 -LiteralPath (Join-Path $backupRoot 'backup-index.json')

$state = [ordered]@{
    deployedAt = (Get-Date).ToString('o')
    upstreamCommit = $config.upstream.pinnedCommit
    managedNames = $currentNames
    backup = $backupRoot
}
$state | ConvertTo-Json -Depth 5 | Set-Content -Encoding utf8 -LiteralPath $statePath
Write-Output "Deployed $($skills.Count) skills. Backup: $backupRoot"
