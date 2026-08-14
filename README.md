# Think With Me

Think through a decision before acting. Think With Me gives you a grounded view, one immediate next step, and a contextual GPT-5.6 recommendation for that step.

## Why use it

Use it when a decision needs more than a quick answer:

- Get a clear position grounded in the current conversation and safely discoverable facts.
- Advance one immediate dependency instead of receiving a backlog or generic process.
- Receive one model and effort recommendation tied to the work that remains.
- End with a compact, localized close that keeps the decision easy to scan.

<!-- MODEL_COMPARISON_START -->
Last reviewed: **2026-07-31**.

## Which model should I use?

| Situation | Model |
| --- | --- |
| Ordinary conversation, project understanding, research, or reversible analysis when extra startup delay is acceptable | `Luna Max` |
| Fast interactive conversation or rapid context recovery | `Sol Medium` |
| Architecture, technical specification, or professional judgment | `Sol High` |
| Quality-first agents, tools, or interdependent execution with a closed contract | `Terra Max` |
| Residual ambiguity, conflicting constraints, or hard-to-detect risk | `Sol XHigh` |
| A bounded critical problem still unresolved after `Sol XHigh` | `Sol Max` |

## Cross-checked data

| Model | DeepSWE Pass@1 | DeepSWE trajectory cost after price overlay | AA Intelligence Index v4.1 | AA time to first answer |
| --- | ---: | ---: | ---: | ---: |
| Sol Max | 72.67% | $8.39 | — | — |
| Sol XHigh | 70.73% | $4.70 | — | — |
| Terra Max | 69.62% | $3.96 | 54.95 | 152.99 s |
| Sol High | 69.40% | $3.47 | 55.87 | 13.25 s |
| Luna Max | 67.19% | $0.61 | 51.24 | 117.02 s |
| Sol Medium | 61.06% | $1.86 | 53.59 | 4.31 s |

Luna Max and Terra Max costs apply the documented 31 July price overlay to
preserved DeepSWE trajectories; this is not a new benchmark run. A dash means
that the value was not captured in the selected 31 July Artificial Analysis
snapshot.

DeepSWE and Artificial Analysis use different harnesses. Do not combine the two benchmark scores into one ranking.
<!-- MODEL_COMPARISON_END -->

Open the concise [model matrix](skills/think-with-me/references/model-comparison.md) for the routing table and cross-checked values. Detailed provenance remains in [model evidence](skills/think-with-me/references/model-evidence.md).

The tables define an evidence portfolio, not a permanent default. The skill rebuilds the eligible set for each immediate next step, then uses the applicable domain, required quality, total task cost, uncertainty, tokens, steps, latency, retries, and conversation health to recommend one atomic configuration. That is why `Sol Max`, `Sol XHigh`, `Terra Max`, `Sol High`, or `Luna Max` may each be correct in a different matched situation, while lower-cost routes remain gated by boundedness and verification.

For ordinary conversation, Think With Me uses a mandatory strong-model
allowlist rather than pretending either benchmark measures Portuguese dialogue.
The only eligible pairs are `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`,
`Terra Max`, and `Luna Max`. `Luna Max` is the default value route for ordinary non-consequential work when startup delay is acceptable. `Sol Medium` is the explicit speed route for latency-sensitive project understanding and
bounded explanation; `Sol High` handles substantive architecture and judgment;
`Sol XHigh` handles concrete residual ambiguity. `Sol Max` requires an explicitly bounded critical risk that remains unresolved after a narrower selective route; a direct request for maximum depth is insufficient. `Terra Max` requires a closed contract plus explicit quality-first priority for heterogeneous, interdependent execution. `Luna Max` execution must remain reversible and be reviewed before any consequential action. When both execution routes remain eligible and that priority is unknown and decisive, the skill asks one focused question and emits no model footer until the input is known. There is no silent downgrade or fallback outside this allowlist. A resolved subject does not create a fake push, publication, or review step merely to justify the footer.

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
> `Sol High` ([View matrix](/absolute/path/to/think-with-me/references/model-comparison.md)) · define the contract outputs while the rule remains under discovery.

The view and next-step labels follow the language of the current user message. The final line is a short model label and reason, so it stays visually quiet while still explaining the recommendation.

`Sol High` is selected because defining the contract is an architectural
judgment with consequences for the implementation. Economic comparison never expands the allowlist: the skill filters
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

The model comparison reference is canonical, but its projections are
purpose-specific: this public README includes the full benchmark table, while
the always-loaded skill core includes only the six-route summary. The skill
loads benchmark and price details progressively when the conversation needs
them.

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
