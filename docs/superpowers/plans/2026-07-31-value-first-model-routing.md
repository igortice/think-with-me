# Value-First Model Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `Luna Max` the ordinary value route, `Sol Medium` the explicit speed route, and preserve evidence-based roles for `Sol High`, `Terra Max`, `Sol XHigh`, and `Sol Max`.

**Architecture:** Keep the existing six-pair allowlist and single-recommendation output contract. Replace topic shortcuts with ordered quality, risk, execution-shape, latency, and total-cost gates; update fixtures before synchronizing the global package.

**Tech Stack:** Markdown skill package, Bash validation scripts, Git, repository/global byte-parity scripts.

## Global Constraints

- Eligible configurations remain exactly `Luna Max`, `Sol Medium`, `Sol High`, `Terra Max`, `Sol XHigh`, and `Sol Max`.
- `Luna Max` is the default value route for ordinary non-consequential work when startup delay is acceptable.
- `Sol Medium` is selected when rapid interaction or low time-to-first-answer is decisive.
- `Terra Max` remains the quality-first heterogeneous/interdependent execution route.
- `Sol Max` still requires a bounded critical risk unresolved after a narrower selective route.
- Source benchmark values remain unchanged.

---

### Task 1: Replace the old routing contract

**Files:**
- Modify: `tests/strong-model-routing-policy.sh`
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `evals/model-routing-cases.md`
- Modify: `evals/think-with-me-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/output-contract.md`
- Modify: `skills/think-with-me/references/model-comparison.md`
- Modify: `docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md`
- Generated: `skills/think-with-me/SKILL.md`, `README.md`

**Interfaces:**
- Consumes: approved value-first design and existing six-pair footer contract.
- Produces: one ordered routing table and regression fixtures for all six configurations.

- [ ] **Step 1: Write failing assertions**

Require these routes:

```text
ordinary non-consequential work + delay acceptable -> Luna Max
rapid interactive conversation -> Sol Medium
professional judgment -> Sol High
quality-first heterogeneous execution -> Terra Max
residual ambiguity -> Sol XHigh
critical risk unresolved after XHigh -> Sol Max
```

- [ ] **Step 2: Confirm RED**

Run `bash tests/strong-model-routing-policy.sh`.

Expected: FAIL because ordinary exploration still selects Sol Medium and Luna still requires asynchronous operation.

- [ ] **Step 3: Implement the approved gate order**

Use these representative footers:

```md
> `Luna Max` · compreender o projeto com a rota de melhor custo-qualidade quando a espera é aceitável.
> `Sol Medium` · manter respostas rápidas na conversa sensível à latência.
> `Sol High` · fechar o trade-off que exige julgamento profissional.
> `Terra Max` · executar o trabalho heterogêneo e interdependente com prioridade de qualidade.
> `Sol XHigh` · resolver a ambiguidade residual difícil de detectar.
> `Sol Max` · concluir o risco crítico que a análise seletiva anterior não resolveu.
```

Remove asynchronous operation as a universal Luna requirement. Keep consequential judgment outside Luna.

- [ ] **Step 4: Update interpretation and mirrors**

Run `bash scripts/sync-model-comparison.sh`.

Expected: README and SKILL mirror the canonical comparison block without changing numeric source observations.

- [ ] **Step 5: Verify Task 1**

Run:

```bash
bash tests/strong-model-routing-policy.sh
bash tests/verify-model-comparison-data.sh
bash scripts/sync-model-comparison.sh --check
git diff --check
```

Expected: all exit 0.

- [ ] **Step 6: Commit Task 1**

```bash
git add README.md docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md evals/model-routing-cases.md evals/think-with-me-cases.md evals/think-with-me-multiturn-cases.md skills/think-with-me/SKILL.md skills/think-with-me/references/model-comparison.md skills/think-with-me/references/model-routing.md skills/think-with-me/references/output-contract.md tests/evidence-gate-v1.sh tests/strong-model-routing-policy.sh
git commit -m "fix: route ordinary work by value"
```

### Task 2: Refresh evidence and global installation

**Files:**
- Create: `evals/evidence-2026-07-31-value-first-routing.md`
- Create: `evals/install-2026-07-31-value-first-routing.md`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `scripts/verify-install-record.sh`
- Modify: `tests/verify-install-record.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: finalized seven-file package and six static scenario fixtures.
- Produces: evidence bound to the new package hash, global parity, and current install record.

- [ ] **Step 1: Bind candidate evidence**

Run `bash scripts/candidate-manifest.sh`; record `PACKAGE_SHA256` and `CANDIDATE_ID` in the new evidence record. Do not rewrite historical records.

- [ ] **Step 2: Back up and synchronize global installation**

Create a recoverable backup under `/private/tmp`, synchronize only the seven installable files, and run `bash scripts/verify-global-install.sh`.

Expected: `Global think-with-me installation matches the repository source.`

- [ ] **Step 3: Verify installed behavior**

Forward-test the installed skill by name for:

```text
Luna Max -> Sol Medium -> Sol High -> Terra Max
```

Preserve evaluator identity and unedited output in the install record.

- [ ] **Step 4: Update current evidence gates**

Point verifiers to the new evidence/install records and require the new package hash, passed parity/runtime statuses, and exact four-step transition.

- [ ] **Step 5: Run the focused release suite**

```bash
bash tests/strong-model-routing-policy.sh
bash tests/verify-model-comparison-data.sh
bash scripts/verify-evidence-record.sh
bash tests/verify-install-record.sh
bash tests/evidence-gate-v1.sh
bash scripts/validate-structure.sh
bash scripts/validate-skill.sh
bash scripts/verify-global-install.sh
git diff --check
```

Expected: all exit 0.

- [ ] **Step 6: Commit Task 2**

```bash
git add evals/evidence-2026-07-31-value-first-routing.md evals/install-2026-07-31-value-first-routing.md scripts/verify-evidence-record.sh scripts/verify-install-record.sh tests/verify-install-record.sh tests/evidence-gate-v1.sh
git commit -m "test: verify value-first routing install"
```
