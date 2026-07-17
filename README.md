# Think With Me

An Agent Skill with hybrid discovery for collaborative planning before execution. `$think-with-me` remains the explicit and predictable path; compatible hosts may also discover it for clearly planning-oriented requests. It helps a user understand context, compare options, make a clear recommendation, and define the next approved step.

> **Status:** private preview. The repository is prepared for a future public release but is not yet published to skills.sh.

## Install after public release

Once this repository is public, install the skill with:

```bash
npx skills add igortice/think-with-me --skill think-with-me
```

Then invoke `$think-with-me` when you want to reason through a change before execution.

## What it does

Think With Me turns a discussion into a conscious next step. It identifies the phase of work, separates facts from choices, gives the assistant's recommendation, and preserves explicit approvals. At a material transition — such as starting or resuming planning, a new critical risk, a subagent result, or an approved handoff — it suggests the model and effort for the relevant stage. It suggests a subagent only when there is an independent, bounded question with a verifiable output.

## What it does not do

The skill may inspect supplied context with read-only tools, but it does not edit files, create branches, change external services, install dependencies, execute an implementation, or dispatch subagents. It does not use benchmark costs to predict a Codex quota.

## Repository layout

The installable artifact is [skills/think-with-me](skills/think-with-me/). It is deliberately small:

- `SKILL.md` contains the phase and explicit-approval workflow.
- `references/model-routing.md` contains routing, escalation, and subagent criteria.
- `references/output-contract.md` contains response and handoff templates.

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

Then use the [behavior cases](evals/think-with-me-cases.md) after behavior changes and the [trigger cases](evals/trigger-cases.md) after changing the frontmatter description. Record the real result with the evidence template. A structural pass proves package integrity; it does not prove conversational behavior. The cases are intentionally outside the installable skill folder.

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
