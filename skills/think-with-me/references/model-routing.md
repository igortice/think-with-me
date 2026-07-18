# Model Routing for the Conversation

Recommend the model for the next material phase of the conversation, not for an imagined implementation. Recommend exactly one primary model and effort, then explain it briefly in the final block, such as `**Modelo:** **Terra High** — comparando trade-offs.` A conditional alternative is optional: include it only when a plausible next-phase change would help the person decide.

## Dynamic choice

Re-evaluate the recommendation whenever the conversation changes material phase: a new technical ambiguity, an irreversible or high-impact constraint, a decision that becomes settled, or a shift to cost/latency-sensitive synthesis. Do not retain Terra, Sol, or Luna by inertia. When the primary choice changes, show the previous model compactly on the same line when that transition helps explain the change.

| Conversational need | Primary recommendation | Decisive reason |
| --- | --- | --- |
| Understanding context, comparing options, planning, refining an idea, or writing a specification with ordinary trade-offs | **Terra High** | This is the balanced default of this skill for connecting context, alternatives, and ordinary risk. It is a local policy, not a universal OpenAI default. |
| Difficult technical reasoning, complex professional work, architecture, security, authorization, irreversible change, data integrity, concurrency, or a high cost of error | **Sol High** | The next discussion needs the frontier tier for deeper judgment, not merely a generic planning model. |
| Summarizing, classifying, extracting, or polishing a direction that is already clear, when cost, latency, or volume matters | **Luna Medium** | The remaining work is bounded synthesis rather than open-ended judgment. Increase to High only when that bounded work still needs multi-step checking. |

## Effort

Select the family first, then the effort. GPT-5.6 Sol, Terra, and Luna support `none`, `low`, `medium`, `high`, `xhigh`, and `max` in the API. Use `none` or `low` for direct transformations, `medium` for bounded analysis, and `high` for real trade-offs or multi-step reasoning. Use `XHigh` only when a first serious discussion leaves material cross-cutting ambiguity. Use `Max` only for an unusually hard, bounded problem that the user explicitly wants to pursue deeply. `Ultra` may be available in Codex for eligible access, but it is not a routine conversational default.

## Factual basis

Last reviewed: 2026-07-18.

- [OpenAI API model catalog](https://developers.openai.com/api/docs/models): Sol is the frontier model for complex reasoning and coding; Terra balances intelligence and cost; Luna is for cost-sensitive, high-volume workloads. The catalog lists reasoning through `max` for all three.
- [GPT-5.6 product availability](https://openai.com/pt-BR/index/gpt-5-6/): Codex availability and plan-dependent `max` / `ultra` options.

If the context does not materially change, keep the recommendation. Never describe a model as active or instruct the user to remain on it.
