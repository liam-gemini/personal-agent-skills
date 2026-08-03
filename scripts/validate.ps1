[CmdletBinding()]
param()

. (Join-Path $PSScriptRoot 'common.ps1')

$root = Get-RepositoryRoot
$config = Get-SkillsConfig
$skills = @(Get-ManagedSkills)
$errors = [System.Collections.Generic.List[string]]::new()

$actualCommit = (git -C (Join-Path $root $config.upstream.path) rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Unable to read the upstream commit.' }
if ($actualCommit -ne $config.upstream.pinnedCommit) {
    $errors.Add("Upstream commit $actualCommit does not match pinned commit $($config.upstream.pinnedCommit).")
}

foreach ($skill in $skills | Where-Object Kind -eq 'personal') {
    if ((Split-Path $skill.Source -Leaf) -ne $skill.Name) {
        $errors.Add("Folder name does not match skill name: $($skill.Source)")
    }

    $content = Get-Content -Raw -Encoding utf8 -LiteralPath (Join-Path $skill.Source 'SKILL.md')
    $links = [regex]::Matches($content, '\]\(([^)#]+\.md)(?:#[^)]*)?\)')
    foreach ($link in $links) {
        $referencedPath = Join-Path $skill.Source $link.Groups[1].Value
        if (-not (Test-Path -LiteralPath $referencedPath)) {
            $errors.Add("Broken Markdown reference in $($skill.Name): $($link.Groups[1].Value)")
        }
    }

    $openaiYaml = Join-Path $skill.Source 'agents\openai.yaml'
    if (-not (Test-Path -LiteralPath $openaiYaml)) {
        $errors.Add("Missing agents/openai.yaml for $($skill.Name)")
    } elseif ((Get-Content -Raw -Encoding utf8 -LiteralPath $openaiYaml) -notmatch [regex]::Escape("`$$($skill.Name)")) {
        $errors.Add("default_prompt does not mention `$$($skill.Name)")
    }

    $validator = Join-Path $env:USERPROFILE '.codex\skills\.system\skill-creator\scripts\quick_validate.py'
    & python $validator $skill.Source
    if ($LASTEXITCODE -ne 0) {
        $errors.Add("quick_validate.py failed for $($skill.Name)")
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "Validated $($skills.Count) skills ($(@($skills | Where-Object Kind -eq 'upstream').Count) upstream, $(@($skills | Where-Object Kind -eq 'personal').Count) personal)."
