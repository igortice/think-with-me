# Model Routing for the Conversation

Recommend exactly one model and effort for the next step that has already been written. The recommendation is a diagnosis of the remaining work and the conversation's ability to converge, not a generic label for the whole conversation and not a prediction of a future phase.

## Output language

Keep the closing in the user's language. Preserve the same order: localized view, localized next step, then one compact model line. Portuguese uses `Minha visão` and `Próximo passo`; English uses `My view` and `Next step`; other languages use concise natural equivalents. The third line has no model-field label: it starts with the selected family and effort in inline code.

## Dynamic choice

Re-evaluate the recommendation whenever the conversation changes material phase: a new technical ambiguity, an irreversible or high-impact constraint, a decision that becomes settled, or a shift to cost/latency-sensitive synthesis. Do not retain Terra, Sol, or Luna by inertia.

First choose by next-step fit:

| Next-step need | Base recommendation | Decisive reason |
| --- | --- | --- |
| Understanding context, comparing options, planning, refining an idea, or writing a specification with ordinary trade-offs | **Terra High** | This is the balanced policy of this skill for connecting context, alternatives, and ordinary risk. It is not a universal OpenAI default. |
| Difficult technical reasoning, complex professional judgment, architecture, security, authorization, irreversible change, data integrity, concurrency, or a high cost of error | **Sol High** | The next step needs the frontier tier for deeper judgment. |
| Summarizing, classifying, extracting, or polishing a direction that is already clear, when cost, latency, or volume matters | **Luna Medium** | The remaining work is bounded synthesis rather than open-ended judgment. |

Then use conversation health as a modifier:

| Observable evidence | Routing effect |
| --- | --- |
| The conversation is progressing and the remaining trade-off is ordinary | Keep the base recommendation; do not escalate for novelty. |
| Corrections repeat, answers contradict the latest requirement, or framing changes have not restored convergence | Increase depth only when the next step still requires judgment; explain the failed convergence concretely. |
| The user explicitly reports unsuccessful model or effort changes | Use the outcomes as evidence. More effort on the same wrong framing is not progress. |
| Direction is accepted and only bounded transformation remains | Prefer Luna only when cost, latency, or volume is materially relevant; otherwise retain the family needed for quality and judgment. |
| Frustration or urgency appears without additional ambiguity or risk | Do not escalate from sentiment alone. Address the communication problem directly. |

Conversation health modifies next-step fit; neither signal is sufficient alone. Never infer the active model from unavailable host state. If the user states the active model or a model trajectory, treat it as evidence, not as a command to preserve or replace that model. The reasoning may consider that history, but the footer reason must summarize its outcome without naming any second family or effort.

Render one compact physical Markdown line whose reason names the actual next step and the decisive evidence. Use an inline-code model label, then ` · `, then the short reason:

```md
> `Terra High` · fechar o trade-off de ownership ainda em aberto.
> `Sol High` · integrar correções repetidas e fechar o contrato sem nova ambiguidade.
> `Luna Medium` · condensar a direção aprovada sem reabrir decisões.
> `Terra High` · resolve the remaining ownership trade-off in the user's language.
```

## Effort

Select the family first, then the effort. GPT-5.6 Sol, Terra, and Luna support `none`, `low`, `medium`, `high`, `xhigh`, and `max` in the API. Use `none` or `low` for direct transformations, `medium` for bounded analysis, and `high` for real trade-offs or multi-step reasoning. Use `XHigh` only when a first serious discussion leaves material cross-cutting ambiguity. Use `Max` only for an unusually hard, bounded problem that the user explicitly wants to pursue deeply. `Ultra` may be available in Codex for eligible access, but it is not a routine conversational default.

## Factual basis

Last reviewed: 2026-07-18.

- [OpenAI API model catalog](https://developers.openai.com/api/docs/models): Sol is the frontier model for complex reasoning and coding; Terra balances intelligence and cost; Luna is for cost-sensitive, high-volume workloads. The catalog lists reasoning through `max` for all three.
- [GPT-5.6 product availability](https://openai.com/pt-BR/index/gpt-5-6/): Codex availability and plan-dependent `max` / `ultra` options.

The line contains no second model, future transition, arrow, `agora`, `depois`, `now`, or `later`. It does not use a translated model-field label, italics, bold text, an em dash, or HTML. Recalculate it from the next step on every response; stable evidence may legitimately produce the same recommendation.
