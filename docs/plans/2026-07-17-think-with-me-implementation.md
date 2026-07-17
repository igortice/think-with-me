# Think With Me Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and install locally the manually-invoked `$think-with-me` skill that guides collaborative planning, makes a recommendation, suggests justified routing, and preserves explicit approval gates.

**Architecture:** Keep the core workflow in a concise `SKILL.md`. Put routing and output examples in two one-level-deep references, read only when relevant. Keep research and design records in `docs/`, outside the installable skill directory.

**Tech Stack:** Markdown, YAML, official `skill-creator` Python utilities, Codex global skill discovery.

## Global Constraints

- Make `$think-with-me` manual-only with `disable-model-invocation: true`.
- Recommend; never edit, execute, install, create branches, or dispatch subagents automatically.
- Treat model family, effort, and mode of work as separate decisions.
- Do not infer Codex quota from DeepSWE costs or API pricing.
- Work directly in `/Users/igortice/Desv/think-with-me`; do not create a worktree.
- Keep publication and license selection out of this local-first implementation.

---

## File structure

| Path | Responsibility |
|---|---|
| `skills/think-with-me/SKILL.md` | Trigger metadata and phase/gate workflow. |
| `skills/think-with-me/agents/openai.yaml` | UI metadata for explicit invocation. |
| `skills/think-with-me/references/model-routing.md` | Matrix, escalation, stopping and subagent criteria. |
| `skills/think-with-me/references/output-contract.md` | Conversation closure, context packet and handoff templates. |
| `README.md` | Local usage and evidence/design links. |
| `docs/specs/2026-07-17-think-with-me-design.md` | Amend publication/license scope. |

## Task 1: Initialize the installable folder

**Files:**

- Create: `skills/think-with-me/SKILL.md`
- Create: `skills/think-with-me/agents/openai.yaml`
- Create: `skills/think-with-me/references/`

**Interfaces:**

- Consumes: the name, trigger and behavior in the approved design.
- Produces: a structurally valid `think-with-me` skill folder.

- [ ] **Step 1: Run the official initializer**

Run:

```bash
python3 /Users/igortice/.codex/skills/.system/skill-creator/scripts/init_skill.py \
  think-with-me \
  --path /Users/igortice/Desv/think-with-me/skills \
  --resources references \
  --interface 'display_name=Think With Me' \
  --interface 'short_description=Plan together before acting' \
  --interface 'default_prompt=Use $think-with-me to help me understand the context, decide a direction, and define the next approved step.'
```

Expected: `skills/think-with-me/` has `SKILL.md`, `agents/openai.yaml`, and `references/`.

- [ ] **Step 2: Inspect the generated templates**

Run:

```bash
sed -n '1,220p' skills/think-with-me/SKILL.md
sed -n '1,160p' skills/think-with-me/agents/openai.yaml
```

Expected: normalized frontmatter and quoted UI values. Do not commit placeholders.

## Task 2: Write the conditional references

**Files:**

- Create: `skills/think-with-me/references/model-routing.md`
- Create: `skills/think-with-me/references/output-contract.md`

**Interfaces:**

- Consumes: design sections 5–13 and the dated evidence report.
- Produces: detailed material that `SKILL.md` opens only when necessary.

- [ ] **Step 1: Write `references/model-routing.md`**

Include:

```md
# Model Routing

## Select the phase before the model
## Choose family, effort, then work mode
## Operational matrix
## Escalate and stop
## Recommend a subagent only when independent
## Evidence boundary
```

Preserve these defaults:

| Work | Initial recommendation | Escalate only when |
|---|---|---|
| Context, understanding, normal planning | Terra High | Dependencies or ambiguity persist after a first synthesis |
| Cross-cutting spec | Terra XHigh | Critical architecture, security, migration, or operational risk needs a short Sol High review |
| Clear, repetitive investigation/documentation | Luna High | Integration or normal implementation needs Luna XHigh |
| Approved normal implementation | Luna XHigh | Work is autonomous, long, bounded, and has explicit validation, then Luna Max |
| Unknown root cause, critical design, security, migration | Sol High | A focused first analysis leaves material uncertainty, then Sol XHigh |
| Exceptional last resort | Sol Max | Never automatic |

Add warnings that DeepSWE/API cost is not a Codex quota calculator and benchmark `xhigh` is not assumed equal to the Codex product selector.

- [ ] **Step 2: Write `references/output-contract.md`**

Include the closure headings `Minha leitura`, `Minha recomendação`, `Próximo passo`, `Roteamento sugerido`, and `Gate`. Include a one-question pattern with a recommended option, direct synthesis when context suffices, a context packet, a subagent request structure, and an approved-execution handoff.

- [ ] **Step 3: Verify the references are narrow**

Run:

```bash
wc -l skills/think-with-me/references/model-routing.md skills/think-with-me/references/output-contract.md
rg -n 'DeepSWE|\$8\.39|weekly quota|créditos por' skills/think-with-me/references
```

Expected: operational instructions and evidence boundaries, not a copied benchmark report or quota promise.

## Task 3: Write the core workflow and UI metadata

**Files:**

- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/agents/openai.yaml`

**Interfaces:**

- Consumes: references from Task 2.
- Produces: a concise manual workflow with conditional reference loading.

- [ ] **Step 1: Replace `SKILL.md` with the core contract**

Use exactly this frontmatter:

```yaml
---
name: think-with-me
description: Collaboratively understand a problem or idea before acting. Use when the user wants to discuss, plan, assess options, receive a clear recommendation, identify the next step, or choose an appropriate model, effort, or subagent.
disable-model-invocation: true
---
```

Require the agent to recover project/spec context; identify phase and open decision; separate facts from user choices; ask one question only when a decision is genuinely open; synthesize directly when it is not; read `model-routing.md` for routing/escalation/subagent advice; read `output-contract.md` for material closure or a context packet; never execute/delegate automatically; and recommend `none` unless a subagent scope is independent and verifiable.

- [ ] **Step 2: Regenerate `agents/openai.yaml` deterministically**

Run:

```bash
python3 /Users/igortice/.codex/skills/.system/skill-creator/scripts/generate_openai_yaml.py \
  skills/think-with-me \
  --interface 'display_name=Think With Me' \
  --interface 'short_description=Plan together before acting' \
  --interface 'default_prompt=Use $think-with-me to help me understand the context, decide a direction, and define the next approved step.'
```

Expected: quoted fields, no icon/brand-color fields, and a default prompt naming `$think-with-me`.

- [ ] **Step 3: Check for instruction defects**

Run:

```bash
rg -n 'TODO|TBD|automaticamente.*execut|automaticamente.*deleg' skills/think-with-me
sed -n '1,260p' skills/think-with-me/SKILL.md
```

Expected: no placeholders; any automatic-execution wording is a prohibition.

## Task 4: Add repository guidance and validate

**Files:**

- Create: `README.md`
- Modify: `docs/specs/2026-07-17-think-with-me-design.md`

**Interfaces:**

- Consumes: the completed skill folder.
- Produces: a local-first repository with no documentation pollution inside the skill folder.

- [ ] **Step 1: Create the root README**

Use this structure:

```md
# Think With Me

An explicit, local-first Codex skill for collaborative planning before action.

## What it does
## What it does not do
## Local development
## Evidence and design
## Publication status
```

State that `skills/think-with-me/` is the installable folder, the repository remains private/experimental, the skill does not predict quota, and publication has not happened.

- [ ] **Step 2: Amend the design layout scope**

Change the layout section to keep `README.md` in the local-first version and defer `LICENSE` until the user explicitly chooses a public license before publication. Do not choose a license silently.

- [ ] **Step 3: Run structural validation in an isolated dependency environment**

Run:

```bash
uv run --with pyyaml python /Users/igortice/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/think-with-me
```

Expected: validator reports that the skill is valid. If `uv` is unavailable, report that rather than changing global Python.

- [ ] **Step 4: Run hygiene checks and commit**

Run:

```bash
git diff --check
git status --short
git add README.md docs/specs/2026-07-17-think-with-me-design.md skills/think-with-me
git commit -m "feat: add think-with-me skill"
```

Expected: no whitespace errors and one coherent local-first skill commit.

## Task 5: Install locally and forward-test without publishing

**Files:**

- No repository changes unless testing finds a defect.

**Interfaces:**

- Consumes: the validated skill directory.
- Produces: a discoverable local skill and evidence from three representative prompts.

- [ ] **Step 1: Inspect global skills locations without overwriting anything**

Run:

```bash
ls -ld ~/.codex/skills ~/.agents/skills 2>/dev/null
```

Expected: identify the active global convention and ensure no existing `think-with-me` folder is overwritten.

- [ ] **Step 2: Install through the supported local mechanism**

Point the discovered global skill location at `/Users/igortice/Desv/think-with-me/skills/think-with-me` using the current Codex/skills.sh local convention. Confirm the mechanism before writing outside the repository; prefer a link over a copy.

- [ ] **Step 3: Forward-test in fresh context**

Use these prompts:

```text
Use $think-with-me. I want to understand a project and decide a feature, but the decision is still open.

Use $think-with-me. The spec is approved; implement a normal change across a few files with tests.

Use $think-with-me. We have an auth migration with an unexplained production failure. What should happen next?
```

Expected: first prompt asks one decisive question or gives a bounded synthesis and recommends Terra High/XHigh without executing; second identifies approval and recommends Luna High/XHigh based on scope without editing automatically; third recommends a bounded Sol High diagnostic path without jumping to Sol Max or a code change.

- [ ] **Step 4: Treat failed forward tests as explicit design fixes**

If a prompt misses its expected behavior, revise the relevant reference or `SKILL.md`, repeat validation, and keep publication blocked until at least one real project use succeeds.

## Plan self-review

- **Spec coverage:** Tasks 1–3 implement invocation, phases, recommendation, routing, escalation, context and subagent gates. Task 4 keeps repository scope coherent. Task 5 verifies local discovery and behavior.
- **No placeholders:** every required file, command, expected result and deferred decision is explicit.
- **Consistency:** `SKILL.md` reads only two bundled references; evidence remains in `docs/research/`; no task publishes the repository or chooses a license.

## Execution decision

Use **inline execution**. The four skill files are one behavior contract; splitting them between subagents would create reconciliation risk without meaningful parallelism.

