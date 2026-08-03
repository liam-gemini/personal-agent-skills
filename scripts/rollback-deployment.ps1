[CmdletBinding()]
param(
    [string]$Backup,
    [switch]$Apply
)

. (Join-Path $PSScriptRoot 'common.ps1')

$root = Get-RepositoryRoot
$config = Get-SkillsConfig
$backupBase = Join-Path $root $config.deployment.backupPath
if (-not $Backup) {
    $Backup = Get-ChildItem -LiteralPath $backupBase -Directory | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty FullName
}
if (-not $Backup -or -not (Test-Path -LiteralPath (Join-Path $Backup 'backup-index.json'))) {
    throw 'A valid deployment backup is required.'
}

$index = Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $Backup 'backup-index.json') | ConvertFrom-Json
Write-Output "Rollback source: $Backup"
Write-Output "Affected skills: $($index.touchedNames -join ', ')"
if (-not $Apply) {
    Write-Output 'Preview only. Re-run with -Apply to roll back.'
    exit 0
}

foreach ($name in $index.touchedNames) {
    $target = Join-Path $index.destinationRoot $name
    Assert-DirectChildPath -Root $index.destinationRoot -Target $target
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
}
foreach ($name in $index.existedNames) {
    Copy-Item -LiteralPath (Join-Path $Backup $name) -Destination (Join-Path $index.destinationRoot $name) -Recurse
}
Write-Output 'Deployment rollback completed.'
