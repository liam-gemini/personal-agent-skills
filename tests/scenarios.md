# Forward-Test Scenarios

Use these prompts in fresh contexts when personal skills change materially. Do not provide expected answers to the testing agent.

## Design grilling

```text
Use $grill-my-design to help me decide whether an order service should publish an event before or after payment confirmation.
```

Inspect whether it investigates available facts, asks one decision question, recommends an answer with a trade-off, and waits before implementation.

## Lesson capture

```text
Use $evolve-my-skills. In the previous task the agent repeatedly proposed infrastructure for hypothetical scale. Help me decide whether this should become a personal rule.
```

Inspect whether it distinguishes a candidate from a formal rule, sanitizes context, searches for an existing rule, and requests approval before editing.

## Routing

```text
Use $my-engineering. A deterministic unit test started failing after yesterday's refactor; I need the root cause before any fix.
```

Inspect whether it selects the narrow debugging route, defines evidence for the root cause, and progresses through verification without unnecessary specification ceremony.

## Code implementation discipline

```text
Use $my-engineering to add input validation to this existing API endpoint.
```

Inspect whether it applies `$karpathy-guidelines`, states material assumptions, avoids unrelated refactoring, and defines a verifiable success criterion.

## Proportional delivery

```text
Use $my-engineering to correct a wrong command in this repository's README.
```

Inspect whether it uses the lightweight Orient -> Build -> Verify -> Deliver path without forcing grilling, a specification, tickets, or a full parallel code review.

## Complex delivery

```text
Use $my-engineering to add organization-level roles to an existing multi-tenant application. The authorization model is not yet decided.
```

Inspect whether it orients from repository evidence, aligns the material authorization decisions, shapes an appropriately staged route, defines verification before implementation, and retains Review because the change is high risk.

## Ask a good question

```text
Use $how-to-ask-good-questions. I want to ask our database maintainer why this query is slow, but all I have is "joins are confusing" and an execution plan showing a sequential scan.
```

Inspect whether it identifies the user's goal and current model, isolates a factual unknown, retains only answer-changing context, and returns a ready-to-send question without requiring exhaustive prior research.

## Get a useful answer

```text
Use $how-to-get-useful-answers-to-your-questions. I asked whether deployment blocks database migrations, but received a long explanation of our CI provider that never answered the ordering question.
```

Inspect whether it preserves facts actually established, identifies the unanswered ordering question, and produces a polite bounded follow-up that redirects the conversation.
