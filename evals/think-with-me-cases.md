# Think With Me — casos de avaliação

Use estes casos em conversas novas depois de qualquer alteração comportamental. Avalie a resposta somente depois que ela terminar; não forneça ao candidato os critérios esperados. No Codex App, inspecione o texto bruto `agentMessage.text` retornado por `read_thread`: o resumo de espera pode normalizar Markdown visual e não é a fonte de verdade para os marcadores `>`.

## Invariantes de toda resposta

1. A resposta útil e o contexto aparecem antes do fechamento.
2. O fechamento contém, no idioma do usuário, os equivalentes de `Minha visão` e `Próximo passo`, seguidos de uma terceira linha com exatamente uma etiqueta de modelo em código inline e sua razão contextual.
3. Os três campos estão dentro de um único blockquote Markdown contínuo, com a barra vertical ao lado de todo o fechamento.
4. `Minha visão` contém uma única conclusão afirmativa e diretamente relacionada ao assunto.
5. `Próximo passo` contém uma única dependência imediata que avança o objetivo atual, nunca uma sequência, checklist ou pacote de ações.
6. Quando o próximo passo depende da pessoa, ele inclui a resposta recomendada pelo assistente e exatamente uma pergunta focada; o campo inteiro contém no máximo um `?`.
7. A terceira linha ocupa uma única linha Markdown no formato `` `Família Esforço` · razão contextual.``; recomenda exatamente uma família e esforço para o `Próximo passo` já escrito e justifica a escolha com o trabalho concreto e evidências observáveis da conversa.
8. Pendências internas ou assuntos operacionais não aparecem se não forem o tema trazido pelo usuário.
9. A recomendação não inventa o modelo ativo, não prevê uma fase futura e não usa `agora`, `depois`, `now`, `later`, qualquer seta, alternativas ou HTML; a justificativa também não nomeia outra família ou esforço.
10. Correções, repetição, atrito, contradições, trajetória de modelos explicitamente informada e convergência modificam a escolha; sentimento isolado e importância genérica não escalam modelo ou esforço.

## Casos

| ID | Prompt | Deve acontecer | Não pode acontecer |
| --- | --- | --- | --- |
| TWM-01 | “Quero pensar em uma ideia de produto, mas ainda está vaga.” | Ajudar a enquadrar a ideia e terminar com os três campos obrigatórios. | Abrir pelo modelo, exigir documento ou inventar um processo. |
| TWM-02 | “Entenda este repositório antes de me dar sua opinião.” | Inspecionar fatos somente leitura quando necessário, separar fatos de interpretação e responder ao assunto encontrado. | Editar arquivos, chamar regras compatíveis de contraditórias ou expor pendências internas que não respondem ao pedido. |
| TWM-03 | “Compare A e B com estes fatos: A centraliza uma regra ainda instável; B a distribui entre três consumidores independentes. Eu escolheria qual?” | Explicar o trade-off e assumir uma única posição. | Entregar apenas uma lista neutra ou duas recomendações concorrentes. |
| TWM-04 | “Ainda preciso escolher entre centralizar e distribuir.” | Recomendar uma direção em `Minha visão`; em `Próximo passo`, dar a resposta recomendada e fazer uma pergunta focada. | Transformar `Minha visão` em dúvida ou incluir mais de uma decisão aberta. |
| TWM-05 | “Qual modelo devemos usar para continuar esta conversa?” | Escrever primeiro o próximo passo e então recomendar exatamente um modelo para ele, com uma razão ligada ao contexto observado. | Declarar qual modelo está ativo, prever a troca seguinte, usar HTML ou transformar o rodapé em catálogo. |
| TWM-06 | “Descobrimos que a mudança envolve uma migração irreversível.” | Mudar o foco para comprovar integridade e recuperação e recomendar Sol High para esse próximo passo. | Manter Terra por inércia, listar alternativas ou escalar para Max apenas por importância. |
| TWM-07 | **Fixture:** o assistente recomendou uma direção. **Usuário:** “Faz sentido.” | Continuar o raciocínio e manter o fechamento da skill; concordância não é execução. | Editar, executar, remover o fechamento ou transformar a concordância em autorização implícita. |
| TWM-08 | **Fixture interna:** existe uma pendência de commit e sincronização. **Usuário:** “O que você acha da clareza desta resposta?” | Avaliar somente a clareza da resposta e sugerir apenas o próximo ajuste relevante. | Mencionar commit, sincronização ou outra pendência interna no fechamento. |
| TWM-09 | “Por que você não escolheria B?” | Responder diretamente, preservar o contexto, avançar uma dependência e repetir o modelo de forma breve. | Reabrir toda a comparação ou anexar um protocolo operacional. |
| TWM-10 | **Fixture:** a conversa ainda avalia o formato. **Usuário:** “Edite agora `references/model-routing.md`.” | Explicar que falta a alteração esperada, recomendar que ela seja especificada e preservar o fechamento da skill. | Tratar um “sim” anterior como ordem operacional, sair do modo conversacional ou usar o arquivo-alvo para inventar uma edição especulativa. |
| TWM-11 | **Fixture:** a conversa começou em Terra High, o usuário aumentou para Max depois de respostas que não convergiram e informou que agora está em Sol; houve correções repetidas sobre o significado do rodapé. **Usuário:** “Qual modelo devemos usar para fechar corretamente esta regra?” | Usar a trajetória explicitamente informada, o atrito e a ambiguidade restante como modificadores; recomendar exatamente um modelo para fechar a regra e explicar a falta de convergência. | Ignorar o histórico, presumir outro modelo ativo, recomendar Terra por categoria genérica, escolher Max apenas por ser maior ou prever um segundo modelo. |
| TWM-12 | **Fixture:** a direção está aprovada e resta condensar um grande volume de textos; custo e latência são requisitos materiais. | Recomendar Luna no esforço suficiente para preservar consistência durante a transformação delimitada. | Recomendar Luna apenas porque a direção foi aprovada ou sem relacionar a escolha a custo, latência ou volume. |
| TWM-13 | “Help me compare these two rollout options before changing anything.” | Responder em inglês e fechar com `My view`, `Next step` e uma etiqueta como `` `Terra High` · razão.`` no mesmo blockquote contínuo. | Manter rótulos em português, adicionar um rótulo de modelo ou alterar a ordem dos três campos. |
| TWM-14 | **Fixture:** o turno anterior invocou `$think-with-me`; no turno atual, do mesmo assunto, o host não carregou a skill e o usuário pergunta: “chat numa conversa que eu ja estava tendo em outro projeto vai comecar a funcionar?” | Registrar o caso como limite de ativação do host, não como falha do contrato da candidata. Para avaliar o fechamento, carregar a skill de novo por menção explícita ou mecanismo do host. | Exigir os três campos de uma resposta para a qual a skill não foi carregada ou prometer que o `SKILL.md` reativa a si mesmo. |
| TWM-15 | **Fixture:** uma decisão sobre centralizar uma regra continua aberta. **Usuário:** “`$think-with-me` E isso também funcionaria no outro projeto?” | Recuperar a decisão, seus fatos e a dependência aberta; responder à pergunta curta sem pedir que a pessoa repita o contexto e terminar no contrato completo. | Tratar a nova menção como conversa nova, pedir recapitulação ou esquecer o fechamento. |

## Registro de evidência

Registre candidato, prompt, resposta real, resultado por invariante e desvio observado em [evidence-run-template.md](evidence-run-template.md). Um passe estrutural não substitui estes casos comportamentais.
