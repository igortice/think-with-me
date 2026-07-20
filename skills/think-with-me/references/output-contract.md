# Conversation Examples

These examples show how to answer naturally and then advance one dependency. The normal answer stays outside the quote; the three-field closing is one continuous blockquote so it renders with a vertical bar. The view and next-step labels follow the user's language; the third line is the selected model as an inline-code label.

Write all prose before the closing and the closing itself in that same language; examples and placeholder text never override the current user message's language.

## Host activation boundary

This output contract only applies when the skill is loaded for that response. It cannot retain or invoke itself on a later turn; host selection, an explicit new invocation, or a host-level mechanism determines whether the contract is available again.

When an explicit new invocation makes this contract available again, resume the exact unresolved dependency already established in the conversation. Do not replace contract outputs with availability, inputs, rollout, or another newly invented dependency unless the user supplies information that changes the decision.

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

## Resolved routine confirmation

Quando a pessoa pede apenas para confirmar um estado já comprovado e nenhuma
decisão real permanece aberta, não invente uma tarefa operacional futura para
alimentar o rodapé. A recomendação descreve a confirmação atual,
que é delimitada, reversível e barata de verificar.

> **Minha visão:** o estado já foi confirmado pelas verificações e não existe correção pendente.
>
> **Próximo passo:** nenhuma ação adicional é necessária para o uso local.
>
> `Sol Medium` · confirmar um estado delimitado e verificável sem inventar nova pendência.

## Long reviewable exploration

Quando a conversa precisa organizar muito contexto e explorar possibilidades,
mas toda conclusão será revisada antes de uma decisão consequencial, use a rota
como piloto conversacional e diga na prosa que ela ainda não prova equivalência.

> **Minha visão:** vale ampliar a exploração agora porque a direção ainda será revisada antes de produzir consequência.
>
> **Próximo passo:** organizar as hipóteses que realmente distinguem as alternativas.
>
> `Terra Max` · sustentar a exploração longa que ainda passará por revisão.

## Long reviewable drafting

Quando o próximo passo é elaborar um rascunho longo e estruturado, custo importa,
uma execução extensa é aceitável e haverá revisão antes do uso consequencial, a
rota é provisória e não herda a economia de nenhum benchmark externo.

> **Minha visão:** a elaboração pode priorizar custo e extensão porque o texto ainda passará por revisão antes do uso final.
>
> **Próximo passo:** produzir o rascunho estruturado a partir da direção já fechada.
>
> `Luna Max` · elaborar o rascunho longo cuja revisão ainda antecede o uso consequencial.

## Compact consequential judgment

Quando a exploração termina e o próximo passo fecha uma decisão profissional
com trade-offs reais, preserve o contrato conservador somente para essa fase.

> **Minha visão:** a evidência já está organizada e agora falta assumir o trade-off que decide a direção final.
>
> **Próximo passo:** escolher a alternativa que preserva ownership explícito e reversibilidade.
>
> `Sol High` · fechar o julgamento profissional compacto com trade-offs reais.

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
> **Próximo passo:** executar um lote piloto representativo no formato único, com critérios prévios de aprovação para qualidade, retries e custo total.
>
> `Luna Medium` · validar o lote piloto delimitado com critérios automáticos antes de ampliar o volume.

## Matched long-horizon cost trade-off

Quando o próximo passo corresponde ao domínio DeepSWE, a qualidade necessária mantém a faixa superior elegível e o custo total é material, a configuração de menor custo médio pode vencer mesmo aceitando mais tokens, passos e provável duração. No snapshot datado, Luna Max custa $0.44, ou cerca de 12.7%, menos por tarefa média que Sol High, mas usa 44,950 tokens de saída e 64.8 passos a mais; essa troca deve permanecer explícita e limitada ao harness medido.

> **Minha visão:** no trabalho longo que corresponde ao harness medido, a economia por tarefa justifica aceitar uma execução bem mais extensa quando prazo e volume de contexto não são restrições dominantes.
>
> **Próximo passo:** executar uma tarefa representativa com o contrato de aceitação já definido.
>
> `Luna Max` · testar a rota de menor custo médio no trabalho longo correspondente ao harness.

## Representative Terra pilot

Terra Max permanece elegível na faixa superior do domínio medido, mas não tem vantagem econômica nem conversacional estabelecida. A recomendação só cabe como piloto representativo quando o objetivo imediato é produzir evidência local de convergência e o custo, os tokens, os passos e a provável duração maiores são aceitáveis; critérios e registro dessa evidência pertencem à prosa, não como uma segunda ação no campo seguinte.

> **Minha visão:** ainda não existe evidência local para transformar o resultado do benchmark em preferência de uso, então a configuração deve ser tratada como hipótese mensurável.
>
> **Próximo passo:** executar uma tarefa longa representativa com critérios de convergência previamente fechados.
>
> `Terra Max` · produzir evidência local no piloto representativo do domínio medido.

## Repeated corrections change the diagnosis

Quando o usuário informa explicitamente que configurações anteriores não restauraram a convergência e ainda restam correções repetidas, use esse resultado como evidência em vez de recomendar apenas pela categoria da tarefa.

> **Minha visão:** a regra está compreendida, mas os erros anteriores de enquadramento mostram que o contrato final ainda exige julgamento preciso.
>
> **Próximo passo:** codificar uma recomendação derivada deste passo e da evidência de convergência observada.
>
> `Sol High` · integrar as correções e fechar a regra que ainda não convergiu.

Quando as correções também revelam uma contradição transversal concreta que
ainda precisa ser reconciliada, a ambiguidade residual passa pelo gate seletivo.

> **Minha visão:** as respostas anteriores falharam porque ownership e autorização ainda impõem requisitos incompatíveis na formulação atual.
>
> **Próximo passo:** reconciliar a contradição entre ownership e autorização no mesmo contrato.
>
> `Sol XHigh` · resolver a contradição transversal exposta pelas correções repetidas.

## Keep unrelated process out

The next step comes from the user's current objective, not from internal repository status or a hidden list of pending work. It names one immediate dependency, never a sequence or checklist.
