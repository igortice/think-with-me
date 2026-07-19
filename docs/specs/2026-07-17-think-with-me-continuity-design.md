# Think With Me — continuidade conversacional

**Status:** simplificada e incorporada ao contrato principal em 17 de julho de 2026

## Objetivo

Manter o mesmo assunto sem transformar cada resposta em recapitulação ou relatório de processo, desde que o host tenha carregado a skill no turno avaliado.

## Estado recuperado silenciosamente

- assunto atual;
- fatos confirmados;
- decisões da pessoa;
- restrições e alternativas descartadas;
- uma única dependência seguinte ainda aberta.

A correção mais recente substitui a informação anterior sobre o mesmo ponto. Evidência nova pode alterar a posição e o modelo recomendado, mas uma mensagem curta por si só não reinicia a conversa.

## Continuação da resposta

- O corpo responde diretamente ao novo turno usando o estado recuperado.
- O fechamento sempre reapresenta, de forma breve, a visão, o próximo passo e o modelo.
- Quando a próxima dependência é uma decisão da pessoa, `Próximo passo` contém a recomendação do assistente e exatamente uma pergunta focada.
- O fechamento não recapitula o workflow, não enumera pendências e não expõe contexto interno irrelevante.
- Uma execução só pausa essa conversa quando a ordem identifica a ação e a mudança esperada. Depois de relatar o resultado, o fechamento volta se o mesmo assunto continuar ativo e a skill continuar carregada naquele turno. Mudança ou encerramento explícito de tema encerra a continuidade dentro de um turno carregado.

## Ativação entre turnos depende do host

A fonte pode preservar continuidade enquanto estiver selecionada no turno. Ela não escolhe a si mesma no turno seguinte: uma conversa contínua, uma confirmação curta ou o mesmo tema não são uma reativação automática.

Se o host trata skills como turn-scoped e não carrega `think-with-me`, uma resposta sem o fechamento não é evidência de falha da fonte. É um limite de ativação: o contrato simplesmente não estava presente naquela resposta. A regressão `TWM-M12` simula exatamente esse caso.

A nova menção explícita reativa o contrato sem zerar o contexto. Nesse turno carregado, a skill recupera o objetivo, os fatos confirmados, as decisões e a dependência aberta da mesma conversa; a pessoa não precisa repetir a explicação anterior. A regressão `TWM-M13` protege essa promessa positiva.

Mecanismos externos possíveis, em ordem de portabilidade:

1. nova menção explícita a `$think-with-me` no turno que precisa do contrato;
2. uma regra persistente ou hook do host que injete a ativação a cada turno relevante, se o host o suportar;
3. uma instrução persistente de repositório, como `AGENTS.md`, apenas quando o host a respeitar.

Os dois últimos mecanismos não podem vencer uma política superior do runtime. Portanto, `SKILL.md` e `AGENTS.md` documentam e orientam; a seleção efetiva continua sendo responsabilidade do host.

## Avaliação

Os casos multi-turno verificam decisão preservada, correção mais recente, follow-up estreito, recomendação e pergunta concentradas no próximo passo, mudança de modelo por risco, retorno ao fechamento depois de uma execução delimitada, ausência de vazamento de contexto interno e a fronteira entre continuidade carregada e reativação pelo host.
