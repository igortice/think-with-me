# Dynamic Think With Me Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `think-with-me` retain its conversational phase, recommend models dynamically, and render a compact contextual model line.

**Architecture:** Keep the behavioral contract in `SKILL.md`, the model/effort decision policy in `references/model-routing.md`, and representative output in `references/output-contract.md`. The evidence gate checks durable textual invariants, while the evaluation cases describe dynamic behavior that needs a fresh conversation check.

**Tech Stack:** Markdown skill package, Bash evidence gate, Markdown behavioral evaluations.

## Global Constraints

- Keep the close as one continuous Markdown blockquote.
- Preserve one declarative view and one immediate next dependency.
- Keep the model line visually compact: primary recommendation plus a short reason; show a conditional alternative only when relevant.
- Do not turn an approval such as “sim” into operational execution; require an explicit instruction to leave conversational mode.
- Use official OpenAI model documentation as the factual source and mark the review date.

---

### Task 1: Establish the failing contract gate

**Files:**
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the installable `SKILL.md`, routing reference, and output examples.
- Produces: a failing static check until the new compact model contract and phase-continuity rule exist.

- [x] **Step 1: Require the new behavioral language**

Add `require_text` assertions for the explicit operational-transition rule, the compact contextual model line, dynamic re-evaluation, and the optional conditional line.

- [x] **Step 2: Run the gate and verify the expected failure**

Run: `bash tests/evidence-gate-v1.sh`

Expected: FAIL because the current source still requires a model line without an explanation and has no dynamic-routing wording.

### Task 2: Implement the installable contract

**Files:**
- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/output-contract.md`

**Interfaces:**
- Consumes: the failing static gate from Task 1 and the factual correction spec.
- Produces: the new conversation boundary, routing policy, and compact rendered examples.

- [x] **Step 1: Preserve the phase through approval**

State that agreement and short follow-ups preserve `think-with-me`; an explicit operational instruction is required to leave it, and the transition must be announced.

- [x] **Step 2: Replace the model-only line**

Require `**Modelo:** **<family> <effort>** — <short contextual reason>.` and permit one italic conditional line only when a plausible transition matters.

- [x] **Step 3: Route dynamically**

Choose the primary model at each material phase: Terra High for open trade-offs, Sol High for difficult technical or critical ambiguity, and Luna Medium for already-settled cost/latency-sensitive synthesis. Describe effort escalation and sources.

- [x] **Step 4: Update examples**

Show a compact normal example, a changed-to-Sol example, and a Luna synthesis example without expanding the closing into a generic model table.

### Task 3: Align evaluations and verify behavior

**Files:**
- Modify: `evals/think-with-me-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the installable contract from Task 2.
- Produces: explicit coverage for phase continuity, a contextual model reason, and visible model transition.

- [x] **Step 1: Update invariants and cases**

Replace the old “model only” invariant with the compact contextual form. Add a case where “sim” retains the conversation and a multi-turn case where a new critical ambiguity visibly changes Terra High to Sol High.

- [x] **Step 2: Run the gate and static checks**

Run: `bash tests/evidence-gate-v1.sh && bash scripts/validate-structure.sh && git diff --check`

Expected: all checks pass with no whitespace errors.

### Task 4: Synchronize and validate the installed package

**Files:**
- Modify: global installation at `~/.agents/skills/think-with-me/` by copying the validated package.
- Modify: `.codex/project-context/CURRENT_STATE.md`, `DECISIONS.md`, and `worklog/2026-07.md` only with durable evidence from this change.

**Interfaces:**
- Consumes: a validated local package.
- Produces: a global installation matching the repository source and durable project-state evidence.

- [x] **Step 1: Synchronize the four package files**

Copy the validated local package to the global installation only after the local checks are green.

- [x] **Step 2: Re-run parity and validation**

Run: `bash scripts/verify-global-install.sh && bash tests/evidence-gate-v1.sh && git diff --check`

Expected: global parity and all local checks pass.

- [x] **Step 3: Record durable state and commit**

Update only the project-context entries that describe the accepted behavior and validation evidence. Commit the changed source, evaluations, plan, and context with a focused message.
