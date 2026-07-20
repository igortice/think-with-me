# Conversational Routing Correction Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the closing recommendation use a provisional conversational routing matrix instead of falling back to `Sol High` for nearly every ordinary conversation.

**Architecture:** Keep Artificial Analysis and DeepSWE unchanged as separate empirical views. Add a non-benchmark conversational policy layer that classifies the actual cognitive work as routine confirmation, reviewable exploration, reviewable long drafting, consequential judgment, residual ambiguity, maximum depth, or mechanical volume, then emits one contextual configuration.

**Tech Stack:** Markdown Agent Skill, Bash gates, Markdown behavioral fixtures, Git, isolated Codex runtime samples, and global package parity.

## Global Constraints

- Work directly on `main`; do not create a worktree.
- Preserve Artificial Analysis and DeepSWE as separate sources.
- Never describe the conversational matrix as benchmark evidence.
- Do not invent a future action when the current subject is resolved.
- Keep exactly one atomic configuration in the closing.
- Do not push or publish.

---

### Task 1: Establish RED conversational-routing expectations

**Files:**
- Modify: `evals/model-routing-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the approved conversational matrix in the design.
- Produces: static assertions and behavior cases that fail against the current package.

- [ ] Add MR-25 through MR-29 covering resolved status with `Sol Medium`, reviewable exploration with `Terra Max`, reviewable cost-sensitive drafting with `Luna Max`, compact consequential judgment with `Sol High`, and material repeated-framing ambiguity with `Sol XHigh`.
- [ ] Add TWM-M17 changing from routine confirmation to exploration and then consequential decision.
- [ ] Require exact policy strings for the conversational matrix, resolved-subject rule, and provisional evidence limits.
- [ ] Run `bash tests/evidence-gate-v1.sh` and verify failure on the missing conversational-matrix invariant.
- [ ] Commit with `test: require conversational model routing`.

### Task 2: Implement the conversational policy layer

**Files:**
- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/model-evidence.md`
- Modify: `skills/think-with-me/references/output-contract.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: MR-25 through MR-29 and TWM-M17.
- Produces: explicit ordinary-conversation eligibility before the conservative fallback.

- [ ] Narrow the `Sol High` floor to consequential unresolved judgment.
- [ ] Add the seven-row provisional conversational matrix and prohibit metric transfer.
- [ ] Allow `Sol Medium` for resolved, bounded, reversible confirmation without material cost pressure.
- [ ] Add `Terra Max` and `Luna Max` conversational pilot routes with mandatory review gates.
- [ ] Make resolved-subject closings describe current cognitive work instead of inventing a future task.
- [ ] Add examples for status, exploration, drafting, final judgment, and repeated corrections.
- [ ] Run structural validation and verify the evidence gate stops only at the previous package hash.
- [ ] Commit with `feat: add conversational model routing`.

### Task 3: Bind fresh runtime evidence

**Files:**
- Create: `evals/runtime-captures-2026-07-20-conversational-routing.md`
- Create: `evals/runtime-captures-2026-07-20-conversational-routing-final.md`
- Create: `evals/evidence-2026-07-20-conversational-routing.md`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the changed package and MR-25 through MR-29 plus TWM-M17.
- Produces: package-bound raw responses and independent review status.

- [ ] Generate the new package hash with `bash scripts/candidate-manifest.sh`.
- [ ] Run isolated local-candidate scenarios for all new cases and preserve unedited responses.
- [ ] Re-run any failed case after tightening the policy; never rewrite failed evidence.
- [ ] Add package and capture hashes plus the required evidence status markers.
- [ ] Obtain a separate read-only review of arithmetic, source scope, footer shape, and case claims.
- [ ] Run `bash tests/evidence-gate-v1.sh` to GREEN.
- [ ] Commit with `test: validate conversational model routing`.

### Task 4: Synchronize and verify the global package

**Files:**
- Replace exact package contents under: `/Users/igortice/.agents/skills/think-with-me/`
- Create: `evals/install-2026-07-20-conversational-routing.md`

**Interfaces:**
- Consumes: the committed package and green evidence gate.
- Produces: a globally usable skill whose source matches the repository.

- [ ] Run pre-install validation and confirm a clean branch.
- [ ] Copy only the installable package files to the global target.
- [ ] Run `bash scripts/verify-global-install.sh`.
- [ ] Run a fresh global smoke test that changes from resolved status to reviewable exploration and then consequential judgment.
- [ ] Record the unedited response and parity result.
- [ ] Commit with `docs: record conversational routing install`.

## Final Verification

Run fresh:

```bash
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash scripts/verify-global-install.sh
bash -n scripts/candidate-manifest.sh scripts/sync-model-comparison.sh scripts/validate-skill.sh scripts/validate-structure.sh scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh tests/sync-model-comparison.sh tests/verify-model-comparison-data.sh
git diff --check
git status --short --branch
```

Expected: every command exits `0`, global parity passes, the branch is clean and ahead of `origin/main`, and no push has occurred.
