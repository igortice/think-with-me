# Think With Me — casos multi-turno

Execute cada roteiro em uma conversa nova com a fonte candidata explicitamente selecionada. Avalie a transcrição inteira.

## TWM-M01 — Preservar a decisão

1. Usuário compara A e B.
2. Assistente recomenda A.
3. Usuário escolhe A e pergunta o próximo ponto.

**Esperado:** manter A, avançar sem recomparar e encerrar com uma visão declarativa, um próximo passo e um modelo curto.

**Proibido:** reabrir A/B ou tratar a escolha como autorização de executar.

## TWM-M02 — Correção mais recente prevalece

1. Usuário informa prazo de duas semanas.
2. Depois corrige o prazo para dois dias.

**Esperado:** responder usando apenas dois dias como premissa atual e atualizar a visão e o próximo passo.

**Proibido:** manter as duas premissas como simultaneamente válidas.

## TWM-M03 — Follow-up estreito continua natural

1. Assistente recomenda A e Terra High.
2. Usuário pergunta: “Por que não B?”

**Esperado:** responder diretamente; `Minha visão` continua afirmativa, `Próximo passo` avança uma dependência e `Modelo` recomenda exatamente uma família e esforço para esse próximo passo.

**Proibido:** repetir toda a análise inicial ou omitir um dos campos finais.

## TWM-M04 — Decisão concentrada no próximo passo

1. Usuário apresenta uma escolha que depende de preferência.
2. Assistente precisa perguntar qual alternativa a pessoa aceita.

**Esperado:** `Minha visão` recomenda uma alternativa sem interrogação; `Próximo passo` inclui a resposta recomendada e exatamente uma pergunta.

**Proibido:** transformar `Minha visão` em dúvida, omitir a recomendação ou incluir duas decisões abertas.

## TWM-M05 — Risco novo muda o modelo

1. A conversa comum usa Terra High.
2. O usuário revela uma migração irreversível com risco de integridade.

**Esperado:** explicar a mudança de contexto, colocar a evidência de segurança como próximo passo e recomendar somente Sol High para esse próximo passo na linha compacta.

**Proibido:** manter Terra por inércia ou usar Max por importância genérica.

## TWM-M06 — Direção fechada reduz o modelo

1. A conversa avaliou alternativas em Terra High.
2. A pessoa fecha a direção e pede somente uma síntese padronizada.
3. A pessoa informa que o volume é grande e que custo ou latência importam materialmente.

**Esperado:** recomendar Luna Medium para o próximo passo, explicando que a tarefa se tornou síntese delimitada e custo, latência ou volume importam.

**Proibido:** recomendar Luna apenas porque a direção foi aceita, manter Terra por inércia, usar Sol por hábito ou listar modelos alternativos/futuros.

## TWM-M07 — Contexto interno não vira assunto

1. A fonte interna registra pendências de versionamento e distribuição.
2. O usuário pergunta somente sobre a qualidade de uma ideia.

**Esperado:** usar apenas o contexto relevante para avaliar a ideia.

**Proibido:** introduzir versionamento, distribuição ou qualquer pendência não solicitada em `Minha visão` ou `Próximo passo`.

## TWM-M08 — Limite de seleção do host

1. Abra uma conversa nova sem invocar a skill.
2. Envie apenas “continua”.

**Esperado:** não classificar a ausência de ativação como falha do comportamento da fonte candidata.

**Proibido:** prometer afinidade de sessão que o host não fornece.

## TWM-M09 — Falta de convergência modifica a recomendação

1. A conversa começa em Terra High para definir um rodapé de recomendação de modelo.
2. Depois de respostas genéricas que não resolvem o pedido, o usuário informa que aumentou o esforço para Max.
3. Após novas correções, o usuário informa que está usando Sol e explica que a recomendação deve considerar o que funcionou, o atrito e o próximo passo.
4. O próximo passo restante é fechar o contrato exato da skill sem repetir a premissa rejeitada.

**Esperado:** formular o próximo passo antes da recomendação; considerar a trajetória informada e as correções repetidas como evidência de falta de convergência; recomendar exatamente um modelo e esforço para fechar o contrato; explicar a escolha com esse contexto concreto.

**Proibido:** dizer `Terra agora → Luna depois`, listar alternativas, inventar o modelo ativo, escolher Max apenas por profundidade nominal ou usar apenas categorias genéricas como `decidir` e `consolidar`.
