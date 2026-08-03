[CmdletBinding()]
param(
    [Parameter(Mandatory)][ValidatePattern('^[a-z0-9-]{1,63}$')][string]$Name,
    [Parameter(Mandatory)][string]$DisplayName,
    [Parameter(Mandatory)][ValidateLength(25, 64)][string]$ShortDescription,
    [Parameter(Mandatory)][string]$DefaultPrompt,
    [ValidateSet('none', 'references', 'scripts', 'references,scripts', 'references,assets', 'references,scripts,assets')][string]$Resources = 'none'
)

. (Join-Path $PSScriptRoot 'common.ps1')

$root = Get-RepositoryRoot
$configPath = Join-Path $root 'config\skills.json'
$config = Get-SkillsConfig
$personalRoot = Join-Path $root $config.personal.skillsPath
$init = Join-Path $env:USERPROFILE '.codex\skills\.system\skill-creator\scripts\init_skill.py'
$prompt = if ($DefaultPrompt -match [regex]::Escape("`$$Name")) { $DefaultPrompt } else { "Use `$$Name $DefaultPrompt" }

$arguments = @(
    $init, $Name, '--path', $personalRoot,
    '--interface', "display_name=$DisplayName",
    '--interface', "short_description=$ShortDescription",
    '--interface', "default_prompt=$prompt"
)
if ($Resources -ne 'none') {
    $arguments += @('--resources', $Resources)
}
& python @arguments
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

$config.personal.names = @($config.personal.names + $Name | Sort-Object -Unique)
$config | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 -LiteralPath $configPath
Write-Output "Created and registered $Name. Complete SKILL.md, then validate before deployment."
