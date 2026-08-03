Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RepositoryRoot {
    return [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
}

function Get-SkillsConfig {
    $configPath = Join-Path (Get-RepositoryRoot) 'config\skills.json'
    return Get-Content -Raw -Encoding utf8 -LiteralPath $configPath | ConvertFrom-Json
}

function Get-SkillName {
    param([Parameter(Mandatory)][string]$SkillDirectory)

    $skillFile = Join-Path $SkillDirectory 'SKILL.md'
    $content = Get-Content -Raw -Encoding utf8 -LiteralPath $skillFile
    $match = [regex]::Match($content, '(?m)^name:\s*([a-z0-9-]+)\s*$')
    if (-not $match.Success) {
        throw "Missing or invalid name in $skillFile"
    }
    return $match.Groups[1].Value
}

function Get-ManagedSkills {
    $root = Get-RepositoryRoot
    $config = Get-SkillsConfig
    $skills = @()

    $upstreamRoot = Join-Path $root $config.upstream.skillsPath
    Get-ChildItem -LiteralPath $upstreamRoot -Recurse -Filter 'SKILL.md' -File | ForEach-Object {
        $directory = $_.Directory.FullName
        $skills += [pscustomobject]@{
            Name = Get-SkillName -SkillDirectory $directory
            Source = $directory
            Kind = 'upstream'
        }
    }

    $personalRoot = Join-Path $root $config.personal.skillsPath
    foreach ($name in $config.personal.names) {
        $directory = Join-Path $personalRoot $name
        if (-not (Test-Path -LiteralPath (Join-Path $directory 'SKILL.md'))) {
            throw "Configured personal skill is missing: $name"
        }
        $skills += [pscustomobject]@{
            Name = Get-SkillName -SkillDirectory $directory
            Source = $directory
            Kind = 'personal'
        }
    }

    $duplicates = $skills | Group-Object Name | Where-Object Count -gt 1
    if ($duplicates) {
        throw "Duplicate skill names: $($duplicates.Name -join ', ')"
    }
    return $skills | Sort-Object Name
}

function Assert-DirectChildPath {
    param(
        [Parameter(Mandatory)][string]$Root,
        [Parameter(Mandatory)][string]$Target
    )

    $rootFull = [System.IO.Path]::GetFullPath($Root).TrimEnd('\')
    $targetFull = [System.IO.Path]::GetFullPath($Target).TrimEnd('\')
    if ([System.IO.Path]::GetDirectoryName($targetFull) -ne $rootFull) {
        throw "Refusing operation outside a direct child of $rootFull`: $targetFull"
    }
}
