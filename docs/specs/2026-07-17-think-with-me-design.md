# Think With Me — especificação de design

**Status:** proposta para revisão  
**Data:** 17 de julho de 2026  
**Repositório:** `igortice/think-with-me` (privado durante a maturação)

## 1. Problema

O usuário trabalha melhor por colaboração deliberada: entende o contexto, conversa sobre alternativas, planeja, registra uma spec, aprova o caminho e só então executa. Com GPT-5.6, a escolha agora depende de duas dimensões — família de modelo e esforço — e uma escolha inadequada em conversas longas consome a cota sem adicionar qualidade proporcional.

Hoje essas decisões ficam implícitas em cada conversa. A skill deve tornar explícitos:

- a fase real do trabalho;
- a leitura e a recomendação do assistente;
- o próximo passo que preserva o gate de aprovação humana;
- a sugestão de modelo/esforço e, quando houver trabalho independente, de subagent.

## 2. Objetivo

`$think-with-me` conduz uma conversa de descoberta, decisão e planejamento sem tomar o controle da execução. Ao final de cada ponto de decisão relevante, ela produz uma posição clara do assistente e um encaminhamento prático.

Ela deve funcionar tanto em conversas sem repositório quanto em projetos que usam `project-context`, OpenSpec ou outro processo de spec.

## 3. Não objetivos

- Não implementar, editar arquivos, criar branches, abrir PRs ou disparar subagents por conta própria.
- Não substituir `project-context`, OpenSpec, skills de diagnóstico, code review ou execução de planos.
- Não prometer que uma configuração gastará uma quantidade específica de cota do Codex. Benchmarks de API e créditos do produto não são a mesma métrica.
- Não tratar um benchmark único como verdade absoluta para toda tarefa.
- Não obrigar uma entrevista longa quando já existe contexto suficiente para uma recomendação.

## 4. Forma de invocação

A skill será manual, no padrão de `grill-me`:

```yaml
name: think-with-me
description: Collaboratively understand a problem or idea before acting. Use when the user wants to discuss, plan, assess options, receive a clear recommendation, identify the next step, or choose an appropriate model, effort, or subagent.
disable-model-invocation: true
```

Consequências:

- é ativada conscientemente com `$think-with-me`;
- não adiciona contexto a toda conversa comum;
- pode ser usada desde a descoberta até o gate anterior à execução.

## 5. Fluxo de conversa

### 5.1 Ler antes de conduzir

1. Identificar o que já foi decidido e o que continua aberto.
2. Se houver projeto, procurar o contexto e a spec existentes antes de pedir ao usuário para repetir informação.
3. Distinguir fatos verificáveis de escolhas de produto/arquitetura. Verificar fatos quando necessário; devolver escolhas ao usuário com recomendação fundamentada.

### 5.2 Conduzir a decisão

Usar a disciplina de `grill-me` de maneira condicional:

- Se uma decisão importante ainda estiver aberta, fazer uma pergunta por vez, explicar por que ela importa e oferecer uma resposta recomendada.
- Se o contexto já for suficiente, não prolongar a entrevista: sintetizar, apontar o risco e recomendar diretamente.

### 5.3 Fechar cada etapa

Quando a conversa atingir uma decisão, mudança de fase ou próximo trabalho claro, responder neste contrato:

```md
## Minha leitura
[o que entendi, premissas e risco principal]

## Minha recomendação
[a escolha que eu faria e por quê]

## Próximo passo
[a menor ação que reduz incerteza ou avança o trabalho]

## Roteamento sugerido
- Principal: [modelo] + [esforço] — [justificativa curta]
- Subagent: [nenhum | papel + escopo independente + modelo/esforço]

## Gate
[o que depende de aprovação explícita antes de executar]
```

O bloco de roteamento pode ser omitido quando não houver uma tarefa concreta. O bloco de subagent deve dizer **nenhum** quando a conversa e a decisão dependem do contexto compartilhado.

## 6. Classificação de fase

| Fase observada | Resultado esperado da skill | Execução permitida? |
|---|---|---|
| Entendimento | mapa do problema, contexto faltante e perguntas decisivas | Não |
| Exploração | alternativas, impactos, evidências e riscos | Não |
| Planejamento | abordagem escolhida, sequência, dependências e validação | Não |
| Spec | documento ou estrutura de requisitos pronta para revisão | Não |
| Aguardando aprovação | resumo do que será feito e gate explícito | Não |
| Execução aprovada | handoff claro para a skill/fluxo de execução | Só após aprovação do usuário |
| Diagnóstico/revisão | hipótese, evidência necessária e critério de saída | Não, salvo aprovação específica |

## 7. Política inicial de modelo e esforço

Esta política é uma recomendação operacional, não uma contabilidade de créditos. Ela será mantida em uma referência separada para poder evoluir quando os modelos, esforços ou limites do Codex mudarem.

| Situação | Escolha inicial | Quando subir | Quando não usar |
|---|---|---|---|
| Conversa de contexto, entendimento e planejamento comum | Terra High | Terra XHigh se houver muitas dependências ou ambiguidade persistente | Não usar Max por padrão em conversa longa |
| Spec que conecta várias áreas do projeto | Terra XHigh | Sol High se a decisão for crítica, arquitetural ou de segurança | Não manter Sol ativo durante toda a descoberta |
| Decisão ambígua, arquitetura, segurança, migração ou causa-raiz difícil | Sol High | Sol XHigh se a primeira análise ainda deixar incerteza material | Não começar diretamente em Sol Max |
| Tarefa pequena, clara e repetitiva | Luna High | Luna XHigh se exigir implementação normal | Não usar para fechar decisão arquitetural ambígua sozinho |
| Implementação aprovada e bem delimitada | Luna XHigh | Luna Max para execução autônoma longa, bem especificada e com critério de validação | Não usar Max apenas porque a tarefa é importante |
| Último recurso de alto risco | Sol Max | Nenhum; é o teto | Não usar como padrão diário |

Heurística de escalonamento:

1. Começar no menor nível que sustente a fase e a incerteza.
2. Subir por evidência: ambiguidade que persiste, falha repetida, risco alto ou dependência transversal real.
3. Manter o modelo mais caro em uma intervenção curta e com pergunta precisa; voltar ao modelo padrão depois.
4. Tratar conversas longas como contexto caro: resumir e registrar decisões, em vez de apenas aumentar o esforço.

## 8. Política de subagents

Um subagent será apenas sugerido — nunca criado automaticamente pela skill.

| Condição | Sugestão | Não sugerir quando |
|---|---|---|
| Há um mapa de código, documentação ou dados a levantar de forma independente | `explorer`/`code_mapper` ou `docs_researcher`, normalmente Terra High | A resposta depende de uma decisão que o usuário ainda não tomou |
| Há duas investigações independentes com critérios claros | Dois subagents com escopos sem sobreposição, normalmente Terra High | O trabalho é pequeno, sequencial ou compartilha o mesmo arquivo/decisão |
| Há uma decisão crítica, ameaça de segurança ou diagnóstico difícil | `reviewer`/`debugger`, Sol High | A situação ainda é apenas falta de contexto simples |

Toda sugestão deve declarar: papel, escopo, pergunta de saída, modelo/esforço e por que vale a pena paralelizar.

## 9. Integração com o processo do usuário

- Quando existir `project-context`, tratar seus registros como fonte de continuidade e atualizar somente depois da aprovação/ação correspondente.
- Quando existir OpenSpec, a skill ajuda a esclarecer e revisar a spec; não substitui os gates do processo.
- Quando não houver nenhuma dessas ferramentas, a skill mantém no chat um resumo compacto das decisões, alternativas descartadas e próximos gates.
- O usuário continua sendo a autoridade de produto e de início de execução.

## 10. Estrutura do repositório

Depois da aprovação desta especificação, a primeira versão terá:

```text
skills/think-with-me/
├── SKILL.md
├── agents/openai.yaml
└── references/model-routing.md

README.md
LICENSE
docs/specs/2026-07-17-think-with-me-design.md
```

`SKILL.md` será enxuto e apontará para `references/model-routing.md` apenas quando precisar sugerir roteamento. O README e a licença ficam na raiz para preparar a futura publicação, sem poluir a pasta instalável da skill.

## 11. Critérios de aceite da versão inicial

1. `$think-with-me` pode iniciar uma conversa de planejamento sem executar trabalho.
2. Para uma decisão aberta, oferece uma pergunta por vez e uma opção recomendada.
3. Para contexto suficiente, oferece uma conclusão direta, sem entrevista artificial.
4. Em um ponto de decisão, entrega leitura, recomendação, próximo passo e gate de aprovação.
5. Quando houver tarefa concreta, sugere modelo/esforço com justificativa e sem inventar números de cota.
6. Só sugere subagent para escopo independente e explícito; nunca o dispara.
7. A pasta da skill passa a validação estrutural antes de ser instalada localmente.
8. A instalação local será testada no Codex antes de qualquer publicação pública.

## 12. Próximo gate

Revisar esta especificação. Após aprovação, criar a estrutura da skill, escrever `SKILL.md`, a referência de roteamento e os metadados de agente; então validar e instalar localmente. A publicação no GitHub público fica para depois de uso real e ajustes.
