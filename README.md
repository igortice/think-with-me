# Think With Me

Think through a decision before acting. Think With Me gives you a grounded view, one immediate next step, and a contextual GPT-5.6 recommendation for that step.

## Why use it

Use it when a decision needs more than a quick answer:

- Get a clear position grounded in the current conversation and safely discoverable facts.
- Advance one immediate dependency instead of receiving a backlog or generic process.
- Receive one model and effort recommendation tied to the work that remains.
- End with a compact, localized close that keeps the decision easy to scan.

## What a response looks like

Centralizing first keeps the rule easy to correct while we are still learning its boundaries.

> **My view:** centralize the first version because one source of truth is safer while the rule is still evolving.
>
> **Next step:** define the outputs the central contract must return.
>
> `Terra High` · define the contract outputs while the rule remains under discovery.

The view and next-step labels follow the language of the current user message. The final line is a short model label and reason, so it stays visually quiet while still explaining the recommendation.

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
