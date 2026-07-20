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

See the full [portable comparison](skills/think-with-me/references/model-comparison.md) for limitations, decision guidance, and the refresh contract.

The tables define an evidence portfolio, not a permanent default. The skill rebuilds the eligible set for each immediate next step, then uses the applicable domain, required quality, total task cost, uncertainty, tokens, steps, latency, retries, and conversation health to recommend one atomic configuration. That is why `Sol Max`, `Sol XHigh`, `Terra Max`, `Sol High`, or `Luna Max` may each be correct in a different matched situation, while lower-cost routes remain gated by boundedness and verification.

For ordinary conversation, Think With Me uses a separate provisional policy
matrix rather than pretending either benchmark measures Portuguese dialogue.
Bounded status confirmation can use `Sol Medium`; long exploration that will be
reviewed can pilot `Terra Max`; long cost-sensitive drafting that will be
reviewed can pilot `Luna Max`; compact consequential judgment uses `Sol High`;
material residual ambiguity can use `Sol XHigh`; explicit maximum depth can use
`Sol Max`; and closed mechanical volume can pilot `Luna Medium`. A resolved
subject does not create a fake push, publication, or review step merely to
justify the footer.


## What a response looks like

Centralizing first keeps the rule easy to correct while we are still learning its boundaries.

> **My view:** centralize the first version because one source of truth is safer while the rule is still evolving.
>
> **Next step:** define the outputs the central contract must return.
>
> `Sol High` · define the contract outputs while the rule remains under discovery.

The view and next-step labels follow the language of the current user message. The final line is a short model label and reason, so it stays visually quiet while still explaining the recommendation.

Lower-cost recommendations apply only to bounded, verifiable work when cost, latency, or volume pressure is material. The skill filters for the required quality first and compares total task cost only among configurations that remain eligible.

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

Follow the [publication runbook](docs/release/skills-sh-publication.md) for source review, global synchronization, and skills.sh verification.

## License

[MIT](LICENSE)
