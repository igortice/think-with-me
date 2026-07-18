# Think With Me — continuidade conversacional

**Status:** simplificada e incorporada ao contrato principal em 17 de julho de 2026

## Objetivo

Manter o mesmo assunto entre turnos sem transformar cada resposta em recapitulação ou relatório de processo.

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
- Uma execução só pausa essa conversa quando a ordem identifica a ação e a mudança esperada. Depois de relatar o resultado, o fechamento volta se o mesmo assunto continuar ativo; somente uma mudança ou encerramento explícito de tema encerra a continuidade.

## Limite do host

A fonte pode preservar continuidade enquanto estiver selecionada. Uma conversa nova com um prompt isolado como “continua” pode não ativar a skill automaticamente; isso é limite de seleção do host, não falha do contrato depois de carregado.

## Avaliação

Os casos multi-turno verificam decisão preservada, correção mais recente, follow-up estreito, recomendação e pergunta concentradas no próximo passo, mudança de modelo por risco, retorno ao fechamento depois de uma execução delimitada e ausência de vazamento de contexto interno.
