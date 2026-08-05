---
name: how-to-get-useful-answers-to-your-questions
description: Help users actively steer technical or work conversations toward useful answers by checking their mental model, narrowing vague explanations, interrupting irrelevant tangents politely, clarifying terminology, and asking focused follow-ups. Use when an answer is confusing, overly broad, jargon-heavy, condescending, incomplete, off-topic, or fails to resolve the original question.
---

# How to Get Useful Answers to Your Questions

Help the user extract the information they need from a live or asynchronous conversation. Do not assume that a long or expert-sounding response answered the question.

Read [article-notes.md](references/article-notes.md) when diagnosing a failed conversation, coaching a sequence of follow-ups, or deciding how to interrupt and redirect constructively.

## Workflow

1. Restate the information the user originally wanted.
2. Separate facts the answer established from irrelevant material and unresolved points.
3. Identify the exact gap: wrong scope, unknown terminology, hidden assumption, missing mechanism, or unsupported conclusion.
4. Form the narrowest useful follow-up, preferably testing one concrete hypothesis.
5. If the explanation is moving away from the goal, provide a polite interruption that redirects it.
6. When new information conflicts with the user's model, pause and update the model before continuing.
7. Continue until the original question has a clear answer or the answerer explicitly reaches the limit of their knowledge.

## Follow-up patterns

### Check a model

```text
My understanding is that [A] causes [B]. Is that correct?
If only partly correct, which part needs changing?
```

### Redirect a tangent

```text
That background helps. I want to pause on one point:
does [specific mechanism] happen before or after [event]?
```

### Clarify terminology

```text
What does [term] mean in this context, and how is it different from [nearby term]?
```

### Reject a non-answer constructively

```text
I understand [fact from the response], but I still do not know [original unknown].
Could you answer this narrower question: [question]?
```

## Guidance

- Prefer yes/no or bounded questions when they reduce tangents, but invite correction of false premises.
- Interrupt politely when continuing would waste both participants' time.
- Never pretend to understand unfamiliar terminology; isolate and define it immediately.
- Do not interpret confusion as evidence that the user lacks ability. The explanation may be poorly targeted.
- Preserve useful parts of the answer before redirecting; avoid adversarial phrasing.
- Treat one reliable new fact as progress while continuing when the core question remains unanswered.

## Output

Provide:

1. **What the answer established** - supported facts only.
2. **What remains unanswered** - the exact gap.
3. **Follow-up to send** - concise, polite, and ready to use.
4. **Next branch** - an optional second question based on likely outcomes.

Based on Julia Evans's article [How to get useful answers to your questions](https://jvns.ca/blog/2021/10/21/how-to-get-useful-answers-to-your-questions/).
