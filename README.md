# Think With Me

An Agent Skill that understands the conversation, gives one clear view, identifies the next relevant step, and recommends the GPT-5.6 model and effort best suited to continue. `$think-with-me` remains the explicit and predictable path; compatible hosts may also discover it for contextual advice, comparison, and planning requests.

> **Status:** private preview. The repository is prepared for a future public release but is not yet published to skills.sh.

## Install after public release

Once this repository is public, install the skill with:

```bash
npx skills add igortice/think-with-me --skill think-with-me
```

Then invoke `$think-with-me` when you want to reason through a change before execution.

## What it does

Think With Me uses the conversation as context, separates facts from choices, and answers naturally before ending with three compact fields: `Minha visão`, `Próximo passo`, and `Modelo`. Those fields render together in one Markdown blockquote with a visible vertical bar. The next step advances one dependency from the current objective; when it is a user decision, the skill gives its recommended answer and asks one focused question. It keeps internal bookkeeping out of the answer unless that bookkeeping is the subject being discussed.

## What it does not do

The skill may inspect supplied context with read-only tools, but it does not edit files, create branches, change external services, install dependencies, or execute an implementation while the user is still thinking through the subject. It does not use benchmark costs to predict a Codex quota.

## Repository layout

The installable artifact is [skills/think-with-me](skills/think-with-me/). It is deliberately small:

- `SKILL.md` contains the conversational and closing contract.
- `references/model-routing.md` contains the small conversation-only routing table.
- `references/output-contract.md` contains examples that separate the conclusion, next step, and short model recommendation.

The repository root contains human-facing documentation, evaluation cases, and maintainer utilities. They are intentionally outside the installable skill folder.

## Validation

Run the structural validation:

```bash
bash scripts/validate-structure.sh
```

Before a behavioral evaluation, identify the candidate being tested:

```bash
bash scripts/candidate-manifest.sh
```

Then use the [behavior cases](evals/think-with-me-cases.md) after behavior changes and the [trigger cases](evals/trigger-cases.md) after changing the frontmatter description. Record the real result with the evidence template, then run `bash tests/evidence-gate-v1.sh`; it checks the static contract and that the current package hash appears in the completed behavior evidence. A structural pass alone does not prove conversational behavior. The cases are intentionally outside the installable skill folder.

## Maintainer review gate

The repository source is canonical. All changes remain local until the user has reviewed the diff. A commit, push, global synchronization, GitHub visibility change, and publication are separate state-changing actions: none happens until the user explicitly authorizes that specific step after review.

For a local Codex installation, only after approved synchronization:

```bash
npx --yes skills update -g think-with-me -y
bash scripts/verify-global-install.sh
```

The verification script is read-only. Do not update the global copy before the local diff has been reviewed and approved.

## Publication

This repository uses the [MIT License](LICENSE). It does not need `skills.sh.json` while it contains one skill; that file only becomes useful when the repository needs to group multiple skills on its skills.sh page.

See the [public-release runbook](docs/release/skills-sh-publication.md) for the deliberate sequence from local review to skills.sh verification.

## Evidence and design

- [Design specification](docs/specs/2026-07-17-think-with-me-design.md)
- [Reliability correction](docs/specs/2026-07-17-think-with-me-reliability-correction.md)
- [Public-release readiness plan](docs/plans/2026-07-17-public-release-readiness.md)
- [Model-routing evidence](docs/research/model-routing-evidence-2026-07-17.md)
- [Original implementation plan](docs/plans/2026-07-17-think-with-me-implementation.md)

The routing policy is a starting point. Calibrate it with representative tasks, accepted results, rework, and observed credit use.
