# Personal Agent Skills

English | [中文](./README.md)

This is my personal AI agent skills repository, built primarily for **OpenAI Codex**.

It starts from the structure and engineering practices of [mattpocock/skills](https://github.com/mattpocock/skills), but it is not merely an upstream mirror. It adds my engineering principles, daily workflows, personal skills, and improvements distilled from real usage. The goal is a personal agent operating system that is maintainable, testable, reversible, and able to evolve with experience.

## Why this repository exists

General-purpose skills are a strong starting point, but every developer has different projects, habits, risk tolerances, and decision-making preferences. This repository is intended to:

- Reuse mature practices instead of designing an entire agent workflow from scratch.
- Turn personal preferences into explicit, executable rules instead of repeating them in every conversation.
- Learn from successful patterns and costly mistakes without letting one-off feedback pollute long-term behavior.
- Manage skill source, validation, deployment, and rollback in one place so the version used by Codex remains traceable.

## Design principles

- **Separate upstream and personal content:** `mattpocock/skills` is retained as a pinned Git submodule, while personal skills are maintained independently.
- **Keep one source of truth:** edit skills in this repository, not installed copies under `~/.codex/skills`.
- **Prefer incremental, reversible change:** updates and deployments are previewed before application, backed up before replacement, and supported by rollback tooling.
- **Review lessons before promotion:** candidate lessons are captured, sanitized, classified, and deduplicated before they become formal skill rules.
- **Keep project knowledge in the project:** customer information, private code, business details, and project-specific conventions do not belong in global personal skills.
- **Preserve human control:** the agent may discover facts and recommend actions, but important decisions, rule promotion, and deployment remain explicitly approved.

## Repository layout

```text
personal-agent-skills/
├── AGENTS.md                       # Persistent Codex instructions for this repository
├── skills/                         # Personal skill source maintained here
│   ├── my-engineering/             # Entry point and router for daily engineering
│   ├── grill-my-design/            # Personalized design interrogation
│   ├── karpathy-guidelines/        # Simple, surgical, verifiable coding discipline
│   ├── personal-engineering-principles/ # Cross-project engineering defaults
│   └── evolve-my-skills/           # Reviewed learning from experience
├── upstream/mattpocock-skills/     # Pinned upstream Git submodule
├── config/skills.json              # Upstream version and personal skill set
├── lessons/                        # Candidate lessons and promoted-rule lifecycle records
├── scripts/                        # Creation, validation, deployment, update, rollback
├── tests/                          # Behavioral scenarios and checks
└── backups/                        # Local pre-deployment backups; not committed
```

## Current personal skills

| Skill | Purpose | Invocation |
| --- | --- | --- |
| `my-engineering` | Selects the smallest suitable workflow for feature, bug, architecture, review, or planning work | `$my-engineering` |
| `grill-my-design` | Stress-tests a design using repository evidence, domain modeling, and personal principles | `$grill-my-design` |
| `karpathy-guidelines` | Avoids overengineering, keeps changes surgical, and defines verifiable goals when writing, reviewing, or refactoring code | Invoked automatically by Codex or explicitly with `$karpathy-guidelines` |
| `personal-engineering-principles` | Applies stable cross-project preferences to engineering recommendations and trade-offs | Usually invoked automatically by Codex |
| `evolve-my-skills` | Captures, reviews, and promotes reusable lessons after explicit approval | `$evolve-my-skills` |

Upstream skills are deployed alongside these personal skills. The exact set is controlled by [`config/skills.json`](./config/skills.json).

## Quick start

### 1. Clone the repository and upstream submodule

```powershell
git clone --recurse-submodules https://github.com/liam-gemini/personal-agent-skills.git
Set-Location personal-agent-skills
```

If the repository was already cloned without its submodule:

```powershell
git submodule update --init --recursive
```

### 2. Check the configuration

Deployment uses `$CODEX_HOME` when set and otherwise falls back to the current Windows user's Codex directory:

```text
$CODEX_HOME/skills
→ $USERPROFILE/.codex/skills
```

Shared configuration normally requires no machine-specific edit. Set `CODEX_HOME` before running a script when another Codex profile directory is required.

### 3. Validate

```powershell
./scripts/validate.ps1
./tests/behavior-checks.ps1
```

### 4. Preview and deploy to Codex

```powershell
# Preview only; installed skills are not modified
./scripts/deploy.ps1

# Apply after reviewing the preview
./scripts/deploy.ps1 -Apply
```

Deployment validates the source first and backs up replaced skills under `backups/`.

### 5. Roll back if needed

```powershell
# Preview rollback from the latest backup
./scripts/rollback-deployment.ps1

# Apply after reviewing the scope
./scripts/rollback-deployment.ps1 -Apply
```

## Create a personal skill

Use the scaffolding script to create and register a new skill:

```powershell
./scripts/new-personal-skill.ps1 `
  -Name "my-new-skill" `
  -DisplayName "My New Skill" `
  -ShortDescription "A focused workflow for a recurring personal task" `
  -DefaultPrompt "help me run this workflow" `
  -Resources "references,scripts"
```

Then:

1. Complete `skills/my-new-skill/SKILL.md` and any required resources.
2. Add behavioral scenarios that demonstrate the intended behavior.
3. Run validation and behavioral checks.
4. Preview deployment before applying it to Codex.
5. Observe it in real work and feed reusable lessons into the evolution workflow.

## Evolve skills from experience

This repository deliberately avoids unrestricted agent “self-modification.” A safer learning loop is:

```text
Real use → capture a candidate lesson → sanitize and classify → check duplicates/conflicts
         → show the proposed rule and diff → human approval → edit source → validate → deploy
```

Good candidates include:

- Repeated failure patterns;
- High-cost mistakes worth preventing;
- Explicit corrective feedback;
- Unusually effective practices that generalize across projects.

Poor candidates for global rules include:

- Temporary preferences from a single task;
- Conventions that apply to only one repository;
- Customer data, internal source code, credentials, or other sensitive information;
- Unvalidated complexity added for hypothetical future needs.

When a retrospective is warranted, explicitly invoke `$evolve-my-skills` in Codex. Candidates are recorded in [`lessons/candidates.md`](./lessons/candidates.md), and formal changes require approval.

Important approved rules are registered in [`lessons/rules.md`](./lessons/rules.md), including their source, scope, target skill, status, last validation date, and replacement or retirement reason. Formal skills remain the executable source of truth; the registry preserves decision history.

## Update upstream skills

Upstream content does not drift silently. Generate a review report first:

```powershell
./scripts/review-upstream-update.ps1
```

After reviewing `config/upstream-update-report.md`, explicitly apply and verify the update:

```powershell
./scripts/review-upstream-update.ps1 -Apply
./scripts/validate.ps1
./tests/behavior-checks.ps1
./scripts/deploy.ps1
./scripts/deploy.ps1 -Apply
```

This keeps upstream improvements available without allowing unreviewed changes to alter daily workflows.

## Recommended next steps

- Add positive, negative, and “must not trigger” behavioral scenarios for every personal skill.
- Track a few practical signals such as rework, missed requirements, task duration, and manual corrections.
- Regularly remove duplicate or obsolete rules so skills do not only grow.
- Record the source, applicability boundary, and last validation date for important rules.
- Add CI once the workflow stabilizes so validation and behavioral checks run on commits or pull requests.
- Keep personal skills small and composable; create a new skill only for a genuinely recurring workflow.

## Relationship to upstream

This repository gratefully builds on the structure and practices of [mattpocock/skills](https://github.com/mattpocock/skills). Upstream content remains in a submodule so its provenance is traceable, upgrades can be reviewed, and personal customization stays separate.

Upstream content remains subject to its original license. Newly authored content in this repository is governed by the repository-root license when one is added.
