# Model Evidence Snapshot

Snapshot review date: **2026-07-20**.

This file is the versioned evidence source for model-routing policy. Every
result remains scoped to its own domain and harness. Values from different
sources are not averaged, normalized into a composite score, or treated as
interchangeable evidence.

## Evidence contract

### Classes

- **Official fact**: a capability, availability, effort, or price statement
  published by the model provider. It establishes what a model is designed to
  do or exposes through the API; it is not an empirical quality result.
- **Independent empirical result**: a result produced by a named external
  benchmark and reproducible only within that benchmark's domain, harness, and
  metric. It cannot by itself establish conversational quality.
- **Local behavioral result**: an observed outcome from this skill's own
  prompts, domains, acceptance criteria, and execution environment. It must
  name the tested configuration and preserve failures as well as successes.
- **Explicit user outcome**: a directly reported user experience or quality
  requirement. It can define the relevant baseline and acceptance condition,
  but it is not a published benchmark score.

Every evidence record must identify its source and source date,
configuration, domain, harness, metric, uncertainty or confidence, total task
cost when known, limitations, and the policy decision it can support. Missing
fields are recorded as unknown rather than inferred.

### Interpretation hierarchy

Evidence authority depends on the claim being made:

1. Official facts control provider positioning, supported effort levels, and
   token prices.
2. Explicit user outcomes define the historical quality baseline and what a
   successful open conversation must preserve.
3. Local behavioral results are the closest test of this skill's actual
   conversational and synthesis behavior.
4. Independent empirical results compare configurations inside their declared
   benchmark domains and harnesses.

No lower item overrides a higher item about a different kind of claim. When
sources disagree on a routing implication, preserve the disagreement and use
the conservative quality floor until a domain-matched local result resolves
it.

## Official OpenAI facts

- **Class:** official fact.
- **Source date:** 2026-07-19.
- **Sources:** [OpenAI API model catalog](https://developers.openai.com/api/docs/models)
  and [GPT-5.6 launch and availability](https://openai.com/index/gpt-5-6/).
- **Configuration:** GPT-5.6 Sol, Terra, and Luna API models.
- **Domain:** provider positioning, API reasoning-effort support, and API token
  price.
- **Harness:** none; these are provider-published product facts.
- **Metric:** published positioning, supported effort values, and USD price per
  1M tokens.
- **Uncertainty/confidence:** high confidence for the dated provider facts;
  future catalog, availability, and pricing changes are outside this snapshot.
- **Total task cost:** not established by per-token pricing. Total task cost
  also depends on token use, reasoning effort, caching, and the number of agent
  steps.
- **Limitations:** provider positioning is not comparative behavioral evidence
  and does not prove quality on this skill's Portuguese multi-turn work.
- **Supported policy decision:** use family positioning as a routing prior and
  expose only documented effort levels; require empirical or local evidence
  for quality claims.

| Family | Official positioning | Input / cached input / output per 1M tokens | Documented effort range |
| --- | --- | ---: | --- |
| Sol | Frontier family for complex professional reasoning and coding | $5 / $0.50 / $30 | `none`, `low`, `medium`, `high`, `xhigh`, `max` |
| Terra | Balances intelligence and price | $2.50 / $0.25 / $15 | `none`, `low`, `medium`, `high`, `xhigh`, `max` |
| Luna | Targets cost-sensitive, high-volume work | $1 / $0.10 / $6 | `none`, `low`, `medium`, `high`, `xhigh`, `max` |

Per-token price must never be presented as total task cost.

## Artificial Analysis snapshot

- **Class:** independent empirical result.
- **Source date:** 2026-07-19, using the user's filtered chart from that date.
- **Sources:** [Capability-index methodology](https://artificialanalysis.ai/methodology/capability-indices),
  [Coding capability page](https://artificialanalysis.ai/models/capabilities/coding),
  and [GPT-5.6 analysis](https://artificialanalysis.ai/articles/gpt-5-6-has-landed/).
- **Preserved chart artifacts:** the source repository archives the
  user-supplied filtered Coding Index capture with `SHA-256
  d0c93da184aef6abbb1c36bba9ec031c254184e2af42751cec4f5d164b242f32`
  and the Intelligence-versus-cost capture with `SHA-256
  846653101b0963757832edd10aed75ea6d962d1870d07d3611a762bef722eefc`.
  The binary captures are release evidence rather than installable runtime
  dependencies. Both came from the same 10-model filter in the user-provided
  URL, with the first capture on `#intelligence-tabs` and the second on
  `#cost-tabs`. The exact filter, both tabs, and the refresh procedure are
  preserved in the [comparison refresh contract](model-comparison.md#refresh-contract).
- **Configuration:** the ten configurations in the table below.
- **Domain:** coding capability and broad intelligence-versus-cost comparison.
- **Harness:** the Coding Index is a 50/50 aggregate of Terminal-Bench 2.1 and
  SciCode. The Intelligence Index v4.1 is a separate broad Artificial Analysis
  index; its values are displayed alongside, not combined with, the Coding
  Index.
- **Metric:** Coding Index; Intelligence Index v4.1; approximate mean cost per
  task from the filtered chart/current model pages.
- **Uncertainty/confidence:** the supplied selected chart values did not include
  confidence intervals. Costs are approximate chart values, and rank gaps must
  not be treated as statistically resolved without underlying uncertainty.
- **Total task cost:** only the approximate mean cost/task column below is
  recorded. It belongs to the broad Intelligence Index view, not to the Coding
  Index and not to this skill's workload.
- **Limitations:** the Coding Index does not evaluate Portuguese multi-turn
  decision quality. Neither external index proves conversational quality or
  baseline equivalence for this skill.
- **Supported policy decision:** Sol High supports a conservative quality floor
  across these selected broad and coding views. Sol Medium is a value candidate,
  not a baseline-equivalent route. The other sources below are still required
  before preferring Terra or a bounded-volume Luna route.

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

## DeepSWE v1.1 snapshot

- **Class:** independent empirical result.
- **Source date:** live artifact checked and preserved 2026-07-20; its
  `generated_at` value is `2026-07-17T08:18:55.870582+00:00`.
- **Sources:** [DeepSWE methodology](https://deepswe.datacurve.ai/blog/deepswe),
  [v1.1 changes](https://deepswe.datacurve.ai/blog/deepswe-v1-1),
  [reproducible repository](https://github.com/datacurve-ai/deep-swe), and
  [raw v1.1 leaderboard](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json).
- **Preserved artifact:** the source repository archives the reviewed JSON as
  `deepswe-v1.1-leaderboard-2026-07-20.json` with SHA-256
  `050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d`.
- **Configuration:** GPT-5.5 High; Sol Medium, High, XHigh, and Max; Terra High,
  XHigh, and Max; Luna XHigh and Max.
- **Domain:** 113 original long-horizon software-engineering tasks across 91
  repositories and five languages.
- **Harness:** four whole-benchmark runs per configuration, about 452 attempts,
  using the common `mini-swe-agent` bash harness with one bash tool and a shared
  prompt.
- **Metric:** Pass@1, 95% run-to-run interval, mean task cost, mean output
  tokens, and mean agent steps.
- **Uncertainty/confidence:** the table reports the artifact's 95% run-to-run
  interval as a half-width, calculated as `1.96 * std(runs) / sqrt(R)` for four
  runs. Overlapping intervals are not treated as a resolved ranking.
- **Total task cost:** mean task cost is reported directly below; it is specific
  to this benchmark execution and harness.
- **Limitations:** the common harness improves like-for-like comparison and
  isolates model capability, but it does not reproduce the native Codex harness,
  tools, or prompt tuning. It also does not measure open Portuguese
  conversation quality.
- **Supported policy decision:** Sol High is the first conservative successor
  to the historical baseline in this domain. Sol XHigh is selective depth;
  Sol Max has diminishing returns and needs an explicit deepest-reasoning gate.
  Terra Max overlaps Sol High's pass-rate interval but is materially less
  efficient. Luna Max can overlap the baseline band but is token- and
  step-heavy.

| Configuration | Pass@1 | 95% run-to-run interval | Mean task cost | Mean output tokens | Mean agent steps |
| --- | ---: | ---: | ---: | ---: | ---: |
| GPT-5.5 High | 64% | ±3.1 pp | $5.10 | 31,159 | 61.9 |
| Sol Medium | 61% | ±1.6 pp | $1.86 | 18,425 | 30.9 |
| Sol High | 69% | ±1.4 pp | $3.47 | 28,450 | 36.9 |
| Sol XHigh | 71% | ±0.8 pp | $4.70 | 40,745 | 44.0 |
| Sol Max | 73% | ±2.8 pp | $8.39 | 60,014 | 61.3 |
| Terra High | 53.8% | ±4.3 pp | $1.13 | 21,517 | 33.5 |
| Terra XHigh | 60% | ±2.1 pp | $2.13 | 39,617 | 43.1 |
| Terra Max | 70% | ±2.6 pp | $4.95 | 71,939 | 75.9 |
| Luna XHigh | 56.9% | ±2.2 pp | $1.54 | 44,678 | 71.1 |
| Luna Max | 67% | ±4.0 pp | $3.03 | 73,400 | 101.7 |

## Decision-facing comparison views

The installable [Portable Model Quality and Cost Comparison](model-comparison.md)
preserves the DeepSWE and Artificial Analysis tables as separate views. It is
a presentation layer over the evidence above, not a new benchmark or a
combined score. It travels with the skill so a downloaded installation can
show the comparison without access to repository-only research files.

The DeepSWE view keeps its Pass@1 interval, mean task cost, output tokens, and
steps together because they come from the same harness. The Artificial
Analysis view keeps Coding Index, Intelligence Index, and its approximate
mean task cost together without importing DeepSWE uncertainty. Sol Max, Sol XHigh, Terra Max, Sol High, and Luna Max remain simultaneously visible as domain-scoped candidates;
none is removed merely because another occupies a nearby quality band.

For decision support, cost differences may be calculated only within the same
source and harness. In the dated DeepSWE snapshot, `Sol XHigh` costs $3.69, or
about 44.0%, less per mean task than `Sol Max`, while their reported Pass@1
intervals overlap. This supports a software-engineering value trade-off; it
does not prove equal behavior or conversational quality.

## Explicit user outcome and baseline

- **Class:** explicit user outcome.
- **Source date:** captured 2026-07-19; the exact date range of the historical
  experience was not provided.
- **Source:** user-provided historical quality baseline.
- **Configuration:** GPT-5.5 High for normal high-quality use; XHigh was needed
  only rarely.
- **Domain:** good open conversations in the user's actual work.
- **Harness:** natural user experience, not a controlled benchmark harness.
- **Metric:** qualitative preservation or improvement of the experienced
  high-quality baseline.
- **Uncertainty/confidence:** confidence is appropriate for the user's stated
  preference, but task mix, sample count, and controlled comparison are
  unknown.
- **Total task cost:** unknown.
- **Limitations:** this outcome defines the acceptance baseline but is not a
  published benchmark score and supplies no numeric equivalence threshold.
- **Supported policy decision:** retain a conservative quality floor for
  consequential unresolved judgment, while allowing explicitly provisional
  and reviewable conversational pilots for lower-risk work.

## Local behavioral evidence status

- **Class:** local behavioral result.
- **Source date:** 2026-07-19 status snapshot.
- **Source:** no qualifying local synthesis run has been supplied yet.
- **Configuration:** Luna Medium is the configuration awaiting evidence.
- **Domain:** bounded, cost- or volume-sensitive synthesis after direction is
  already clear.
- **Harness:** pending a local prompt set and acceptance criteria for this skill.
- **Metric:** pending quality-floor pass rate, correction/retry rate, token use,
  latency, agent steps, and total task cost.
- **Uncertainty/confidence:** no empirical confidence can be assigned before the
  local run.
- **Total task cost:** unknown.
- **Limitations:** absent evidence cannot establish baseline equivalence or
  generalize Luna Medium to open-ended reasoning.
- **Supported policy decision:** only a provisional representative pilot is
  justified; full-volume use remains gated on a qualifying local synthesis run.

## Provisional conversational policy status

- **Class:** local policy hypothesis awaiting behavioral evidence.
- **Source date:** 2026-07-20.
- **Source:** explicit user requirement that the closing recommendation use the
  portfolio contextually instead of treating Sol High as a permanent default.
- **Configuration:** Sol Medium for bounded routine confirmation; Terra Max for
  long reviewable exploration; Luna Max for long reviewable drafting; Sol High
  for compact consequential judgment; Sol XHigh and Sol Max behind their
  existing ambiguity and maximum-depth gates.
- **Domain:** Portuguese day-to-day conversation using this skill.
- **Harness:** versioned runtime pressure prompts with independent review; no
  controlled comparative conversation run exists yet.
- **Metric:** correct phase classification, correction/retry rate, user
  acceptance, latency, tokens, and total task cost when exposed by the host.
- **Uncertainty/confidence:** policy confidence is sufficient for bounded pilots,
  but no conversational equivalence or superiority claim is established.
- **Total task cost:** unknown; benchmark costs cannot be transferred here.
- **Limitations:** family positioning and external benchmark results are indirect
  priors. Consequential outputs from pilot routes require review before use.
- **Supported policy decision:** use the provisional conversational matrix to
  collect local evidence without turning its routes into universal defaults.

## Cross-source interpretation

- Sol High is above GPT-5.5 High in the selected Artificial Analysis coding and
  broad views and in DeepSWE Pass@1. Together with the explicit user outcome,
  this supports it as the sustained conservative quality floor; it does not
  prove universal superiority.
- Sol Medium looks attractive on the Artificial Analysis broad cost view, but
  its advantage over the historical baseline there is small and its DeepSWE
  Pass@1 is lower. Preserve that disagreement: it is a value candidate, not a
  baseline-equivalent default.
- Sol XHigh and Max have higher DeepSWE Pass@1 point estimates than Sol High,
  but their reported intervals overlap Sol High's. Their mean cost, tokens, and
  steps are also higher. Sol XHigh is materially cheaper than Max in that
  harness and remains a near-top value candidate when the current task matches
  the measured domain. Max remains visible as the highest point estimate, but
  the evidence does not establish a statistically distinct improvement.
- Terra Max and Sol High have overlapping DeepSWE intervals, while Terra Max
  uses substantially more output tokens and agent steps and has higher mean
  task cost in that harness. Terra Max remains a domain-scoped upper-band
  candidate, but this snapshot does not establish a cost advantage or transfer
  its result to open conversation.
- Luna Max can overlap the DeepSWE baseline pass-rate band, but its high token
  and step use create a different execution trade-off. It remains a
  domain-scoped candidate when lower mean task cost matters and a longer run is
  acceptable; this does not support substituting it for the conversational
  baseline. Luna Medium has no recorded local result in this snapshot.

These are scoped deductions, not a new score. No cross-source average or
composite ranking is permitted.

## Supported policy states

These states form an open evidence portfolio, not a top-N ranking:

- Contextual upper-band candidate: `Sol Max` only behind the explicit deepest-reasoning gate when its highest observed point estimate is worth its higher cost, tokens, and steps.
- Contextual upper-band candidate: `Sol XHigh` for material residual ambiguity or a matched long-horizon value trade-off near the highest observed point estimate.
- Contextual upper-band candidate: `Terra Max` only as a representative matched-domain pilot that collects local convergence evidence; current sources establish neither a conversational nor an economic advantage.
- Provisional conversational pilot: `Terra Max` for long reviewable exploration whose output is checked before a consequential decision.
- Contextual upper-band candidate and consequential conversational quality floor: `Sol High`, especially when compact final judgment matters.
- Contextual upper-band candidate: `Luna Max` for matched long-horizon software engineering when lower mean task cost matters and substantially higher tokens, steps, and likely duration are acceptable.
- Provisional conversational pilot: `Luna Max` for long reviewable drafting when extended execution is acceptable and benchmark economics are not transferred.
- Value candidate, not baseline-equivalent: `Sol Medium`, including bounded routine confirmation whose result is reversible and cheap to verify.
- Provisional representative pilot: `Luna Medium`; full-volume use remains pending local synthesis evidence.
- Recorded without a distinct preferred role from the current sources: `Terra High`, `Terra XHigh`, and `Luna XHigh`.

The compact response footer still recommends one atomic configuration for the
current next step. When a nearby eligible option could change an informed
choice, the prose may preserve that alternative and state its measured
quality, uncertainty, and total-task-cost trade-off.

Any future change to these states must add a dated record with the same evidence
fields, preserve the original domain and harness, and explain which uncertainty
or limitation has been resolved.
