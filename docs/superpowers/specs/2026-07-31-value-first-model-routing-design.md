# Value-First Model Routing Design

**Date:** 2026-07-31  
**Status:** approved conversational design; pending implementation  
**Scope:** `think-with-me` routing among the existing six allowed configurations

## Objective

Recalculate model recommendations from current quality, task-cost, latency, and
workload evidence instead of assigning model families to broad topic labels.
The router chooses the lowest-total-cost configuration that satisfies the
quality and operational requirements of the immediate next step.

The exact allowlist remains:

- `Luna Max`
- `Sol Medium`
- `Sol High`
- `Terra Max`
- `Sol XHigh`
- `Sol Max`

No other family or effort pair becomes eligible.

## Evidence boundary

The policy uses each source only inside its measured domain:

- official OpenAI pricing establishes current token prices and family
  positioning;
- DeepSWE compares long-horizon software-engineering execution in one shared
  agent harness;
- Artificial Analysis provides a separate broad intelligence, coding, cost,
  throughput, and time-to-first-answer perspective;
- local forward tests verify whether the written routing contract is followed.

The sources are not averaged into a universal score. Their combined role is to
identify quality floors, cost advantages, latency penalties, and operational
boundaries.

## Current comparison used by the policy

| Configuration | DeepSWE Pass@1 | Displayed DeepSWE cost | Intelligence Index | Time to first answer |
| --- | ---: | ---: | ---: | ---: |
| `Luna Max` | 67.19% | $0.61 | 51.24 | 117.02 s |
| `Sol Medium` | 61.06% | $1.86 | 53.59 | 4.31 s |
| `Sol High` | 69.40% | $3.47 | 55.87 | 13.25 s |
| `Terra Max` | 69.62% | $3.96 | 54.95 | 152.99 s |
| `Sol XHigh` | 70.73% | $4.70 | not captured | not captured |
| `Sol Max` | 72.67% | $8.39 | not captured | not captured |

Luna and Terra DeepSWE costs are the documented 31 July price overlay applied
to preserved benchmark trajectories, not a capability rerun.

## Routing algorithm

Apply the following gates in order to the immediate next step:

1. If a bounded critical risk remains unresolved after a narrower selective
   route, normally `Sol XHigh`, choose `Sol Max`.
2. If concrete residual ambiguity, conflicting constraints, repeated framing
   failure, or a difficult-to-detect risk remains, choose `Sol XHigh`.
3. If the step requires a consequential architecture trade-off, technical
   specification, or other professional judgment, choose `Sol High`.
4. If a closed execution contract requires quality-first heterogeneous agents,
   tool-heavy coordination, or interdependent processing, choose `Terra Max`.
5. If ordinary conversation, explanation, discovery, research, or reversible
   analysis requires rapid back-and-forth or low time-to-first-answer, choose
   `Sol Medium`.
6. Otherwise choose `Luna Max` for ordinary non-consequential conversation,
   project understanding, research, reversible analysis, independent volume,
   or long-running work when its additional startup delay is acceptable.

This makes `Luna Max` the default value route and `Sol Medium` the explicit
speed route. Price alone still cannot override a higher quality or risk gate.

## Configuration roles

| Immediate need | Required configuration | Decisive reason |
| --- | --- | --- |
| Ordinary conversation or analysis with no strict response-time requirement | `Luna Max` | Best observed cost/value among eligible configurations while preserving competitive quality |
| Latency-sensitive conversation or rapid interactive context recovery | `Sol Medium` | Lowest observed time to first answer in the compared set |
| Consequential architecture or professional judgment | `Sol High` | Stronger balanced intelligence with materially lower cost than the deepest Sol routes |
| Quality-first heterogeneous and interdependent execution | `Terra Max` | Execution and coordination role; not a generic claim of higher conversational intelligence than Sol High |
| Concrete residual ambiguity or difficult-to-detect risk | `Sol XHigh` | Near-top quality at substantially lower task cost than Sol Max |
| Unresolved bounded critical risk after a failed selective route | `Sol Max` | Highest observed DeepSWE quality, reserved for the final critical gate |

## Important boundaries

- `Luna Max` is eligible for ordinary conversation; it is no longer restricted
  to asynchronous batches.
- `Sol Medium` is not the universal conversational default. It is chosen when
  responsiveness is decisive.
- `Terra Max` must remain visible, but the evidence does not support calling it
  universally better than `Sol High`. Its route is quality-first heterogeneous
  execution and coordination.
- A broad word such as “architecture”, “agents”, “conversation”, or “volume”
  never decides the route without the substantive condition.
- Explicit requests for maximum depth do not bypass the prior-failure gate for
  `Sol Max`.
- Recalculate when the immediate next step changes.

## Required behavior examples

| Scenario | Expected recommendation |
| --- | --- |
| “Quero entender este projeto; posso esperar e quero o melhor custo-benefício.” | `Luna Max` |
| “Vamos conversar rapidamente, com respostas imediatas.” | `Sol Medium` |
| “Escolha entre estas duas arquiteturas e assuma o trade-off.” | `Sol High` |
| “Execute agentes e ferramentas interdependentes; qualidade é a prioridade.” | `Terra Max` |
| “Ainda existe esta contradição transversal difícil de detectar.” | `Sol XHigh` |
| “O XHigh anterior não resolveu este mesmo risco crítico que bloqueia o release.” | `Sol Max` |

## Verification

Implementation must add regression checks for all six scenarios, reject the old
universal `conversation -> Sol Medium` rule, preserve the exact allowlist, keep
benchmark provenance intact, synchronize the global install, and forward-test
at least the transition `Luna Max -> Sol Medium -> Sol High -> Terra Max` using
the installed skill by name.

## Non-goals

- Adding weaker or unreviewed model/effort pairs.
- Claiming that one benchmark proves universal model superiority.
- Repricing historical benchmark trajectories without a documented overlay.
- Encoding an autonomous multi-agent orchestration workflow in this
  conversational routing skill.
