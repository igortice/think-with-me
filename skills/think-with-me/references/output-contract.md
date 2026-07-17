# Conversation Endings

Use this reference to preserve the useful information from a decision without making the conversation sound like a form.

## Default ending

Keep the main response natural. When a conclusion, phase change, or decision matters, end with one short paragraph in this shape:

~~~
**Minha visão:** eu seguiria com [escolha] porque [motivo e trade-off].

Para esta conversa, eu ficaria em [modelo] + [esforço]. [Se houver uma próxima tarefa concreta: quando fecharmos [tarefa], eu usaria [modelo] + [esforço].]

[Não chamaria outro agente agora porque ... | Eu sugeriria um [papel] para [escopo] em [modelo] + [esforço], porque ele pode devolver [saída verificável].]

[Se isso fizer sentido, eu sigo por esse caminho. | Antes de executar, preciso que você confirme [decisão ou escopo].]
~~~

Use only the sentences that apply. Never emit placeholders, a fixed set of headings, or a sentence saying that something is “not defined”.

## One open decision

When one user choice blocks progress, end with one focused question:

~~~
**Minha visão:** eu escolheria [opção] porque [motivo].

Para esta conversa, eu ficaria em [modelo] + [esforço]. [Explicação curta de agente, se relevante.]

Você prefere seguir com essa opção ou escolher [alternativa]?
~~~

Ask no second decision in the same turn.

## When a spec is approved but missing

Say naturally:

~~~
A direção parece aprovada, mas ainda preciso localizar a spec que define o escopo. Qual é o arquivo, issue ou trecho que devo usar como referência?
~~~

Do not say that implementation will start, and do not present this as a formal process label.

## Approval before execution

When the spec is known and the user must authorize work, say plainly:

~~~
Eu faria [resumo da abordagem]. Se você confirmar esse escopo, eu preparo o handoff para a execução com [modelo] + [esforço] e estes critérios de validação: [critérios].
~~~

## Context recap

Offer this only when a phase closes, the conversation is long, or the user asks to record it:

~~~
Até aqui, decidimos [decisões]. A evidência principal é [evidência]. Descartamos [alternativas] porque [motivo]. Ainda precisamos resolver [risco ou decisão]. O próximo passo é [passo].
~~~

Record the recap in the project's existing source of truth when one exists.

## Suggested agent

Mention another agent only when the work is independent. Keep it conversational:

~~~
Eu separaria [pergunta] para um [papel] em [modelo] + [esforço]. Ele ficaria restrito a [escopo] e me devolveria [saída]. Isso vale a pena porque [motivo]. Se você quiser, eu preparo esse handoff.
~~~

When no agent is warranted, say only the reason in one sentence, such as: “Eu não abriria outro agente agora porque a próxima decisão depende desta conversa.”
