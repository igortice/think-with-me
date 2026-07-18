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
> _Model for the next step: **Terra High** — define the contract outputs while the rule remains under discovery._

The three labels follow the language of the current user message while preserving the same roles: view, next step, and model recommendation.

## Install for Codex

```bash
npx skills add igortice/think-with-me --skill think-with-me -g -a codex
```

## Use it

Invoke the skill when you want to reason before execution:

```text
$think-with-me Help me compare these rollout options before changing anything.
```

Compatible hosts can also discover it from a matching request for contextual planning or a decision before action.

## Language, compatibility, and boundaries

Think With Me is designed for Codex conversations that can route GPT-5.6 models. Other Agent Skills-compatible hosts can load the instructions when they support the named model families and efforts.

The response language follows the current user message. The skill never infers the active model, and it does not edit files, install dependencies, change services, or begin implementation until the user gives a direct operational instruction.

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
