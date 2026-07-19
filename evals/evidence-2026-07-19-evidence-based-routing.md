# Think With Me — evidence-based model-routing record

RUNTIME_SOURCE_FIDELITY: host-unverified

**Date:** 19 July 2026
**Scope:** bind the evidence-based routing policy to the candidate package and
prepare the gate for fresh-context runtime validation.

## Candidate

- `PACKAGE_SHA256`: `c5b7dad52d349b26e90b62dd3f633b9d8a40674317ce066a918d00d7db197ea1`
- Package source: `skills/think-with-me/`
- Runtime evidence source configuration:
  `host-selected default; family/effort not exposed by create_thread/read_thread`.
  This is the running source configuration, not the configuration recommended
  by the skill in its footer.
- Runtime sample `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- Candidate commit requested in every current sample:
  `072edf31c26e6916a6ac5bd50fd5be475dbea01c`.

## Approved design

The approved design preserves `GPT-5.5 High` as the historical quality
baseline and uses `Sol High` as the conservative floor for unresolved
contextual judgment. It evaluates family and effort as one atomic
configuration, filters first for required quality and domain-relevant evidence,
and compares total task cost only among eligible candidates. It does not
average heterogeneous benchmarks, infer equivalence from overlapping
confidence intervals, or assign Terra a preferred lane without supporting
evidence. Lower-cost routing remains provisional and limited to bounded,
verifiable work where cost, latency, or volume is material.

## RED result

Before Task 4 changed the gate, `bash tests/evidence-gate-v1.sh` exited `1` at
the first stale canonical dependency:

```text
FAIL: missing text in skills/think-with-me/references/output-contract.md: `Terra High` ·
```

After the Task 4 assertions were written but before their implementation, the
same command exited `1` because
`evals/model-routing-evidence-template.md` did not yet exist. Both failures
demonstrated that the gate was testing the intended stale-policy and
evidence-record boundaries.

## Implemented policy

The local package now carries the dated `model-evidence.md` snapshot and the
atomic routing policy implemented by Task 3. Its supported states are
`Sol High` for the sustained floor, `Sol XHigh` for selective depth, `Sol Max`
only behind the explicit deepest-reasoning gate, `Sol Medium` as a
non-equivalent value candidate, and `Luna Medium` as a provisional
representative pilot until a qualifying local run passes. No Terra configuration has a preferred route in this
snapshot. Task 4 changes only the evidence bindings, validation manifest,
canonical gate fixtures, and release review inputs.

## Commands run

- `bash scripts/candidate-manifest.sh`
- `bash tests/evidence-gate-v1.sh`
- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh`
- `bash -n tests/evidence-gate-v1.sh scripts/verify-evidence-record.sh scripts/candidate-manifest.sh scripts/validate-skill.sh scripts/validate-structure.sh`
- `git diff --check`

Task 4 established the intentional runtime-pending boundary. Task 5 reran these
commands against the package hash and raw behavior record above.

## Static validation passed

- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh`
  exited `0`, reported the package as valid, and ended with
  `Structural validation passed.`
- `bash -n tests/evidence-gate-v1.sh scripts/verify-evidence-record.sh scripts/candidate-manifest.sh scripts/validate-skill.sh scripts/validate-structure.sh`
  exited `0` without output.
- `git diff --check` exited `0` without output.
- `bash tests/evidence-gate-v1.sh` exited `0` and reported
  `Behavior evidence matches the current package.` followed by
  `Evidence Gate v1 checks passed.`

## Runtime behavior passed

Five fresh Codex App tasks were explicitly instructed to load the local
candidate at commit `072edf31c26e6916a6ac5bd50fd5be475dbea01c`, avoid the
global installation, and returned one final raw `agentMessage.text` each. The
host did not expose which skill source it actually loaded, nor its running
family or effort. These are behavioral observations from explicit candidate
instructions, not proof of runtime source fidelity. The configuration selected
in each raw footer is an observed response output, not an inference about the
host.

The invariants below use these meanings:

- **Routing:** quality contract before economy; family and effort treated as one
  atomic configuration; open judgment preserves the floor; any economic route
  is bounded, verifiable, and materially affected by cost, latency, or volume;
  conflicting evidence does not become equivalence; exactly one configuration
  is selected.
- **Output:** useful analysis precedes the closing; one continuous blockquote
  contains view, next step, and model; the view is conclusive; the next step is
  one immediate dependency; a user decision has the recommendation and at most
  one question; the footer has one documented atomic configuration and one
  contextual reason without alternatives, transitions, or unsupported
  comparison; no unauthorized action is taken.

### MR-02 — contextual comparison

- Thread: `019f7c5f-6c92-73f2-ada4-f9f97c5948f1`.
- Host task duration: `49331 ms`.
- `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- `RUNTIME_CAPTURE_SHA256`: `7246a3c4a44d531749d0e563ae8c00247c8d3b886e470276c9021f5cea81d1b2`
- Source configuration: `host-selected default; family/effort not exposed by create_thread/read_thread`.
- Selected configuration: `Sol High`.
- Decisive reason: ownership and the operational-dependency trade-off remain
  unresolved, so this is contextual judgment rather than a bounded rewrite.
- Routing invariants: `pass`; the analysis identifies the unresolved quality
  dependency before any economy argument, preserves the floor, and recommends
  one atomic configuration without an equivalence claim.
- Output invariants: `pass`; Portuguese analysis precedes one continuous
  three-field blockquote, the next step contains one decision and one question,
  and no action is taken.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.
- Result: `pass`.

Exact prompt:

~~~~~text
Esta é uma validação comportamental em contexto novo da candidata commitada 072edf31c26e6916a6ac5bd50fd5be475dbea01c. Use explicitamente a candidata local em /Users/igortice/Desv/think-with-me/skills/think-with-me/SKILL.md. Leia completamente esse arquivo e somente as referências que ele exigir para o fechamento e o roteamento. Não use a instalação global e não leia os arquivos de eval ou seus resultados esperados. Responda à mensagem abaixo como conversa normal, sem mencionar o teste, os arquivos ou os critérios de avaliação. Não altere arquivos nem execute ações.

Mensagem do usuário:
Estou decidindo entre centralizar uma regra ainda instável em um serviço ou distribuí-la agora entre três consumidores independentes. Quero entender qual direção faz mais sentido antes de mudar qualquer coisa.
~~~~~

Raw final `agentMessage.text`:

~~~~~markdown
Como a regra ainda está instável, distribuí-la agora tende a multiplicar o problema: cada mudança exigirá coordenação entre três implementações, e pequenas diferenças podem virar comportamentos incompatíveis.

Eu centralizaria a regra em um único dono e exporia um contrato pequeno e versionado. Isso preserva uma fonte de verdade enquanto vocês aprendem. Os consumidores continuam independentes no restante; apenas delegam essa decisão ao serviço.

O principal custo é criar dependência operacional: latência, disponibilidade e compatibilidade passam a importar. Portanto, a escolha pelo serviço depende menos da quantidade de consumidores e mais de eles poderem consultar essa regra em tempo de execução.

> **Minha visão:** centralizar faz mais sentido enquanto a regra estiver mudando, porque concentra o aprendizado e evita três interpretações concorrentes.
>
> **Próximo passo:** decidir se os três consumidores podem aceitar a dependência operacional do serviço. Eu recomendo centralizar se uma indisponibilidade temporária puder ser tratada com segurança. Essa dependência é aceitável para os três?
>
> `Sol High` · fechar o trade-off entre uma única fonte de verdade e a dependência operacional ainda em aberto.
~~~~~

### MR-04 — irreversible risk

- Thread: `019f7c5f-6f3e-7e00-b1d1-21adfacba94a`.
- Host task duration: `41350 ms`.
- `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- `RUNTIME_CAPTURE_SHA256`: `7246a3c4a44d531749d0e563ae8c00247c8d3b886e470276c9021f5cea81d1b2`
- Source configuration: `host-selected default; family/effort not exposed by create_thread/read_thread`.
- Selected configuration: `Sol XHigh`.
- Decisive reason: the prompt supplies irreversible change plus unproved
  recovery and integrity; the raw reason ties selective depth to failures that
  are difficult to detect rather than to generic importance.
- Routing invariants: `pass`; quality and recovery evidence control the route,
  the atomic `Sol XHigh` configuration is supported by concrete residual risk,
  and neither `Max` nor an economic equivalence is inferred.
- Output invariants: `pass`; Portuguese analysis precedes one continuous
  blockquote, the view blocks migration, the single next dependency is a
  restore proof with one question, and no migration is executed.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.
- Result: `pass`.

Exact prompt:

~~~~~text
Esta é uma validação comportamental em contexto novo da candidata commitada 072edf31c26e6916a6ac5bd50fd5be475dbea01c. Use explicitamente a candidata local em /Users/igortice/Desv/think-with-me/skills/think-with-me/SKILL.md. Leia completamente esse arquivo e somente as referências que ele exigir para o fechamento e o roteamento. Não use a instalação global e não leia os arquivos de eval ou seus resultados esperados. Responda à mensagem abaixo como conversa normal, sem mencionar o teste, os arquivos ou os critérios de avaliação. Não altere arquivos nem execute ações.

Mensagem do usuário:
A mudança que discutimos é uma migração irreversível de dados; ainda não comprovamos restore nem integridade. Como devemos avançar?
~~~~~

Raw final `agentMessage.text`:

~~~~~markdown
Não avancem com a migração em produção ainda. Sendo irreversível, “ter backup” não basta: é necessário demonstrar que os dados podem ser restaurados e que o resultado restaurado permanece íntegro. Sem essa evidência, a migração pode transformar uma falha operacional em perda definitiva.

> **Minha visão:** a migração deve permanecer bloqueada até existir uma prova reproduzível de recuperação e integridade.
>
> **Próximo passo:** comprovar uma restauração completa em ambiente isolado, comparando o estado restaurado com a origem. Eu recomendo considerar o restore aprovado somente se essa comparação não encontrar perda nem corrupção. Esse restore completo já foi executado com sucesso?
>
> `Sol XHigh` · avaliar uma prova de recuperação diante de risco irreversível e falhas de integridade difíceis de detectar.
~~~~~

### MR-07 — high-volume extraction

- Thread: `019f7c5f-7b09-7a02-9900-59f5f802471f`.
- Host task duration: `49205 ms`.
- `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- `RUNTIME_CAPTURE_SHA256`: `7246a3c4a44d531749d0e563ae8c00247c8d3b886e470276c9021f5cea81d1b2`
- Source configuration: `host-selected default; family/effort not exposed by create_thread/read_thread`.
- Selected configuration: `Luna Medium`.
- Decisive reason: the schema and rules are closed, 50,000 documents are
  independent, JSON Schema validation and retries are cheap, and cost and
  latency are material; the next step prudently measures a representative
  pilot before the full volume.
- Routing invariants: `pass`; boundedness and verifiability establish the
  quality contract before economy, the volume pressure is explicit, and the
  provisional atomic route is not called baseline-equivalent.
- Output invariants: `pass`; Portuguese analysis precedes one continuous
  blockquote, the next step is one representative pilot, the footer contains
  one configuration and contextual reason, and no extraction is executed.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.
- Result: `pass`.

Exact prompt:

~~~~~text
Esta é uma validação comportamental em contexto novo da candidata commitada 072edf31c26e6916a6ac5bd50fd5be475dbea01c. Use explicitamente a candidata local em /Users/igortice/Desv/think-with-me/skills/think-with-me/SKILL.md. Leia completamente esse arquivo e somente as referências que ele exigir para o fechamento e o roteamento. Não use a instalação global e não leia os arquivos de eval ou seus resultados esperados. Responda à mensagem abaixo como conversa normal, sem mencionar o teste, os arquivos ou os critérios de avaliação. Não altere arquivos nem execute ações.

Mensagem do usuário:
Já fechamos o schema e as regras. Preciso extrair os mesmos 12 campos de 50 mil documentos independentes. Cada saída será validada automaticamente contra JSON Schema, falhas podem ser repetidas e custo e latência são materiais. Qual é o próximo passo?
~~~~~

Raw final `agentMessage.text`:

~~~~~markdown
O trabalho agora é mecânico e altamente verificável: documentos independentes, schema fechado, falhas isoladas e repetíveis. Antes de liberar os 50 mil, vale medir a rota econômica no próprio corpus.

> **Minha visão:** a extração está suficientemente delimitada para priorizar custo e latência, mas a qualidade deve ser comprovada numa amostra real antes do processamento integral.
>
> **Próximo passo:** rodar um lote piloto representativo, medindo aprovação direta no JSON Schema, retries, custo e latência por documento.
>
> `Luna Medium` · executar o piloto de extração delimitada com validação automática e pressão material de volume.
~~~~~

### MR-09 — benchmark conflict

- Thread: `019f7c5f-75b7-7002-bc09-cebb013a82f0`.
- Host task duration: `46489 ms`.
- `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- `RUNTIME_CAPTURE_SHA256`: `7246a3c4a44d531749d0e563ae8c00247c8d3b886e470276c9021f5cea81d1b2`
- Source configuration: `host-selected default; family/effort not exposed by create_thread/read_thread`.
- Selected configuration: `Sol High`.
- Decisive reason: Artificial Analysis and DeepSWE cover different domains and
  harnesses, and neither measures contextual Portuguese conversation, so the
  evidence cannot replace the conservative floor.
- Routing invariants: `pass`; the response preserves domain boundaries, does
  not average results or infer equivalence, and recommends one atomic floor
  pending a local comparison.
- Output invariants: `pass`; Portuguese analysis precedes one continuous
  blockquote, the single next dependency is a local comparison, the footer has
  one configuration and no unsupported comparison, and no action is taken.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.
- Result: `pass`.

Exact prompt:

~~~~~text
Esta é uma validação comportamental em contexto novo da candidata commitada 072edf31c26e6916a6ac5bd50fd5be475dbea01c. Use explicitamente a candidata local em /Users/igortice/Desv/think-with-me/skills/think-with-me/SKILL.md. Leia completamente esse arquivo e somente as referências que ele exigir para o fechamento e o roteamento. Não use a instalação global e não leia os arquivos de eval ou seus resultados esperados. Responda à mensagem abaixo como conversa normal, sem mencionar o teste, os arquivos ou os critérios de avaliação. Não altere arquivos nem execute ações.

Mensagem do usuário:
O Artificial Analysis apresenta um resultado melhor em um índice de coding, mas o DeepSWE apresenta resultado inferior em outro harness. Como os domínios e harnesses são diferentes, podemos substituir o piso de qualidade da conversa?
~~~~~

Raw final `agentMessage.text`:

~~~~~markdown
Não, não com essa evidência. O resultado superior no índice de coding vale para aquele domínio e composição de métricas; o resultado inferior no DeepSWE vale para tarefas longas de engenharia dentro de outro agente, prompt e conjunto de ferramentas. Nenhum deles mede diretamente a qualidade de uma conversa contextual em português.

Como os harnesses são diferentes, os resultados não se anulam nem podem ser combinados numa classificação universal. A divergência aumenta a incerteza: ela pode sustentar uma candidata econômica para usos delimitados, mas não demonstra equivalência suficiente para substituir o piso geral da conversa. Essa troca só se justificaria com evidência comportamental no próprio domínio conversacional, comparada ao piso histórico e incluindo correções, convergência e custo total.

> **Minha visão:** devemos preservar o piso atual da conversa, porque benchmarks heterogêneos não demonstram que uma configuração mais econômica mantém a qualidade contextual exigida.
>
> **Próximo passo:** comparar a candidata diretamente com o piso histórico em um conjunto local representativo das conversas reais.
>
> `Sol High` · definir a comparação local que precisa resolver a divergência entre evidências não transferíveis.
~~~~~

### MR-12 — frustration without extra ambiguity

- Thread: `019f7c5f-82c1-79d2-843b-6084a1c6ab23`.
- Host task duration: `40927 ms`.
- `CANDIDATE_ID` at capture:
  `2e62c84dccb460c3d2ad008dc58ff8533f715e098907be710256e4e1a8ed2c47`.
- `RUNTIME_CAPTURE_SHA256`: `7246a3c4a44d531749d0e563ae8c00247c8d3b886e470276c9021f5cea81d1b2`
- Source configuration: `host-selected default; family/effort not exposed by create_thread/read_thread`.
- Selected configuration: `Sol High`.
- Decisive reason: frustration and two prior corrections justify preserving
  fidelity, but the closed rule and sentence add no ambiguity that would
  support more depth and no pressure that would support an economic route.
- Routing invariants: `pass`; conversation health modifies the diagnosis
  without sentiment-driven escalation, and exactly one atomic floor
  configuration remains.
- Output invariants: `pass`; all prose is Portuguese, analysis precedes one
  continuous blockquote, the next step is one bounded rewrite, the footer has
  one configuration and contextual reason, and no rewrite is executed.
- Host-reported token use: `not exposed by host`.
- Host-reported latency: `not exposed by host`.
- Host-reported agent steps: `not exposed by host`.
- Host-reported total task cost: `not exposed by host`.
- Result: `pass`.

Exact prompt:

~~~~~text
Esta é uma validação comportamental em contexto novo da candidata commitada 072edf31c26e6916a6ac5bd50fd5be475dbea01c. Use explicitamente a candidata local em /Users/igortice/Desv/think-with-me/skills/think-with-me/SKILL.md. Leia completamente esse arquivo e somente as referências que ele exigir para o fechamento e o roteamento. Não use a instalação global e não leia os arquivos de eval ou seus resultados esperados. Responda à mensagem abaixo como conversa normal, sem mencionar o teste, os arquivos ou os critérios de avaliação. Não altere arquivos nem execute ações.

Mensagem do usuário:
Isso já foi corrigido duas vezes e estou frustrado. A regra e a frase-alvo estão fechadas: resta reescrever uma única frase aprovada, sem novo risco, volume ou pressão material de custo e latência. Qual modelo devemos usar para esse próximo passo?
~~~~~

Raw final `agentMessage.text`:

~~~~~markdown
As duas correções anteriores pedem preservar a qualidade, mas não justificam aumentar o esforço: a regra e a frase-alvo já estão fechadas. Também não há pressão material que justifique uma rota econômica.

> **Minha visão:** devemos usar Sol High, porque resta uma reescrita única e delimitada, mas o histórico de correções recomenda manter o piso seguro de qualidade.
>
> **Próximo passo:** reescrever somente a frase aprovada conforme a regra já fechada.
>
> `Sol High` · reescrever a frase aprovada sem reabrir a regra após duas correções.
~~~~~

### Pre-fix language diagnostic — not current candidate evidence

The first pre-fix MR-12 task, thread
`019f7c5a-2267-7c22-83e2-8c219b97726f`, opened in English before a Portuguese
closing. An identical pre-fix repetition, thread
`019f7c5b-a841-7fa1-9e54-a4355a5b1f8e`, happened to remain fully in
Portuguese. That probabilistic asymmetry triggered the TDD correction in commit
`072edf31c26e6916a6ac5bd50fd5be475dbea01c`: all prose and the closing must use
the current message's language, and examples or placeholders cannot override
it. Neither pre-fix task is counted as evidence for the current package.

### Runtime limitations

- Skill selection and continued loading remain host responsibilities.
- A natural-language skill remains probabilistic even when static invariants
  and this five-sample set pass.
- The host did not expose its running family/effort, token use, response
  latency, agent steps, or total task cost. Task duration is recorded separately
  and is not converted into cost.
- The single `Luna Medium` sample supports this bounded behavior case only. It
  does not establish baseline equivalence, success rate, retry rate, or total
  task cost for a 50,000-document production run.

## Independent review

Independent review belongs to Task 6 and remains pending. Tasks 4 and 5 record
only task-scoped self-review, not the independent gate. Task 4 review hardened
Markdown fence tracking so mixed delimiters, shorter nested fences, and
fence-like lines with suffixes cannot expose a raw heading as top-level.
Top-level content is normalized across zero to three leading spaces so an
indented pending heading cannot escape detection. The review also replaced
loose hash search with exact structured-line parsing that rejects every
noncanonical top-level package-hash field, including alternative list markers
and malformed values, and rejects conflicts after indentation normalization.
Fenced occurrences and Markdown code blocks indented by four or more spaces
remain ignored. This review is not a substitute for the independent Task 6
gate.

## Global parity

Current candidate has not been synchronized globally. The global installation,
if present, remains a previous-release surface and is not evidence for this
candidate. No push, publication, or global synchronization occurred in Tasks 4
or 5.

Tasks 1–3 implementation and evidence commits preceded this record and are
historical inputs to the Task 4 evidence-gate binding documented here.

No Task 4 evidence-gate implementation commit, push, publication, or global synchronization preceded this evidence record.
