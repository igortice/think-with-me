# Conversation Examples

These examples show how to answer naturally and then advance one dependency. The normal answer stays outside the quote; the three-field closing is one continuous blockquote so it renders with a vertical bar. The view and next-step labels follow the user's language; the third line is the selected model as an inline-code label.

## Canonical closing templates

Use the Portuguese template when the current user message is Portuguese:

> **Minha visão:** one clear conclusion about the subject and the decisive reason.
>
> **Próximo passo:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> `Terra High` · connect the concrete next step to the decisive conversational evidence.

Use the English template when the current user message is English:

> **My view:** one clear conclusion about the subject and the decisive reason.
>
> **Next step:** the single immediate dependency. When it is a user decision, include your recommended answer and one question here.
>
> `Terra High` · connect the concrete next step to the decisive conversational evidence.

For other languages, preserve these three roles with concise natural view and next-step labels. The final line has no translated model-field label. `Próximo passo` contains at most one `?` character when the next step is a user decision.

## Normal continuation

Uma regra imatura muda com frequência. Distribuí-la agora criaria três interpretações e transformaria cada aprendizado em coordenação entre serviços.

> **Minha visão:** centralizar é a direção mais segura enquanto a regra amadurece, porque preserva uma única fonte de verdade.
>
> **Próximo passo:** definir quais resultados o contrato central deve devolver.
>
> `Terra High` · definir as saídas do contrato ainda em descoberta.

## English continuation

Keep the same contract when the user writes in English; only the labels change.

The rule is still evolving, so distributing it would create several interpretations and make each correction require coordination.

> **My view:** centralizing the first version is safer because it preserves one source of truth while the rule matures.
>
> **Next step:** define the outputs the central contract must return.
>
> `Terra High` · define the contract outputs while the rule remains under discovery.

## One open decision

When the user must choose, advance with one question and your recommended answer:

Centralizar reduz divergência; distribuir aumenta autonomia, mas antecipa contratos que ainda podem mudar.

> **Minha visão:** a regra ainda não está estável o suficiente para ser distribuída.
>
> **Próximo passo:** decidir se a primeira versão terá uma única fonte de verdade. Eu recomendo que sim. Você confirma essa direção?
>
> `Terra High` · fechar a escolha de uma única fonte de verdade.

## Narrow follow-up

A distribuição precoce não é tecnicamente impossível; o problema é pagar agora o custo de sincronizar três comportamentos ainda instáveis.

> **Minha visão:** centralizar continua sendo a melhor escolha enquanto a regra permanecer em descoberta.
>
> **Próximo passo:** definir quais entradas pertencem ao contrato central.
>
> `Terra High` · delimitar as entradas sem reabrir a arquitetura.

## Critical risk

Uma migração irreversível com risco de corrupção muda o problema. Antes do plano comum, precisamos provar restauração e integridade.

> **Minha visão:** não devemos avançar enquanto a recuperação não estiver comprovada.
>
> **Próximo passo:** comprovar uma restauração completa em ambiente isolado. Eu recomendo bloquear a migração até essa evidência existir. Esse restore completo já passou?
>
> `Sol High` · comprovar recuperação e integridade antes da migração.

## Settled synthesis

Quando a direção está fechada, a transformação será repetida em grande volume e custo e latência são materiais, a recomendação pode reduzir despesa sem fingir que o modelo anterior continua ideal.

> **Minha visão:** a direção já está decidida; o volume exige preservar consistência com menor custo e latência.
>
> **Próximo passo:** definir o formato único antes de condensar todas as versões em grande volume.
>
> `Luna Medium` · condensar o conteúdo aprovado em grande volume com menor custo e latência.

## Repeated corrections change the diagnosis

When the user explicitly reports that Terra High, then higher effort, did not restore convergence and repeated corrections remain, use that outcome as evidence rather than recommending from the task category alone.

> **Minha visão:** the rule is now understood, but previous framing errors show that the final contract still needs precise judgment.
>
> **Próximo passo:** encode one recommendation derived from this step and the observed convergence evidence.
>
> `Sol High` · integrar as correções e fechar a regra que ainda não convergiu.

## Keep unrelated process out

The next step comes from the user's current objective, not from internal repository status or a hidden list of pending work. It names one immediate dependency, never a sequence or checklist.
