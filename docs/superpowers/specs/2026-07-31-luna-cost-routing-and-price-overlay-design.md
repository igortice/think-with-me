# Luna Max cost routing and current-price overlay

**Status:** approved in conversation; pending written-spec review

**Date:** 31 July 2026

## Problem

The current policy correctly preserves a six-pair strong-model allowlist and
keeps interactive project conversation separate from professional judgment and
critical gates. Two parts are now stale after OpenAI's 30 July price change:

1. the public DeepSWE comparison still shows the pre-reduction mean costs of
   US$3.03 for Luna Max and US$4.95 for Terra Max, while the live leaderboard
   reprices the same trajectories preserved in the JSON generated on 17 July
   to US$0.61 and US$3.96;
2. Luna Max is eligible only for homogeneous fixed-schema volume, even though
   DeepSWE provides domain-matched evidence that it can complete open-ended,
   long-horizon software-engineering work.

The opposite overcorrection would be to make Luna Max the default for normal
conversation. Current Artificial Analysis values still place Sol Medium above
Luna Max on the broad Intelligence Index and show a much shorter time to first
answer, while no source directly evaluates the project's Portuguese
conversations.

## Goal

Update the skill so that it:

- preserves exactly `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`,
  `Terra Max`, and `Luna Max` as eligible atomic pairs;
- keeps Sol Medium as the route for latency-sensitive interactive project
  conversation without hidden professional judgment;
- expands Luna Max into a controlled cost-first route for asynchronous,
  reversible, reviewable long-horizon work, including open-ended execution;
- keeps Terra Max as the quality-first route for heterogeneous, tool-heavy
  execution after the decision contract is closed;
- displays the 30 July price overlay without rewriting immutable historical
  evidence or representing repricing as a new benchmark run;
- requires local evidence before promoting Luna Max to the default for normal
  interactive conversation.

## Approaches considered

### 1. Replace Sol Medium with Luna Max for all normal conversation

Rejected. Luna Max is dramatically cheaper and stronger in the DeepSWE slice,
but that benchmark does not measure normal conversation. The current latency
gap and lower broad Intelligence score leave a material user-experience and
quality uncertainty.

### 2. Keep the current routing and update prices only

Rejected. This would correct the economic table while preserving an unsupported
categorical claim that Luna Max is useful only for fixed-schema volume. The
open-ended DeepSWE trajectories are evidence against that restriction.

### 3. Add a controlled cost-first Luna Max route and preserve the interactive
default

Approved. This changes eligibility where the new evidence is relevant, keeps
the quality floor conservative where evidence is absent, and creates a clear
local-evaluation path for a future default change.

## Routing design

The six-pair allowlist remains unchanged. Routing still begins from the single
immediate next step and selects one atomic family-effort pair.

| Immediate next-step condition | Required pair | Boundary |
| --- | --- | --- |
| Latency-sensitive interactive project conversation, context recovery, explanation, architecture discovery, or bounded reversible analysis without hidden judgment | `Sol Medium` | Long text alone does not change the route. |
| Architecture trade-off, technical specification, or other substantive professional judgment | `Sol High` | Use when the response must assume a position or preserve hidden constraints. |
| Concrete residual ambiguity, conflicting constraints, repeated framing failure, or difficult-to-detect risk | `Sol XHigh` | Name the concrete ambiguity or failure. |
| Explicitly bounded critical risk that remains unresolved after a narrower selective route, normally `Sol XHigh` | `Sol Max` | The prior selective failure is mandatory; maximum-depth requests, importance, novelty, and urgency never bypass it. |
| Quality-first heterogeneous agent execution, tool-heavy coordination, or interdependent multi-step processing after the decision contract is closed | `Terra Max` | Do not claim a universal quality advantage; retain only while the required quality contract excludes the cost-first route or local evidence favors it. |
| Cost-first asynchronous work whose output is reversible and reviewed before consequence, including fixed-schema volume or open-ended long-horizon execution, when extra latency, tokens, steps, and retries are acceptable | `Luna Max` | No consequential judgment may be delegated; normal interactive conversation remains outside this route until the local gate passes. |

The decisive split between Terra Max and Luna Max is not “heterogeneous versus
homogeneous” by itself. It is the quality contract and operating priority:

- Terra Max is eligible when heterogeneous coordination is quality-first and
  the cheaper configuration has not satisfied the required acceptance floor.
- Luna Max is eligible when cost or credit consumption is material, the work
  can run asynchronously, output is reversible and reviewed before consequence,
  and the user accepts additional latency, tokens, steps, or retries.

When both execution routes satisfy the closed contract and the priority is
unknown and decisive, ask exactly one focused cost-first-versus-quality-first
question; no model footer is emitted until the required priority is known.

## Evidence and price-overlay design

The historical file
`skills/think-with-me/references/model-evidence-2026-07-20.md` remains byte-for-
byte immutable.

The current public comparison in
`skills/think-with-me/references/model-comparison.md` remains the canonical
block synchronized into `README.md` and `skills/think-with-me/SKILL.md`. Its
review date becomes 31 July 2026 and it must explicitly separate:

- quality, intervals, tokens, and steps from the preserved DeepSWE JSON
  generated at `2026-07-17T08:18:55.870582+00:00`;
- live repriced DeepSWE mean costs of US$0.61 for Luna Max and US$3.96 for Terra
  Max;
- the raw JSON's pre-reduction cost fields, retained as source history;
- current official OpenAI Standard prices and Codex/ChatGPT Work credit rates;
- current Artificial Analysis comparison values as a separate broad and
  latency-oriented view.

No calculation may be presented as a new benchmark execution. The comparison
must label source fields, live displayed values, and derived ratios separately.

## Local promotion gate

The skill may recommend Luna Max immediately for the controlled cost-first
route. It must not call Luna Max the normal conversational default until a
representative local evaluation establishes all of the following:

- non-inferior acceptance without editing within a three-percentage-point
  margin;
- no regression in critical errors or unauthorized actions;
- acceptable median and p95 time to first answer on the actual host surface;
- at least 70% lower cost or credit consumption per accepted conversation;
- blinded preference that is non-inferior within the same margin.

The research protocol and detailed metrics live in
`docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md`. The
runtime skill should carry only the gate and routing consequences, not the full
research narrative.

## Files affected by implementation

- `tests/strong-model-routing-policy.sh`
- `tests/evidence-gate-v1.sh`
- `evals/model-routing-cases.md`
- `evals/think-with-me-multiturn-cases.md`
- `skills/think-with-me/references/model-routing.md`
- `skills/think-with-me/references/model-evidence.md`
- `skills/think-with-me/references/model-comparison.md`
- `skills/think-with-me/references/output-contract.md`
- `skills/think-with-me/SKILL.md` and `README.md` through the existing sync
  script
- current dated evidence and installation records required by the repository
  gates

The immutable 20 July evidence snapshot is explicitly excluded from edits.

## Test design

Implementation follows skill TDD:

1. Add failing structural assertions for the new Luna Max route, price overlay,
   immutable-snapshot boundary, and local promotion gate.
2. Add failing routing cases for:
   - cost-first asynchronous open-ended work selecting Luna Max;
   - the same long work under an interactive latency requirement selecting Sol
     Medium when it remains conversational;
   - quality-first heterogeneous tool execution selecting Terra Max;
   - professional judgment inside an otherwise cheap workflow selecting a Sol
     judgment route rather than Luna Max;
   - old DeepSWE costs being forbidden in the current comparison while
     remaining present in immutable historical evidence.
3. Run the focused policy gate and confirm it fails for the missing behavior.
4. Make the smallest policy and evidence changes that satisfy the cases.
5. Run focused gates, all repository gates, exact local-source evaluator cases,
   synchronization checks, and global-install parity.

## Success criteria

The change is complete only when:

- all six and only the six approved atomic pairs remain eligible;
- Luna Max can win a cost-first, asynchronous, reversible, reviewable
  long-horizon case without requiring a fixed schema;
- Luna Max does not win a normal latency-sensitive interactive conversation or
  consequential professional judgment;
- Terra Max remains available for quality-first heterogeneous execution without
  claiming universal benchmark superiority;
- the current public view shows the post-30-July prices and the historical
  snapshot hash is unchanged;
- benchmark domain, repricing, latency, and local-promotion limitations are
  explicit;
- all structural, evidence, runtime, sync, and global-install checks pass.

## Out of scope

- Changing the host's active model automatically.
- Adding any family-effort pair outside the six-pair allowlist.
- Claiming conversational equivalence before the local gate passes.
- Re-running third-party benchmarks or rewriting their raw artifacts.
- Committing, pushing, or publishing the implementation without the repository's
  normal verification and the user's release direction.
