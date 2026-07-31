# Portable Model Quality and Cost Comparison

- [Model quality and cost at a glance](#model-quality-and-cost-at-a-glance)
- [Nearby DeepSWE choices](#nearby-deepswe-choices-that-can-change-the-decision)
- [Presentation contract](#how-to-present-the-comparison)
- [Refresh contract](#refresh-contract)

<!-- MODEL_COMPARISON_START -->
## Model quality and cost at a glance

Comparison review date: **2026-07-31**. DeepSWE Pass@1, uncertainty, output
tokens, agent steps, and historical costs come from the preserved DeepSWE JSON generated at `2026-07-17T08:18:55.870582+00:00`; later live observations do not replace that artifact or constitute a benchmark rerun. Only the displayed Luna Max and Terra Max costs use the explicit 31 July price overlay. Artificial Analysis values are a separate 31 July snapshot.

These dated views explain why the skill keeps more than one useful
configuration visible. They belong to different sources and harnesses, so
they must be read separately rather than merged into a universal score.

### DeepSWE v1.1 — one software-engineering harness

DeepSWE compares long-horizon software-engineering tasks in the same
`mini-swe-agent` harness. The interval is the reported 95% run-to-run
half-width. Pass@1, interval, output, and steps remain means from the preserved
benchmark trajectories; the displayed cost column identifies the two repriced
rows below.

| Configuration | Pass@1 | 95% interval | Displayed mean task cost | Mean output tokens | Mean agent steps |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sol Max | 72.67% | ±2.83 pp | $8.39 | 60,014 | 61.3 |
| Sol XHigh | 70.73% | ±0.82 pp | $4.70 | 40,745 | 44.0 |
| Terra Max | 69.62% | ±2.56 pp | $3.96 | 71,939 | 75.9 |
| Sol High | 69.40% | ±1.43 pp | $3.47 | 28,450 | 36.9 |
| Luna Max | 67.19% | ±3.99 pp | $0.61 | 73,400 | 101.7 |
| GPT-5.5 High | 64.38% | ±3.12 pp | $5.10 | 31,159 | 61.9 |
| Sol Medium | 61.06% | ±1.58 pp | $1.86 | 18,425 | 30.9 |
| Terra XHigh | 60.18% | ±2.12 pp | $2.13 | 39,617 | 43.1 |
| Luna XHigh | 56.86% | ±2.17 pp | $1.54 | 44,678 | 71.1 |
| Terra High | 53.76% | ±4.33 pp | $1.13 | 21,517 | 33.5 |

**Displayed DeepSWE price overlay (31 July):** all rows except Luna Max and
Terra Max retain their historical measured cost. Raw preserved-JSON costs remain $3.03 for Luna Max and $4.95 for Terra Max.
The visible 31 July prices apply explicit factors of 0.20 for Luna Max and 0.80 for Terra Max, yielding $0.61 and $3.96. The formulas are `$3.0281 × 0.20 = $0.60562 → $0.61` and
`$4.9458 × 0.80 = $3.95664 → $3.96`. This is a reprice of the same trajectories,
not a new benchmark run.

Overlapping intervals leave the observed order unresolved; they do not prove equality. Sol XHigh costs $3.69, or about 44.0%, less per mean task than Sol Max while their reported intervals overlap. Sol High sits only 0.22 pp below Terra Max's point estimate at $0.49 less displayed cost and with fewer tokens and steps. Luna Max costs $2.86 less than Sol High at the displayed rate but uses substantially more output and steps.

**Policy boundary:** lower Luna Max cost expands eligibility for asynchronous, reversible, reviewable work; it does not prove lower interactive end-to-end latency.

### Artificial Analysis — a separate perspective

The Coding Index is a 50/50 aggregate of Terminal-Bench 2.1 and SciCode. The
Intelligence Index v4.1 is a separate broad index, and the mean cost belongs to
that intelligence view. The 31 July research report verified the four rows
below; earlier snapshot-only rows are intentionally not carried into this
current table. The machine-readable capture is
`docs/research/assets/artificial-analysis-model-pages-2026-07-31.json`, SHA-256
`acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce`.
It records `retrieved_date` `2026-07-31`, timezone `America/Fortaleza`, and
`retrieved_time` null because the exact time of day was not recorded.

| Configuration | Coding Index | Intelligence Index v4.1 | Mean cost/task | Output speed | Time to first answer |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sol High | 77.16 | 55.87 | $0.771 | 62.4 tok/s | 13.25 s |
| Terra Max | 76.66 | 54.95 | $0.733 | 131.8 tok/s | 152.99 s |
| Sol Medium | 76.26 | 53.59 | $0.514 | 54.6 tok/s | 4.31 s |
| Luna Max | 71.45 | 51.24 | $0.066 | 177.8 tok/s | 117.02 s |

Artificial Analysis did not publish confidence intervals in the selected snapshot. Its score gaps are therefore not treated as statistically resolved. Its API time-to-first-answer observations are not a measure of host-specific end-to-end interaction latency, but Luna Max's 117.02 s observation does not support calling the lower price a latency improvement. These tables do not establish conversational equivalence.

Sources: [DeepSWE methodology](https://deepswe.datacurve.ai/blog/deepswe),
[DeepSWE v1.1 changes](https://deepswe.datacurve.ai/blog/deepswe-v1-1),
[raw DeepSWE v1.1 leaderboard](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json),
[Artificial Analysis capability-index methodology](https://artificialanalysis.ai/methodology/capability-indices),
and [Artificial Analysis coding capability](https://artificialanalysis.ai/models/capabilities/coding).
The specific 31 July values and price provenance are documented in
`gpt-5-6-price-benchmark-routing-review-2026-07-31.md`.
<!-- MODEL_COMPARISON_END -->

## Nearby DeepSWE choices that can change the decision

| Comparison | Observed quality difference | Displayed task-cost difference | Decision meaning inside DeepSWE |
| --- | ---: | ---: | --- |
| Sol XHigh vs. Sol Max | −1.94 pp | $3.69 less, about 44.0% less | Near-top value: intervals overlap, while the higher point estimate remains available at materially higher cost. |
| Sol High vs. Terra Max | −0.22 pp | $0.49 less, about 12.4% less | Very close point estimates; Sol High also uses 43,489 fewer output tokens and 39.0 fewer steps on average. |
| Luna Max vs. Sol High | −2.21 pp | $2.86 less, about 82.4% less | Lower displayed cost, but 44,950 more output tokens and 64.8 more steps on average. |

Differences involving Luna Max or Terra Max use the explicit 31 July price
overlay; quality, interval, output, and step fields remain historical DeepSWE
observations.

## How to present the comparison

Use this installable reference when the user asks to see a table, chart, map,
or comparison of GPT-5.6 quality and cost. Reply in the user's language. Show
both source-specific Markdown tables, even when graphical rendering is not
available. Keep each value inside its source and harness. Do not average, normalize, or merge the two sources into a composite score.

1. Translate headings and interpretation into the user's language; preserve
   model labels, numbers, units, and source names.
2. Show both source-specific Markdown tables. Never silently choose only the
   source that favors the recommendation.
3. Explain that DeepSWE includes an uncertainty interval and Artificial
   Analysis does not provide one in this selected snapshot.
4. Surface nearby alternatives that materially change cost, uncertainty,
   output volume, or steps. Do not impose a top-N list or one model per family.
5. Label Luna Max and Terra Max displayed DeepSWE costs as a price overlay, not
   a new benchmark run.
6. State that similarity inside one harness is not universal equivalence.
7. End with the normal think-with-me closing and exactly one model-and-effort
   configuration in its footer.

## Refresh contract

Historical snapshots are immutable. A source update creates a new dated
evidence record and a new reviewed snapshot; an explicit price overlay leaves
the underlying benchmark observations unchanged and never becomes a new
benchmark execution. This file is the canonical comparison record. The
Markdown block between
`MODEL_COMPARISON_START` and `MODEL_COMPARISON_END` is the canonical public
view copied into `README.md` and `SKILL.md`.

Live source endpoints last checked: **2026-07-31**. HTTP availability does not
prove that a source kept the same methodology, metric, harness, or values.

### Exact live-source views

- Artificial Analysis verified 31 July model pages:
  [Luna Max](https://artificialanalysis.ai/models/gpt-5-6-luna/),
  [Sol Medium](https://artificialanalysis.ai/models/gpt-5-6-sol-medium/),
  [Terra Max](https://artificialanalysis.ai/models/gpt-5-6-terra/), and
  [Sol High](https://artificialanalysis.ai/models/gpt-5-6-sol-high/).
- DeepSWE raw v1.1 source:
  [`leaderboard-live.json`](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json).

The source repository preserves the reviewed DeepSWE JSON as
`docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json`, generated at
`2026-07-17T08:18:55.870582+00:00`, with SHA-256
`050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d`.
The binary artifact is release evidence and is not required at install time.

The 31 July Artificial Analysis review verified Luna Max, Sol Medium, Terra
Max, and Sol High. The exact filtered rows are preserved as
`docs/research/assets/artificial-analysis-model-pages-2026-07-31.json`, with
SHA-256
`acb5227d3825406968ebc0ca42841d46f5d1cf3b450123608f9edc06fa9ff3ce`.
Its retrieval date is `2026-07-31` in `America/Fortaleza`; the exact time of day
was not recorded and remains null. Preserve this explicitly limited set until
the same source and date verify additional rows; do not silently carry forward
earlier snapshot-only values as current data.

### Source values versus derived values

- **Source observations:** DeepSWE Pass@1, run-to-run interval, historical
  mean task cost, output tokens, and agent steps come from its raw leaderboard.
  Artificial Analysis Coding Index, Intelligence Index v4.1, mean task cost,
  output speed, and time to first answer come from the four verified 31 July
  model pages.
- **Displayed price overlay:** Luna Max and Terra Max DeepSWE costs apply the
  official 30 July factors to their raw historical costs. They are current
  displayed costs for the same benchmark trajectories, not new source
  observations or a new benchmark run.
- **Derived values:** absolute differences, percentage differences, interval
  overlap descriptions, and prose such as “about 44.0% less” are calculated
  from values inside one source and harness. Recalculate and review them after
  every source or price update.
- **Not transferable:** neither source establishes conversational equivalence,
  Codex credits, plan quotas, or universal task cost.

### Refresh sequence

1. Verify whether each live source changed its version, harness, metric,
   uncertainty definition, model identifiers, or cost meaning before copying
   new numbers.
2. Create a new dated evidence record and preserve the supporting raw artifact
   or filtered captures with hashes. Keep the previous snapshot intact.
3. Update this canonical file: revise the public block's snapshot date and
   source values, or label an explicit price overlay separately from those
   observations. Recalculate its prose and the nearby-choice table below it.
   Do not edit either public mirror manually.
4. Run `bash scripts/sync-model-comparison.sh` from the repository root to
   update `README.md` and `skills/think-with-me/SKILL.md`.
5. Run `bash scripts/sync-model-comparison.sh --check`,
   `bash scripts/validate-skill.sh`, `bash tests/evidence-gate-v1.sh`, and
   `git diff --check` before review.
