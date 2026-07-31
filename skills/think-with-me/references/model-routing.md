# Evidence-Based Model Routing

Recommend exactly one model and effort for the immediate next step already
written in the response. The recommendation describes that step, not the whole
conversation and not a speculative future phase.

## Mandatory strong-model allowlist

This is a hard allowlist, not a preference. Eligible configurations are exactly
these six atomic pairs: `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`.

No other family or effort pair is eligible for recommendation. Historical
benchmark visibility never creates routing eligibility. Treat family and effort
as one configuration; never choose a family first and adjust effort afterward.

## Respect the host boundary

The skill recommends a pair; the host selects and executes the active model.
Never claim that the skill changed, retried, blocked, or verified the host
model.

If the host reports that pair as unavailable, preserve the recommendation, report the mismatch, and require an explicit host-level choice from the allowlist.
Never present an unapproved replacement as compliant and never infer
availability from host state that was not exposed.

## Form the quality contract

Form the view and exactly one next step before routing. Classify the substantive
work performed by that step using observable conditions:

- whether the step is discovery or judgment;
- whether ambiguity is ordinary or concrete and residual;
- whether failure is difficult to detect;
- whether an explicitly bounded critical risk remains unresolved after a
  narrower selective route, normally `Sol XHigh`;
- whether the user is waiting interactively or execution can run asynchronously;
- whether the output is reversible and reviewed before any consequence;
- whether execution is quality-first or cost-first;
- whether execution is heterogeneous and interdependent or fixed-schema and
  independently verifiable;
- reversibility, consequence of error, tokens, latency, retries, and review.

Sentiment, urgency, importance, prompt length, or model prestige never decides
the pair by itself.

## Use one mutually exclusive route

Choose the row whose decisive condition describes the immediate next step.
The conditions are intentionally disjoint; broad topic words such as
"architecture", "agents", or "volume" do not override the substantive work.
The rows are in decision order, not quality rank.

| Decisive condition for the immediate next step | Required configuration | Boundary |
| --- | --- | --- |
| Explicitly bounded critical risk that remains unresolved after a narrower selective route, normally `Sol XHigh` | `Sol Max` | Prior selective failure is mandatory; an explicit request for maximum depth is not sufficient. |
| Concrete residual ambiguity, conflicting constraints, repeated framing failure, or difficult-to-detect risk | `Sol XHigh` | Name the concrete ambiguity or failure that remains after selective analysis. |
| Architecture trade-off, technical specification, or other substantive professional judgment | `Sol High` | Use after enough context is known, when the response must assume a consequential position or preserve hidden constraints. |
| Quality-first heterogeneous agent execution, tool-heavy coordination, or interdependent multi-step processing after the decision contract is closed | `Terra Max` | The contract and acceptance criteria must be closed; use for execution, not project conversation or consequential judgment. |
| Latency-sensitive conversation, rapid context recovery, or reversible analysis that requires quick back-and-forth | `Sol Medium` | Response speed is decisive; escalate when the step becomes judgment, residual ambiguity, or a critical gate. |
| Ordinary non-consequential conversation, project understanding, research, explanation, or reversible analysis when additional startup delay is acceptable | `Luna Max` | This is the value route; switch to Sol Medium when rapid interaction is required. |
| Cost-first execution whose output is reversible and reviewed before consequence, including fixed-schema volume or open-ended long-horizon work, when extra latency, tokens, steps, and retries are acceptable | `Luna Max` | Cost priority, reversibility, review before consequence, and tolerance for additional execution are required. |

When both `Terra Max` and `Luna Max` could execute a closed task, the explicit
user or system priority is the discriminator: quality-first heterogeneous
execution selects `Terra Max`; cost-first reviewable execution selects `Luna
Max`. If that priority is both unknown and decisive, make it the one unresolved
dependency instead of choosing from per-token price: ask exactly one focused cost-first-versus-quality-first question and do not emit a model footer until the priority is known.

`Luna Max` is the default value route for ordinary non-consequential work
when additional startup delay is acceptable. `Sol Medium` is the explicit speed route
when rapid back-and-forth is decisive. This policy follows the
observed cost-quality trade-off without calling Luna universally superior:
Artificial Analysis still gives Sol Medium the stronger broad indices and much
lower time to first answer, while DeepSWE gives Luna Max the higher observed
Pass@1 at much lower displayed task cost.

`Luna Max` cannot own professional or consequential judgment. Stop the value
route at that boundary and recalculate, normally to `Sol High`. For
consequential cost-first execution, the output must remain reversible and
reviewed before consequence. Long duration or volume alone never overrides a
higher quality, risk, or judgment gate.

Recalculate whenever the immediate next step changes. A previous
recommendation is trajectory evidence, never a routing lock.

For a task involving agents, route only the current step. If the next step later
becomes a substantive architecture decision, residual-risk investigation, or
final critical gate, recalculate from the corresponding Sol condition. Do not
encode an orchestration workflow in this conversational skill.

## Keep evidence scoped

Official facts establish positioning, availability, effort support, and current
price. Independent benchmarks compare configurations only inside their declared
domain, harness, and metric. Local behavioral evidence is the closest test of
this skill's actual work. Explicit user outcomes define the acceptance floor.

Do not average heterogeneous benchmarks or combine them into a universal score.
Do not claim that a coding result proves universal conversational superiority,
or transfer a benchmark cost to an unrelated task. Overlapping intervals do
not prove equality. Use the combined evidence to identify value, speed, and
quality boundaries while preserving each source's domain.

A benchmark row can remain visible for historical comparison, but only the
mandatory allowlist and the current routing condition can make a pair eligible.

## Compare total task cost only after quality

First remove every pair that does not satisfy the quality contract. Only then
compare total task cost among the remaining eligible pairs. Include successful
completion, output and reasoning tokens, retries, latency, tool steps, and
verification when available.

Official price is not total task cost. Higher effort can increase token use and
latency, while a lower per-token price cannot justify a weaker quality
condition. If current pricing matters, verify the provider source rather than
relying on a dated benchmark snapshot.

When a same-harness alternative could materially change the user's choice,
describe its measured trade-off in the prose while keeping exactly one pair in
the closing. Never turn the closing into a model catalog.

## Apply conversation health precisely

Use observable progress, repeated corrections, contradictions, friction,
remaining ambiguity, and explicitly disclosed model history as evidence.
Frustration alone calls for clearer framing, not automatic escalation.

Repeated corrections select `Sol XHigh` only when they expose a concrete
cross-cutting contradiction or difficult-to-detect failure. `Sol Max` always
requires both an explicitly bounded critical risk and evidence that a narrower
selective route did not resolve it. An explicit request for maximum depth, importance, novelty, or urgency never bypasses the prior-failure requirement.

When the subject is resolved, do not invent work for the footer. State that no
additional action is needed and route the bounded confirmation actually
performed.

## Render exactly one recommendation

Keep the answer and closing in the user's language. The final model line
contains exactly one allowed atomic pair, a parenthesized localized Markdown
link to the absolute local path of the installed
`references/model-comparison.md`, then ` · ` and a short reason tied to the
immediate next step. Resolve the target relative to the loaded `SKILL.md`; do
not use GitHub, another remote URL, or a repository-relative target. The reason
does not name another pair, predict a transition, list alternatives, or claim
a host-side action.

There is one narrow routing-input exception: when both execution routes remain
eligible and cost-first versus quality-first priority is unknown and decisive,
ask the single focused priority question and omit the model footer. Resume the
normal three-field closing only after that required input is known.

Valid examples:

```md
> `Luna Max` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · compreender o projeto pela rota de melhor custo-qualidade quando a espera é aceitável.
> `Sol Medium` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · manter respostas rápidas na conversa sensível à latência.
> `Sol High` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · fechar o trade-off arquitetural que ainda exige julgamento.
> `Sol XHigh` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · reconciliar a contradição transversal que permanece difícil de detectar.
> `Sol Max` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · concluir o gate crítico cuja profundidade anterior não resolveu o problema delimitado.
> `Terra Max` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · executar com prioridade de qualidade o trabalho heterogêneo e interdependente já definido.
> `Luna Max` ([Ver matriz](/absolute/path/to/think-with-me/references/model-comparison.md)) · executar de forma assíncrona a exploração reversível e revisável orientada por custo.
```

## Factual basis and review date

Current policy reviewed: **2026-07-31**.

The normative evidence boundary is
[Current Strong-Model Policy Evidence](model-evidence.md). The current price,
benchmark, and routing analysis is recorded under the repository provenance
label `gpt-5-6-price-benchmark-routing-review-2026-07-31.md`.
Historical results remain in the
[2026-07-20 snapshot](model-evidence-2026-07-20.md) and the
[portable model comparison](model-comparison.md).
