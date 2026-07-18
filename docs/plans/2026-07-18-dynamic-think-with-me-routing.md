# Context-Aware Next-Step Model Recommendation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `think-with-me` recommend exactly one GPT-5.6 model and effort for the next step, using both the work required and evidence about whether the conversation is converging.

**Architecture:** `SKILL.md` defines the ordered closing contract, `references/model-routing.md` combines next-step fit with conversation-health signals, and `references/output-contract.md` demonstrates contextual reasons. Static shell assertions and fresh-context agent samples form the RED-GREEN evidence; the global installation is synchronized only after the candidate passes.

**Tech Stack:** Markdown skill package, Bash contract gate, Markdown evaluation fixtures, fresh-context Codex agent samples.

## Global Constraints

- Keep `Minha visão`, `Próximo passo`, and the model recommendation in one continuous Markdown blockquote.
- Formulate `Minha visão` and exactly one `Próximo passo` before choosing the model.
- Recommend exactly one family and effort for that next step.
- Ground the reason in the concrete next step and observable conversation evidence.
- Use corrections, repetition, friction, contradictions, disclosed model history, and convergence as modifiers; sentiment alone never selects a model.
- Never invent the active model or infer it from unavailable host state.
- Do not include `agora`, `depois`, arrows, future model transitions, alternatives, or a model catalog in the footer.
- Keep the footer on one authored Markdown line in italics and do not use raw HTML for font sizing.
- Maximum value means best fit for the remaining work, not automatic selection of Sol, Max, or Ultra.

---

### Task 1: Establish RED evidence for the rejected footer

**Files:**
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `evals/think-with-me-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`

**Interfaces:**
- Consumes: the currently rejected `agora → depois` contract.
- Produces: static assertions and a multi-turn fixture that fail until one contextual next-step recommendation exists.

- [x] **Step 1: Add the failing static contract assertions**

Require the exact structural ideas `Model recommendation is derived only after`, `conversation health`, and `_Modelo para o próximo passo:`. Reject authored footer lines containing `agora`, `depois`, `→`, `<small>`, or a second model recommendation.

- [x] **Step 2: Move evidence verification after semantic assertions**

Keep `scripts/verify-evidence-record.sh` mandatory, but execute it after the contract checks so a semantic regression reports its own failure before a stale package hash.

- [x] **Step 3: Add the approved behavioral fixture**

Record a conversation that moved from Terra High to Max and then Sol, includes repeated user corrections and visible friction, and ends with one unresolved contract decision. Require one model for the next step, a reason tied to the failed convergence, and no future prediction.

- [x] **Step 4: Run five fresh-context samples against the rejected source**

Each read-only sample reads the current candidate skill and answers the same fixture. Expected RED result: at least one required invariant fails, specifically because the footer predicts a future model or gives a generic reason.

- [x] **Step 5: Run the static gate and observe RED**

Run: `bash tests/evidence-gate-v1.sh`

Expected: `FAIL` for a missing next-step/health invariant before evidence-hash verification.

### Task 2: Implement the ordered recommendation contract

**Files:**
- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/output-contract.md`

**Interfaces:**
- Consumes: the approved specification and RED fixtures from Task 1.
- Produces: an installable contract that derives one contextual model recommendation from the already-written next step.

- [x] **Step 1: Encode the ordered closing algorithm**

Require this order: conclude `Minha visão`; write exactly one `Próximo passo`; evaluate next-step fit and conversation health; emit exactly one model and effort with a concrete reason.

- [x] **Step 2: Add the conversation-health modifier**

Use observable signals: progress, repeated correction, contradiction, disclosed unsuccessful model/effort changes, friction, stabilized direction, and remaining ambiguity. State that these modify task fit rather than replace it.

- [x] **Step 3: Prevent invented runtime state and automatic escalation**

Use model history only when stated or available. Explain that more effort cannot repair a wrong framing and that Sol/Max/Ultra are not rewards for frustration.

- [x] **Step 4: Replace the footer recipe**

Use one authored line:

```md
> _Modelo para o próximo passo: **Sol High** — fechar esta regra após correções repetidas._
```

The reason is generated from the actual next step and conversation evidence; it is not a fixed phrase.

- [x] **Step 5: Replace examples with contextual cases**

Cover ordinary converging trade-offs, repeated misunderstanding, irreversible migration risk, and settled synthesis. Every example contains one recommendation and no predicted model transition.

### Task 3: Prove GREEN behavior and close the evidence gate

**Files:**
- Create: `evals/evidence-2026-07-18-context-aware-next-step.md`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the implemented package and the same fixture used during RED.
- Produces: package-bound behavioral evidence and a green contract gate.

- [x] **Step 1: Run five fresh-context samples against the candidate**

Expected in every sample: `Minha visão` precedes `Próximo passo`; the footer contains one model and effort; its reason references the concrete next step and failed convergence; no active model is invented; no future model is listed.

- [x] **Step 2: Record RED and GREEN observations**

Write the package SHA-256, candidate ID, scenario, sample counts, representative actual output, invariant results, limitations, and parity result into the new evidence record.

- [x] **Step 3: Point evidence verification to the new record**

Require the current package hash, `## Forward test passed`, global parity text, and the statement that no implementation commit, push, or publication preceded the evidence record.

- [x] **Step 4: Run local validation**

Run:

```bash
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-structure.sh
bash tests/evidence-gate-v1.sh
git diff --check
```

Expected: structural validation and the evidence gate pass; whitespace check is silent.

### Task 4: Synchronize, verify, and record durable state

**Files:**
- Modify: `/Users/igortice/.agents/skills/think-with-me/SKILL.md`
- Modify: `/Users/igortice/.agents/skills/think-with-me/agents/openai.yaml`
- Modify: `/Users/igortice/.agents/skills/think-with-me/references/model-routing.md`
- Modify: `/Users/igortice/.agents/skills/think-with-me/references/output-contract.md`
- Modify: `.codex/project-context/CURRENT_STATE.md`
- Modify: `.codex/project-context/DECISIONS.md`
- Modify: `.codex/project-context/worklog/2026-07.md`

**Interfaces:**
- Consumes: the green local candidate.
- Produces: matching global installation, durable project continuity, and a focused implementation commit.

- [x] **Step 1: Synchronize the four package files**

Copy the validated candidate package to the exact global installation paths.

- [x] **Step 2: Verify installed parity and re-run all gates**

Run:

```bash
bash scripts/verify-global-install.sh
bash tests/evidence-gate-v1.sh
git diff --check
```

Expected: global parity and evidence gate pass; whitespace check is silent.

- [x] **Step 3: Update only durable context**

Record the accepted one-model next-step contract, the validated global state, the evidence file, and any residual nondeterminism risk.

- [x] **Step 4: Commit the implementation**

Stage only the skill, routing reference, examples, evaluations, gate, evidence verifier/record, plan, and project-context files changed by this correction. Commit with `feat: make model recommendation context aware`.
