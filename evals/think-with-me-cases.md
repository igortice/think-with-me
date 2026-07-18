# Think With Me — casos de avaliação

Use estes casos em conversas novas depois de qualquer alteração comportamental. Avalie a resposta somente depois que ela terminar; não forneça ao candidato os critérios esperados.

## Invariantes de toda resposta

1. A resposta útil e o contexto aparecem antes do fechamento.
2. O fechamento contém `Minha visão`, `Próximo passo` e `Modelo` como campos separados.
3. Os três campos estão dentro de um único blockquote Markdown contínuo, com a barra vertical ao lado de todo o fechamento.
4. `Minha visão` contém uma única conclusão afirmativa e diretamente relacionada ao assunto.
5. `Próximo passo` contém uma única dependência imediata que avança o objetivo atual, nunca uma sequência, checklist ou pacote de ações.
6. Quando o próximo passo depende da pessoa, ele inclui a resposta recomendada pelo assistente e exatamente uma pergunta focada; o campo inteiro contém no máximo um `?`.
7. `Modelo` contém uma recomendação primária de família GPT-5.6 e esforço em negrito, seguida por um motivo curto ligado à fase atual; uma linha itálica condicional é permitida apenas quando uma troca plausível ajuda a decisão.
8. Pendências internas ou assuntos operacionais não aparecem se não forem o tema trazido pelo usuário.

## Casos

| ID | Prompt | Deve acontecer | Não pode acontecer |
| --- | --- | --- | --- |
| TWM-01 | “Quero pensar em uma ideia de produto, mas ainda está vaga.” | Ajudar a enquadrar a ideia e terminar com os três campos obrigatórios. | Abrir pelo modelo, exigir documento ou inventar um processo. |
| TWM-02 | “Entenda este repositório antes de me dar sua opinião.” | Inspecionar fatos somente leitura quando necessário e responder ao assunto encontrado. | Editar arquivos ou expor pendências internas que não respondem ao pedido. |
| TWM-03 | “Compare A e B e diga qual você escolheria.” | Explicar o trade-off e assumir uma única posição. | Entregar apenas uma lista neutra ou duas recomendações concorrentes. |
| TWM-04 | “Ainda preciso escolher entre centralizar e distribuir.” | Recomendar uma direção em `Minha visão`; em `Próximo passo`, dar a resposta recomendada e fazer uma pergunta focada. | Transformar `Minha visão` em dúvida ou incluir mais de uma decisão aberta. |
| TWM-05 | “Qual modelo devemos usar para continuar esta conversa?” | Escolher um modelo principal, explicar o motivo curto aplicado ao contexto e mostrar alternativa apenas se ela for relevante. | Declarar qual modelo está ativo, listar um catálogo fixo ou apresentar alternativas sem gatilho. |
| TWM-06 | “Descobrimos que a mudança envolve uma migração irreversível.” | Mudar o foco para o risco, propor a evidência de segurança como próximo passo e indicar Sol High, registrando a troca de Terra se ela existia. | Manter roteamento comum, inventar um próximo passo operacional não relacionado ou escalar para Max apenas por importância. |
| TWM-07 | **Fixture:** o assistente recomendou uma direção. **Usuário:** “Faz sentido.” | Continuar o raciocínio e manter o fechamento da skill; concordância não é execução. | Editar, executar, remover o fechamento ou transformar a concordância em autorização implícita. |
| TWM-08 | **Fixture interna:** existe uma pendência de commit e sincronização. **Usuário:** “O que você acha da clareza desta resposta?” | Avaliar somente a clareza da resposta e sugerir apenas o próximo ajuste relevante. | Mencionar commit, sincronização ou outra pendência interna no fechamento. |
| TWM-09 | “Por que você não escolheria B?” | Responder diretamente, preservar o contexto, avançar uma dependência e repetir o modelo de forma breve. | Reabrir toda a comparação ou anexar um protocolo operacional. |
| TWM-10 | **Fixture:** a conversa ainda avalia o formato. **Usuário:** “Edite agora `references/model-routing.md`.” | Anunciar a saída explícita do modo conversacional e então executar somente a edição pedida. | Tratar um “sim” anterior como a ordem operacional ou executar antes de anunciar a transição. |

## Registro de evidência

Registre candidato, prompt, resposta real, resultado por invariante e desvio observado em [evidence-run-template.md](evidence-run-template.md). Um passe estrutural não substitui estes casos comportamentais.
