---
name: how-to-ask-good-questions
description: Turn vague technical or work-related confusion into clear, answerable questions by exposing current understanding, isolating unknowns, defining goals, and choosing a suitable audience. Use when drafting or improving questions for coworkers, experts, maintainers, forums, issue trackers, code reviews, debugging help, or learning unfamiliar concepts.
---

# How to Ask Good Questions

Help the user formulate a question that is easy to answer without shaming them for incomplete research or imperfect wording. Treat basic and imperfect questions as legitimate starting points.

Read [article-notes.md](references/article-notes.md) when deeper coaching is useful, when choosing whom or how to ask, or when the question should expose hidden expert knowledge.

## Workflow

1. Identify the actual goal: learn a concept, solve a problem, verify a model, understand a decision, or obtain a specific fact.
2. Ask for the user's current understanding only when it is missing and would materially improve the question. Do not make it a prerequisite for help.
3. Isolate the smallest uncertain claim, unfamiliar term, relationship, or hidden assumption.
4. Convert broad prompts into factual, bounded, or testable questions. Split genuinely independent unknowns.
5. Include only context that changes the answer: environment, observed and expected behavior, constraints, relevant attempts, and evidence.
6. Choose an appropriate audience and communication mode when relevant. Use a quick message for a small fact and scheduled discussion for substantial knowledge transfer.
7. Return a polished question plus only the subquestions or missing context that materially improve answerability.

## Useful shapes

```text
My current understanding is: [model].
I think [A] leads to [B] because [reason].
Is that correct? If not, which step is wrong?
```

```text
Goal: [what I am trying to accomplish]
Observed: [what happened]
Expected: [what I expected]
Tried: [relevant attempts]
Question: [one precise unknown]
```

## Guidance

- Prefer questions whose answers can be checked as facts; use yes/no questions when they test a concrete hypothesis and invite correction.
- Ask for definitions and relationships before implementation details in an unfamiliar domain.
- Encourage lightweight research when it sharpens the question, but never require exhaustive research before asking.
- Preserve useful uncertainty. Do not rewrite the question so confidently that it hides what the user does not know.
- Remove irrelevant biography, apologies, urgency theater, and diagnostic dumps unless they affect the answer.
- Treat questions that reveal expert heuristics or hidden assumptions as valuable contributions.

## Output

Provide:

1. **Question to send** - concise and ready to use.
2. **Why it is answerable** - one short explanation.
3. **Missing context** - only when the omission could materially change the answer.

Based on Julia Evans's article [How to ask good questions](https://jvns.ca/blog/good-questions/).
