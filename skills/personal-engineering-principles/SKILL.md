---
name: personal-engineering-principles
description: Apply the user's stable cross-project engineering preferences to software planning, design, implementation, debugging, and review. Use automatically when a recommendation or trade-off would benefit from the user's established engineering defaults; project-specific rules still take precedence.
---

# Personal Engineering Principles

Read [principles.md](references/principles.md) before making a material engineering recommendation.

Apply the principles as defaults, not universal laws. When project evidence or a concrete constraint justifies an exception:

1. Name the principle being departed from.
2. Cite the concrete constraint.
3. Explain the trade-off.
4. Prefer a reversible way to test the exception.

Follow repository-local `AGENTS.md`, `CONTEXT.md`, ADRs, and explicit user decisions when they conflict with a global preference. Never copy project-confidential knowledge into this skill.
