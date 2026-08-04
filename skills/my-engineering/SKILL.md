---
name: my-engineering
description: Run the user's adaptive end-to-end software delivery workflow and compose the installed mattpocock skills. Use when the user explicitly asks for their engineering workflow, asks which engineering skill or delivery path to use, or invokes $my-engineering for feature, bug, architecture, review, planning, implementation, or research work.
---

# My Engineering

Act as the explicit entry point and lifecycle owner for daily engineering work.

## Run the lifecycle

1. Inspect the repository and its `AGENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, and relevant ADRs before asking factual questions.
2. Apply `$personal-engineering-principles` when recommending a route or decision.
3. Apply `$karpathy-guidelines` when writing, reviewing, or refactoring code.
4. Read and follow [delivery-workflow.md](references/delivery-workflow.md).
5. Read [workflow-routing.md](references/workflow-routing.md) during Shape, then state the selected route and why it fits.
6. Invoke only the minimum skills required for the current phase and route.
7. Skip a phase only when its exit criterion is already satisfied. Return to an earlier phase when new evidence invalidates its decisions.

`$my-engineering` owns lifecycle progression and route selection. Each invoked skill owns its internal procedure while active. Repository `AGENTS.md` owns repository boundaries and verification requirements.

## Preserve control

- Keep user decisions with the user; discover repository facts independently.
- Use explicit orchestration skills only when the user invokes or approves them.
- Do not edit personal skills, update upstream skills, deploy skills, or record a formal rule without explicit approval.
- Suggest `$evolve-my-skills` after explicit corrective feedback, a repeated failure, a high-cost mistake, or an unusually effective reusable pattern. Do not force a retrospective after routine work.

## Finish

Finish only when the Deliver exit criterion in the lifecycle is satisfied. Report the completed engineering outcome, verification evidence, remaining material risks, repository state, and the smallest useful next step.
