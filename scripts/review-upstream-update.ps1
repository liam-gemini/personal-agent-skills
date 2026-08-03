[CmdletBinding()]
param([switch]$Apply)

. (Join-Path $PSScriptRoot 'common.ps1')

$root = Get-RepositoryRoot
$configPath = Join-Path $root 'config\skills.json'
$config = Get-SkillsConfig
$upstream = Join-Path $root $config.upstream.path

git -C $upstream fetch origin main
if ($LASTEXITCODE -ne 0) { throw 'Unable to fetch upstream/main.' }

$current = (git -C $upstream rev-parse HEAD).Trim()
$candidate = (git -C $upstream rev-parse origin/main).Trim()
$reportPath = Join-Path $root 'config\upstream-update-report.md'
$summary = git -C $upstream diff --stat $current $candidate
$changedSkills = git -C $upstream diff --name-status $current $candidate -- skills
$report = @(
    '# Upstream Update Report',
    '',
    "- Current: ``$current``",
    "- Candidate: ``$candidate``",
    '',
    '## Summary',
    '',
    '```text',
    ($summary -join "`n"),
    '```',
    '',
    '## Skill changes',
    '',
    '```text',
    ($changedSkills -join "`n"),
    '```'
)
$report | Set-Content -Encoding utf8 -LiteralPath $reportPath
Write-Output "Update report: $reportPath"

if ($current -eq $candidate) {
    Write-Output 'Upstream is already current.'
    exit 0
}
if (-not $Apply) {
    Write-Output 'Review the report. Re-run with -Apply only after approval.'
    exit 0
}

git -C $upstream checkout --detach $candidate
if ($LASTEXITCODE -ne 0) { throw 'Unable to check out the approved upstream commit.' }
$config.upstream.pinnedCommit = $candidate
$config | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 -LiteralPath $configPath
Write-Output "Pinned upstream at $candidate. Validate and deploy separately."
