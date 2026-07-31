# Luna Max Cost Routing and Price Overlay Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct the `think-with-me` routing policy so that `Luna Max` becomes eligible for cheap asynchronous, reversible, reviewable long-horizon execution while `Sol Medium` remains the default for latency-sensitive project conversation, and refresh the cost comparison without rewriting historical benchmark observations.

**Architecture:** Preserve the exact six-pair allowlist and split routing into three independent dimensions: interaction latency, consequence/reviewability, and execution preference. Keep benchmark quality, token, and step observations bound to their original raw artifacts; apply the official 2026-07-30 price changes as an explicit cost overlay for `Luna Max` and `Terra Max`. Route cost-first asynchronous work to `Luna Max`, quality-first heterogeneous agent execution to `Terra Max`, ordinary interactive project conversation to `Sol Medium`, and escalating professional judgment through `Sol High`, `Sol XHigh`, and `Sol Max`.

**Tech Stack:** Markdown Agent Skill, Bash semantic/data/evidence gates, Markdown behavioral fixtures, immutable JSON evidence, Codex isolated runtime evaluators, Git, and user-level skill parity verification.

## Global Constraints

- Work directly on `main`; do not create a worktree.
- Preserve exactly these six eligible atomic pairs: `Sol Medium`, `Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`.
- Preserve `skills/think-with-me/references/model-evidence-2026-07-20.md` byte-for-byte with SHA-256 `13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8`.
- Never claim that the OpenAI price update is a new benchmark run. Label raw measured quality separately from repriced cost.
- Do not make `Luna Max` the default for latency-sensitive conversation without the local promotion gate defined in the approved design.
- Do not describe `Terra Max` as universally superior to `Luna Max`; the choice is quality-first heterogeneous execution versus cost-first reviewable execution.
- Keep one atomic model configuration in each closing recommendation.
- Do not push or publish during implementation.
- Synchronize the global installation only after the local package, evidence record, and independent review are green.

---

### Task 1: Establish RED routing and repricing expectations

**Files:**
- Modify: `evals/model-routing-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Modify: `tests/strong-model-routing-policy.sh`
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `tests/verify-model-comparison-data.sh`

**Interfaces:**
- Consumes: the approved design in `docs/superpowers/specs/2026-07-31-luna-cost-routing-and-price-overlay-design.md`.
- Produces: failing static and behavioral expectations for the new `Luna Max` eligibility, the `Terra Max`/`Luna Max` priority split, and the price-overlay provenance.

- [ ] Append `MR-33` for open-ended, asynchronous, long-horizon, cost-first work whose output is reversible and reviewed before consequence; require `Luna Max`.
- [ ] Append `MR-34` for the same broad project exploration when the user is actively waiting and discussing architecture; require `Sol Medium`.
- [ ] Append `MR-35` for a closed execution contract with heterogeneous tools, interdependent changes, and a quality-first objective; require `Terra Max`.
- [ ] Append `MR-36` for a cheap workflow that still contains consequential professional judgment; require `Sol High`, not `Luna Max`.
- [ ] Append `MR-37` for a failed prior selective investigation with material residual ambiguity; require `Sol XHigh` before `Sol Max`.
- [ ] Append `TWM-M19` for a conversation that starts interactively on `Sol Medium` and becomes an asynchronous, reviewable batch on `Luna Max`.
- [ ] Append `TWM-M20` for a `Luna Max` batch that discovers a consequential judgment boundary and must return to `Sol High`.
- [ ] Append `TWM-M21` for an explicit user preference transition from cost-first `Luna Max` to quality-first heterogeneous `Terra Max` after the execution contract is closed.
- [ ] Replace the old `Luna Max` fixed-schema-only assertions in `tests/strong-model-routing-policy.sh` with assertions for both eligible subclasses: fixed-schema volume and open-ended asynchronous long-horizon work.
- [ ] Add negative assertions that reject `Luna Max` as the default for latency-sensitive interactive conversation or consequential judgment.
- [ ] Add positive assertions for the exact `Sol Medium` interactive role and the exact `Terra Max` quality-first heterogeneous role.
- [ ] Update `tests/evidence-gate-v1.sh` to require a current review date of `2026-07-31`, a visible raw-versus-repriced distinction, and references to the 2026-07-31 research report.
- [ ] Refactor `tests/verify-model-comparison-data.sh` test expectations before changing production Markdown: verify quality, uncertainty, output tokens, and steps against the preserved raw JSON; verify the displayed `Luna Max` and `Terra Max` costs through explicit `0.20` and `0.80` price factors; keep unchanged rows bound directly to their raw costs.
- [ ] Run the focused baseline and confirm RED for missing policy/overlay content, not for shell syntax:

```bash
bash -n tests/strong-model-routing-policy.sh tests/evidence-gate-v1.sh tests/verify-model-comparison-data.sh
bash tests/strong-model-routing-policy.sh
bash tests/verify-model-comparison-data.sh
bash tests/evidence-gate-v1.sh
```

- [ ] Commit the failing contract with `git add evals/model-routing-cases.md evals/think-with-me-multiturn-cases.md tests/strong-model-routing-policy.sh tests/evidence-gate-v1.sh tests/verify-model-comparison-data.sh && git commit -m "test: require cost-first Luna routing"`.

### Task 2: Implement the corrected six-pair routing policy

**Files:**
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/model-evidence.md`
- Modify: `skills/think-with-me/references/output-contract.md`
- Modify: `skills/think-with-me/SKILL.md`
- Add: `docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md`

**Interfaces:**
- Consumes: MR-33 through MR-37, TWM-M19 through TWM-M21, and the official/source evidence summarized in the approved design.
- Produces: one mutually exclusive routing policy that can distinguish cheap asynchronous execution from interactive conversation and quality-first agent execution.

- [ ] In `model-routing.md`, preserve the six-pair allowlist and define the rows in this order of decision, not as a quality ranking:
  - `Sol Medium`: latency-sensitive interactive project conversation, context recovery, explanation, architecture discovery, and bounded reversible analysis without hidden consequential judgment.
  - `Sol High`: architecture choice, professional judgment, or consequential decision after enough context is known.
  - `Sol XHigh`: concrete residual ambiguity, conflicting constraints, or difficult-to-detect material risk that remains after selective analysis.
  - `Sol Max`: final critical maximum-depth gate only after a narrower route did not resolve the explicitly bounded risk.
  - `Terra Max`: quality-first heterogeneous agent/tool execution with interdependent changes after the contract and acceptance criteria are closed.
  - `Luna Max`: cost-first asynchronous, reversible, reviewable work where additional latency, tokens, steps, or retries are acceptable, including fixed-schema volume and open-ended long-horizon execution.
- [ ] Add explicit exclusions: `Luna Max` cannot own consequential judgment and cannot become the normal interactive default merely because its per-token price is lower.
- [ ] Add the priority discriminator: if both `Terra Max` and `Luna Max` could execute the task, user/system priority selects quality-first heterogeneous execution (`Terra Max`) or cost-first reviewable execution (`Luna Max`).
- [ ] Add the local conversational promotion gate for `Luna Max`: accepted-without-edit noninferiority within `-3pp`, no critical-error regression, acceptable host latency, at least `70%` lower accepted-conversation cost/credit, and noninferior blinded preference.
- [ ] In `model-evidence.md`, record the 2026-07-30 official price changes and state that benchmark trajectories and repriced costs have different provenance.
- [ ] In `output-contract.md`, add concise examples for `Sol Medium` interactive discovery, `Luna Max` asynchronous open-ended execution, `Terra Max` quality-first tool execution, and a `Luna Max` to `Sol High` escalation at a judgment boundary.
- [ ] In `SKILL.md`, keep routing details delegated to the references but ensure the main flow asks whether the user is waiting interactively, whether output is reviewed before consequence, and whether execution preference is cost-first or quality-first.
- [ ] Add the completed 2026-07-31 research report to version control without weakening its source caveats.
- [ ] Run the focused semantic gate and confirm GREEN:

```bash
bash tests/strong-model-routing-policy.sh
bash scripts/validate-structure.sh
git diff --check
```

- [ ] Commit the policy with `git add skills/think-with-me/SKILL.md skills/think-with-me/references/model-routing.md skills/think-with-me/references/model-evidence.md skills/think-with-me/references/output-contract.md docs/research/gpt-5-6-price-benchmark-routing-review-2026-07-31.md && git commit -m "feat: route cost-first async work to Luna Max"`.

### Task 3: Refresh the public comparison with an explicit price overlay

**Files:**
- Modify: `skills/think-with-me/references/model-comparison.md`
- Modify through sync: `skills/think-with-me/SKILL.md`
- Modify through sync: `README.md`
- Modify if required by the test seam: `scripts/sync-model-comparison.sh`
- Modify: `tests/verify-model-comparison-data.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: preserved benchmark rows and official 2026-07-30 price multipliers.
- Produces: one canonical public comparison with raw quality provenance and transparently repriced `Luna Max`/`Terra Max` costs, mirrored byte-for-byte into README and SKILL.

- [ ] Update the canonical review date to `2026-07-31`.
- [ ] Keep `PASS@1`, uncertainty, output-token, and step values tied to the preserved DeepSWE artifact; do not label them as 2026-07-30 reruns.
- [ ] Display the repriced DeepSWE average costs with a visible note and formula:
  - `Luna Max`: historical measured cost multiplied by `0.20`, yielding the current displayed value rounded to `$0.61`.
  - `Terra Max`: historical measured cost multiplied by `0.80`, yielding the current displayed value rounded to `$3.96`.
  - all unchanged model rows: preserve their measured historical costs.
- [ ] Keep Artificial Analysis separate from DeepSWE and update only values verified in the 2026-07-31 research report; do not merge its Intelligence Index with DeepSWE `PASS@1`.
- [ ] Add a short policy note that lower `Luna Max` cost expands asynchronous eligibility but does not prove lower interactive end-to-end latency.
- [ ] Run the existing canonical sync script rather than manually copying blocks:

```bash
bash scripts/sync-model-comparison.sh
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
bash tests/evidence-gate-v1.sh
```

- [ ] Confirm that the only comparison-block differences in `README.md` and `SKILL.md` are generated from `model-comparison.md`.
- [ ] Commit the overlay with `git add skills/think-with-me/references/model-comparison.md skills/think-with-me/SKILL.md README.md tests/verify-model-comparison-data.sh tests/evidence-gate-v1.sh scripts/sync-model-comparison.sh && git commit -m "docs: apply Luna and Terra price overlay"`.

### Task 4: Bind fresh static and runtime evidence to the candidate

**Files:**
- Add: `evals/runtime-captures-2026-07-31-luna-cost-routing.md`
- Add: `evals/runtime-captures-2026-07-31-luna-cost-routing-final.md`
- Add: `evals/evidence-2026-07-31-luna-cost-routing.md`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the complete candidate package and the new behavioral fixtures.
- Produces: package-hash-bound runtime responses and an independent read-only review that distinguish local candidate behavior from global host parity.

- [ ] Generate the candidate manifest with `bash scripts/candidate-manifest.sh` and record its `PACKAGE_SHA256` only after all installable-package edits are complete.
- [ ] Run isolated evaluators against the exact local paths `skills/think-with-me/SKILL.md`, `skills/think-with-me/references/model-routing.md`, and `skills/think-with-me/references/output-contract.md`.
- [ ] Preserve unedited first-pass outputs for at least these scenarios: interactive architecture discovery, asynchronous open-ended cost-first execution, quality-first heterogeneous execution, consequential judgment discovered during a Luna batch, and host-model unavailability.
- [ ] If a first-pass scenario fails, preserve that result in the initial capture, tighten only the smallest policy ambiguity, recompute the package hash, and rerun in a fresh evaluator.
- [ ] Preserve final passing outputs in the final capture and identify each isolated evaluator.
- [ ] Ask a separate read-only reviewer to verify: exact six-pair allowlist, mutual exclusivity, benchmark/repricing provenance, cost arithmetic, historical hash, footer shape, and no unsupported claim that repricing is a benchmark rerun.
- [ ] Record these exact status fields in the candidate evidence before global synchronization:

```text
RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run
```

- [ ] Point `scripts/verify-evidence-record.sh` to the 2026-07-31 evidence and capture files and verify all three hashes structurally.
- [ ] Run all local gates fresh:

```bash
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
bash tests/strong-model-routing-policy.sh
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash scripts/verify-evidence-record.sh
git diff --check
```

- [ ] Commit the evidence with `git add evals/runtime-captures-2026-07-31-luna-cost-routing.md evals/runtime-captures-2026-07-31-luna-cost-routing-final.md evals/evidence-2026-07-31-luna-cost-routing.md scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh && git commit -m "test: validate Luna cost routing"`.

### Task 5: Verify global installation and post-install behavior

**Files:**
- Replace exact installable package contents under: `/Users/igortice/.agents/skills/think-with-me/`
- Add: `evals/install-2026-07-31-luna-cost-routing.md`

**Interfaces:**
- Consumes: a committed, locally green package and candidate evidence record.
- Produces: byte-for-byte global parity plus one fresh name-based runtime sample proving that the host loads the corrected skill.

- [ ] Confirm the local candidate is green and inspect `git status --short --branch` before any global write.
- [ ] Synchronize only the installable package contents to `/Users/igortice/.agents/skills/think-with-me/`; do not copy repository tests, evals, research, or Git metadata.
- [ ] Run `bash scripts/verify-global-install.sh` and require byte-for-byte parity.
- [ ] Run a fresh name-based `$think-with-me` scenario that transitions from latency-sensitive `Sol Medium` discussion to asynchronous reviewable `Luna Max` work, then to `Sol High` when consequential judgment appears.
- [ ] Preserve the unedited response and parity output in `evals/install-2026-07-31-luna-cost-routing.md`.
- [ ] Update the release-side status in the install record, but do not rewrite the pre-install candidate evidence claim that global parity had not yet run.
- [ ] Commit the install record with `git add evals/install-2026-07-31-luna-cost-routing.md && git commit -m "docs: record Luna routing install"`.

## Final Verification

Run fresh after the global installation:

```bash
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
bash tests/strong-model-routing-policy.sh
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash scripts/verify-evidence-record.sh
bash scripts/verify-global-install.sh
bash -n scripts/candidate-manifest.sh scripts/sync-model-comparison.sh scripts/validate-skill.sh scripts/validate-structure.sh scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh tests/strong-model-routing-policy.sh tests/sync-model-comparison.sh tests/verify-model-comparison-data.sh
test "$(shasum -a 256 skills/think-with-me/references/model-evidence-2026-07-20.md | awk '{print $1}')" = "13c76308c5a69163c24ccf32443a2ca854073d0fa43c2f6caa0e229d44f5d9e8"
git diff --check
git status --short --branch
```

Expected: every command exits `0`; all six eligible model/effort pairs remain exact and mutually exclusive; `Luna Max` is eligible for asynchronous cost-first reviewable long-horizon work but not default interactive conversation or consequential judgment; repriced costs are explicitly separated from raw benchmark observations; the historical evidence hash is unchanged; the global package matches the repository; and no push has occurred.
