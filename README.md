# Think With Me

Think through a decision before acting. Think With Me gives you a grounded view, one immediate next step, and a contextual GPT-5.6 recommendation for that step.

## Why use it

Use it when a decision needs more than a quick answer:

- Get a clear position grounded in the current conversation and safely discoverable facts.
- Advance one immediate dependency instead of receiving a backlog or generic process.
- Receive one model and effort recommendation tied to the work that remains.
- End with a compact, localized close that keeps the decision easy to scan.

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

See the full [portable comparison](skills/think-with-me/references/model-comparison.md) for limitations, decision guidance, and the refresh contract.

The tables define an evidence portfolio, not a permanent default. The skill rebuilds the eligible set for each immediate next step, then uses the applicable domain, required quality, total task cost, uncertainty, tokens, steps, latency, retries, and conversation health to recommend one atomic configuration. That is why `Sol Max`, `Sol XHigh`, `Terra Max`, `Sol High`, or `Luna Max` may each be correct in a different matched situation, while lower-cost routes remain gated by boundedness and verification.

For ordinary conversation, Think With Me uses a mandatory strong-model
allowlist rather than pretending either benchmark measures Portuguese dialogue.
The only eligible pairs are `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`,
`Terra Max`, and `Luna Max`. `Sol Medium` handles project understanding and
bounded explanation; `Sol High` handles substantive architecture and judgment;
`Sol XHigh` handles concrete residual ambiguity. `Sol Max` requires an explicitly bounded critical risk that remains unresolved after a narrower selective route; a direct request for maximum depth is insufficient. `Terra Max` requires a closed contract plus explicit quality-first priority for heterogeneous, interdependent execution. `Luna Max` requires cost-first, asynchronous, reversible work reviewed before consequence and tolerant of extra latency, tokens, steps, or retries. When both execution routes remain eligible and that priority is unknown and decisive, the skill asks one focused question and emits no model footer until the input is known. There is no silent downgrade or fallback outside this allowlist. A resolved subject does not create a fake push, publication, or review step merely to justify the footer.

This policy governs the recommendation emitted by the skill; it cannot select,
retry, replace, or verify the model used by the host. If the host reports a
model outside this allowlist, preserve the recommendation and treat the
difference as a host mismatch requiring an explicit host-level choice.


## What a response looks like

Centralizing first keeps the rule easy to correct while we are still learning its boundaries.

> **My view:** centralize the first version because one source of truth is safer while the rule is still evolving.
>
> **Next step:** define the outputs the central contract must return.
>
> `Sol High` · define the contract outputs while the rule remains under discovery.

The view and next-step labels follow the language of the current user message. The final line is a short model label and reason, so it stays visually quiet while still explaining the recommendation.

`Sol Medium` is selected by the bounded, reversible, no-hidden-judgment nature
of the immediate step; it does not require material cost, latency, or volume
pressure. Economic comparison never expands the allowlist: the skill filters
for required quality first and compares total task cost only among
configurations that remain eligible.

## Install for Codex

```bash
npx skills add igortice/think-with-me --skill think-with-me -g -a codex
```

## Use it

Invoke the skill when you want to reason before execution:

```text
$think-with-me Help me compare these rollout options before changing anything.
```

Some compatible hosts may also discover it from a matching request for contextual planning or a decision before action. Explicit `$think-with-me` is the reliable activation path.

For a short follow-up in the same decision, invoke it again and keep writing naturally:

```text
$think-with-me E isso também funcionaria no outro projeto?
```

A new explicit invocation reactivates the skill without resetting the conversation context. The user does not need to repeat the objective, confirmed facts, or prior decision.

## Language, compatibility, and boundaries

Think With Me is designed for Codex conversations that can route GPT-5.6 models. Other Agent Skills-compatible hosts can load the instructions when they support the named model families and efforts.

The response language follows the current user message. The skill never infers the active model, and it does not edit files, install dependencies, change services, or begin implementation until the user gives a direct operational instruction that identifies both the action and the expected change.

An explicitly scoped operation pauses the decision conversation; it does not end it while the host has the skill loaded. When the same subject remains active after the result is reported, Think With Me returns to its compact decision close in that loaded response. This prevents a file name alone, a short agreement, or a broad “go ahead” from becoming permission to invent a change.

The skill does not keep itself loaded in later turns. If a host treats skills as turn-scoped, invoke `$think-with-me` again or configure a host-level activation rule or hook that the host honors. A repository instruction can help only when the host follows it; it cannot override a higher-priority host policy.

## For maintainers

The installable package lives in [skills/think-with-me](skills/think-with-me/). Its core contract is in [SKILL.md](skills/think-with-me/SKILL.md); detailed templates and routing policy live in [references](skills/think-with-me/references/).

Validate a candidate before synchronizing an installed copy:

```bash
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
```

The current routing evidence is
[model-evidence.md](skills/think-with-me/references/model-evidence.md); the
immutable 2026-07-20 snapshot is
[model-evidence-2026-07-20.md](skills/think-with-me/references/model-evidence-2026-07-20.md).
Follow the [publication runbook](docs/release/skills-sh-publication.md) for
source review, global synchronization, and skills.sh verification.

## License

[MIT](LICENSE)
