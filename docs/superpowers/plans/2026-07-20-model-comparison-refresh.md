# Model Comparison Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the dated Markdown comparison traceable, reproducible, and automatically synchronized across the installable skill and public documentation.

**Architecture:** Treat `skills/think-with-me/references/model-comparison.md` as the canonical public comparison. Copy its marked public block deterministically into `README.md` and `skills/think-with-me/SKILL.md`, while keeping source provenance and refresh instructions in the canonical reference.

**Tech Stack:** Markdown, POSIX-oriented Bash, existing repository evidence gates.

## Global Constraints

- Preserve the DeepSWE and Artificial Analysis tables as separate source-specific views.
- Preserve the 2026-07-19 snapshot; future refreshes create a new dated evidence record.
- Keep the comparison installable and readable without repository-only assets.
- Do not commit before the user-requested final review.

---

### Task 1: Canonical comparison and refresh contract

**Files:**
- Modify: `skills/think-with-me/references/model-comparison.md`
- Modify: `README.md`
- Modify: `skills/think-with-me/SKILL.md`

**Interfaces:**
- Consumes: the verified 2026-07-19 DeepSWE artifact and Artificial Analysis ten-model filtered captures.
- Produces: one marked canonical Markdown block and two byte-equivalent public mirrors.

- [x] **Step 1: Add stable begin/end markers around the canonical public block.**
- [x] **Step 2: Put direct source links beneath the tables.**
- [x] **Step 3: Record the exact Artificial Analysis filtered URLs, DeepSWE raw endpoint, ten configurations, source-versus-derived field mapping, immutable-snapshot rule, and refresh sequence.**
- [x] **Step 4: Align the README and SKILL.md marked blocks with the canonical block.**

### Task 2: Deterministic synchronization

**Files:**
- Create: `scripts/sync-model-comparison.sh`
- Modify: `scripts/validate-skill.sh`

**Interfaces:**
- Consumes: `<!-- MODEL_COMPARISON_START -->` and `<!-- MODEL_COMPARISON_END -->` from the canonical reference and mirrors.
- Produces: synchronized mirrors in write mode; exit status 0 only when mirrors are current in `--check` mode.

- [x] **Step 1: Implement strict marker-count validation and canonical-block extraction.**
- [x] **Step 2: Implement atomic mirror replacement through temporary files.**
- [x] **Step 3: Implement `--check` using the same renderer and `cmp`.**
- [x] **Step 4: Add the check to the normal skill validator.**

### Task 3: Regression gates and verification

**Files:**
- Modify: `tests/evidence-gate-v1.sh`
- Create: `tests/verify-model-comparison-data.sh`
- Create: `docs/research/assets/deepswe-v1.1-leaderboard-2026-07-20.json`
- Modify: `docs/release/skills-sh-publication.md`

**Interfaces:**
- Consumes: the refresh contract and synchronization script from Tasks 1-2.
- Produces: a release gate that rejects missing provenance, incomplete refresh instructions, and diverging public tables.

- [x] **Step 1: Add failing assertions for the exact filtered URLs, raw DeepSWE endpoint, immutable-snapshot rule, source-versus-derived distinction, and sync script.**
- [x] **Step 2: Preserve the reviewed DeepSWE JSON with SHA-256 and verify all ten public rows numerically against it.**
- [x] **Step 3: Calculate and validate the SHA-256 of both preserved Artificial Analysis captures.**
- [x] **Step 4: Add the refresh-and-check command to the release runbook.**
- [x] **Step 5: Run `bash scripts/sync-model-comparison.sh --check`; expect `Model comparison mirrors are synchronized.`**
- [x] **Step 6: Run `bash scripts/validate-structure.sh`; expect `Structural validation passed.`**
- [x] **Step 7: Run `bash tests/evidence-gate-v1.sh`; expect success or only the already-known stale evidence-package hash failure, with all new assertions passing.**
- [x] **Step 8: Run `git diff --check`; expect no output.**
- [x] **Step 9: Review the complete diff without staging or committing.**
