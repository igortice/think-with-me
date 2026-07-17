# Output Contract

Use this reference when closing a material decision, handing off approved work, or preserving context between phases. Reply in the language of the conversation. The Portuguese form below is the default for a Portuguese conversation.

## Material decision closure

~~~
## Minha leitura
- Fatos e decisões já confirmados:
- Premissas que estou usando:
- Incerteza ou risco principal:

## Minha recomendação
[Escolha clara que eu faria agora.]
Trade-off aceito: [o que se ganha e o que se abre mão].

## Próximo passo
[A menor ação que reduz a incerteza ou avança o trabalho.]

## Roteamento sugerido
- Conversa atual: [modelo] + [esforço] — [fase atual e motivo].
- Próxima tarefa: [ainda não definida | modelo + esforço — tarefa delimitada e motivo].
- Escalonamento: [condição observável para subir, pausar ou descer].
- Subagent: [nenhum | papel, pergunta, escopo independente, saída, modelo/esforço].

## Gate
[O que já está aprovado e qual aprovação, evidência ou decisão ainda falta antes de executar.]
~~~

Do not fill sections with generic prose. Always state the conversation model for the current phase. If the next task is not concrete, state **Próxima tarefa: ainda não definida** rather than inventing an implementation route. Always state **Subagent: nenhum** unless a valid independent scope exists.

Use this closure before any follow-up question when the conversation reaches a planning, spec, approval, diagnosis, review, or routing boundary. The question must be the only unresolved decision left after the closure.

## One-question pattern

Use when a material choice remains open:

~~~
A decisão que falta é: [decisão].

Ela muda [impacto] porque [causalidade].

Minha opção recomendada é: **[opção]** — [razão curta].

Você prefere seguir com essa opção ou escolher [alternativa]?
~~~

Ask only this question. Do not add a second decision in the same turn.

If the user says that a spec is approved but does not identify it, make the single question: **Qual é o arquivo, issue ou trecho da spec aprovada que define o escopo?** Keep the gate as execution context missing; never promise implementation.

## Direct-synthesis pattern

Use when evidence and context already support the answer:

~~~
Com o contexto atual, eu seguiria com **[escolha]**.

O ponto que sustenta isso é [evidência]. O risco residual é [risco].

Não preciso de nova decisão agora; o próximo gate é [gate].
~~~

## Context packet

Use when a phase ends, the conversation is large, or work moves to another session:

~~~
## Decisões confirmadas
- ...

## Evidências e fontes
- ...

## Alternativas descartadas e motivo
- ...

## Riscos pendentes
- ...

## Spec/plano atual
- ...

## Próximo gate e aprovação necessária
- ...
~~~

Write this into the project's existing system of record when one exists. Otherwise keep it in the conversation until the user chooses a repository location.

## Subagent recommendation

Recommend only; do not dispatch.

~~~
## Subagent sugerido
- Papel: [papel]
- Pergunta: [pergunta específica]
- Escopo independente: [arquivos, documentos ou investigação; sem sobreposição]
- Saída esperada: [artefato verificável]
- Roteamento: [modelo] + [esforço]
- Por que paralelizar: [ganho concreto]
- Gate: aguardando sua aprovação para iniciar
~~~

When any field cannot be stated clearly, use **Subagent: none**.

## Approved-execution handoff

Use only after the user explicitly approves execution:

~~~
## Execução aprovada
- Escopo aprovado: ...
- Fora de escopo: ...
- Critérios de aceite e validação: ...
- Contexto/spec de referência: ...
- Roteamento inicial: ...
- Pausar e voltar ao planejamento se: ...
~~~

Do not reinterpret approval as permission to expand scope, alter unrelated files, or skip validation.
