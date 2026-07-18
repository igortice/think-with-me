# Think With Me — Evidence Gate v1

> **Historical status:** candidate identification remains useful, but the routing and delegation criteria in this document were superseded on 2026-07-17 by the simplified conversational contract. Current acceptance criteria live in `evals/think-with-me-cases.md` and `tests/evidence-gate-v1.sh`.

**Status:** implementado localmente; baseline comportamental ainda pendente
**Data:** 17 de julho de 2026
**Objetivo:** tornar a qualidade da skill verificável por um candidato identificado, evidências separadas e uma revisão humana final, sem multiplicar subagentes nem transformar cada mudança em uma revisão circular.

## 1. Problema

O repositório possui contrato instalável, referências, documentação e casos de avaliação, mas ainda não possui um sistema único que responda:

- qual versão exata foi avaliada;
- o que cada validação realmente prova;
- qual arquivo é proprietário de cada regra;
- quais achados impedem commit, publicação ou apenas exigem registro de risco.

Por isso, uma correção pode parecer concluída em uma revisão e voltar como contradição documental ou lacuna de evidência na seguinte.

## 2. Decisões de arquitetura

### 2.1 Candidato identificado

Toda revisão parte de um `candidate_id`, calculado a partir de:

- commit-base e branch;
- manifesto ordenado de arquivos modificados e não rastreados;
- hash de cada arquivo do pacote instalável;
- hash agregado do manifesto;
- versões dos casos de avaliação;
- limites conhecidos do ambiente.

Se qualquer item do manifesto mudar, o candidato muda e a evidência anterior não libera o novo candidato.

### 2.2 Autoridade por domínio

| Domínio | Proprietário normativo | Artefatos derivados ou históricos |
| --- | --- | --- |
| Fluxo, autoridade, fases e invariantes comportamentais | `skills/think-with-me/SKILL.md` | README, specs e planos |
| Matriz detalhada de família, esforço, escalonamento e subagent | `references/model-routing.md` | exemplos e evals |
| Ativação e metadata do host | `agents/openai.yaml` | casos de trigger |
| Exemplos de resposta | `references/output-contract.md` | somente ilustrativos; não criam regra |
| Comportamento verificado | `evals/` | não cria regra nova |
| Processo de release | `docs/release/skills-sh-publication.md` | README pode resumir e apontar para ele |
| Decisões e execução passadas | `docs/specs/` e `docs/plans/` concluídos | históricos; não competem com o pacote instalado |

Há uma exceção deliberada: `SKILL.md` manterá o resumo dos quatro roteamentos de emissão crítica. Testes anteriores mostraram que deixar esses valores apenas em uma referência opcional permite respostas com esforço inventado. A referência continua dona da matriz detalhada; uma validação semântica garantirá que o resumo e a matriz permaneçam alinhados.

### 2.3 Handoff de execução

Quando o escopo normal está aprovado, o roteamento que abre o handoff é o da **próxima tarefa**: `Luna XHigh, se disponível`. Não deve haver um segundo roteamento de conversa apenas por esse handoff, salvo se a aprovação também trouxer uma nova ambiguidade ou risco material. Isso elimina a ambiguidade entre roteamento de conversa e de tarefa.

### 2.4 Evidência não é aprovação

Os estados permitidos serão:

| Estado | Condição |
| --- | --- |
| Candidato em elaboração | Arquivos ainda mudam ou não há manifesto fechado. |
| Pronto para revisão humana | Manifesto fechado; gates exigidos passaram; achados e riscos estão integrados. |
| Pronto para commit | Revisão humana aprovou o mesmo `candidate_id` e autorizou explicitamente o commit. |
| Commitado | SHA privado existe; isso não significa pronto para publicação. |
| Pronto para publicação | CI do SHA, instalação limpa, segurança e runbook passaram; há autorização específica. |

## 3. Gates

### 3.1 Gate estrutural

Verifica o pacote e o repositório sem prometer comportamento:

- validator oficial Agent Skills;
- YAML, links relativos e manifesto permitido da skill;
- sintaxe de scripts e workflow;
- higiene do candidato incluindo arquivos não rastreados;
- alinhamento do resumo de roteamento crítico com a matriz detalhada.

O resultado deve se chamar `structural validation`, não `public-release validation`.

### 3.2 Gate comportamental

Executa casos autocontidos e registra, para cada caso:

- `candidate_id`, prompt e fixture;
- transcrição e log de ferramentas;
- critério avaliado, severidade e veredito `pass`, `fail`, `unclear` ou `not-observable`;
- trecho de evidência e avaliador.

O subconjunto obrigatório inicial cobre: não execução, aprovação explícita, correção de contexto, roteamento material, follow-up estreito, subagent independente e resultado de subagent sem decisão inventada. Casos de descoberta implícita permanecem separados porque dependem do host.

### 3.3 Gate de contrato

Um revisor rastreia requisitos do pacote instalável até os casos e exemplos. Ele não repete a validação mecânica nem reescreve documentação histórica. Conflito factual é reproduzido pelo agente principal; conflito de preferência ou risco segue para a pessoa.

### 3.4 Gate de instalação e publicação

Só ocorre depois de commit e autorização própria. Compara manifestos e hashes do candidato aprovado, da instalação limpa e da cópia global. Descoberta implícita e página do skills.sh são verificações de ambiente/pós-publicação, não falsas promessas do contrato local.

## 4. Uso de subagentes

O fluxo normal antes de commit tem no máximo dois sidecars, ambos somente leitura:

| Papel | Modelo/esforço | Responsabilidade exclusiva |
| --- | --- | --- |
| `qa_expert` | Sol High | Executar e registrar o gate comportamental; não revisar o diff inteiro. |
| `reviewer` | Sol High | Rastrear contrato, riscos e regressões; não repetir a suíte. |

O agente principal produz o manifesto, executa checks determinísticos, confirma evidências bloqueantes e integra o ledger. Nenhum agente escritor atua durante revisão. Um terceiro agente só cabe para uma pergunta independente de segurança ou publicação, nunca como voto extra.

## 5. Fora de escopo

- Commit, push, mudança de visibilidade, publicação ou sincronização global.
- Prometer que a skill controla a seleção persistente no host.
- Construir uma plataforma genérica de avaliação de LLMs.
- Transformar documentos históricos em cópias atualizadas do contrato.

## 6. Critérios de aceite

1. Cada candidato possui um manifesto e hash reproduzíveis antes da revisão.
2. O pacote instalável possui proprietário único por domínio e o resumo crítico é validado contra a referência detalhada.
3. O handoff de execução tem um único roteamento inequívoco.
4. A validação estrutural não declara provar comportamento ou release.
5. Casos críticos são autocontidos, registram evidência e não usam saída do assistente como fixture pré-escrita.
6. Nenhum hard gate crítico pode terminar como `unclear` para declarar o candidato pronto para revisão humana.
7. O fluxo de subagentes normal usa no máximo dois sidecars antes de commit.
