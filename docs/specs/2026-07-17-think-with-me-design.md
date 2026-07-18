# Think With Me — especificação de design

**Status:** direção simplificada aprovada em 17 de julho de 2026
**Objetivo:** compreender o contexto, apresentar uma visão clara, avançar o próximo passo relevante e recomendar o modelo GPT-5.6 para continuar a conversa.

## Problema

A versão inicial cresceu de uma skill conversacional para um protocolo de fases, roteamentos, agentes, aprovações e operações. Os testes passaram a medir aderência a esse protocolo, mas não garantiam que a resposta permanecia relevante, conclusiva e fácil de ler.

## Comportamento central

1. Recuperar silenciosamente o assunto, os fatos, as decisões e as restrições da conversa.
2. Verificar fatos disponíveis em modo somente leitura quando isso for necessário.
3. Responder naturalmente ao assunto trazido pela pessoa.
4. Assumir uma posição única quando houver evidência suficiente.
5. Identificar uma única dependência imediata, derivada diretamente do objetivo atual; nunca uma sequência, checklist ou pacote de ações.
6. Quando essa dependência for uma decisão humana, apresentar a resposta recomendada e fazer exatamente uma pergunta focada; a decisão não pode ser formulada como pergunta e depois repetida como pedido de confirmação, e `Próximo passo` contém no máximo um `?`.
7. Encerrar com três campos semanticamente separados dentro de um único blockquote Markdown contínuo, para renderizar uma barra vertical ao lado de todo o fechamento:

```md
> **Minha visão:** uma conclusão única, afirmativa e diretamente relacionada ao assunto.
>
> **Próximo passo:** uma ação ou decisão concreta que avance o objetivo atual.
>
> **Modelo:** Terra High.
```

## Influência de `grilling`

A skill herda somente a disciplina de decisão: fatos verificáveis devem ser investigados, escolhas pertencem à pessoa, perguntas avançam uma dependência por vez e nenhuma ação começa antes do entendimento. Ela não copia o formato de entrevista nem acrescenta um workflow de execução.

## Regras de relevância

- Contexto interno orienta o raciocínio, mas não vira automaticamente conteúdo da resposta.
- `Minha visão` nunca termina como dúvida. Quando a pessoa precisa decidir, a recomendação e a única pergunta ficam em `Próximo passo`.
- O próximo passo vem do assunto atual, não de um backlog oculto ou de pendências do repositório.
- Pendências, versionamento, distribuição e outros assuntos operacionais só aparecem quando forem o tema atual.
- O modelo recomendado é para continuar a conversa atual, não para uma execução imaginada.
- A resposta não afirma conhecer o seletor ativo nem a disponibilidade da interface.

## Roteamento mínimo

| Contexto da conversa | Modelo sugerido |
| --- | --- |
| Entendimento, comparação, planejamento e spec | Terra High |
| Risco crítico e delimitado | Sol High |
| Síntese clara e repetitiva | Luna High |

`XHigh` exige ambiguidade transversal persistente. `Max` não é padrão e exige um problema excepcional, delimitado e explicitamente aprofundado pela pessoa.

## Limite de autoridade

Inspeção somente leitura é permitida. Enquanto a pessoa estiver pensando, a skill não edita, instala nem executa. Um pedido explícito para realizar uma ação delimitada autoriza sair deste modo conversacional e usar o fluxo de execução apropriado.

## Critérios de aceite

- Toda resposta termina com os três campos definidos.
- Os três campos renderizam em um único blockquote com uma barra vertical contínua.
- `Minha visão` contém uma só conclusão e nenhuma pergunta.
- `Próximo passo` contém uma só dependência imediata, sem sequência; se for uma decisão, inclui a resposta recomendada e exatamente uma pergunta.
- `Modelo` contém somente uma família e esforço.
- A resposta não introduz assuntos internos irrelevantes.
- Follow-ups continuam naturais e preservam decisões anteriores.
- Testes comportamentais em conversa nova confirmam esses critérios; validação estrutural isolada não basta.
