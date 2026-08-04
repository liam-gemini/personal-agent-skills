# Repository Instructions

## Scope

These instructions apply to the entire repository. More specific instructions in a nested `AGENTS.md` or `AGENTS.override.md` take precedence within that subtree.

## Source boundaries

- Treat `skills/` as the source of truth for personal skills.
- Never edit installed copies under `~/.codex/skills` as source files.
- Treat `upstream/mattpocock-skills/` as a pinned upstream submodule. Do not edit it directly or update it as part of unrelated work.
- Keep project-specific knowledge, private code, customer data, credentials, and machine-specific state out of personal skills.
- Preserve unrelated user changes in the worktree.

## Personal skills

- Register every personal skill in `config/skills.json`.
- Keep the skill directory name and the `name` in `SKILL.md` identical.
- Include `agents/openai.yaml`, and make its `default_prompt` mention the skill as `$skill-name`.
- Keep personal skills small and composable. Add a new skill only for a recurring workflow.
- Update both `README.md` and `README.en.md` when the documented skill set or operating workflow changes.

## Collaboration discipline

- Surface material assumptions and ambiguities instead of choosing silently.
- Prefer the simplest complete response or solution and stay within the requested scope.
- Discover repository facts before asking the user, while leaving material decisions with the user.
- For actionable work, define a verifiable outcome and continue until it is checked.
- Match process depth to task complexity; keep trivial interactions lightweight.

## Coding discipline

- Apply `$karpathy-guidelines` when writing, reviewing, or refactoring code. Keep changes simple, surgical, and tied to verifiable success criteria.

## Experience evolution

- Use `skills/evolve-my-skills/` for changes derived from feedback or lessons.
- Sanitize candidate lessons and keep project-local knowledge in its project.
- Do not promote a candidate into a formal rule without explicit user approval.
- Search for duplicate or conflicting rules before promotion.

## Upstream, deployment, and rollback

- Review upstream changes with `scripts/review-upstream-update.ps1` before applying them.
- Resolve the Codex installation from `$CODEX_HOME`, falling back to `$USERPROFILE/.codex`. Do not add machine-specific absolute deployment paths to shared configuration.
- Preview deployment and rollback commands before using `-Apply`.
- Do not commit, push, deploy, apply an upstream update, or perform a rollback unless the user explicitly requests that action.

## Verification

After changing personal skills, configuration, deployment scripts, or behavioral rules, run from the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\behavior-checks.ps1
```

Also run `git diff --check` before committing. Validate other changes in proportion to their risk.
