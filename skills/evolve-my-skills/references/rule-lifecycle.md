# Rule Lifecycle

Track every important rule promoted through `$evolve-my-skills` in `lessons/rules.md`. Do not register every explanatory sentence or imported upstream rule.

## States

```text
candidate -> active -> deprecated
                    -> superseded
```

- `candidate`: Remains in `lessons/candidates.md`; it is not a formal rule.
- `active`: Approved, present in a personal skill, and currently applicable.
- `deprecated`: Retained for history but no longer applied.
- `superseded`: Replaced by another registered rule.

Only move a rule between states with explicit user approval. A rejected or project-local candidate never becomes a registered rule.

## Registry format

```markdown
## RULE-YYYYMMDD-NN — Short title

- **Status:** active | deprecated | superseded
- **Source:** Candidate ID or concise sanitized origin.
- **Scope:** Where the rule applies and its exception boundary.
- **Target:** Personal skill and file containing the executable rule.
- **Rule:** Concise statement of the approved behavior.
- **Approved:** YYYY-MM-DD
- **Last validated:** YYYY-MM-DD
- **Supersedes / conflicts:** Rule ID or `none`.
- **Retirement reason:** Reason and replacement Rule ID, or `none` while active.
```

Use stable rule IDs. Never reuse an ID, even after deprecation.

## Promotion

When a candidate is approved:

1. Add the executable rule to its target personal skill.
2. Mark the candidate `promoted` and record the Rule ID and resolution date.
3. Add an `active` registry entry.
4. Run repository validation and behavior checks.
5. Set `Last validated` only after the checks pass.

## Review and retirement

Review a registered rule when new evidence contradicts it, its target workflow changes, or it has not been validated in its current context.

For deprecation or replacement:

1. Show the affected rule, evidence, target diff, and proposed replacement if any.
2. Obtain explicit user approval.
3. Remove or replace the executable rule in its target skill.
4. Set the registry status to `deprecated` or `superseded` and record the reason.
5. Link both rule IDs when one rule supersedes another.
6. Run repository validation and behavior checks.
