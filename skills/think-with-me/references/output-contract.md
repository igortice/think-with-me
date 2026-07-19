# Conversation Examples

These examples show how to answer naturally and then advance one dependency. The normal answer stays outside the quote; the three-field closing is one continuous blockquote so it renders with a vertical bar. The view and next-step labels follow the user's language; the third line is the selected model as an inline-code label.

Write all prose before the closing and the closing itself in that same language; examples and placeholder text never override the current user message's language.

## Host activation boundary

This output contract only applies when the skill is loaded for that response. It cannot retain or invoke itself on a later turn; host selection, an explicit new invocation, or a host-level mechanism determines whether the contract is available again.

## Canonical closing templates

Use the Portuguese template when the current user message is Portuguese:

> **Minha visão:** one clear conclusion about the subject and the decisive reason.
>
> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> `Sol High` · connect the concrete next step to the decisive conversational evidence.

Use the English template when the current user message is English:

> **My view:** one clear conclusion about the subject and the decisive reason.
>
> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> `Sol High` · connect the concrete next step to the decisive conversational evidence.

For other languages, preserve these three roles with concise natural view and next-step labels. The final line has no translated model-field label. `Próximo passo` contains at most one `?` character when the next step is a user decision.

## Normal continuation

Uma regra imatura muda com frequência. Distribuí-la agora criaria três interpretações e transformaria cada aprendizado em coordenação entre serviços.

> **Minha visão:** centralizar é a direção mais segura enquanto a regra amadurece, porque preserva uma única fonte de verdade.
>
> **Próximo passo:** definir quais resultados o contrato central deve devolver.
>
> `Sol High` · definir as saídas do contrato ainda em descoberta.

## English continuation

Keep the same contract when the user writes in English; only the labels change.

The rule is still evolving, so distributing it would create several interpretations and make each correction require coordination.

> **My view:** centralizing the first version is safer because it preserves one source of truth while the rule matures.
>
> **Next step:** define the outputs the central contract must return.
>
> `Sol High` · define the contract outputs while the rule remains under discovery.

## One open decision

When the user must choose, advance with one question and your recommended answer:

Centralizar reduz divergência; distribuir aumenta autonomia, mas antecipa contratos que ainda podem mudar.

> **Minha visão:** a regra ainda não está estável o suficiente para ser distribuída.
>
> **Próximo passo:** decidir se a primeira versão terá uma única fonte de verdade. Eu recomendo que sim. Você confirma essa direção?
>
> `Sol High` · fechar a escolha de uma única fonte de verdade.

## Narrow follow-up

A distribuição precoce não é tecnicamente impossível; o problema é pagar agora o custo de sincronizar três comportamentos ainda instáveis.

> **Minha visão:** centralizar continua sendo a melhor escolha enquanto a regra permanecer em descoberta.
>
> **Próximo passo:** definir quais entradas pertencem ao contrato central.
>
> `Sol High` · delimitar as entradas sem reabrir a arquitetura.

## Critical risk

Uma migração irreversível muda o problema, mas irreversibilidade isolada não prova ambiguidade residual nem falha difícil de detectar. Antes do plano comum, precisamos provar restauração e integridade.

> **Minha visão:** não devemos avançar enquanto a recuperação não estiver comprovada.
>
> **Próximo passo:** comprovar uma restauração completa em ambiente isolado. Eu recomendo bloquear a migração até essa evidência existir. Esse restore completo já passou?
>
> `Sol High` · comprovar recuperação e integridade antes da migração.

## Selective depth for difficult-to-detect risk

Quando a mesma migração também apresenta um modo concreto de corrupção silenciosa que os checks atuais não detectam, a ambiguidade residual passa pelo gate de profundidade seletiva.

> **Minha visão:** não devemos autorizar a migração enquanto o modo de corrupção silenciosa permanecer fora dos checks de integridade.
>
> **Próximo passo:** construir uma prova isolada que injete a falha e demonstre sua detecção antes de qualquer mudança em produção.
>
> `Sol XHigh` · investigar falhas de integridade difíceis de detectar antes de autorizar a migração.

## Settled synthesis

Quando a direção está fechada, a transformação é delimitada e repetida em grande volume, o formato permite verificação barata e custo e latência são materiais, a recomendação pode usar a rota provisória primeiro em um piloto representativo, sem alegar equivalência com o piso de conversa ou liberar o corpus inteiro.

> **Minha visão:** a direção já está decidida; o formato delimitado e verificável permite tratar o volume com menor custo e latência.
>
> **Próximo passo:** executar primeiro um lote piloto representativo no formato único, medindo qualidade, retries e custo total com validação automática.
>
> `Luna Medium` · validar o lote piloto delimitado com critérios automáticos antes de ampliar o volume.

## Repeated corrections change the diagnosis

Quando o usuário informa explicitamente que configurações anteriores não restauraram a convergência e ainda restam correções repetidas, use esse resultado como evidência em vez de recomendar apenas pela categoria da tarefa.

> **Minha visão:** a regra está compreendida, mas os erros anteriores de enquadramento mostram que o contrato final ainda exige julgamento preciso.
>
> **Próximo passo:** codificar uma recomendação derivada deste passo e da evidência de convergência observada.
>
> `Sol High` · integrar as correções e fechar a regra que ainda não convergiu.

## Keep unrelated process out

The next step comes from the user's current objective, not from internal repository status or a hidden list of pending work. It names one immediate dependency, never a sequence or checklist.
