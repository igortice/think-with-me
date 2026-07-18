# Think With Me

Think through a decision before acting: get a clear position, identify one immediate next step, and receive a contextual GPT-5.6 model recommendation for that step.

Designed for Codex conversations where the quality of the next decision matters more than moving quickly with an unexamined assumption.

## What you get

- A real point of view grounded in the current conversation and any safely discoverable facts.
- One immediate dependency instead of a backlog, checklist, or generic process.
- Exactly one GPT-5.6 model and effort recommendation for that dependency.
- A compact closing that adapts its labels to the user's language while retaining the same order: view, next step, then model.

## Example

Centralizing first keeps the rule easy to correct while we are still learning its boundaries.

> **My view:** centralize the first version because one source of truth is safer while the rule is still evolving.
>
> **Next step:** define the outputs the central contract must return.
>
> _Model for the next step: **Terra High** — define the contract outputs while the rule remains under discovery._

For Portuguese conversations, the same closing uses `Minha visão`, `Próximo passo`, and `Modelo para o próximo passo`.

## Install

Install it globally for Codex:

```bash
npx skills add igortice/think-with-me --skill think-with-me -g -a codex
```

Or omit `-g -a codex` to let the Skills CLI choose the detected supported agent and scope:

```bash
npx skills add igortice/think-with-me --skill think-with-me
```

## Use it

Invoke it explicitly when you want to reason before execution:

```text
$think-with-me Help me compare these rollout options before changing anything.
```

It can also be discovered for requests such as:

- “Help me decide between these approaches before touching the code.”
- “Give me your view, the next decision, and the right model for this conversation.”
- “We keep correcting this plan; what should we resolve next?”

## Compatibility and boundaries

Think With Me is designed for Codex with GPT-5.6 model routing. Other Agent Skills-compatible hosts can load the instructions, but the model recommendation is useful only when the host exposes the named model families and efforts.

The skill works in the user's language. It keeps the three closing fields in one continuous Markdown blockquote, never infers the active model, and does not execute edits, installs, service changes, or other operational work until the user gives a direct instruction.

## Package layout

The installable artifact is [skills/think-with-me](skills/think-with-me/):

- [SKILL.md](skills/think-with-me/SKILL.md) contains the activation and conversation contract.
- [agents/openai.yaml](skills/think-with-me/agents/openai.yaml) supplies Codex-facing display metadata and a default prompt.
- [references/model-routing.md](skills/think-with-me/references/model-routing.md) contains the contextual routing policy.
- [references/output-contract.md](skills/think-with-me/references/output-contract.md) contains output examples in Portuguese and English.

## Maintaining the skill

Validate the package and its behavioral evidence before synchronizing an installed copy:

```bash
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
```

The [publication runbook](docs/release/skills-sh-publication.md) separates source review, repository visibility, the first public installation, and skills.sh verification. These remain distinct actions.

## License

[MIT](LICENSE)
