# Evidence-Based Model Routing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace family-first GPT-5.6 routing with evidence-backed configuration routing that preserves `GPT-5.5 High` quality through a `Sol High` floor for open judgment.

**Architecture:** Keep the stable conversation and execution boundaries in `SKILL.md`, move empirical inputs into a new versioned `model-evidence.md`, and make `model-routing.md` apply a quality gate before cost or conversation-health modifiers. Preserve the output contract while replacing examples and tests that hard-code the old Terra-first policy.

**Tech Stack:** Markdown Agent Skill, Bash contract gates, Markdown behavior fixtures, Git, Skills CLI, and fresh-context Codex runtime validation.

## Global Constraints

- Preserve `Minha visão`, exactly one `Próximo passo`, and exactly one compact model configuration in one continuous Markdown blockquote.
- Preserve the current read-only and explicit-execution boundary.
- Treat `GPT-5.5 High` as the historical quality baseline and `Sol High` as the conservative floor for unresolved contextual judgment.
- Select atomic `family + effort` configurations; never select family first and effort second.
- Do not average heterogeneous benchmarks into a universal score.
- Do not infer equivalence when confidence intervals overlap or relevant benchmarks disagree.
- Compare total task cost only after filtering for required quality.
- Do not give Terra a preferred lane without evidence that it is non-dominated for the relevant workload.
- Keep lower-cost routes bounded, verifiable, low-risk, and explicit about their provisional evidence.
- Work directly on `main`; do not create a worktree.
- Do not push or publish without a separate explicit instruction.

---

## File Structure

| File | Responsibility after implementation |
|---|---|
| `skills/think-with-me/SKILL.md` | Stable conversation contract plus concise quality-gate routing summary. |
| `skills/think-with-me/references/model-routing.md` | Ordered atomic-configuration algorithm, quality floor, escalation, economy, uncertainty, and cost rules. |
| `skills/think-with-me/references/model-evidence.md` | Dated official, Artificial Analysis, DeepSWE, and user-baseline evidence with domain limitations. |
| `skills/think-with-me/references/output-contract.md` | Unchanged closing format with policy-consistent examples. |
| `README.md` | Public example and explanation of quality-preserving versus bounded economy routes. |
| `evals/think-with-me-cases.md` | Core one-turn behavior cases aligned with the quality floor. |
| `evals/think-with-me-multiturn-cases.md` | Continuity plus valid/invalid reduction cases. |
| `evals/model-routing-cases.md` | Dedicated routing fixtures for baseline, conflict, uncertainty, cost, risk, and depth. |
| `evals/model-routing-evidence-template.md` | Reusable record for actual runtime samples. |
| `evals/evidence-2026-07-19-evidence-based-routing.md` | Package-bound implementation and runtime evidence. |
| `tests/evidence-gate-v1.sh` | Static invariants for the existing contract and new routing policy. |
| `scripts/validate-structure.sh` | Installable-package manifest updated for the new evidence reference. |
| `scripts/verify-evidence-record.sh` | Hash-bound verification of the new evidence record. |
| `docs/release/skills-sh-publication.md` | Release checks updated only where the new evidence files change required review. |

---

### Task 1: Establish RED Routing Expectations

**Files:**
- Modify: `evals/think-with-me-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Create: `evals/model-routing-cases.md`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the approved design and the current output-contract invariants.
- Produces: explicit fixtures that reject family-first routing and the old Terra default before implementation changes.

- [x] **Step 1: Add model-routing invariants to the one-turn cases**

Add these invariants after the existing ten:

```md
11. A configuração é escolhida como o par indivisível `família + effort`; a resposta não escolhe uma família antes de avaliar o effort.
12. Decisões abertas que exigem contexto ou julgamento preservam `Sol High` como piso conservador em relação ao baseline histórico `GPT-5.5 High`.
13. Uma rota econômica só aparece quando o trabalho está delimitado, é barato verificar o resultado e custo, latência ou volume são materiais.
14. Benchmarks de domínios ou harnesses diferentes não são somados nem usados para declarar equivalência universal.
15. Empates e fontes divergentes preservam a opção conservadora até existir evidência local suficiente.
```

- [x] **Step 2: Replace policy-specific expectations in existing fixtures**

Set `TWM-01`, `TWM-03`, `TWM-04`, `TWM-05`, and `TWM-13` to expect the quality floor for unresolved judgment. Keep `TWM-06` on the same floor, remove wording that treats it as exceptional, and keep `TWM-12` as a bounded high-volume economy case. Do not change activation, language, continuity, or authorization expectations.

- [x] **Step 3: Add multi-turn reduction cases**

Append these exact cases:

```md
## TWM-M14 — Direção aceita não reduz qualidade por si só

1. A conversa fecha uma decisão arquitetural.
2. O próximo passo ainda exige transformar a decisão em uma especificação com trade-offs e critérios de aceite.

**Esperado:** preservar o piso de qualidade porque ainda existe julgamento substantivo.

**Proibido:** reduzir apenas porque a direção principal foi aceita.

## TWM-M15 — Economia delimitada e verificável

1. A direção, o formato e os exemplos estão aprovados.
2. Restam centenas de extrações independentes para um schema fixo.
3. Custo e latência são requisitos materiais e cada saída passa por validação automática.

**Esperado:** permitir a rota econômica documentada e justificar boundedness, volume e verificação barata.

**Proibido:** descrever a configuração econômica como equivalente ao baseline de conversa.
```

- [x] **Step 4: Create the dedicated routing case matrix**

Create `evals/model-routing-cases.md` with twelve cases: open product discovery, contextual comparison, technical specification, irreversible migration, repeated framing corrections, short settled rewrite without material cost pressure, high-volume schema extraction, long-horizon coding, Artificial Analysis versus DeepSWE disagreement, confidence-interval tie, explicit deepest-reasoning request, and frustration without additional ambiguity. Each row must state required evidence, expected configuration policy, and forbidden inference.

- [x] **Step 5: Add RED static assertions**

Add requirements for these future strings to `tests/evidence-gate-v1.sh`:

```bash
require_text "${routing_file}" 'GPT-5.5 High is the historical quality baseline'
require_text "${routing_file}" 'Sol High is the conservative quality floor'
require_text "${routing_file}" 'Treat family and effort as one atomic configuration'
require_text "${routing_file}" 'Do not average heterogeneous benchmarks'
require_text "${routing_file}" 'Terra has no preferred route in the current evidence snapshot'
require_text "${evidence_file}" 'DeepSWE v1.1'
require_text "${evidence_file}" 'Artificial Analysis Coding Index'
```

Reject these legacy routing statements:

```bash
if rg -Fq 'First choose by next-step fit:' "${routing_file}"; then
  fail 'routing still chooses a family role before an atomic configuration'
fi
if rg -Fq 'Select the family first, then the effort.' "${routing_file}"; then
  fail 'routing still selects family before effort'
fi
```

- [x] **Step 6: Run RED**

Run: `bash tests/evidence-gate-v1.sh`

Expected: FAIL on the first missing quality-baseline or evidence-reference assertion.

---

### Task 2: Version the Evidence Snapshot

**Files:**
- Create: `skills/think-with-me/references/model-evidence.md`

**Interfaces:**
- Consumes: official OpenAI documentation, Artificial Analysis results, DeepSWE v1.1 results, and the user-provided historical baseline.
- Produces: a dated, domain-scoped evidence source used by the routing policy and gates.

- [x] **Step 1: Add the evidence schema and hierarchy**

Define `official fact`, `independent empirical result`, `local behavioral result`, and `explicit user outcome`. Require source date, configuration, domain, harness, metric, uncertainty, total cost, limitations, and supported policy decision.

- [x] **Step 2: Record the OpenAI facts**

Record that Sol is the frontier family for complex professional reasoning and coding, Terra balances intelligence and price, Luna targets cost-sensitive volume, all three expose the documented effort range, and per-token price is not total task cost. Link only official OpenAI pages.

- [x] **Step 3: Record the Artificial Analysis snapshot**

Include the selected Coding Index results and broad intelligence-versus-cost observations from 19 July 2026. Label Coding Index as a 50/50 Terminal-Bench 2.1 and SciCode aggregate and state that it does not evaluate Portuguese multi-turn decision quality.

- [x] **Step 4: Record the DeepSWE v1.1 snapshot**

Include the four-run values for GPT-5.5 High, Sol Medium/High/XHigh/Max, Terra High/XHigh/Max, and Luna XHigh/Max. Record `Pass@1`, 95% run-to-run interval, mean task cost, output tokens, and agent steps. State that the common `mini-swe-agent` bash harness isolates model capability but does not reproduce the native Codex harness.

- [x] **Step 5: Derive only supported policy states**

Mark:

```md
- Sustained quality floor: `Sol High`.
- Selective depth: `Sol XHigh`; `Sol Max` only under the explicit deepest-reasoning gate.
- Value candidate, not baseline-equivalent: `Sol Medium`.
- Provisional bounded-volume route: `Luna Medium`, pending local synthesis evidence.
- No preferred route in this snapshot: Terra configurations.
```

- [x] **Step 6: Validate source links and terminology**

Run:

```bash
rg -n 'https://|historical quality baseline|conservative quality floor|mini-swe-agent|confidence|total task cost' skills/think-with-me/references/model-evidence.md
```

Expected: every evidence class, limitation, and routing decision is discoverable.

---

### Task 3: Implement Atomic Configuration Routing

**Files:**
- Modify: `skills/think-with-me/SKILL.md`
- Replace: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/output-contract.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: `model-evidence.md`, the approved design, and RED fixtures.
- Produces: an installable skill that applies the quality floor before economy and health modifiers.

- [x] **Step 1: Update the core selection summary**

Replace the generic four-category list under `Choose the model from the next step` with an ordered summary that requires: quality contract, domain, atomic configuration, evidence sufficiency, conversation health, then cost among eligible candidates. Keep the instruction to derive the recommendation after the view and next step.

- [x] **Step 2: Replace `model-routing.md`**

Use these sections in this order:

```md
# Evidence-Based Model Routing
## Start from the quality contract
## Treat family and effort as one atomic configuration
## Apply the current policy snapshot
## Escalate selectively
## Use economy only for bounded work
## Handle uncertainty and conflicting evidence
## Compare total task cost after quality
## Apply conversation health without waiting for failure
## Render exactly one recommendation
## Factual basis and review date
```

Encode `Sol High` as the default for unresolved contextual judgment, `Sol XHigh` as selective depth, `Sol Max` behind the explicit deepest-reasoning gate, `Sol Medium` as a non-equivalent value candidate, `Luna Medium` as provisional bounded-volume transformation, and no preferred Terra route.

- [x] **Step 3: Preserve footer validation while updating examples**

Replace ordinary `Terra High` examples with policy-consistent `Sol High` examples. Keep the high-volume settled transformation example on the bounded route and ensure its reason names volume and verifiability rather than claiming equivalent intelligence.

- [x] **Step 4: Update public documentation**

Use a `Sol High` README example for an unresolved contextual decision. Add one short paragraph explaining that lower-cost recommendations apply only to bounded, verifiable work with material cost, latency, or volume pressure.

- [x] **Step 5: Run GREEN static policy checks**

Run: `bash tests/evidence-gate-v1.sh`

Expected: progress past the new routing assertions and fail only on the first stale evidence-path or literal-template requirement owned by Task 4.

---

### Task 4: Bind the New Policy to Evidence Gates

**Files:**
- Create: `evals/model-routing-evidence-template.md`
- Create: `evals/evidence-2026-07-19-evidence-based-routing.md`
- Modify: `scripts/validate-structure.sh`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `tests/evidence-gate-v1.sh`
- Modify: `docs/release/skills-sh-publication.md`

**Interfaces:**
- Consumes: the implemented package and routing cases.
- Produces: candidate-hash-bound evidence and release checks that cannot silently validate the old policy.

- [ ] **Step 1: Create the runtime evidence template**

Require candidate ID, package SHA-256, source configuration, prompt, raw `agentMessage.text`, routing invariants, output invariants, cost evidence when available, observed deviation, and pass/fail result.

- [ ] **Step 2: Create the dated evidence record**

Record the approved design, RED result, implemented policy, commands run, current package hash, known runtime limitations, global parity state, and the exact statement `No implementation commit, push, publication, or global synchronization preceded this evidence record.`

- [ ] **Step 3: Prepare evidence verification requirements**

Prepare `scripts/verify-evidence-record.sh` to target `evals/evidence-2026-07-19-evidence-based-routing.md` after Task 5 records runtime behavior. The final verifier will require the current package hash and headings `## Static validation passed`, `## Runtime behavior passed`, `## Independent review`, and `## Global parity`.

- [ ] **Step 4: Remove literal Terra dependencies from the gate**

Replace literal canonical-template requirements for `Terra High` with a structural template using `Sol High`. Keep the footer parser accepting all documented family/effort labels, because formatting validity is separate from routing eligibility.

- [ ] **Step 5: Update release review inputs**

Add `model-evidence.md`, `model-routing-cases.md`, and the dated evidence record to the release review checklist. Do not alter publication authority.

- [ ] **Step 6: Run local validation**

Run:

```bash
bash tests/evidence-gate-v1.sh
UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh
git diff --check
```

Expected: structural validation and `git diff --check` pass. The evidence gate reaches the dated evidence check and fails only because runtime behavior is still marked pending; Task 5 closes that intentional RED state.

---

### Task 5: Prove Runtime Behavior in Fresh Contexts

**Files:**
- Modify: `evals/evidence-2026-07-19-evidence-based-routing.md`

**Interfaces:**
- Consumes: the candidate package and representative cases from `model-routing-cases.md`.
- Produces: raw runtime evidence that the installed behavior matches the static policy.

- [ ] **Step 1: Run the minimum fresh-context sample**

Run independent sessions for: open contextual comparison, irreversible risk, settled high-volume extraction, benchmark conflict, and frustration without extra ambiguity. Load the local candidate explicitly in each session.

- [ ] **Step 2: Inspect raw responses**

Use raw `agentMessage.text`, not a normalized wait summary. Verify one view, one next step, one configuration, the correct floor/economy behavior, and no unsupported equivalence claim.

- [ ] **Step 3: Record actual results**

Add each prompt, selected configuration, decisive reason, invariant result, and representative raw closing to the dated evidence record. Do not claim cost observations when the host does not expose them.

- [ ] **Step 4: Repoint the verifier, recompute the candidate hash, and close the gate**

Point `scripts/verify-evidence-record.sh` to the dated record and require the final headings from Task 4. Run `bash scripts/candidate-manifest.sh`, update the package hash in the evidence record, then run `bash tests/evidence-gate-v1.sh`.

Expected: `Behavior evidence matches the current package.` and `Evidence Gate v1 checks passed.`

---

### Task 6: Independent Review and Global Synchronization

**Files:**
- Review: every changed file
- Modify if necessary: files implicated by review findings

**Interfaces:**
- Consumes: green local candidate and runtime evidence.
- Produces: independently reviewed candidate, synchronized global installation, and parity proof.

- [ ] **Step 1: Run an independent read-only review**

Review for policy correctness, source fidelity, hidden Terra-first assumptions, unsupported benchmark generalization, stale literal examples, weakened output invariants, and missing behavior cases.

- [ ] **Step 2: Correct findings and rerun all gates**

Use `apply_patch` for corrections. Rerun the static gate, structural validation, shell syntax checks, and `git diff --check`.

- [ ] **Step 3: Synchronize the approved local package globally**

Run:

```bash
NPM_CONFIG_CACHE=.cache/npm npx --yes skills add . --skill think-with-me -g -a codex -y
bash scripts/verify-global-install.sh
```

Expected: `Global think-with-me installation matches the repository source.`

- [ ] **Step 4: Run one post-sync fresh session**

Invoke `$think-with-me` from the global installation on an unresolved contextual comparison. Confirm raw output uses the new floor and preserves the output contract.

- [ ] **Step 5: Update final evidence and rerun parity**

Record global parity and post-sync runtime result, recompute the package hash if package files changed, and rerun all gates.

- [ ] **Step 6: Commit the complete implementation**

Stage only the files in this plan and commit with:

```bash
git commit -m "feat: route models from evidence and quality floor"
```

Do not push.

---

## Final Verification

- [ ] `bash tests/evidence-gate-v1.sh`
- [ ] `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh`
- [ ] `bash -n scripts/*.sh tests/*.sh`
- [ ] `git diff --check HEAD^ HEAD`
- [ ] `bash scripts/verify-global-install.sh`
- [ ] fresh global runtime sample passes
- [ ] independent review has no unresolved material finding
- [ ] `git status --short` is clean
- [ ] branch is not pushed without explicit authorization
