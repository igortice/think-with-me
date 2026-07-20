# Contextual Model Portfolio Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Think With Me select one GPT-5.6 configuration from an evidence-scoped contextual portfolio for each next step instead of converging on a permanent default.

**Architecture:** Preserve the two benchmark views as separate immutable evidence, then rebuild the eligible configuration set from the domain and priorities of every immediate next step. Add explicit winning or pilot cases for every configuration in the DeepSWE upper band, bind fresh runtime evidence to the changed package, and synchronize the validated package to the global installation.

**Tech Stack:** Markdown Agent Skill, Bash gates, Markdown behavior fixtures, Git, Codex runtime samples, and filesystem package parity.

## Global Constraints

- Preserve Artificial Analysis and DeepSWE as separate source-specific views.
- Never average heterogeneous benchmarks or transfer their costs to another domain.
- Keep `Sol Max`, `Sol XHigh`, `Terra Max`, `Sol High`, and `Luna Max` eligible inside the measured DeepSWE upper band.
- Do not make any configuration a permanent conversation default.
- Recompute eligibility whenever the immediate next step changes materially.
- Keep exactly one atomic `family + effort` configuration in the closing footer.
- Give `Terra Max` only a representative-pilot route until local behavior establishes a distinct advantage.
- Give `Luna Max` a matched long-horizon cost route only when extra tokens, steps, and duration are acceptable.
- Preserve `Sol Medium` as a provisional value route and `Luna Medium` as a bounded-volume pilot route.
- Preserve the read-only thinking boundary and host activation boundary.
- Work directly on `main`; do not create a worktree.
- Do not push or publish without a separate explicit instruction.

---

## File Structure

| File | Responsibility after implementation |
| --- | --- |
| `skills/think-with-me/SKILL.md` | Contextual-portfolio selection summary. |
| `skills/think-with-me/references/model-routing.md` | Eligible-set algorithm, contextual routes, recomputation, and rendering. |
| `skills/think-with-me/references/model-evidence.md` | Dated evidence states and limits for every portfolio configuration. |
| `skills/think-with-me/references/output-contract.md` | Examples with different recommendations for different immediate steps. |
| `README.md` | Public explanation that the matrices define a portfolio, not a default. |
| `evals/model-routing-cases.md` | Positive and near-miss cases for supported and pilot routes. |
| `evals/think-with-me-multiturn-cases.md` | Recommendation change after a material next-step change. |
| `tests/evidence-gate-v1.sh` | Static invariants against permanent defaults and candidate exclusion. |
| `evals/evidence-2026-07-20-contextual-model-portfolio.md` | Fresh package-bound evidence record. |
| `scripts/verify-evidence-record.sh` | Verifier for the new evidence and capture artifacts. |

---

### Task 1: Establish RED Contextual-Portfolio Expectations

**Files:**
- Modify: `evals/model-routing-cases.md`
- Modify: `evals/think-with-me-multiturn-cases.md`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the approved design and MR-01 through MR-19.
- Produces: failing expectations for contextual eligibility and recomputation.

- [ ] **Step 1: Add routing cases MR-20 through MR-24**

Append these rows to `evals/model-routing-cases.md`:

```md
| MR-20 | Luna Max vence por custo dentro do DeepSWE | O próximo passo corresponde a engenharia longa no mesmo harness; qualidade da faixa superior é suficiente, custo total é material e mais tokens, passos e duração são aceitáveis. | Recomendar `Luna Max`; informar que custa US$ 0,44 ou 12,7% menos que `Sol High` no DeepSWE e que usa 44.950 tokens e 64,8 passos a mais em média. | Transferir a economia para conversa comum, omitir a execução mais longa ou declarar equivalência universal. |
| MR-21 | Piloto representativo com Terra Max | O próximo passo é um piloto isolado de engenharia longa destinado a observar convergência local; custo, tokens e passos maiores são aceitáveis. | Recomendar `Terra Max` somente para o piloto e declarar que a rota busca evidência local, não vantagem econômica demonstrada. | Torná-lo default ou afirmar equivalência conversacional. |
| MR-22 | Sol High vence pela execução compacta | O contrato de qualidade é atendido na faixa superior e o próximo passo valoriza interação, menos tokens e menos passos. | Recomendar `Sol High` porque a forma compacta decide entre candidatas elegíveis. | Chamá-lo de piso permanente ou excluir candidatas antes de avaliar prioridades. |
| MR-23 | Rota cotidiana de valor aceita pelo usuário | A conversa é de baixo risco, barata de corrigir, sem decisão profissional escondida, e o usuário aceita a incerteza de equivalência. | Permitir `Sol Medium` como rota contextual provisória. | Torná-lo default ou usar DeepSWE para provar conversa cotidiana. |
| MR-24 | Nenhum default permanente | Dois próximos passos sucessivos têm domínios e prioridades diferentes. | Recalcular o conjunto elegível e permitir recomendações diferentes. | Preservar uma configuração apenas porque ela foi recomendada antes. |
```

- [ ] **Step 2: Add the multi-turn recomputation case**

Append to `evals/think-with-me-multiturn-cases.md`:

```md
## TWM-M16 — O próximo passo muda a configuração elegível

1. O primeiro turno fecha uma decisão profissional interativa e recomenda uma configuração compacta da faixa superior.
2. O usuário muda o próximo passo para uma execução longa no domínio DeepSWE, torna custo total material e aceita mais tokens, passos e duração.

**Esperado:** recuperar a decisão fechada, recalcular o conjunto elegível e recomendar a configuração de menor custo sustentada no novo domínio, explicitando a execução mais longa.

**Proibido:** manter a configuração anterior por inércia, criar um default da conversa ou transferir o custo observado para outro domínio.
```

- [ ] **Step 3: Add failing gate assertions**

Add to `tests/evidence-gate-v1.sh`:

```bash
require_text "${routing_file}" 'No configuration is a permanent conversation default.'
require_text "${routing_file}" 'Build the eligible set again whenever the immediate next step changes materially.'
require_text "${routing_file}" '`Terra Max` is eligible only for a representative long-horizon pilot'
require_text "${routing_file}" '`Luna Max` can win inside the matched DeepSWE domain when total task cost is material'
require_text "${model_evidence_file}" 'Contextual upper-band candidate: `Terra Max`'
require_text "${model_evidence_file}" 'Contextual upper-band candidate: `Luna Max`'
require_text "${routing_cases_file}" 'MR-20 | Luna Max vence por custo dentro do DeepSWE'
require_text "${routing_cases_file}" 'MR-21 | Piloto representativo com Terra Max'
require_text "${routing_cases_file}" 'MR-24 | Nenhum default permanente'
require_text "${multiturn_cases_file}" 'TWM-M16 — O próximo passo muda a configuração elegível'
```

- [ ] **Step 4: Run RED**

Run: `bash tests/evidence-gate-v1.sh`

Expected: FAIL on `No configuration is a permanent conversation default.`

- [ ] **Step 5: Commit the RED contract**

```bash
git add evals/model-routing-cases.md evals/think-with-me-multiturn-cases.md tests/evidence-gate-v1.sh
git commit -m "test: require contextual model portfolio"
```

---

### Task 2: Implement Eligible-Set Routing

**Files:**
- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/references/model-routing.md`
- Modify: `skills/think-with-me/references/model-evidence.md`
- Modify: `skills/think-with-me/references/output-contract.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: MR-20 through MR-24 and TWM-M16.
- Produces: one contextual recommendation recalculated per immediate next step.

- [ ] **Step 1: Add the eligible-set invariant**

Insert after the atomic-configuration section in `model-routing.md`:

```md
No configuration is a permanent conversation default. Build an eligible set for the immediate next step from the applicable domain, required quality, material cost or latency pressure, tolerated tokens and steps, retry cost, and conversation health. Build the eligible set again whenever the immediate next step changes materially; a previous recommendation is trajectory evidence, not a routing lock.
```

- [ ] **Step 2: Define the contextual routes**

Replace the closed role bullets with:

```md
- `Sol Max` can win only behind the explicit deepest-reasoning gate for an unusually difficult bounded problem.
- `Sol XHigh` can win for concrete residual ambiguity or near-top value when DeepSWE matches the next step.
- `Terra Max` is eligible only for a representative long-horizon pilot that collects local convergence evidence and accepts its higher mean cost, tokens, and steps.
- `Sol High` can win when upper-band quality is required and compact execution decides among eligible configurations.
- `Luna Max` can win inside the matched DeepSWE domain when total task cost is material and its higher token use, step count, and likely duration are acceptable.
- `Sol Medium` remains a provisional value route for low-risk, cheaply verified work when the user accepts unresolved equivalence risk.
- `Luna Medium` remains a representative pilot for closed, mechanical, high-volume transformation with automatic validation.
```

- [ ] **Step 3: Align evidence states**

Replace `Supported policy states` in `model-evidence.md` with:

```md
- Contextual upper-band candidate: `Sol Max`, behind the explicit deepest-reasoning gate.
- Contextual upper-band candidate: `Sol XHigh`, for selective depth or near-top DeepSWE value.
- Contextual upper-band candidate: `Terra Max`, only for a representative long-horizon pilot until local evidence establishes a distinct advantage.
- Contextual upper-band candidate: `Sol High`, when compact upper-band execution fits the immediate next step.
- Contextual upper-band candidate: `Luna Max`, when matched-domain task cost matters and a longer, token- and step-heavy run is acceptable.
- Provisional value candidate: `Sol Medium`, without baseline-equivalence status.
- Provisional bounded-volume pilot: `Luna Medium`, pending qualifying local evidence.
- Recorded without a distinct preferred role: `Terra High`, `Terra XHigh`, and `Luna XHigh`.
```

- [ ] **Step 4: Update the skill summary**

Add under `Choose the model from the next step` in `SKILL.md`:

```md
- Never turn a conservative fallback into a permanent conversation default; recalculate eligible configurations for the immediate next step.
- In a domain matched by the evidence, keep every configuration that satisfies the quality contract until current priorities over cost, duration, tokens, steps, and retries select one.
```

- [ ] **Step 5: Add output examples and README explanation**

Add examples to `output-contract.md` with these single physical model lines:

```md
> `Luna Max` · executar a tarefa longa quando custo total importa e uma execução extensa é aceitável.
> `Terra Max` · testar a convergência local no piloto isolado sem presumir vantagem geral.
```

Add after the comparison block in `README.md`:

```md
The tables define an evidence portfolio, not a permanent default. Think With Me rebuilds the eligible set for each immediate next step and may select a different configuration when the domain, quality requirement, total-cost pressure, tolerated duration, tokens, steps, retries, or conversation health changes. Inclusion in a benchmark upper band remains scoped to that benchmark and does not prove conversational equivalence.
```

- [ ] **Step 6: Run GREEN checks**

Run:

```bash
bash scripts/sync-model-comparison.sh --check
bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
```

Expected: comparison and structural checks PASS; the evidence gate passes new assertions and stops only at the old package-bound evidence hash.

- [ ] **Step 7: Commit the routing implementation**

```bash
git add README.md skills/think-with-me/SKILL.md skills/think-with-me/references/model-routing.md skills/think-with-me/references/model-evidence.md skills/think-with-me/references/output-contract.md
git commit -m "feat: route from contextual model portfolio"
```

---

### Task 3: Bind Fresh Runtime Evidence

**Files:**
- Create: `evals/runtime-captures-2026-07-20-contextual-portfolio.md`
- Create: `evals/runtime-captures-2026-07-20-contextual-portfolio-final.md`
- Create: `evals/evidence-2026-07-20-contextual-model-portfolio.md`
- Modify: `scripts/verify-evidence-record.sh`
- Modify: `tests/evidence-gate-v1.sh`

**Interfaces:**
- Consumes: the Task 2 package and MR-20 through MR-24 plus TWM-M16.
- Produces: immutable samples and a verifier bound to the new package hash.

- [ ] **Step 1: Point the verifier to new artifacts**

Replace only the three artifact variables in `scripts/verify-evidence-record.sh`:

```bash
evidence_file="${repo_root}/evals/evidence-2026-07-20-contextual-model-portfolio.md"
initial_captures_file="${repo_root}/evals/runtime-captures-2026-07-20-contextual-portfolio.md"
final_captures_file="${repo_root}/evals/runtime-captures-2026-07-20-contextual-portfolio-final.md"
```

Require the new record in `tests/evidence-gate-v1.sh` and retain the old record as a required historical file.

- [ ] **Step 2: Generate candidate identity**

Run: `bash scripts/candidate-manifest.sh`

Expected: one `PACKAGE_SHA256`, one `CANDIDATE_ID`, and deterministic file hashes.

- [ ] **Step 3: Capture and review runtime cases**

Run MR-20 through MR-24 and TWM-M16 against the local candidate. Preserve every prompt and unedited response in the initial capture; preserve corrected qualifying reruns in the final capture.

Expected: every upper-band configuration has a positive or pilot case; MR-24 and TWM-M16 recompute after a changed next step; no sample declares a permanent default or cross-domain equivalence.

- [ ] **Step 4: Create the evidence record**

Create `evals/evidence-2026-07-20-contextual-model-portfolio.md` with the package and capture hashes plus these exact markers:

```text
RUNTIME_SOURCE_FIDELITY: host-unverified
LOCAL_CANDIDATE_STATUS: passed
INDEPENDENT_REVIEW_STATUS: passed
GLOBAL_PARITY_STATUS: not-run
POST_INSTALL_RUNTIME_STATUS: not-run
No commit, push, publication, global synchronization, or skills.sh installation preceded this candidate evidence record.
```

Include headings `## Static validation passed`, `## Runtime behavior passed`, `## Independent review`, `## Global parity`, and `## Post-install runtime`.

- [ ] **Step 5: Run the complete local gate**

Run:

```bash
bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash -n scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh
git diff --check
```

Expected: all commands exit `0` and output includes `Evidence Gate v1 checks passed.`

- [ ] **Step 6: Commit fresh evidence**

```bash
git add evals/runtime-captures-2026-07-20-contextual-portfolio.md evals/runtime-captures-2026-07-20-contextual-portfolio-final.md evals/evidence-2026-07-20-contextual-model-portfolio.md scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh
git commit -m "test: validate contextual model portfolio"
```

---

### Task 4: Synchronize the Usable Global Version

**Files:**
- Replace contents under the user-level install target, normally `~/.agents/skills/think-with-me/`
- Verify against: `skills/think-with-me/`

**Interfaces:**
- Consumes: committed and validated Task 3 package.
- Produces: the global skill package used by new explicit invocations.

- [ ] **Step 1: Re-run pre-install gates**

Run:

```bash
bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
git status --short --branch
```

Expected: both gates PASS and the branch is clean.

- [ ] **Step 2: Replace the global package exactly**

Synchronize every file under `skills/think-with-me/` to the resolved user-level install target, normally `~/.agents/skills/think-with-me/`, and remove no files outside that exact target package. Do not push or publish.

- [ ] **Step 3: Verify parity**

Run: `bash scripts/verify-global-install.sh`

Expected: `Global think-with-me installation matches the repository source.`

- [ ] **Step 4: Run a post-install smoke test**

Invoke the global skill with a prompt that changes the immediate next step from compact interactive judgment to matched long-horizon cost-sensitive execution.

Expected: the second recommendation is recalculated and does not preserve the earlier configuration by inertia.

- [ ] **Step 5: Record and commit post-install evidence**

Create a dated addendum under `evals/` containing the parity command and unedited smoke response, then run:

```bash
git add evals/
git commit -m "docs: record contextual portfolio install"
```

---

## Final Verification

Run fresh:

```bash
bash scripts/sync-model-comparison.sh --check
bash tests/sync-model-comparison.sh
bash tests/verify-model-comparison-data.sh
bash scripts/validate-skill.sh
bash tests/evidence-gate-v1.sh
bash scripts/verify-global-install.sh
bash -n scripts/candidate-manifest.sh scripts/sync-model-comparison.sh scripts/validate-skill.sh scripts/validate-structure.sh scripts/verify-evidence-record.sh tests/evidence-gate-v1.sh tests/sync-model-comparison.sh tests/verify-model-comparison-data.sh
git diff --check
git status --short --branch
```

Expected: every command exits `0`, global parity is reported, whitespace and shell checks are clean, and the branch is ahead of `origin/main` only by local approved commits.
