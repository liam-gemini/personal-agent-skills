# Workflow Routing

Choose the narrowest route that matches the work.

| Situation | Preferred route |
| --- | --- |
| Unclear idea in a repository | `$grill-my-design` |
| Unclear idea without a repository | `$grill-me` |
| Huge effort that cannot fit one session | `$wayfinder` → `$to-spec` → `$to-tickets` |
| Agreed multi-session feature | `$to-spec` → `$to-tickets` → `$implement` |
| Agreed small feature | `$implement` |
| Concrete behavior to build test-first | `$tdd` |
| Hard, intermittent, or regressed bug | `$diagnosing-bugs` |
| Branch or PR review | `$code-review` |
| Codebase structure is degrading | `$improve-codebase-architecture` |
| Question requires primary-source research | `$research` |
| Context must cross sessions | `$handoff` |

Run `$setup-matt-pocock-skills` once in a repository before relying on issue-tracker, label, or documentation conventions.

Do not turn routing into ceremony. Skip planning layers when the request is already concrete, reversible, and small.
