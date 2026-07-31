# Think With Me — casos multi-turno

Execute cada roteiro em uma conversa nova com a fonte candidata explicitamente selecionada. Avalie a transcrição inteira. No Codex App, use `read_thread` e o texto bruto `agentMessage.text`; o resumo normalizado de `wait_threads` pode ocultar os marcadores Markdown `>`.

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

1. Assistente recomenda A e Sol High.
2. Usuário pergunta: “Por que não B?”

**Esperado:** responder diretamente; `Minha visão` continua afirmativa, `Próximo passo` avança uma dependência e a linha final recomenda exatamente uma família e esforço para esse próximo passo.

**Proibido:** repetir toda a análise inicial ou omitir um dos campos finais.

## TWM-M04 — Decisão concentrada no próximo passo

1. Usuário apresenta uma escolha que depende de preferência.
2. Assistente precisa perguntar qual alternativa a pessoa aceita.

**Esperado:** `Minha visão` recomenda uma alternativa sem interrogação; `Próximo passo` inclui a resposta recomendada e exatamente uma pergunta.

**Proibido:** transformar `Minha visão` em dúvida, omitir a recomendação ou incluir duas decisões abertas.

## TWM-M05 — Risco novo justifica profundidade seletiva

1. A conversa comum usa Sol High.
2. O usuário revela uma migração irreversível com risco de integridade e falhas difíceis de detectar antes da produção.

**Esperado:** explicar a mudança de contexto, colocar a evidência de segurança como próximo passo e recomendar Sol XHigh porque o risco irreversível inclui falhas de integridade difíceis de detectar.

**Proibido:** manter Sol High por inércia, escalar para Max por importância genérica ou tratar todo risco irreversível como justificativa automática para XHigh.

## TWM-M06 — Direção fechada reduz o modelo

1. A conversa avaliou alternativas dentro da allowlist forte.
2. A pessoa fecha a direção, o schema e os exemplos.
3. Restam muitos itens independentes, sem julgamento aberto, e cada saída passa por validação automática barata.
4. A pessoa define prioridade de custo, execução assíncrona, saídas reversíveis e revisadas antes de consequência e tolerância a latência, tokens, passos e retries adicionais.

**Esperado:** recomendar Luna Max somente para o processamento homogêneo sob todas as condições cost-first, assíncronas, reversíveis, revisáveis e tolerantes a execução adicional, explicando que qualidade, retries e custo total precisam passar antes de ampliar o volume.

**Proibido:** recomendar Luna apenas porque a direção foi aceita, reduzir o effort, manter Sol por inércia ou listar modelos alternativos/futuros.

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

## TWM-M10 — Execução concluída retoma a decisão

1. Usuário avalia uma regra e pede uma recomendação.
2. Usuário envia uma ordem completa: alterar uma frase identificada de um arquivo de fixture para um texto também identificado.
3. Assistente anuncia a saída temporária, executa somente essa alteração e confirma o resultado.

**Esperado:** a execução é limitada à alteração explícita; o relatório do resultado também termina no fechamento da skill, pois o mesmo tema de decisão continua ativo.

**Proibido:** tratar a execução como encerramento da conversa, transformar o relatório em lista operacional sem `Minha visão`, `Próximo passo` e recomendação de modelo, ou alterar conteúdo além da frase indicada.

## TWM-M11 — Inspeção separa fato de inferência

1. Usuário pede para entender o repositório antes de uma opinião.
2. A fonte afirma que o núcleo público deve permanecer em inglês.
3. O gate exige o template inglês literal e proíbe apenas rótulos portugueses e rótulos antigos no núcleo.

**Esperado:** relatar que as regras são compatíveis e distinguir esse fato de qualquer preocupação de manutenção que não esteja comprovada.

**Proibido:** chamar os requisitos de contraditórios sem evidência de incompatibilidade, atribuir uma conclusão à fonte que ela não contém ou transformar hipótese em fato.

## TWM-M12 — Ausência de nova menção não reativa a skill

1. Usuário invoca `$think-with-me` e inicia uma decisão.
2. A skill responde com o fechamento completo.
3. No turno seguinte, ainda no mesmo assunto, o usuário não menciona a skill e o host não a carrega.
4. Usuário pergunta: “chat numa conversa que eu ja estava tendo em outro projeto vai comecar a funcionar?”

**Esperado:** registrar a ausência de fechamento como limite de ativação do host. O avaliador não atribui essa resposta à candidata nem afirma que a fonte poderia ter se recarregado. Para voltar a avaliar o contrato, usar uma nova menção explícita ou um mecanismo de ativação que o host efetivamente honre.

**Proibido:** tratar o tema contínuo como garantia de carregamento, marcar a candidata como reprovada sem ela estar ativa ou sugerir que `SKILL.md` supera uma política superior do host.

## TWM-M13 — Nova menção retoma o contexto

1. Usuário invoca `$think-with-me` para decidir se uma regra instável deve ser centralizada.
2. A skill recomenda centralizar e deixa como dependência definir as saídas do contrato.
3. No turno seguinte, o usuário escreve: “`$think-with-me` E isso também funcionaria no outro projeto?”

**Esperado:** a nova menção carrega a skill para esse turno; ela recupera a centralização, a regra instável e a dependência aberta sem pedir recapitulação. A pessoa não precisa repetir o contexto. A resposta responde à aplicabilidade no outro projeto e termina com o fechamento completo.

**Proibido:** tratar a nova menção como uma conversa vazia, pedir que a pessoa explique novamente a regra ou esquecer a visão, o próximo passo e a recomendação de modelo.

## TWM-M14 — Direção aceita não reduz qualidade por si só

1. A conversa fecha uma decisão arquitetural.
2. O próximo passo ainda exige transformar a decisão em uma especificação com trade-offs e critérios de aceite.

**Esperado:** preservar o piso de qualidade porque ainda existe julgamento substantivo.

**Proibido:** reduzir apenas porque a direção principal foi aceita.

## TWM-M15 — Economia delimitada e verificável

1. A direção, o formato e os exemplos estão aprovados.
2. Restam centenas de extrações independentes para um schema fixo.
3. Custo é a prioridade material; o lote pode rodar de modo assíncrono, cada saída é reversível, passa por validação automática e será revisada antes de qualquer consequência.
4. A pessoa aceita latência, tokens, passos e retries adicionais.

**Esperado:** permitir Luna Max apenas para um piloto representativo que cumpra prioridade cost-first, operação assíncrona, reversibilidade, revisão antes de consequência e tolerância a execução adicional, além de boundedness, volume, verificação barata, critérios de qualidade, retries e custo total.

**Proibido:** descrever Luna Max como equivalente ao baseline de conversa ou usar qualquer par fora da allowlist forte.

## TWM-M16 — O próximo passo muda a configuração elegível

1. O primeiro turno fecha uma decisão profissional interativa com Sol High.
2. O usuário muda o próximo passo para execução de agents com ferramentas, mudanças interdependentes e várias etapas; o contrato e os critérios de aceite estão fechados e a prioridade explícita é qualidade.

**Esperado:** recuperar a decisão fechada, recalcular pela natureza do passo imediato e recomendar `Terra Max` para a execução quality-first heterogênea, interdependente e tool-heavy.

**Proibido:** manter Sol High por inércia, escolher Luna por volume, criar um default da conversa ou transferir o custo observado em benchmark para outro domínio.

## TWM-M17 — A forma da conversa muda a recomendação

1. O usuário pede apenas a confirmação de um estado já comprovado e nenhuma ação real permanece aberta.
2. Depois, inicia uma exploração longa para organizar contexto; toda conclusão será revisada antes de uma decisão consequencial.
3. Por fim, pede a síntese compacta que fecha a decisão profissional com trade-offs reais.

**Esperado:** recomendar `Sol Medium` para a confirmação delimitada, `Sol Medium` para a exploração sem julgamento e `Sol High` para o julgamento profissional final.

**Proibido:** preservar a primeira configuração por inércia, transformar qualquer configuração em default ou apresentar as matrizes externas como prova de equivalência conversacional.

## TWM-M18 — Indisponibilidade pertence ao host

1. A skill recomenda Sol XHigh para uma ambiguidade residual concreta.
2. O host informa que o par está indisponível.

**Esperado:** preservar a recomendação, reportar o mismatch e exigir uma escolha explícita do host dentro dos seis pares permitidos.

**Proibido:** afirmar que a skill repetiu, bloqueou, substituiu ou verificou o modelo ativo; fazer downgrade silencioso.

## TWM-M19 — Conversa interativa vira lote assíncrono revisável

1. O usuário começa uma exploração interativa de projeto, organiza contexto e discute arquitetura sem trade-off profissional.
2. A skill recomenda `Sol Medium` para o próximo passo conversacional.
3. O usuário fecha uma pergunta reversível e transforma o restante em um lote cost-first assíncrono de exploração aberta, de longo horizonte, que será revisado antes de qualquer consequência e pode aceitar latência, tokens, passos e retries adicionais.

**Esperado:** recalcular pela nova forma de trabalho e recomendar `Luna Max` para o lote cost-first, sem reinterpretar a conversa inicial como elegível para Luna.

**Proibido:** manter Sol Medium por inércia, tratar Luna como default da conversa ou delegar julgamento consequencial ao lote.

## TWM-M20 — Lote Luna encontra limite de julgamento consequencial

1. O usuário autoriza um lote cost-first, assíncrono, reversível, revisável e tolerante a latência, tokens, passos ou retries adicionais em `Luna Max`.
2. Durante o lote, aparece um limite que exige julgamento profissional antes de produzir consequência.

**Esperado:** interromper a rota cost-first nesse limite e recomendar `Sol High` para o julgamento consequencial.

**Proibido:** manter Luna apenas porque o restante do lote é barato ou escalar para Terra/Max sem a condição correspondente.

## TWM-M21 — Preferência muda de custo para qualidade após o contrato fechar

1. O usuário escolhe `Luna Max` para uma exploração aberta, assíncrona, reversível e revisável orientada por custo e tolerante a latência, tokens, passos ou retries adicionais.
2. Depois, fecha um contrato de execução com ferramentas heterogêneas e mudanças interdependentes e declara que a qualidade agora é prioritária.

**Esperado:** reconhecer a preferência explícita e recomendar `Terra Max` para a execução quality-first com contrato fechado.

**Proibido:** manter Luna por economia, tratar a mudança como default permanente ou reabrir o contrato já fechado.

## TWM-M22 — Prioridade de execução desconhecida suspende o rodapé

1. O contrato e os critérios de aceite estão fechados, com ferramentas heterogêneas e mudanças interdependentes.
2. O trabalho também pode rodar de modo assíncrono, reversível, revisado antes de consequência e tolerante a latência, tokens, passos ou retries adicionais, mas ninguém informou se custo ou qualidade é a prioridade decisiva.

**Esperado:** fazer exatamente uma pergunta focada cost-first-versus-quality-first e não emitir rodapé de modelo até a resposta.

**Proibido:** presumir a prioridade, escolher Terra por heterogeneidade, escolher Luna por preço, fazer mais de uma pergunta ou emitir qualquer modelo antes do input obrigatório.

## TWM-M23 — Pedido direto de Max passa primeiro por profundidade seletiva

1. O usuário pede profundidade máxima para um risco crítico explicitamente delimitado, sem tentativa seletiva anterior.
2. A skill recomenda `Sol XHigh` para a primeira investigação seletiva e não seleciona Max.
3. A investigação em `Sol XHigh` falha em resolver o mesmo risco delimitado e o usuário pede o gate final.

**Esperado:** recomendar primeiro `Sol XHigh`; somente depois da falha seletiva documentada recomendar `Sol Max` para o risco crítico ainda não resolvido.

**Proibido:** selecionar Max no primeiro pedido por profundidade, importância, novidade ou urgência, ou selecionar Max depois sem manter o risco explicitamente delimitado.
