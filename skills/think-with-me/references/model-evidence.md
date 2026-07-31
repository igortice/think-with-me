# Current Strong-Model Policy Evidence

Policy review date: **2026-07-31**.

This file records the current evidence boundary for Think With Me. The routing
contract itself is [Evidence-Based Model Routing](model-routing.md). Historical
benchmarks remain available in the
[Historical model evidence snapshot — 2026-07-20](model-evidence-2026-07-20.md)
and the [portable comparison](model-comparison.md); neither historical source
can authorize a configuration outside the current policy.
The source review behind the corrected roles uses the repository provenance
label `gpt-5-6-price-benchmark-routing-review-2026-07-31.md`.

## Current policy authority

Every recommendation uses exactly one of these atomic pairs: `Sol Medium`,
`Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`.

All other family and effort combinations are ineligible for recommendation by
this skill. Benchmark rows may remain visible for historical comparison, but
visibility is not eligibility.

The user-defined quality contract controls the current roles:

- Luna Max is the default value route for ordinary non-consequential
  conversation, project understanding, research, explanation, and reversible
  analysis when additional startup delay is acceptable. Sol Medium is the
  explicit speed route for rapid interaction and context recovery. Sol High
  through Max cover consequential judgment, concrete residual risk, and a
  final explicitly bounded maximum-depth gate only after a narrower selective
  route did not resolve that same risk.
- Terra Max covers quality-first heterogeneous agent or tool execution with
  interdependent changes after the contract and acceptance criteria are closed.
- Luna Max also covers cost-first asynchronous, reversible, reviewable work
  that can tolerate additional latency, tokens, steps, and retries, including
  fixed-schema volume and open-ended long-horizon execution.

Luna Max cannot own consequential judgment. Its ordinary-work default depends
on accepting the observed startup-delay trade-off; when rapid interaction is
decisive, use `Sol Medium`. When both execution families satisfy a closed task,
explicit user or system priority selects quality-first `Terra Max` or
cost-first `Luna Max`.

## Current official pricing

The [official OpenAI API changelog](https://developers.openai.com/api/docs/changelog)
records that on 2026-07-30 Luna became 80% less expensive and Terra 20% less
expensive. Sol did not receive a reduction in that update.

The current OpenAI Standard API prices are US$5/30 per 1M input/output tokens
for Sol, US$2/12 for Terra, and US$0.20/1.20 for Luna. These values come from
the [official OpenAI pricing table](https://developers.openai.com/api/docs/pricing).

The current Plus local-message ranges shown by the ChatGPT/Codex pricing page
for a shared five-hour window are 10–100 for Sol, 25–200 for Terra, and
250–2,000 for Luna. They are operational ranges rather than fixed task
conversions; reasoning, context, tools, retrieval, cache, and additional weekly
limits can change actual usage.

Per-token price is not total task cost. Reasoning tokens, retries, tool steps,
latency, verification, and successful completion remain part of any economic
comparison. A lower price never weakens the quality requirement.

## Benchmark and repricing provenance

The DeepSWE trajectories for Pass@1, uncertainty, tokens, steps, duration, and
historical costs come from the preserved benchmark JSON generated at `2026-07-17T08:18:55.870582+00:00`. The lower Luna Max and Terra Max costs
visible after the 2026-07-30 official price change have different provenance:
the 2026-07-31 research review observes that they equal exactly 20% and 80% of
the preserved pre-change costs.

That report treats the visible cost change as a repricing overlay on the same
trajectories, not as a new capability run. This is a source-labeled inference:
the exact factors strongly support it, but DeepSWE does not explicitly document
the overlay mechanism. Benchmark trajectory and repriced cost must therefore
remain separately attributed.

Artificial Analysis is a separate source. Its four 2026-07-31 model-page rows
are preserved in the repository artifact
`docs/research/assets/artificial-analysis-model-pages-2026-07-31.json` with
SHA-256 `acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce`.
The capture records `America/Fortaleza`, a null retrieval time, and the explicit
limitation that the exact time of day was not recorded.

## Evidence limits

Artificial Analysis and DeepSWE measure different domains and harnesses. Their
scores are not averaged, and neither proves Portuguese conversational quality
or universal model equivalence. Current routing therefore combines:

1. the explicit six-pair quality floor chosen by the user;
2. the observable shape of the immediate next step;
3. source-scoped benchmark evidence when the task actually matches the source;
4. fresh local runtime evidence before publication.

The skill recommends a pair; it cannot select, retry, replace, or verify the
host's active model. When the host exposes a mismatch, the response reports it
without presenting an unapproved replacement as compliant.
