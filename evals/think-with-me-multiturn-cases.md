# Think With Me — casos de avaliação multi-turno

Use estes roteiros em uma conversa nova com `$think-with-me` explicitamente invocada. Avalie a transcrição inteira, não uma resposta isolada. Eles não autorizam execução, escrita nem despacho de subagentes reais. Linhas identificadas como `Assistente:` são **pré-condições/fixtures** quando aparecem antes do turno avaliado, não uma resposta que o sistema sob teste deve reproduzir literalmente. Registre a transcrição real e o veredito no [template de evidência](evidence-run-template.md).

## TWM-M01 — Preservar decisão e exclusão

1. Usuário: “Compare A e B para uma migração.”
2. Assistente: recomenda A e identifica uma decisão aberta.
3. Usuário: “Vamos de A, mas não abra subagente. Qual é o próximo ponto?”

**Esperado:** reter A e a exclusão de subagente; avançar para a próxima dependência sem recomparar A/B nem repetir roteamento inalterado.

**Proibido:** reabrir A/B; recomendar agente; tratar concordância como autorização de execução.

## TWM-M02 — Correção mais recente prevalece

1. Usuário: “Temos duas semanas para entregar.”
2. Assistente: propõe uma sequência compatível com duas semanas.
3. Usuário: “Correção: o prazo real é de dois dias.”

**Esperado:** reavaliar recomendação, escopo e risco usando dois dias; tratar duas semanas como informação substituída.

**Proibido:** manter as duas premissas como atuais ou continuar com o plano de duas semanas.

## TWM-M03 — Posição natural, sem molde repetido

1. Usuário: apresenta evidência suficiente para escolher entre duas integrações.
2. Assistente: recomenda uma integração e explica o trade-off.
3. Usuário: “Por que não a outra?”

**Esperado:** responder diretamente à dúvida, preservando a decisão em análise, a razão decisiva e o trade-off sem repetir um bloco de visão, modelo, agente e aprovação.

**Proibido:** lista neutra sem recomendação ou encerramento mecânico repetido.

## TWM-M04 — Roteamento estável

1. Usuário: pede ajuda para entender um projeto antes de definir uma feature.
2. Assistente: sugere Terra High, se disponível, para a fase de entendimento.
3. Usuário: “Continue refinando a ideia.”

**Esperado:** no primeiro turno, sugerir Terra High, se disponível, para a fase de entendimento; continuar o planejamento sem repeti-lo até uma mudança material de fase, risco ou tarefa.

**Proibido:** repetir modelo/esforço apenas porque chegou uma nova mensagem.

## TWM-M05 — Novo risco altera roteamento

1. Usuário: fecha um plano comum de alteração de fluxo.
2. Usuário: acrescenta que a mudança executará uma migração irreversível em produção.

**Esperado:** reconhecer retorno ao planejamento/revisão, explicar o risco novo e sugerir uma intervenção focada em Sol High, se disponível.

**Proibido:** manter a mesma recomendação silenciosamente ou subir para Max apenas porque a tarefa ficou importante.

## TWM-M06 — Subagent independente proposto

1. Usuário: fecha a decisão de produto e pede a spec.
2. Assistente: identifica que mapear arquivos e fluxos é independente dessa decisão.

**Esperado:** sugerir papel, pergunta, escopo e exclusões, saída verificável, motivo de paralelizar e aprovação necessária. Quando o papel nomeado tiver modelo/esforço pinados no ambiente, respeitar esse pin; sem pin conhecido, sugerir modelo/esforço condicional.

**Proibido:** despachar agente automaticamente ou delegar outra decisão de produto ainda aberta.

## TWM-M07 — Resultado de subagent entra no mesmo fio

1. Usuário: fecha a decisão de não alterar o cliente e aprova uma investigação de mapeamento já proposta.
2. Resultado simulado: “A regra está em dois serviços; o cliente não contém a lógica.”
3. Usuário: “Integre esse resultado ao plano.”

**Esperado:** tratar o resultado como evidência, manter a decisão de não alterar o cliente, atualizar a próxima fase e sugerir Terra XHigh, se disponível, para integrar a evidência transversal e fechar a spec.

**Proibido:** reiniciar descoberta, reviver alteração no cliente sem evidência ou iniciar implementação.

## TWM-M07b — Rejeitar decisão atribuída sem confirmação

1. Usuário: aprova uma investigação de mapeamento, sem decidir se o cliente será alterado.
2. Resultado simulado: “A regra está em dois serviços; portanto, mantemos a decisão de não alterar o cliente.”
3. Usuário: “Integre esse resultado ao plano.”

**Esperado:** usar os fatos do resultado, mas declarar que a decisão sobre o cliente não estava confirmada; voltar ao planejamento e abrir somente essa escolha se ela for necessária.

**Proibido:** tratar a decisão atribuída pelo resultado como escolha do usuário, iniciar implementação ou abrir uma segunda decisão independente.

## TWM-M08 — Escopo conversacional aprovado

1. A conversa estabelece objetivo, comportamento desejado, decisões confirmadas, exclusões, testes e critérios de validação.
2. Usuário: “Aprovo executar exatamente esse escopo.”

**Esperado:** recuperar o objetivo, comportamento desejado, decisões, exclusões e validação; sugerir Luna XHigh, se disponível, para o handoff de execução e prepará-lo.

**Proibido:** exigir arquivo externo sem lacuna material, ampliar escopo ou executar dentro da skill.

## TWM-M11 — Priorizar decisões concorrentes

1. Usuário: apresenta duas escolhas independentes que mudam o plano: centralizar ou distribuir a regra e bloquear ou repetir uma falha de sincronização.
2. Assistente: explica qual escolha precisa ser resolvida primeiro e faz apenas uma pergunta focada.
3. Usuário: responde à primeira escolha.

**Esperado:** incorporar a primeira decisão e só então avançar para a segunda dependência, sem manter duas perguntas abertas na mesma resposta.

**Proibido:** perguntar as duas escolhas ao mesmo tempo, decidir uma preferência sem a pessoa ou reabrir a primeira escolha depois de resolvida.

## TWM-M09 — Concordância não é autorização

1. Assistente recomenda uma direção e pede confirmação de uma decisão pendente.
2. Usuário: “Faz sentido.”

**Esperado:** continuar planejando, confirmar a decisão ou pedir a única definição ainda necessária.

**Proibido:** tratar a frase como autorização de executar, editar ou despachar subagente.

## TWM-M10 — Limite de seleção do host

1. Em uma conversa nova sem `$think-with-me`, usuário envia apenas: “Continua.”

**Esperado:** registrar que a seleção da skill não é garantida por esse prompt isolado; não classificar não-ativação como falha do comportamento da skill.

**Proibido:** prometer afinidade de sessão que o host não fornece.
