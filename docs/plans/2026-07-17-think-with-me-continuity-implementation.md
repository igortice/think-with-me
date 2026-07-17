# Think With Me Continuity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `subagent-driven-development` (recommended) or `executing-plans` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `think-with-me` sustain a natural decision thread while preserving model/effort and subagent recommendations at meaningful continuation points.

**Architecture:** Keep the decision-thread contract in `SKILL.md`, routing and delegation detail in `references/model-routing.md`, and natural response examples in `references/output-contract.md`. Keep activation and multi-turn evaluation scenarios outside the installable skill folder.

**Tech Stack:** Markdown Agent Skill, YAML metadata, `skills-ref`, the repository validator, and static Git checks.

> **Status de execução:** todas as tarefas deste plano foram concluídas localmente. O diff permanece sem commit, push, sincronização global ou publicação, aguardando revisão humana.

## Global Constraints

- Implement [continuity hybrid design](../specs/2026-07-17-think-with-me-continuity-design.md) without copying the interrogative behavior of `grilling` literally.
- Preserve read-only planning: no edits, implementation, subagent dispatch, commit, push, publication, global synchronization, or global-Codex configuration changes under this skill.
- `$think-with-me` remains the explicit path. Implicit discovery improves activation but cannot promise host-level session affinity.
- At material continuation points, always state the current-stage model/effort, then evaluate the next bounded task and whether an independent subagent helps. Do not repeat unchanged guidance in narrow follow-ups.
- The main conversation owns decisions. A subagent result returns as evidence to the same decision thread.
- A conversation can be approved scope when objective, desired behavior, confirmed decisions, exclusions, validation, and explicit authorization are clear.
- Do not commit this implementation. Present the local diff for human review first.

---

## File structure

| File | Responsibility after implementation |
|---|---|
| `skills/think-with-me/SKILL.md` | Decision-thread recovery, turn rhythm, authority, material continuation, and handoff boundary. |
| `skills/think-with-me/agents/openai.yaml` | UI metadata and implicit-discovery policy. |
| `skills/think-with-me/references/model-routing.md` | Three routing types, escalation rules, and portable/named-subagent recommendations. |
| `skills/think-with-me/references/output-contract.md` | Natural decision, routing, subagent-return, recap, and approval examples. |
| `evals/trigger-cases.md` | Positive and negative discovery cases. |
| `evals/think-with-me-cases.md` | Isolated behavior cases and evaluation protocol. |
| `evals/think-with-me-multiturn-cases.md` | Transcript cases for continuity and delegated-evidence integration. |

## Task 1: Encode the decision thread and authority contract

**Files:**

- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/agents/openai.yaml`

**Interfaces:**

- Consumes: conversation history, supplied sources, and direct user corrections.
- Produces: a connected planning response with at most one user decision open; an execution handoff only after explicit authorization.

- [x] **Step 1: Add the decision-thread recovery rule**

After `## Converse naturally`, add:

```md
## Preserve the decision thread

On every turn in which this skill is active, silently recover the current objective, confirmed facts, confirmed decisions, discarded alternatives, explicit constraints, current phase, and one unresolved decision. A later explicit correction from the user replaces older information about the same subject.

Use unchanged state to guide the answer, but do not restate it as a report. Do not reopen a discarded alternative without relevant new evidence. If evidence changes the plan, say that the conversation returns to the appropriate phase.
```

- [x] **Step 2: Add the four turn behaviors**

Add this section after the recovery rule:

```md
## Advance one dependency at a time

- Verify a discoverable fact with read-only inspection before asking the user for it.
- When a user choice is genuinely required, give a recommendation, decisive reason, and trade-off, then ask one focused question.
- When the user resolves that choice, incorporate it and advance to the next dependency without reopening the same choice.
- When no choice is open, synthesize, refine the plan/spec, define validation, or prepare the next bounded block; do not invent a question.
```

- [x] **Step 3: Replace literal mandatory-closing language**

Replace `## Finish with your view` with:

```md
## Give a real position at meaningful transitions

When a decision can advance, state the choice you recommend, the decisive reason, and the meaningful trade-off in natural language. Do not require a literal label or a closing block. A narrow follow-up inside an unchanged direction should receive a direct answer without repeated recap, model, agent, or approval wording.
```

- [x] **Step 4: Accept conversational scope for a handoff**

Replace the external-spec-only condition with:

```md
When execution is requested, recover the approved scope from the conversation when it already states the objective, desired behavior, confirmed decisions, exclusions, validation, and explicit authorization. Ask for a file, issue, or excerpt only when the user identified it as authoritative or material scope information is missing.
```

- [x] **Step 5: Enable hybrid discovery**

Change `skills/think-with-me/agents/openai.yaml` to:

```yaml
policy:
  allow_implicit_invocation: true
```

Keep display name and default prompt unchanged.

- [x] **Step 6: Verify the old contract was removed**

Run `rg -n 'Minha visão|approved spec is not identified|otherwise say naturally|mandatory report template' skills/think-with-me/SKILL.md`.

Expected: no active installable instruction requires an external spec or a literal mandatory closing.

## Task 2: Make model and subagent advice part of continuity

**Files:**

- Modify: `skills/think-with-me/SKILL.md`
- Modify: `skills/think-with-me/references/model-routing.md`

**Interfaces:**

- Consumes: phase, task shape, known availability, named-agent contracts, and subagent eligibility.
- Produces: current-stage routing, next-task routing, or a proposed subagent handoff.

- [x] **Step 1: Add material-continuation triggers in `SKILL.md`**

Require routing evaluation at phase start/resumption, a closed decision with a bounded next task, an independent parallelizable question, a subagent result, and explicit execution approval. Include:

```md
Do not repeat an unchanged routing recommendation in a narrow follow-up. Outside a material continuation point, mention routing only when the user asks.
```

- [x] **Step 2: Align the routing-reference loading rule**

Change the first paragraph of `references/model-routing.md` so it loads for explicit model/agent questions and material continuation points. Keep the matrix internal; never dump it wholesale.

- [x] **Step 3: Add the three-routing table**

Insert before the operational matrix:

```md
| Routing | Question | When to state it |
|---|---|---|
| Conversation stage | How should this phase be reasoned about? | Phase start/resumption or material ambiguity/risk change. |
| Next bounded task | How should the now-clear task be executed? | The task has scope, output, and validation. |
| Subagent | Who can answer an independent question and with what capability? | The eligibility test passes and delegation changes the next step. |
```

- [x] **Step 4: Define subagent proposal and return rules**

Require every suggested subagent to include role, question, scope/exclusions, output, model/effort, reason for parallelism, and explicit approval needed. Add:

```md
## Integrate a subagent result

Treat a completed subagent result as new evidence in the main decision thread. Compare it with confirmed decisions and exclusions, state only what it confirms or changes, then recommend the next phase and routing. Do not restart discovery, revive discarded options without evidence, or treat the result as authorization to execute.
```

- [x] **Step 5: Preserve portable and named-agent behavior**

Add after the subagent matrix:

```md
When the environment exposes a named agent with a model/effort pinned in its own configuration, respect that contract. Otherwise recommend a role and conditional family/effort without claiming the role or selector exists.
```

- [x] **Step 6: Check routing consistency**

Run `rg -n 'when the user asks|when helpful|session start|phase change|subagent' skills/think-with-me/SKILL.md skills/think-with-me/references/model-routing.md`.

Expected: explicit question or material continuation is the only routing threshold, and no line claims knowledge of the active selector.

## Task 3: Replace template pressure with natural examples

**Files:**

- Modify: `skills/think-with-me/references/output-contract.md`

**Interfaces:**

- Consumes: recovered decision state, routing recommendation, and approval status.
- Produces: examples that preserve a real point of view without a mandatory form.

- [x] **Step 1: Replace the default-ending template**

Replace `## Default ending` with guidance that the useful answer comes first and only the changed decision, routing, or approval condition is stated. Include:

```md
Eu seguiria com a alternativa A porque ela mantém a restrição já confirmada e reduz a integração. Como o próximo bloco é mapear os fluxos afetados, eu sugiro um `code_mapper`, usando o modelo e esforço pinados para esse agente quando existirem. A pergunta é quais fluxos são afetados; o escopo é apenas mapear caminhos e evidências, sem decidir arquitetura nem editar arquivos. A saída esperada são caminhos, evidências e lacunas. Vale paralelizar porque esse mapeamento não depende da decisão já fechada. Se você aprovar essa investigação, integramos o resultado aqui antes de fechar a spec.
```

- [x] **Step 2: Add one-decision and subagent-return examples**

Add these examples:

```md
Eu centralizaria o fluxo agora: reduz o número de contratos novos, mas concentra a primeira implementação. Antes de mapear arquivos ou abrir um agente, precisamos fechar essa escolha porque ela muda o escopo. Você prefere centralizar ou distribuir desde já?

O mapeamento confirmou que a regra já existe em dois serviços e contradiz a hipótese de uma alteração local. Mantemos a decisão de não mexer no cliente e voltamos ao planejamento do backend. Para fechar a spec transversal, minha sugestão é Terra XHigh, se estiver disponível.
```

- [x] **Step 3: Revise no-agent and missing-spec wording**

State that no-agent reasoning appears only at a material continuation point or when requested. Replace missing-spec wording so a complete conversational scope is valid and an external source is requested only when authoritative or materially incomplete.

- [x] **Step 4: Scan for template regressions**

Run `rg -n 'Default ending|Minha visão:|\[Quando ajudar|\[Não chamaria|\[Se isso fizer sentido' skills/think-with-me/references/output-contract.md`.

Expected: no bracketed default-ending structure remains.

## Task 4: Add activation and multi-turn evaluation cases

**Files:**

- Modify: `evals/trigger-cases.md`
- Modify: `evals/think-with-me-cases.md`
- Create: `evals/think-with-me-multiturn-cases.md`

**Interfaces:**

- Consumes: a new chat transcript with explicit invocation for behavior cases, or no invocation for activation cases.
- Produces: expected and forbidden outcomes for discovery and continuity.

- [x] **Step 1: Update activation and single-turn cases**

Add positive discovery prompts for `continue refinando este plano` and `quero decidir o próximo passo e se vale abrir um subagente`. Add isolated cases for conversational-scope handoff, material routing, and ineligible subagent handling. Keep typo correction, test execution, and translation as negative activation cases.

- [x] **Step 2: Create complete transcript cases**

Create `evals/think-with-me-multiturn-cases.md` with one numbered sequence each for retained decision/exclusion, latest correction wins, natural position, stable routing, irreversible-risk escalation, independent subagent proposal, subagent-result integration, conversational-scope handoff, agreement versus authorization, and host selection boundary.

Use this exact first case:

```md
### TWM-M01 — Preserve a decision and exclusion
1. User: "Compare A e B para uma migração."
2. Assistant: recommends A and identifies one open decision.
3. User: "Vamos de A, mas não abra subagente. Qual é o próximo ponto?"

Expected: retain A and the no-subagent exclusion; advance to the next dependency without recomparing A/B or repeating routing.
Forbidden: reopen A/B; recommend an agent; treat agreement as execution approval.
```

- [x] **Step 3: Check evaluation coverage**

Run `rg -n 'TWM-M0[1-9]|correção|subagent|seleção|autorização' evals/think-with-me-multiturn-cases.md`.

Expected: every continuity-design scenario has a named multi-turn case.

## Task 5: Validate source and prepare review evidence

**Files:**

- Modify only if needed: documentation status references that directly contradict the approved continuity design.

- [x] **Step 1: Check contradictory active policy**

Run `rg -n 'allow_implicit_invocation: false|approved spec is not identified|Default ending|always explain.*agent' skills docs evals || true`.

Expected: no active installable instruction contradicts the continuity design.

- [x] **Step 2: Run structural validation with isolated caches**

Run `UV_CACHE_DIR=/private/tmp/think-with-me-validate-uv UV_TOOL_DIR=/private/tmp/think-with-me-uv-tools bash scripts/validate-skill.sh`.

Expected: `Public-release validation passed.`

Then run `UV_CACHE_DIR=/private/tmp/think-with-me-verify-uv uv run --with pyyaml python /Users/igortice/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/think-with-me`.

Expected: `Skill is valid!` when the helper exists in the local Codex installation. If it is absent, validate `openai.yaml` with PyYAML and record that the missing helper is an environment limitation rather than a skill failure.

- [x] **Step 3: Run static checks and review diff**

Run `bash -n scripts/validate-skill.sh`, `bash -n scripts/verify-global-install.sh`, `git diff --check`, `git status --short`, and `git diff -- skills/think-with-me evals docs/specs docs/plans`.

Expected: all checks exit `0`; only approved continuity behavior, evaluations, and documentation changes are added; pre-existing local release-readiness work remains intact.

- [x] **Step 4: Stop for human review**

Do not run `git add`, `git commit`, `git push`, `npx skills update`, or global configuration commands. Present changed paths, validation evidence, remaining host-selection limitation, and the exact authorization required for a later commit or global synchronization.
