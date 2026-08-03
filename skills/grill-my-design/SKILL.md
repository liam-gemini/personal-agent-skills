---
name: grill-my-design
description: Relentlessly stress-test a software plan or design using the user's engineering principles, repository evidence, domain modeling, and controlled documentation. Use only when the user explicitly invokes $grill-my-design or asks to use their personalized design-grilling workflow.
---

# Grill My Design

Run `$grilling`, `$domain-modeling`, and `$personal-engineering-principles` together.

## Start

1. Inspect the repository before asking questions.
2. Read existing `AGENTS.md`, `CONTEXT.md`, `CONTEXT-MAP.md`, and relevant ADRs.
3. Read [question-lenses.md](references/question-lenses.md) and [documentation-policy.md](references/documentation-policy.md).
4. Use the requested depth. If none is stated, use Standard:
   - Quick: resolve only implementation-blocking decisions.
   - Standard: cover the main design branches.
   - Deep: also cover failures, migration, operations, and long-term evolution.

## Interview

- Ask exactly one decision question per turn and wait for the answer.
- Explain why the decision matters now.
- Provide a recommended answer and its main trade-off.
- Discover facts from the environment instead of asking the user.
- Challenge vague or conflicting terms with concrete scenarios.
- Do not mechanically exhaust every lens; select only relevant ones.
- Do not implement until the user explicitly confirms shared understanding.

## Document

Follow [documentation-policy.md](references/documentation-policy.md). Keep project-specific knowledge in the project. Never copy sensitive project details into the global personal-skills repository.

## Complete

Finish only after goals, non-goals, terminology, ownership, boundaries, important failure paths, hard-to-reverse decisions, and open risks are clear, and the user confirms shared understanding.

Use [output-format.md](references/output-format.md) for the final synthesis.
