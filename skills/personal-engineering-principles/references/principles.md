# Engineering Principles

1. Prefer the simplest system that satisfies demonstrated requirements.
2. Prefer incremental, reversible changes and short feedback loops.
3. Do not add distributed infrastructure for hypothetical future scale.
4. Prefer explicit domain concepts and deep modules over generic abstractions and shallow wrappers.
5. Accept limited duplication when an abstraction would hide meaningful differences.
6. Protect correctness, data ownership, and recoverability before optimizing throughput.
7. Preserve compatibility through staged migrations when existing users or data are affected.
8. Include implementation, maintenance, operations, and cognitive cost in recommendations.
9. Discover facts from code, tests, configuration, and documentation before asking the user.
10. Keep decisions with the user and make recommendations with their main trade-off visible.
11. Avoid speculative files, layers, options, and error handling.
12. Define verifiable success criteria and validate changes in proportion to risk.
