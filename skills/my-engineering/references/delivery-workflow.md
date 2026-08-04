# Adaptive Delivery Workflow

Own progression from initial orientation through delivery. Treat phases as gates, not mandatory ceremony: skip a phase when its exit criterion is already satisfied, and return to an earlier phase when evidence invalidates a prior decision.

## 1. Orient

- Inspect repository instructions, code, tests, configuration, documentation, and worktree state.
- Separate discovered facts, material assumptions, and decisions that belong to the user.
- Define the requested outcome in observable terms.

**Exit:** The goal, current state, relevant scope, and main constraints are understood.

## 2. Align

- Resolve only ambiguities that materially change behavior, scope, ownership, or irreversible decisions.
- Use `$grill-my-design` for substantial repository design branches and `$domain-modeling` when terminology or boundaries are unclear.
- Skip extended alignment for concrete, reversible work.

**Exit:** Goals, non-goals, important behavior, boundaries, and hard-to-reverse decisions are clear enough to act.

## 3. Shape

- Read [workflow-routing.md](workflow-routing.md) and choose the narrowest delivery route.
- Define scope, success criteria, verification evidence, and a brief plan only when the work is multi-step.
- Avoid specs and tickets when direct implementation provides a shorter safe feedback loop.

**Exit:** The route, delivery scope, acceptance checks, and next executable step are explicit.

## 4. Build

- Apply `$karpathy-guidelines`; keep changes surgical and consistent with repository style.
- Use `$tdd` where behavior can be established through a useful failing test.
- Work in small verifiable slices. If implementation evidence disproves the plan, return to Align or Shape.

**Exit:** The requested behavior is implemented and no orphaned work was introduced by the change.

## 5. Verify

- Gather direct evidence appropriate to the artifact: tests, type checks, lint, runtime behavior, browser interaction, script preview, or document inspection.
- Exercise important failure paths in proportion to risk.
- Do not treat successful editing or a plausible diff as proof of completion.

**Exit:** Evidence demonstrates the acceptance criteria, or the exact blocker and unverified criteria are known.

## 6. Review

- Use `$code-review` for complex, high-risk, or multi-file changes when an independent review adds value.
- For small changes, inspect the diff for scope fidelity, correctness, unnecessary complexity, and repository-rule compliance.
- Fix confirmed in-scope findings, then repeat affected verification.

**Exit:** No unresolved high-confidence in-scope findings remain; residual risks are explicit.

## 7. Deliver

- Report the outcome, verification evidence, remaining risks, and repository state.
- Commit, push, deploy, publish, or otherwise change external state only when explicitly authorized.
- Identify the smallest useful next step without inventing additional scope.

**Exit:** The user can determine what is complete, what was verified, what remains, and whether any action is still required.

## 8. Learn

- Suggest `$evolve-my-skills` only after explicit corrective feedback, repeated failure, a high-cost mistake, or an unusually effective cross-project pattern.
- Do not force a retrospective after routine successful work.

**Exit:** A material learning signal is captured or deliberately declined; otherwise this phase is skipped.

## Proportional paths

```text
Trivial change:   Orient -> Build -> Verify -> Deliver
Small feature:    Orient -> Shape -> Build -> Verify -> Deliver
Complex feature:  Orient -> Align -> Shape -> Build -> Verify -> Review -> Deliver
Hard bug:         Orient -> Shape/Diagnose -> Build -> Verify -> Review -> Deliver
Material lesson:  Any completed path -> Learn
```
