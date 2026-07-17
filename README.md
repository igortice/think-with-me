# Think With Me

An explicit, local-first Codex skill for collaborative planning before action.

## What it does

Think With Me helps turn a discussion into a conscious next step. It identifies the phase of work, separates facts from choices, gives the assistant's recommendation, preserves explicit approvals, and suggests a model, effort, or subagent only when a concrete next task justifies it.

## What it does not do

The skill does not execute, edit files, create branches, run commands, install dependencies, or dispatch subagents automatically. It does not use benchmark costs to predict a Codex quota.

## Local development

The installable artifact is [skills/think-with-me](skills/think-with-me/). It is deliberately small:

- SKILL.md contains the phase and explicit-approval workflow.
- references/model-routing.md contains routing, escalation, and subagent criteria.
- references/output-contract.md contains response and handoff templates.

Keep the skill private and iterate on real work before considering public distribution. Prefer a link to this directory for local installation so the active skill follows repository changes.

## Evidence and design

- [Design specification](docs/specs/2026-07-17-think-with-me-design.md)
- [Model-routing evidence](docs/research/model-routing-evidence-2026-07-17.md)
- [Implementation plan](docs/plans/2026-07-17-think-with-me-implementation.md)

The routing policy is a starting point. Calibrate it with representative tasks, accepted results, rework, and observed credit use.

## Publication status

This repository is private and experimental. It has not been published to skills.sh. A public license and publication workflow will be selected explicitly only after local use has validated the skill.
