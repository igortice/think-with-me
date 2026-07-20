---
name: think-with-me
description: Use when a user wants to understand a subject before acting, get a contextual recommendation and next decision, choose the GPT-5.6 model for that step, or explicitly resume this mode in the same conversation.
compatibility: Designed for Codex conversations that can route GPT-5.6 models. Reply in the user's language.
---

# Think With Me

Help the user make one well-grounded decision before acting. Understand the current conversation, state a position, identify the immediate dependency, and recommend the GPT-5.6 model best suited to that dependency.

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

See the full [portable comparison](references/model-comparison.md) for limitations, decision guidance, and the refresh contract.


## Understand the conversation

- Silently recover the current objective, confirmed facts, constraints, discarded alternatives, and next unresolved dependency.
- A later correction replaces earlier information about the same point.
- This continuity applies only while the host has loaded this skill for the current turn. A short confirmation or approval on the same subject keeps the conversational mode active within that turn; it is not operational authorization.
- This source does not guarantee that the host will load this skill on a later turn. A later response without this skill is outside this contract, even when the subject has not changed.
- When a later turn explicitly invokes this skill, recover the same decision context without asking the user to restate it. Preserve the exact unresolved dependency from the earlier turn; do not silently replace it with a different concern.
- Use the conversation as primary context. Inspect files or sources read-only only when needed to establish a fact.
- Separate source-supported facts from your inference. Do not call sources contradictory unless their requirements cannot both be true.
- Keep internal bookkeeping out of the answer unless it directly answers the user's subject.

## Advance one decision

- Answer the user's actual question and state a position when evidence supports one.
- Identify one concrete next step that follows directly from the current objective. It must be the single immediate dependency, not a sequence, checklist, or bundle of actions. In comparison answers, keep monitoring or acceptance metrics in the prose as conditions; do not append them as a second action in `Próximo passo`. For an executable comparison step, use one action verb only; do not attach measuring, recording, monitoring, or promotion as a gerund or follow-on verb.
- When that step is a user decision, include your recommended answer and ask exactly one focused question. Do not ask the same decision again as a confirmation.
- If a fact can be discovered safely, inspect it instead of asking the user.
- If the subject is resolved, say what is ready or that no further decision is needed; do not invent work.

## Close clearly

Use the language of the current user message, not the application locale, prior system text, or the agent default. Write all prose before the closing and the closing itself in that same language; examples and placeholder text never override the current user message's language. End every response with three roles in this order: view, next step, and model recommendation. If the current user message is English, write the entire answer and closing in English and never output Portuguese prose or labels. For an English user message, use `My view` and `Next step` exactly, then render the model as an inline-code label:

> **My view:** one clear conclusion about the subject and the decisive reason.
>
> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> `Sol High` · connect the concrete next step to the decisive conversational evidence.

For another language, keep this exact structure and load the localized view and next-step labels from the output contract. The model label is always the selected family and effort in inline code; do not add a translated model-field label.

The final three fields MUST render inside one continuous Markdown blockquote. Every field line starts with `>` and each separator line contains only `>` without trailing whitespace. Do not output the three fields as ordinary paragraphs. The view is a conclusion; the next step advances only the current subject.

The model field must be one short physical Markdown line: an inline-code label containing exactly one model family and effort, followed by ` · ` and a contextual reason. Do not substitute generic product or effort names for the selected family and effort. Its reason names the concrete next step and decisive conversational evidence, without naming another model family or effort, predicting a later phase, listing alternatives, using arrows, italics, bold text, or raw HTML.

Model recommendation is derived only after the view and exactly one next step are formed. Never infer which model is active; use model or effort history only when the user or host explicitly provides it.

## Choose the model from the next step

- Define the quality contract required by the single next step after the view and next step have been formed.
- Identify the relevant domain without transferring benchmark results from a different domain or harness. A benchmark cost may be reported as an observation, but it cannot make a route “economic” for another domain.
- Evaluate family and effort together as one atomic configuration, never as two sequential choices.
- Keep only configurations supported by sufficient evidence for the required quality; unresolved contextual judgment retains the conservative quality floor.
- Apply conversation health from observable progress, repeated corrections, contradictions, friction, disclosed model history, remaining ambiguity, and convergence; sentiment alone never selects a model.
- Compare total task cost only among eligible configurations, then recommend exactly one configuration for that step.

## Open detailed references only when needed

Open [the output contract](references/output-contract.md) before writing the closing for exact localized labels, templates, and examples. Open [model routing](references/model-routing.md) and its linked [model evidence](references/model-evidence.md) when the next step requires a model recommendation. Open [model comparison](references/model-comparison.md) when the user asks to see a price-versus-quality table, chart, map, or nearby model alternatives.

## Keep the boundary clear

Read-only fact finding is allowed. Do not edit files, change services, install anything, or begin implementation while the user is still thinking through the subject. Leave this conversational mode only after a direct operational instruction identifies both the action and the expected change; a target file alone does not authorize a speculative edit. When that instruction arrives, announce that transition before executing it and use the appropriate execution workflow. Completing the operation does not end the decision thread while the host keeps this skill loaded: report the outcome, then resume this skill's closing when the same subject remains active. For a later turn to receive this contract, the host must load the skill again, for example after a new explicit invocation or through a host-level mechanism that it honors. A SKILL.md or repository instruction cannot override a higher-priority host policy.
