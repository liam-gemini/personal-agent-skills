---
name: evolve-my-skills
description: Convert explicit interaction feedback, repeated failures, high-cost mistakes, or unusually effective patterns into reviewed improvements for the user's personal Codex skills. Use only when the user explicitly invokes $evolve-my-skills or asks to capture, review, promote, or apply lessons to their personal skills.
---

# Evolve My Skills

Maintain the source repository at `C:\Users\16477\Documents\personal-agent-skills`. Never edit installed copies under `.codex\skills` as the source of truth.

Read [lesson-policy.md](references/lesson-policy.md), [lesson-format.md](references/lesson-format.md), and [rule-lifecycle.md](references/rule-lifecycle.md).

## Capture

Capture a candidate lesson only when the user gives explicit positive or corrective feedback, a failure repeats, a mistake has high cost, or a pattern is clearly reusable. Append the sanitized candidate to `lessons/candidates.md`.

- Remove company names, customer data, source snippets, credentials, and private paths.
- Record project-specific knowledge in the project instead of this global repository.
- Do not treat a single preference expressed for one task as a global rule without evidence.

## Review

For each candidate:

1. Identify the observed behavior and desired behavior.
2. Find the root procedural gap.
3. Decide whether the lesson is global, project-local, or one-off.
4. Search existing personal rules to avoid duplication or contradiction.
5. Rewrite the lesson as a concise, executable rule with an applicability boundary.
6. Identify the exact target file and show the proposed diff.

## Promote

Do not modify a formal skill until the user explicitly approves the proposed rule and target.

After approval:

1. Edit the source skill, not the installed copy.
2. Mark the candidate as promoted, rejected, or project-local with its resolution.
3. For a promoted important rule, add an `active` entry to `lessons/rules.md` using a stable Rule ID.
4. Run `scripts/validate.ps1` and `tests/behavior-checks.ps1` from the repository root.
5. Record the validation date only after both checks pass.
6. Show the resulting diff.
7. Ask before committing or deploying.

## Retire

Do not deprecate or supersede a registered rule without explicit user approval. Update the executable rule and its registry entry together, preserve the reason and replacement link, then run the same validation checks.

Never update the mattpocock submodule as part of lesson promotion.
