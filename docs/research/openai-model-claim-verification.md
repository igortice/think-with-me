# Verificação da alegação: GPT-5.6 Sol, Terra e Luna

**Consulta inicial:** 30 de julho de 2026 (America/Fortaleza)

**Auditoria e atualização:** 31 de julho de 2026 (America/Fortaleza)
**Escopo:** verificar o screenshot atribuído a `@OpenAI`, confrontar as reduções
de preço, o Fast mode, o consumo em Codex/ChatGPT Work e o gráfico do Artificial
Analysis Intelligence Index v4.1.

## Conclusão

A alegação textual central foi confirmada pelos canais oficiais da OpenAI. O
changelog de 30/07/2026 registra exatamente que a Luna passou a custar 80% menos
e a Terra 20% menos, além da introdução do Fast mode na API.

Há duas distinções essenciais:

1. Os 80%/20% são reduções em relação aos preços imediatamente anteriores, não
   descontos relativos ao Sol. Depois da mudança, Terra custa 60% menos que Sol
   e Luna custa 96% menos que Sol na tarifa API Standard de contexto curto.
2. O gráfico do Artificial Analysis é evidência independente de desempenho em
   um benchmark composto; não é uma garantia de qualidade, latência ou custo
   para qualquer fluxo específico. A imagem mostra uma curva da Luna em vários
   níveis de raciocínio, e não cinco modelos Luna diferentes.

## Evidência oficial da OpenAI

O [changelog da API](https://developers.openai.com/api/docs/changelog) registra em
30 de julho:

- GPT-5.6 Luna: redução de 80% no preço;
- GPT-5.6 Terra: redução de 20% no preço;
- Fast mode, substituindo o nome Priority Processing;
- para GPT-5.6 Sol, Fast mode entrega até 2,5x a velocidade do processamento
  Standard, com o dobro do preço.

O [catálogo de modelos](https://developers.openai.com/api/docs/models) e a
[orientação de seleção](https://developers.openai.com/api/docs/guides/latest-model)
confirmam os papéis:

- **Sol:** flagship para raciocínio e código complexos; o alias `gpt-5.6`
  aponta para `gpt-5.6-sol`;
- **Terra:** equilíbrio entre inteligência e custo;
- **Luna:** workloads sensíveis a custo e de alto volume.

As três variantes têm, segundo suas páginas de modelo, janela de contexto de
1.050.000 tokens e máximo de saída de 128.000 tokens. Em prompts com mais de
272K tokens de entrada, a requisição inteira é tarifada com 2x na entrada e 1,5x
na saída. Escritas de cache custam 1,25x a entrada sem cache.

## Preços API atuais

Preços por 1 milhão de tokens, contexto curto, processamento Standard, conforme
a [tabela de preços atual](https://developers.openai.com/api/docs/pricing):

| Modelo | Entrada | Cache hit | Cache write | Saída | Preço relativo a Sol |
| --- | ---: | ---: | ---: | ---: | ---: |
| Sol | US$ 5,00 | US$ 0,50 | US$ 6,25 | US$ 30,00 | 100% |
| Terra | US$ 2,00 | US$ 0,20 | US$ 2,50 | US$ 12,00 | 40% |
| Luna | US$ 0,20 | US$ 0,02 | US$ 0,25 | US$ 1,20 | 4% |

Os preços atuais permitem reconstruir os preços anteriores a partir dos
percentuais do changelog:

- Terra: US$ 2,50 / US$ 15,00 antes; US$ 2,00 / US$ 12,00 depois = 20% menos;
- Luna: US$ 1,00 / US$ 6,00 antes; US$ 0,20 / US$ 1,20 depois = 80% menos.

Isso explica por que uma busca ou captura anterior pode mostrar US$ 2,50/15
para Terra e US$ 1/6 para Luna: eram os preços pré-redução, não a tabela atual.

Para completar a matriz de operação da API:

- **Batch e Flex:** a tabela publica, para GPT-5.6, a metade da tarifa Standard;
- **Fast mode:** a tabela publica o dobro da tarifa Standard no contexto curto
  (Sol US$ 10/60, Terra US$ 4/24, Luna US$ 0,40/2,40);
- **Fast mode não suporta contexto longo**; cache hit continua recebendo o
  desconto aplicável;
- o [guia de Fast mode](https://developers.openai.com/api/docs/guides/fast-mode)
  recomenda-o para aplicações user-facing nas quais latência seja prioritária,
  mas alerta que o tráfego pode ser rebaixado para Standard durante rampas
  agressivas.

## Codex e ChatGPT Work

O [guia de velocidade do Codex](https://learn.chatgpt.com/docs/agent-configuration/speed)
afirma explicitamente que ChatGPT Work e Codex compartilham preços, créditos e
limites de uso. Portanto, a imagem está correta ao dizer que a escolha passa a
render mais uso, mas isso não significa que API e créditos do ChatGPT sejam a
mesma contabilidade em dólares.

A tabela de créditos por 1 milhão de tokens em [Codex pricing](https://learn.chatgpt.com/docs/pricing)
é:

| Modelo | Entrada | Cache hit | Saída | Relativo a Sol |
| --- | ---: | ---: | ---: | ---: |
| Sol | 125 | 12,5 | 750 | 100% |
| Terra | 50 | 5 | 300 | 40% |
| Luna | 5 | 0,5 | 30 | 4% |

Ou seja: na matriz de créditos, Terra usa 60% menos que Sol e Luna 96% menos.
As faixas de mensagens são apenas médias operacionais, não uma conversão fixa
por tarefa. Na tabela Plus atual, por janela compartilhada de cinco horas, a
OpenAI mostra 10–100 mensagens locais para Sol, 25–200 para Terra e 250–2.000
para Luna. Contexto, raciocínio, ferramentas, retrieval e cache alteram o
consumo.

No Codex:

- Fast mode aumenta a velocidade em 1,5x;
- GPT-5.6 e GPT-5.5 consomem 2,5x os créditos Standard nesse modo;
- com chave de API, não se aplicam os multiplicadores de crédito do ChatGPT:
  valem os preços por token da API; Priority/Fast da API tem faturamento próprio.

## O que o gráfico confirma — e o que não confirma

A página da [Artificial Analysis para GPT-5.6 Luna](https://artificialanalysis.ai/models/gpt-5-6-luna)
confirma que o modelo é da OpenAI. Na captura auditada em 31/07, a variante
`max` marcou 51,24 no Artificial Analysis Intelligence Index v4.1, 71,45 no
Coding Index, custo médio de US$ 0,066 por tarefa do Intelligence Index,
177,8 tokens/s de output e 117,02 s até o primeiro token de resposta. O recorte
legível por máquina está preservado em
`docs/research/assets/artificial-analysis-model-pages-2026-07-31.json`.

O índice v4.1 reúne nove avaliações, incluindo GDPval-AA v2, tau³-Banking,
Terminal-Bench v2.1, SciCode, Humanity's Last Exam, GPQA Diamond, CritPt,
AA-Omniscience e AA-LCR. A Artificial Analysis calcula custo por tarefa usando
preços e tokens de entrada, cache hit, cache write, raciocínio e resposta.

Portanto:

- o gráfico é um bom sinal de que Luna pode ter uma relação inteligência/preço
  muito forte em tarefas de raciocínio e agentes;
- ele não prova que Luna seja melhor para RAG jurídico, português, extração de
  campos específicos ou julgamento aberto sem uma avaliação nossa;
- tokens por segundo não é tempo de resposta total: para modelos de raciocínio,
  TTFT inclui o tempo de pensar antes do primeiro token de resposta;
- qualidade, esforço de raciocínio, volume de saída e retrabalho precisam entrar
  na matriz, não apenas o preço nominal por token.

O [artigo comparativo da Artificial Analysis](https://artificialanalysis.ai/articles/gpt-5-6-intelligence-vs-cost-across-sol-terra-luna)
relata que Sol e Luna ficam à frente de Terra na fronteira inteligência/custo
naquele conjunto de avaliações. Isso é uma conclusão válida para aquela
metodologia, não uma ordem universal de roteamento.

## Matriz recomendada após a mudança

| Tipo de tarefa | Família | Esforço |
| --- | --- | --- |
| Conversa comum, entendimento de projeto e análise reversível sem urgência de resposta | Luna | max |
| Conversa rápida e recuperação de contexto sensível à latência | Sol | medium |
| Arquitetura com trade-offs, especificação técnica ou julgamento profissional | Sol | high |
| Ambiguidade residual concreta, restrições conflitantes ou risco difícil de detectar | Sol | xhigh |
| Risco crítico delimitado que permaneceu sem solução após uma rota seletiva mais estreita, normalmente Sol XHigh | Sol | max |
| Contrato fechado, prioridade de qualidade e execução heterogênea interdependente | Terra | max |
| Trabalho comum orientado a valor quando a espera é aceitável, ou execução cost-first reversível e revisada | Luna | max |

Minha leitura operacional é: **a matriz deve mudar sem rebaixar o piso de
qualidade**. Luna Max é a rota de valor para trabalho comum não consequencial
quando a espera adicional é aceitável; Sol Medium é a rota de velocidade.
Em execução consequencial, Luna continua exigindo saída reversível e revisada
antes de consequência. Terra Max exige contrato
fechado, prioridade explícita de qualidade e execução heterogênea
interdependente. Sol Max só entra quando um risco crítico explicitamente
delimitado permanece sem solução após uma rota seletiva mais estreita; um pedido
direto de profundidade máxima não basta. Preço e benchmark não autorizam nenhum
par fora das seis configurações.

Ao avaliar o custo das seis rotas elegíveis, rode o mesmo conjunto de tarefas
do domínio correspondente, fixando `reasoning.effort` e separando
Standard/Fast. Meça:

1. taxa de aceitação sem edição;
2. correção e completude;
3. retrabalho e escalonamentos;
4. tokens e créditos por tarefa aceita;
5. TTFT, tempo total e throughput.

O critério final deve ser **custo por tarefa aceita**, não custo por token nem
posição isolada no Intelligence Index.

## Fontes e rastreabilidade

1. [OpenAI API Changelog](https://developers.openai.com/api/docs/changelog),
   atualização de 30/07/2026.
2. [OpenAI API Pricing](https://developers.openai.com/api/docs/pricing),
   tabela atual de Standard, Batch, Flex e Fast mode.
3. [OpenAI Model guidance](https://developers.openai.com/api/docs/guides/latest-model)
   e [Models catalog](https://developers.openai.com/api/docs/models).
4. [Codex Speed](https://learn.chatgpt.com/docs/agent-configuration/speed) e
   [ChatGPT/Codex pricing](https://learn.chatgpt.com/docs/pricing).
5. [Artificial Analysis — GPT-5.6 Luna](https://artificialanalysis.ai/models/gpt-5-6-luna)
   e [comparação Sol/Terra/Luna](https://artificialanalysis.ai/articles/gpt-5-6-intelligence-vs-cost-across-sol-terra-luna).

Os preços, limites e valores de benchmark apresentados como atuais foram
auditados em 31/07/2026; preços, limites, disponibilidade e métricas de sites
vivos podem mudar. Capturas históricas datadas permanecem imutáveis e não
substituem esta visão atual.
