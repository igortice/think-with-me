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

Quando a pessoa está esperando e a conversa precisa organizar muito contexto e
explorar possibilidades, mas ainda não há trade-off técnico nem julgamento
profissional escondido, a extensão não muda a natureza interativa e reversível
do próximo passo.

> **Minha visão:** vale ampliar a exploração agora porque a direção ainda será revisada antes de produzir consequência.
>
> **Próximo passo:** organizar as hipóteses que realmente distinguem as alternativas.
>
> `Sol Medium` · organizar a descoberta interativa sem antecipar uma decisão profissional.

## Long reviewable drafting

Quando a direção já está fechada e o próximo passo é elaborar um único rascunho
longo, reversível e revisável, sem transformar centenas de itens independentes,
o tamanho do texto não cria por si só uma rota de volume.

> **Minha visão:** a elaboração já tem direção fechada e continuará reversível porque será revisada antes do uso final.
>
> **Próximo passo:** produzir o rascunho estruturado a partir da direção já fechada.
>
> `Sol Medium` · elaborar o rascunho delimitado e revisável sem julgamento escondido.

## Cost-first asynchronous open-ended execution

Quando a pessoa não está esperando, a exploração pode permanecer aberta por
muito tempo e toda saída será revisada antes de qualquer consequência, a rota
orientada por custo pode aceitar latência, tokens, passos e retries adicionais.

> **Minha visão:** a exploração pode priorizar custo porque é assíncrona, reversível e será revisada antes de orientar qualquer ação.
>
> **Próximo passo:** executar a exploração aberta até organizar as descobertas no formato revisável já definido.
>
> `Luna Max` · executar a exploração assíncrona e reversível com prioridade de custo.

## Judgment boundary during cost-first execution

Se uma execução assíncrona em `Luna Max` encontrar uma escolha profissional que
produz consequência, a rota de custo para no limite. O julgamento vira o novo
próximo passo e não pode ficar escondido no restante do lote.

> **Minha visão:** o lote reuniu evidência suficiente, mas a escolha final exige julgamento profissional antes de produzir consequência.
>
> **Próximo passo:** decidir qual alternativa preserva as restrições profissionais já identificadas.
>
> `Sol High` · assumir o julgamento consequencial que apareceu no limite do lote.

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

## Structured high-volume processing

Quando a direção está fechada, centenas de itens independentes passam pela mesma
transformação, o schema é fixo, não existe julgamento aberto dentro de cada
item e a validação automática é barata, o volume pode usar primeiro um lote
representativo. Qualidade, retries e custo total precisam passar antes de
ampliar o corpus.

> **Minha visão:** a direção já está decidida; o formato delimitado e verificável permite tratar o volume com menor custo e latência.
>
> **Próximo passo:** executar um lote piloto representativo no formato único, com critérios prévios de aprovação para qualidade, retries e custo total.
>
> `Luna Max` · processar o lote homogêneo com schema fixo e validação automática.

## Matched long-horizon agent execution

Quando a decisão e o contrato de aceitação já estão definidos, o próximo passo
é executar trabalho heterogêneo de longa duração com ferramentas e mudanças
interdependentes, e a prioridade explícita é qualidade, use a rota de execução
quality-first. O resultado histórico do DeepSWE é evidência de domínio, não
autorização para transferir custo ou qualidade a outra tarefa.

> **Minha visão:** o contrato está fechado e a prioridade de qualidade governa a execução heterogênea com ferramentas e etapas interdependentes.
>
> **Próximo passo:** executar uma tarefa representativa com o contrato de aceitação já definido.
>
> `Terra Max` · executar com prioridade de qualidade o trabalho heterogêneo e interdependente.

## Heavy agent execution

Terra Max cabe quando o próximo passo já é a execução de agents ou o
processamento pesado e heterogêneo, com ferramentas e estados intermediários.
Não use essa rota para conversa sobre o projeto, descoberta arquitetural,
julgamento profissional ou transformação homogênea com schema fixo.

> **Minha visão:** as decisões já estão fechadas e resta coordenar uma execução pesada com ferramentas e estados intermediários.
>
> **Próximo passo:** executar o trabalho heterogêneo conforme o contrato de aceitação definido.
>
> `Terra Max` · coordenar a execução pesada com ferramentas e múltiplas etapas.

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
