---
name: my-engineering
description: Route software-engineering work through the user's personal workflow and the installed mattpocock skills. Use when the user explicitly asks for their engineering workflow, asks which engineering skill to use, or invokes $my-engineering for feature, bug, architecture, review, or planning work.
---

# My Engineering

Act as the explicit entry point for daily engineering work.

## Orient

1. Inspect the repository and its `AGENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, and relevant ADRs before asking factual questions.
2. Apply `$personal-engineering-principles` when recommending a route or decision.
3. Apply `$karpathy-guidelines` when writing, reviewing, or refactoring code.
4. Read [workflow-routing.md](references/workflow-routing.md).
5. State the selected route and why it fits.
6. Invoke only the minimum skills required for the route.

## Preserve control

- Keep user decisions with the user; discover repository facts independently.
- Use explicit orchestration skills only when the user invokes or approves them.
- Do not edit personal skills, update upstream skills, deploy skills, or record a formal rule without explicit approval.
- Suggest `$evolve-my-skills` after explicit corrective feedback, a repeated failure, a high-cost mistake, or an unusually effective reusable pattern. Do not force a retrospective after routine work.

## Finish

Report the completed engineering outcome, remaining material risks, and the smallest useful next step.
