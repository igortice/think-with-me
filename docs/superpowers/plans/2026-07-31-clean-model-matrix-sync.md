# Clean Model Matrix Synchronization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove synchronization comments from the user-facing model matrix without losing deterministic README and skill mirrors.

**Architecture:** Keep `model-comparison.md` as the clean canonical document. Extract its public body between the unique `# Model Matrix` heading and unique `Detailed evidence` link, then inject that body between technical markers that remain only in `README.md` and `SKILL.md`.

**Tech Stack:** Markdown, Bash, Git, existing repository validation scripts.

## Global Constraints

- `model-comparison.md` contains no `MODEL_COMPARISON_START` or `MODEL_COMPARISON_END` comments.
- The matrix values, model recommendations, and English-only language remain unchanged.
- README and SKILL replacement markers remain unique and ordered.
- The globally installed package must match the repository package byte-for-byte.

---

### Task 1: Make the canonical matrix clean

**Files:**
- Modify: `tests/sync-model-comparison.sh`
- Modify: `tests/current-model-documentation.sh`
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `scripts/sync-model-comparison.sh`
- Modify: `skills/think-with-me/references/model-comparison.md`
- Generated: `README.md`
- Generated: `skills/think-with-me/SKILL.md`

**Interfaces:**
- Consumes: a canonical Markdown file with one `# Model Matrix` H1 and one `[Detailed evidence](model-evidence.md)` link.
- Produces: a public matrix body injected between the existing target markers.

- [ ] **Step 1: Require a marker-free canonical source**

Update the tests to reject either synchronization marker in
`model-comparison.md`, while requiring exactly one canonical H1 and detailed
evidence link. Keep target-marker rejection fixtures for README and SKILL.

- [ ] **Step 2: Run the focused tests and confirm RED**

Run:

```bash
bash tests/sync-model-comparison.sh
bash tests/current-model-documentation.sh
```

Expected: failure because the canonical matrix still contains both technical
markers and the current script still requires them.

- [ ] **Step 3: Replace source-marker extraction**

Change `scripts/sync-model-comparison.sh` to:

1. require exactly one `# Model Matrix` line;
2. require exactly one `[Detailed evidence](model-evidence.md)` line;
3. verify H1 precedes the detailed-evidence link;
4. extract every line after the H1 and before the detailed-evidence link;
5. trim only leading and trailing blank lines;
6. wrap the extracted body with the existing markers while replacing each target.

The script must fail before writing any target when a source anchor is missing,
duplicated, reversed, or produces an empty body.

- [ ] **Step 4: Remove markers and regenerate mirrors**

Delete both synchronization comments from
`skills/think-with-me/references/model-comparison.md`, then run:

```bash
bash scripts/sync-model-comparison.sh
```

Expected: README and SKILL retain one ordered marker pair and contain the exact
clean matrix body.

- [ ] **Step 5: Verify the repository package**

Run:

```bash
bash tests/sync-model-comparison.sh
bash tests/current-model-documentation.sh
bash tests/verify-model-comparison-data.sh
bash tests/strong-model-routing-policy.sh
bash scripts/sync-model-comparison.sh --check
git diff --check
```

Expected: all commands exit 0.

- [ ] **Step 6: Commit the clean source and synchronization contract**

```bash
git add README.md docs/superpowers/plans/2026-07-31-clean-model-matrix-sync.md scripts/sync-model-comparison.sh skills/think-with-me/SKILL.md skills/think-with-me/references/model-comparison.md tests/current-model-documentation.sh tests/evidence-gate-v1.sh tests/sync-model-comparison.sh
git commit -m "fix: hide model matrix sync markers"
```

### Task 2: Synchronize and verify the installed matrix

**Files:**
- Modify: `evals/evidence-2026-07-31-value-first-routing.md`
- Modify: `evals/install-2026-07-31-value-first-routing.md`
- Modify: `tests/evidence-gate-v1.sh`
- External copy: `/Users/igortice/.agents/skills/think-with-me`

**Interfaces:**
- Consumes: the validated seven-file repository package.
- Produces: a byte-identical global installation and evidence bound to its package hash.

- [ ] **Step 1: Record the candidate identity and create a backup**

Run `bash scripts/candidate-manifest.sh`, preserve the package hash, and back up
the existing global installation under `/private/tmp` before copying files.

- [ ] **Step 2: Synchronize the seven installable files**

Copy only the package manifest files into
`/Users/igortice/.agents/skills/think-with-me`, then run:

```bash
bash scripts/verify-global-install.sh
```

Expected: exact repository/global parity.

- [ ] **Step 3: Verify the installed user view**

Open the installed `references/model-comparison.md` and require:

```text
# Model Matrix
## Which model should I use?
## Cross-checked data
```

Reject both synchronization marker strings. Confirm that the response footer
still resolves to the same absolute local matrix path.

- [ ] **Step 4: Refresh current evidence bindings**

Update the current evidence and install records with the new package hash,
candidate identity, backup path, and fresh verification identity. Update only
the corresponding exact-value assertions in `tests/evidence-gate-v1.sh`.

- [ ] **Step 5: Run the final release gates**

Run:

```bash
bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash scripts/verify-global-install.sh
bash scripts/sync-model-comparison.sh --check
git diff --check
```

Expected: all commands exit 0 and the installed matrix contains no technical
markers.

- [ ] **Step 6: Commit refreshed installation evidence**

```bash
git add evals/evidence-2026-07-31-value-first-routing.md evals/install-2026-07-31-value-first-routing.md tests/evidence-gate-v1.sh
git commit -m "test: verify clean installed matrix"
```
