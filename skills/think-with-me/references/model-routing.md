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
- whether maximum depth was explicitly requested or already proved necessary;
- whether execution is heterogeneous and tool-heavy or homogeneous and
  independently verifiable;
- reversibility, consequence of error, tokens, latency, retries, and review.

Sentiment, urgency, importance, prompt length, or model prestige never decides
the pair by itself.

## Use one mutually exclusive route

Choose the row whose decisive condition describes the immediate next step.
The conditions are intentionally disjoint; broad topic words such as
"architecture", "agents", or "volume" do not override the substantive work.

| Decisive condition for the immediate next step | Required configuration | Boundary |
| --- | --- | --- |
| Final critical gate requiring explicitly requested maximum depth or unresolved failure after `Sol XHigh` | `Sol Max` | Do not select for importance, novelty, or urgency alone. |
| Concrete residual ambiguity, conflicting constraints, repeated framing failure, or difficult-to-detect risk | `Sol XHigh` | The response must name the concrete ambiguity or failure. |
| Architecture trade-off, technical specification, or other substantive professional judgment | `Sol High` | Use when the response must assume a position or preserve hidden constraints. |
| Heterogeneous agent execution, tool-heavy coordination, or heavy multi-step processing after the decision contract is defined | `Terra Max` | Use for the execution step, not for project conversation or final critical judgment. |
| Homogeneous high-volume transformation with fixed schema, independent items, and cheap automatic validation | `Luna Max` | Every condition is required; no open judgment may be hidden in an item. |
| Project conversation, context recovery, architecture discovery, explanation, or bounded reversible analysis without hidden judgment | `Sol Medium` | Escalate when the next step becomes a trade-off, residual ambiguity, or critical gate. |

Recalculate whenever the immediate next step changes. A previous
recommendation is trajectory evidence, never a routing lock.

For a task involving agents, route only the current step. Execution and
tool-heavy coordination use `Terra Max`. If the next step later becomes a
substantive architecture decision, residual-risk investigation, or final
critical gate, recalculate from the corresponding Sol condition. Do not encode
an orchestration workflow in this conversational skill.

## Keep evidence scoped

Official facts establish positioning, availability, effort support, and current
price. Independent benchmarks compare configurations only inside their declared
domain, harness, and metric. Local behavioral evidence is the closest test of
this skill's actual work. Explicit user outcomes define the acceptance floor.

Do not average heterogeneous benchmarks or combine them into a universal score.
Do not transfer a coding result to Portuguese conversation, or a benchmark cost
to an unrelated task. Overlapping intervals do not prove equality. When
relevant evidence conflicts, preserve the stronger quality condition until a
domain-matched local result resolves it.

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
cross-cutting contradiction or difficult-to-detect failure. `Sol Max` requires
an explicit maximum-depth need or evidence that the selective-depth attempt did
not resolve the bounded critical problem.

When the subject is resolved, do not invent work for the footer. State that no
additional action is needed and route the bounded confirmation actually
performed.

## Render exactly one recommendation

Keep the answer and closing in the user's language. The final model line
contains exactly one allowed atomic pair followed by ` · ` and a short reason
tied to the immediate next step. The reason does not name another pair, predict
a transition, list alternatives, or claim a host-side action.

Valid examples:

```md
> `Sol Medium` · organizar o entendimento inicial do projeto sem antecipar uma decisão técnica.
> `Sol High` · fechar o trade-off arquitetural que ainda exige julgamento.
> `Sol XHigh` · reconciliar a contradição transversal que permanece difícil de detectar.
> `Sol Max` · concluir o gate crítico cuja profundidade anterior não resolveu o problema delimitado.
> `Terra Max` · executar o trabalho heterogêneo com ferramentas e múltiplas etapas já definidas.
> `Luna Max` · processar o lote homogêneo com schema fixo e validação automática.
```

## Factual basis and review date

Current policy reviewed: **2026-07-30**.

The normative evidence boundary is
[Current Strong-Model Policy Evidence](model-evidence.md). Historical results
remain in the
[2026-07-20 snapshot](model-evidence-2026-07-20.md) and the
[portable model comparison](model-comparison.md).
