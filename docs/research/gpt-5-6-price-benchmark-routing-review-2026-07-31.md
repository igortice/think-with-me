# Revisão de preço, benchmarks e roteamento do GPT-5.6 — 2026-07-31

**Pergunta principal:** após a redução de 80% no preço de GPT-5.6 Luna, há
evidência suficiente para substituir `Sol Medium` por `Luna Max` em conversas
normais?

**Conclusão:** não há evidência suficiente para tornar `Luna Max` o substituto
padrão de `Sol Medium` em conversas normais. A redução torna `Luna Max`
extraordinariamente barata por token e por tarefa nos dois benchmarks
consultados. No DeepSWE v1.1, ela também supera o Pass@1 observado de `Sol
Medium`. Mas essa evidência vem de agentes de engenharia de software em tarefas
longas, não de conversas normais. Na Artificial Analysis (AA), `Luna Max` fica
abaixo de `Sol Medium` nos índices de Intelligence e Coding e leva
aproximadamente 117 s até o primeiro token de resposta, contra 4,31 s de `Sol
Medium`. O preço novo não autoriza a troca do default, mas já invalida uma
restrição excessivamente estreita: DeepSWE mostra que Luna Max pode executar
trabalho aberto e longo, e não apenas transformações de schema fixo. A política
deve abrir uma rota controlada de custo para trabalho assíncrono, reversível e
revisável, mantendo a promoção a default conversacional condicionada a teste
local.

Esta revisão não abriu evals existentes nem leu respostas esperadas. Foram
consultadas documentação oficial da OpenAI, páginas e metodologia originais da
Artificial Analysis e material, repositório e dados publicados pelos autores do
DeepSWE.

## 1. O que mudou em 30/07/2026

### Fatos oficiais

O [changelog da API da OpenAI](https://developers.openai.com/api/docs/changelog)
registra que, a partir de 30/07, GPT-5.6 Luna passou a custar 80% menos e Terra,
20% menos. A mesma atualização renomeou Priority Processing para Fast mode; para
Sol, a OpenAI anuncia até 2,5 vezes a velocidade Standard por duas vezes o preço.

Na [tabela oficial de preços](https://developers.openai.com/api/docs/pricing), o
processamento Standard em contexto curto custa, por 1 milhão de tokens:

| Família | Entrada | Cache hit | Cache write | Saída |
| --- | ---: | ---: | ---: | ---: |
| Sol | US$ 5,00 | US$ 0,50 | US$ 6,25 | US$ 30,00 |
| Terra | US$ 2,00 | US$ 0,20 | US$ 2,50 | US$ 12,00 |
| Luna | US$ 0,20 | US$ 0,02 | US$ 0,25 | US$ 1,20 |

O changelog fala de redução em relação ao preço anterior da própria família,
não de desconto contra Sol. Com os preços atuais, Terra custa 40% da tarifa de
Sol e Luna custa 4%: Luna está 96% abaixo de Sol por token. Para requisições com
mais de 272 mil tokens de entrada, as [páginas de Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol),
[Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra) e
[Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna) informam 2x
na entrada e 1,5x na saída para toda a requisição. A proporção entre as famílias
permanece a mesma.

A [orientação oficial de modelos](https://developers.openai.com/api/docs/guides/latest-model)
posiciona Sol como a opção de capacidade flagship, Terra como equilíbrio entre
inteligência e custo e Luna como opção eficiente para workloads de alto volume.
As três famílias aceitam `none`, `low`, `medium`, `high`, `xhigh` e `max`. A
OpenAI recomenda `medium` como ponto inicial equilibrado e reserva `max` para os
workloads mais difíceis, comparando configurações em tarefas representativas.
Isso é orientação de produto, não evidência de equivalência entre famílias.

### Codex e ChatGPT Work

O [guia de velocidade](https://learn.chatgpt.com/docs/agent-configuration/speed)
afirma que ChatGPT Work e Codex compartilham preços, créditos e limites. A
[tabela de preços e créditos](https://learn.chatgpt.com/docs/pricing) publica:

| Família | Créditos/1M entrada | Créditos/1M cache hit | Créditos/1M saída |
| --- | ---: | ---: | ---: |
| Sol | 125 | 12,5 | 750 |
| Terra | 50 | 5 | 300 |
| Luna | 5 | 0,5 | 30 |

Assim, Luna também usa 4% dos créditos de Sol para o mesmo número e tipo de
tokens. Isso não significa “25 vezes mais tarefas”: contexto, raciocínio,
ferramentas, cache, retries e conclusão bem-sucedida alteram o consumo. A
documentação diz que uma mensagem GPT-5.6 usa em média 5–40 créditos, mas não
fornece conversão fixa de mensagem ou tarefa. API em dólares e créditos do plano
são contabilidades diferentes.

No Codex, Fast mode entrega 1,5x a velocidade e GPT-5.6 consome 2,5x os créditos
Standard. Na API, Fast mode tem sua própria tarifa e não suporta contexto longo;
o [guia oficial](https://developers.openai.com/api/docs/guides/fast-mode) também
avisa que rampas agressivas podem ser rebaixadas para Standard. Nenhum número de
Fast mode abaixo deve ser misturado com os benchmarks, que não declaram esse
modo.

## 2. As métricas não são intercambiáveis

| Medida | O que mede | O que não demonstra |
| --- | --- | --- |
| Preço por token | Tarifa de entrada, cache e saída | Quantos tokens, passos, retries ou correções uma tarefa exigirá |
| Custo por tarefa | Tokens realmente consumidos no domínio e harness medidos, multiplicados pelas tarifas aplicáveis | Custo universal de qualquer tarefa ou equivalência de qualidade |
| Pass@1 | Proporção de tentativas que passam o verificador do benchmark | Qualidade de conversa, preferência humana ou sucesso fora daquele domínio |
| Intervalo DeepSWE | Variação entre quatro passagens completas do benchmark | Teste pareado de diferença entre dois modelos |
| Output tokens | Volume emitido pelo agente | Qualidade ou latência, isoladamente |
| Passos | Iterações do agente no harness | Turnos de uma conversa comum |
| Output speed | Tokens recebidos por segundo depois que a geração começou | Tempo até a resposta começar |
| TTFT/TTFA | Tempo entre enviar a requisição e receber o primeiro token ou primeiro token de resposta | Throughput depois do primeiro token ou tempo total da tarefa |

A [metodologia da AA](https://artificialanalysis.ai/methodology) distingue TTFT
(primeiro token, inclusive de raciocínio) de time to first answer token (primeiro
token da resposta após o raciocínio). A comparação direta da AA chama a coluna
de “Time to First Token”, enquanto a seção de latência das páginas de modelo a
descreve como primeiro token de resposta e inclui o tempo de raciocínio. Nesta
revisão, os valores de 117,02 s, 4,31 s, 152,99 s e 13,25 s são tratados como
latência até a primeira resposta visível, não como velocidade de decodificação.

## 3. DeepSWE v1.1

### Domínio e método

O [DeepSWE original](https://deepswe.datacurve.ai/blog/deepswe) contém 113
tarefas longas de engenharia de software em 91 repositórios e cinco linguagens.
Os prompts são curtos e orientados a comportamento, mas cada agente precisa
explorar e alterar um repositório. Todos os modelos usam o mesmo
`mini-swe-agent`, com uma ferramenta `bash` e prompt compartilhado. Isso reduz a
variação de scaffolding, mas não representa Codex, ChatGPT Work nem uma conversa
normal.

No [DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1), a alteração
principal é de execução e grading: o patch commitado pelo agente é aplicado e
testado em contêiner limpo e isolado. O [repositório original](https://github.com/datacurve-ai/deep-swe)
explica que a solução de referência existe para revisão offline e não é usada
no grading.

O [`leaderboard-live.json`](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json)
define Pass@1 como a taxa de tentativas aprovadas. Falhas de janela de contexto
e timeout do agente contam como falha; erros de provider, rede ou verificador
são excluídos. Cada configuração abaixo tem quatro runs quase completos. O
intervalo é 95% run-to-run, calculado como `1,96 × std(runs) / sqrt(R)`; não é um
intervalo pareado entre modelos.

### Resultados pertinentes

Dados de qualidade, tokens e passos vêm do JSON gerado em
`2026-07-25T03:13:49Z`. Custos com `*` são o overlay pós-30/07 hoje mostrado na
página pública, explicado logo abaixo.

| Configuração | Pass@1 | Intervalo 95% | Custo médio/tarefa | Input médio | Output médio | Passos médios | Duração média no JSON |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Luna Max | 67,19% (301/448) | 63,20–71,18% | **US$ 0,61\*** | 15,44M | 73,4k | 101,7 | 1.123 s |
| Sol Medium | 61,06% (276/452) | 59,48–62,65% | US$ 1,86 | 1,51M | 18,4k | 30,9 | 423 s |
| Terra Max | 69,62% (314/451) | 67,07–72,18% | **US$ 3,96\*** | 9,23M | 71,9k | 75,9 | 1.017 s |
| Sol High | 69,40% (313/451) | 67,97–70,83% | US$ 3,47 | 2,71M | 28,5k | 36,9 | 594 s |

`Duração média` é o tempo total do rollout no JSON, não TTFT. Os autores deixaram
de exibir wall-clock na página v1.1 porque máquina e carga do provider o tornam
inconsistente. Portanto, ele serve apenas como contexto do harness e não como
comparação de latência conversacional.

### Divergência de custo e overlay de preço

O JSON foi gerado em 25/07, antes da redução, e ainda contém US$ 3,0281 para
Luna Max e US$ 4,9458 para Terra Max. Em 31/07, a página renderizada do DeepSWE
mostra US$ 0,61 e US$ 3,96, respectivamente. Esses valores correspondem
exatamente a 20% e 80% dos custos antigos, os fatores das reduções anunciadas.

**Inferência:** a página pública reaplica as tarifas atuais às mesmas
trajetórias; não houve nova execução do benchmark depois da mudança de preço.
Por isso, Pass@1, tokens e passos continuam sendo resultados de execução de
25/07, enquanto os custos visíveis são uma reprecificação. Essa é uma inferência
fortemente sustentada pelos valores, mas o site não documenta explicitamente o
mecanismo do overlay.

### Leitura das duas comparações

**Luna Max vs. Sol Medium.** Dentro do DeepSWE, Luna tem +6,13 pontos
percentuais de Pass@1 e os intervalos run-to-run não se sobrepõem. Depois da
reprecificação, custa cerca de 67,5% menos por tarefa. Porém usa 10,3x o input,
4,0x o output e 3,3x os passos. Esse resultado é evidência favorável a Luna em
engenharia longa com verificador automático; não mede conversa normal.

**Terra Max vs. Sol High.** A diferença de Pass@1 é apenas +0,22 pp para Terra,
com intervalos amplamente sobrepostos. Mesmo após a redução de 20%, Terra custa
cerca de 14% mais por tarefa, usa 3,4x o input, 2,5x o output e 2,1x os passos.
O DeepSWE não demonstra vantagem de Terra Max sobre Sol High em qualidade ou
custo nessa vizinhança.

## 4. Artificial Analysis

### Método e domínio

O Intelligence Index v4.1 agrega nove avaliações: GDPval-AA v2, tau3-Banking,
Terminal-Bench v2.1, SciCode, Humanity's Last Exam, GPQA Diamond, CritPt,
AA-Omniscience e AA-LCR. É mais amplo que DeepSWE, mas ainda não é um teste de
conversa cotidiana em português.

O [Coding Index](https://artificialanalysis.ai/models/capabilities/coding) é uma
média 50/50 de Terminal-Bench v2.1 e SciCode. A
[metodologia de capability indices](https://artificialanalysis.ai/methodology/capability-indices)
alerta que os índices podem não mapear diretamente para cada caso de uso. As
páginas comparadas não publicam intervalo agregado para Intelligence ou Coding;
diferenças pequenas não devem ser tratadas como estatisticamente resolvidas.

A AA define custo por tarefa como média ponderada dos custos de input, cache
hit, cache write, raciocínio e resposta por tarefa do Intelligence Index. Já o
“preço por 1M tokens” da comparação direta é um preço blended com proporção
7:2:1 de cache hit, input e output. São medidas diferentes.

### Comparação atual

Valores consultados em 31/07 nas páginas de
[Luna Max](https://artificialanalysis.ai/models/gpt-5-6-luna/),
[Sol Medium](https://artificialanalysis.ai/models/gpt-5-6-sol-medium/),
[Terra Max](https://artificialanalysis.ai/models/gpt-5-6-terra/) e
[Sol High](https://artificialanalysis.ai/models/gpt-5-6-sol-high/):

| Configuração | Intelligence v4.1 | Coding Index | Blended/1M | Custo/ tarefa Intelligence | Output speed | Latência até resposta | Output total no índice |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Luna Max | 51,24 | 71,45 | US$ 0,174 | US$ 0,066 | 177,8 tok/s | 117,02 s | 130M |
| Sol Medium | 53,59 | 76,26 | US$ 4,35 | US$ 0,514 | 54,6 tok/s | 4,31 s | 12M |
| Terra Max | 54,95 | 76,66 | US$ 1,74 | US$ 0,733 | 131,8 tok/s | 152,99 s | 96M |
| Sol High | 55,87 | 77,16 | US$ 4,35 | US$ 0,771 | 62,4 tok/s | 13,25 s | 21M |

O total de output é o volume para executar o índice inteiro, não tokens de uma
tarefa nem de uma conversa. O custo/tarefa é a medida ponderada do próprio
índice. A [comparação direta Luna Max vs. Sol Medium](https://artificialanalysis.ai/models/comparisons/gpt-5-6-luna-vs-gpt-5-6-sol-medium)
confirma os valores arredondados de Intelligence, preço blended, output speed e
latência.

**Luna Max vs. Sol Medium.** Luna custa 87,2% menos por tarefa da AA e gera
tokens 3,3x mais rápido depois de começar. Mas fica 2,35 pontos abaixo no
Intelligence Index, 4,81 abaixo no Coding Index e sua primeira resposta demora
27,2x mais. O fato de Luna custar 96% menos por token, mas “apenas” 87% menos
por tarefa, mostra por que volume de raciocínio e resposta importa.

**Terra Max vs. Sol High.** Terra custa cerca de 5% menos por tarefa da AA e
decodifica 2,1x mais rápido. Fica 0,91 ponto abaixo no Intelligence Index e 0,50
no Coding Index, sem intervalo agregado publicado, e demora 11,5x mais até a
primeira resposta. Isso é compatível com execução longa e assíncrona, não com a
conclusão de que Terra é melhor para conversa ou julgamento profissional.

## 5. Fatos, inferências e lacunas

### Fatos sustentados

- Luna ficou 80% mais barata e Terra, 20%, em 30/07; Sol não recebeu redução
  nessa atualização.
- Na tarifa Standard e na tabela de créditos, Luna custa 4% de Sol para o mesmo
  tipo e número de tokens.
- DeepSWE v1.1 mede engenharia de software longa no `mini-swe-agent`, não
  conversa normal; nele, Luna Max tem Pass@1 observado maior que Sol Medium.
- O custo DeepSWE exibido para Luna/Terra foi atualizado, mas o JSON de
  resultados ainda é anterior à redução.
- Na AA, Luna Max é muito mais barata e tem output speed maior, mas seus índices
  são menores e a latência até a primeira resposta é muito maior que a de Sol
  Medium.
- Terra Max e Sol High ficam próximos nos índices e no Pass@1 DeepSWE; nenhuma
  das fontes demonstra superioridade geral de Terra.

### Inferências operacionais

- O custo novo fortalece `Luna Max` para lotes homogêneos, schema fixo e
  validação automática, mas o DeepSWE também sustenta uma rota experimental
  para engenharia aberta e longa quando a execução puder ser assíncrona,
  reversível e revisada antes de produzir consequência.
- `Terra Max` continua plausível para execução heterogênea e longa quando o
  contrato já está fechado; seu maior output speed pode ajudar throughput, mas
  o TTFT alto piora interação síncrona.
- `Sol Medium` continua sendo a escolha prudente para conversa, recuperação de
  contexto e análise reversível enquanto faltar uma avaliação local que mostre
  não inferioridade de Luna em qualidade e latência aceitável.
- O overlay DeepSWE é reprecificação, não uma nova medição de capacidade.

### Lacunas que impedem a troca

- Não há benchmark de conversa normal em português com o contexto, tom,
  continuidade e critérios deste projeto.
- Não há preferência humana cega Luna Max vs. Sol Medium nesse domínio.
- Não há taxa local de correções, omissões, overreach, respostas aceitas sem
  edição ou custo por conversa aceita.
- DeepSWE não mede TTFT e não representa o harness do Codex/ChatGPT Work.
- Os índices agregados da AA não publicam intervalo para essa comparação.
- A latência AA é de API e pode diferir da superfície local, do plano, da região
  e da carga atuais.
- Preço e limites podem mudar; uma futura decisão deve registrar modelo,
  esforço, modo Standard/Fast, superfície e data.

## 6. Proposta de teste local antes de alterar a política

### Hipótese

Testar se `Luna Max` é não inferior a `Sol Medium` em conversas normais do
projeto e simultaneamente reduz o custo por conversa aceita sem violar o SLO de
latência. Não testar “qual modelo é melhor em geral”.

### Corpus sem gabarito copiado

Criar 60 episódios novos, a partir de padrões reais sanitizados, sem abrir evals
existentes e sem copiar respostas esperadas:

- 20 de recuperação de contexto e explicação;
- 15 de análise delimitada e reversível, sem trade-off arquitetural aberto;
- 15 de continuidade multi-turno, correção e síntese de 3–5 turnos;
- 10 de pesquisa ou organização leve sem execução pesada de ferramentas.

Excluir decisões arquiteturais com julgamento (`Sol High`), execução
heterogênea (`Terra Max`) e lotes de schema fixo (`Luna Max` na política atual),
pois misturá-los esconderia a pergunta sobre conversa normal.

### Execução controlada

1. Rodar `Luna Max` e `Sol Medium` em Standard, mesma superfície, instruções,
   histórico, ferramentas permitidas e configuração de reasoning context.
2. Fazer três repetições por episódio, em ordem aleatória e com rótulos cegos:
   180 saídas por configuração.
3. Fixar snapshot quando a superfície permitir e registrar data, região, modo,
   cache e indisponibilidades. Não usar Fast mode no teste principal.
4. Separar uma rodada via API de uma rodada via Codex/ChatGPT Work. Na API,
   calcular dólares; no produto, registrar créditos reais. Não converter um no
   outro por aproximação.

### Métricas

**Qualidade primária:** aceitação sem edição, avaliada cegamente por critérios,
não por uma resposta textual esperada. Rubrica: correção, completude, respeito
às restrições, continuidade, incerteza calibrada, ausência de ação indevida e
clareza.

**Falhas:** fato inventado, restrição perdida, necessidade de correção do
usuário, escalonamento para outro modelo, retry e falha crítica difícil de
detectar.

**Economia:** input, cache hit/write, reasoning, answer tokens, créditos ou
dólares, retries e **custo por conversa aceita**.

**Experiência:** tempo ao primeiro chunk, tempo ao primeiro token de resposta,
tempo total, mediana e p95. Output speed deve permanecer uma métrica separada.

### Gate proposto

Comparar por episódio e calcular intervalo de 95% por bootstrap pareado. Só
considerar alteração da política se todos os gates passarem:

- limite inferior do intervalo para a diferença de aceitação Luna − Sol não
  ficar abaixo de −3 pontos percentuais;
- nenhuma regressão em falhas críticas e aumento absoluto de no máximo 1 pp em
  respostas que exigem correção;
- mediana de latência até a resposta de Luna no máximo 1,5x a de Sol e p95 de no
  máximo 30 s;
- custo por conversa aceita pelo menos 70% menor com Luna;
- preferência cega por Luna não inferior dentro do mesmo limite de 3 pp.

Se Luna passar, fazer canário de 10% das conversas elegíveis antes de propor a
troca. Se falhar qualidade ou latência, manter `Sol Medium` para conversa e
`Luna Max` para volume homogêneo.

### Controle secundário Terra Max vs. Sol High

Rodar uma lane separada, sem misturar no gate acima:

- 20 tarefas de execução heterogênea, tool-heavy e assíncrona já especificada;
- 20 tarefas de julgamento, trade-off e especificação técnica.

A expectativa a testar é especialização, não substituição universal: Terra
deve reduzir custo/tempo de execução aceita na primeira lane; Sol High deve
preservar qualidade e concisão na segunda. Medir os mesmos tokens, passos,
TTFT, tempo total, retries, falhas e custo por tarefa aceita.

## 7. Recomendação para a política

**Alterar a elegibilidade, mas não o default conversacional.** Preservar a
allowlist atual e ajustar os papéis:

- `Sol Medium` permanece como padrão para conversa interativa de projeto,
  contexto, explicação e análise reversível sem julgamento oculto;
- `Sol High` permanece para trade-offs e julgamento profissional;
- `Terra Max` permanece como candidata para execução heterogênea e longa com
  contrato fechado, sem alegar superioridade sobre Sol High enquanto a lane
  local não demonstrar vantagem em tarefa aceita;
- `Luna Max` mantém a rota comprovada de volume homogêneo, schema fixo e
  validação barata e passa a ser elegível, em caráter controlado, para execução
  longa e aberta ou conversa cost-first quando o trabalho for assíncrono,
  reversível, revisável e tolerante à latência e aos passos adicionais;
- `Luna Max` não deve substituir automaticamente `Sol Medium` em conversa
  interativa até passar o gate local de não inferioridade e latência.

Também é necessário atualizar a superfície pública da skill: preservar o
snapshot de 20/07 como histórico imutável, adicionar o overlay de preços de
30/07, rotular claramente valores reprecificados e impedir que o custo antigo
de Luna/Terra continue orientando a matriz atual.

A mudança de preço altera fortemente a economia, mas não o requisito de
qualidade. A próxima ação correta é executar o teste local cego e decidir a
promoção conversacional por custo por conversa aceita, qualidade não inferior e
latência observada — não por preço por token, Pass@1 de coding ou output speed
isolados.

## Fontes primárias

### OpenAI

- [API changelog — atualização de 30/07/2026](https://developers.openai.com/api/docs/changelog)
- [API pricing](https://developers.openai.com/api/docs/pricing)
- [Model guidance — GPT-5.6](https://developers.openai.com/api/docs/guides/latest-model)
- [GPT-5.6 Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol)
- [GPT-5.6 Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra)
- [GPT-5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna)
- [Reasoning models e níveis de esforço](https://developers.openai.com/api/docs/guides/reasoning)
- [Fast mode da API](https://developers.openai.com/api/docs/guides/fast-mode)
- [ChatGPT Work/Codex — speed](https://learn.chatgpt.com/docs/agent-configuration/speed)
- [ChatGPT Work/Codex — pricing e créditos](https://learn.chatgpt.com/docs/pricing)

### DeepSWE/DataCurve

- [DeepSWE original e metodologia](https://deepswe.datacurve.ai/blog/deepswe)
- [DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1)
- [Raw leaderboard v1.1](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json)
- [Repositório original](https://github.com/datacurve-ai/deep-swe)

### Artificial Analysis

- [Comparação direta Luna Max vs. Sol Medium](https://artificialanalysis.ai/models/comparisons/gpt-5-6-luna-vs-gpt-5-6-sol-medium)
- [Luna Max](https://artificialanalysis.ai/models/gpt-5-6-luna/)
- [Sol Medium](https://artificialanalysis.ai/models/gpt-5-6-sol-medium/)
- [Terra Max](https://artificialanalysis.ai/models/gpt-5-6-terra/)
- [Sol High](https://artificialanalysis.ai/models/gpt-5-6-sol-high/)
- [Benchmarking methodology](https://artificialanalysis.ai/methodology)
- [Capability Indices methodology](https://artificialanalysis.ai/methodology/capability-indices)
- [Coding Index](https://artificialanalysis.ai/models/capabilities/coding)
