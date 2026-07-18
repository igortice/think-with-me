# Think With Me — casos de ativação

Use estes casos apenas para avaliar a descrição no frontmatter e a descoberta implícita. Eles são diferentes dos [casos comportamentais](think-with-me-cases.md), que avaliam o que acontece depois que a skill já foi invocada.

Em hosts que escolhem skills automaticamente, execute cada prompt em uma conversa nova **sem** mencionar `$think-with-me`, registre se a skill foi carregada e compare o resultado com esta tabela. No Codex, onde a interface pode manter a invocação manual, use os casos para revisar a precisão semântica da descrição.

| ID | Prompt | Deve ativar? | Motivo |
|---|---|---:|---|
| TWM-T01 | “Antes de mexer no código, quero entender o fluxo atual e decidir a melhor abordagem.” | Sim | Planejamento e entendimento antes da execução. |
| TWM-T02 | “Tenho duas formas de fazer esta migração; me ajude a comparar riscos e fechar uma spec.” | Sim | Comparação de opções e elaboração de spec. |
| TWM-T03 | “Qual família de modelo e esforço fazem sentido para planejar esta mudança?” | Sim | Roteamento de modelo para uma etapa de planejamento. |
| TWM-T04 | “Continue refinando esta ideia, dê sua visão e diga o próximo passo.” | Sim | Retomada explícita de uma conversa de entendimento que precisa avançar. |
| TWM-T05 | “Com base neste contexto, qual é a sua visão, o que fazemos agora e qual GPT-5.6 devemos usar?” | Sim | Pedido direto de posição contextual, próximo passo e recomendação de modelo. |
| TWM-T06 | “Corrija o typo no título deste README.” | Não | Edição pequena e direta, sem decisão de planejamento. |
| TWM-T07 | “Rode os testes e me diga quais falharam.” | Não | Execução de uma ação delimitada, não planejamento antes da execução. |
| TWM-T08 | “Traduza este parágrafo para inglês.” | Não | Transformação pontual de texto, sem decisão aberta. |

Um resultado aceitável exige que os casos positivos sejam cobertos sem fazer a skill disparar nos três casos negativos. Revise a descrição por conceitos gerais, não por palavras isoladas dos prompts. Uma descoberta positiva melhora a ativação; ela não garante que uma continuação curta sem contexto, como “continua”, manterá a skill selecionada pelo host.
