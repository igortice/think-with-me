# Portable Model Quality and Cost Comparison

- [Model quality and cost at a glance](#model-quality-and-cost-at-a-glance)
- [Nearby DeepSWE choices](#nearby-deepswe-choices-that-can-change-the-decision)
- [Presentation contract](#how-to-present-the-comparison)
- [Refresh contract](#refresh-contract)

<!-- MODEL_COMPARISON_START -->
## Model quality and cost at a glance

Comparison review date: **2026-07-20**. The Artificial Analysis captures are
from 2026-07-19; the DeepSWE artifact was generated on 2026-07-17 and
preserved from the live endpoint on 2026-07-20.

These dated views explain why the skill keeps more than one useful
configuration visible. They belong to different sources and harnesses, so
they must be read separately rather than merged into a universal score.

### DeepSWE v1.1 — one software-engineering harness

DeepSWE compares long-horizon software-engineering tasks in the same
`mini-swe-agent` harness. The interval is the reported 95% run-to-run
half-width; cost, output, and steps are means from this benchmark.

| Configuration | Pass@1 | 95% interval | Mean task cost | Mean output tokens | Mean agent steps |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sol Max | 72.67% | ±2.83 pp | $8.39 | 60,014 | 61.3 |
| Sol XHigh | 70.73% | ±0.82 pp | $4.70 | 40,745 | 44.0 |
| Terra Max | 69.62% | ±2.56 pp | $4.95 | 71,939 | 75.9 |
| Sol High | 69.40% | ±1.43 pp | $3.47 | 28,450 | 36.9 |
| Luna Max | 67.19% | ±3.99 pp | $3.03 | 73,400 | 101.7 |
| GPT-5.5 High | 64.38% | ±3.12 pp | $5.10 | 31,159 | 61.9 |
| Sol Medium | 61.06% | ±1.58 pp | $1.86 | 18,425 | 30.9 |
| Terra XHigh | 60.18% | ±2.12 pp | $2.13 | 39,617 | 43.1 |
| Luna XHigh | 56.86% | ±2.17 pp | $1.54 | 44,678 | 71.1 |
| Terra High | 53.76% | ±4.33 pp | $1.13 | 21,517 | 33.5 |

Overlapping intervals leave the observed order unresolved; they do not prove equality. Sol XHigh costs $3.69, or about 44.0%, less per mean task than Sol Max while their reported intervals overlap. Sol High sits only 0.22 pp below Terra Max's point estimate at lower cost and with fewer tokens and steps. Luna Max costs slightly less than Sol High but uses substantially more output and steps.

### Artificial Analysis — a separate perspective

The Coding Index is a 50/50 aggregate of Terminal-Bench 2.1 and SciCode. The
Intelligence Index v4.1 is a separate broad index, and the approximate cost
belongs to that intelligence view.

| Configuration | Coding Index | Intelligence Index v4.1 | Approx. mean cost/task |
| --- | ---: | ---: | ---: |
| Sol XHigh | 78.3 | 57.7 | $0.68 |
| Sol Max | 77.4 | 58.9 | $1.04 |
| Sol High | 77.2 | 55.9 | $0.46 |
| Terra Max | 76.7 | 55.0 | $0.55 |
| Sol Medium | 76.3 | 53.6 | $0.31 |
| GPT-5.5 High | 71.6 | 53.1 | $0.67 |
| Luna Max | 71.4 | 51.2 | $0.21 |
| Terra XHigh | 70.6 | 51.6 | $0.32 |
| Luna XHigh | 68.6 | 49.1 | $0.15 |
| Terra High | 67.1 | 49.0 | $0.24 |

Artificial Analysis did not publish confidence intervals in the selected snapshot. Its small score gaps are therefore not treated as statistically resolved. These tables do not establish conversational equivalence.

Sources: [DeepSWE methodology](https://deepswe.datacurve.ai/blog/deepswe),
[DeepSWE v1.1 changes](https://deepswe.datacurve.ai/blog/deepswe-v1-1),
[raw DeepSWE v1.1 leaderboard](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json),
[Artificial Analysis capability-index methodology](https://artificialanalysis.ai/methodology/capability-indices),
and [Artificial Analysis coding capability](https://artificialanalysis.ai/models/capabilities/coding).
<!-- MODEL_COMPARISON_END -->

## Nearby DeepSWE choices that can change the decision

| Comparison | Observed quality difference | Mean task-cost difference | Decision meaning inside DeepSWE |
| --- | ---: | ---: | --- |
| Sol XHigh vs. Sol Max | −1.94 pp | $3.69 less, about 44.0% less | Near-top value: intervals overlap, while the higher point estimate remains available at materially higher cost. |
| Sol High vs. Terra Max | −0.22 pp | $1.48 less, about 29.9% less | Very close point estimates; Sol High also uses 43,489 fewer output tokens and 39.0 fewer steps on average. |
| Luna Max vs. Sol High | −2.21 pp | $0.44 less, about 12.7% less | Lower mean cost, but 44,950 more output tokens and 64.8 more steps on average. |

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
5. State that similarity inside one harness is not universal equivalence.
6. End with the normal think-with-me closing and exactly one model-and-effort
   configuration in its footer.

## Refresh contract

Historical snapshots are immutable. A source update creates a new dated
evidence record and a new reviewed snapshot; it never silently rewrites a
prior dated snapshot. This file is the canonical comparison record. The
Markdown block between
`MODEL_COMPARISON_START` and `MODEL_COMPARISON_END` is the canonical public
view copied into `README.md` and `SKILL.md`.

Live source endpoints last checked: **2026-07-20**. HTTP availability does not
prove that a source kept the same methodology, metric, harness, or values.

### Exact live-source views

- Artificial Analysis Coding Index filter:
  [ten configurations, intelligence tab](https://artificialanalysis.ai/?intelligence=coding-index&models=gpt-5-6-sol%2Cgpt-5-6-terra%2Cgpt-5-6-sol-xhigh%2Cgpt-5-6-sol-high%2Cgpt-5-6-sol-medium%2Cgpt-5-5-high%2Cgpt-5-6-terra-xhigh%2Cgpt-5-6-luna-xhigh%2Cgpt-5-6-terra-high%2Cgpt-5-6-luna&coding-agents=cost&cost=intelligence-vs-cost-per-task&total-cost=intelligence-vs-total-cost#intelligence-tabs).
- Artificial Analysis intelligence-versus-cost view with the same filter:
  [ten configurations, cost tab](https://artificialanalysis.ai/?intelligence=coding-index&models=gpt-5-6-sol%2Cgpt-5-6-terra%2Cgpt-5-6-sol-xhigh%2Cgpt-5-6-sol-high%2Cgpt-5-6-sol-medium%2Cgpt-5-5-high%2Cgpt-5-6-terra-xhigh%2Cgpt-5-6-luna-xhigh%2Cgpt-5-6-terra-high%2Cgpt-5-6-luna&coding-agents=cost&cost=intelligence-vs-cost-per-task&total-cost=intelligence-vs-total-cost#cost-tabs).
- DeepSWE raw v1.1 source:
  [`leaderboard-live.json`](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json).

The source repository preserves the reviewed DeepSWE JSON as
`docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json`, generated at
`2026-07-17T08:18:55.870582+00:00`, with SHA-256
`050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d`.
The binary artifact is release evidence and is not required at install time.

The Artificial Analysis filter contains exactly Sol Max, Sol XHigh, Sol High,
Sol Medium, Terra Max, Terra XHigh, Terra High, Luna Max, Luna XHigh, and
GPT-5.5 High. Preserve this set when comparing a later snapshot, or document
the model-set change explicitly.

### Source values versus derived values

- **Source values:** DeepSWE Pass@1, run-to-run interval, mean task cost,
  output tokens, and agent steps come from its raw leaderboard. Artificial
  Analysis Coding Index, Intelligence Index v4.1, and displayed approximate
  mean task cost come from the two filtered views.
- **Derived values:** absolute differences, percentage differences, interval
  overlap descriptions, and prose such as “about 44.0% less” are calculated
  from values inside one source and harness. Recalculate and review them after
  every source update.
- **Not transferable:** neither source establishes conversational equivalence,
  Codex credits, plan quotas, or universal task cost.

### Refresh sequence

1. Verify whether each live source changed its version, harness, metric,
   uncertainty definition, model identifiers, or cost meaning before copying
   new numbers.
2. Create a new dated evidence record and preserve the supporting raw artifact
   or filtered captures with hashes. Keep the previous snapshot intact.
3. Update this canonical file: revise the public block's snapshot date and
   source values, then recalculate its prose and the nearby-choice table below
   it. Do not edit either public mirror manually.
4. Run `bash scripts/sync-model-comparison.sh` from the repository root to
   update `README.md` and `skills/think-with-me/SKILL.md`.
5. Run `bash scripts/sync-model-comparison.sh --check`,
   `bash scripts/validate-skill.sh`, `bash tests/evidence-gate-v1.sh`, and
   `git diff --check` before review.
