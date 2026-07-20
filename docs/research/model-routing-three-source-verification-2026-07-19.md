# Verificação documental de três fontes — 2026-07-19

**Revisão de proveniência em 20/07/2026.** O JSON DeepSWE usado para conferir
os valores foi preservado em
[`assets/deepswe-v1.1-leaderboard-2026-07-20.json`](assets/deepswe-v1.1-leaderboard-2026-07-20.json).
O artefato informa `generated_at=2026-07-17T08:18:55.870582+00:00` e possui
SHA-256 `050663ae245106a7fc59312565059f46bd6ee10fa587131dd09a5062af5ed24d`.
Essa revisão corrigiu a falsa precisão da transcrição visual de Luna XHigh e
Terra High na comparação pública; os demais valores foram conferidos contra o
mesmo JSON.

## Escopo

Este registro compara somente três fontes, sem recomendar uma rota de modelo:
(1) documentação oficial da OpenAI, (2) os dois recortes do Artificial Analysis
fornecidos pelo usuário e preservados com o mesmo filtro de dez configurações,
e (3) DeepSWE v1.1 e seu artefato publicado. Descrição de produto não é
benchmark; índice composto não é DeepSWE; custo DeepSWE não é cobrança ou cota
do Codex. Cálculos são marcados como tais; lacunas permanecem como não
demonstradas.

## 1. OpenAI: fatos explícitos

A [página de modelos](https://developers.openai.com/api/docs/models) posiciona
GPT-5.6 Sol para raciocínio e código complexos, Terra para equilibrar
inteligência e custo, e Luna para cargas de alto volume sensíveis a custo. Ela
lista `none`, `low`, `medium`, `high`, `xhigh` e `max` nas três famílias. Isto
é posicionamento e disponibilidade de API, não resultado comparativo de
qualidade.

| Família | Preço por 1M tokens: entrada / cache / saída | Esforços documentados | Fonte direta |
| --- | --- | --- | --- |
| Sol | US$ 5,00 / US$ 0,50 / US$ 30,00 | `none` a `max` | [GPT-5.6 Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol) |
| Terra | US$ 2,50 / US$ 0,25 / US$ 15,00 | `none` a `max` | [GPT-5.6 Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra) |
| Luna | US$ 1,00 / US$ 0,10 / US$ 6,00 | `none` a `max` | [GPT-5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna) |

As páginas individuais também declaram cache-write a 1,25× a entrada sem cache
e multiplicadores para prompts acima de 272K tokens. Assim, preço por token não
determina custo total de tarefa. A documentação não demonstra equivalência com
GPT-5.5, identidade de comportamento entre `xhigh` do benchmark e o produto,
nem qual configuração serve melhor para conversas deste projeto.

## 2. Artificial Analysis: recortes fornecidos, filtro preservado

Os dois recortes da conversa foram preservados em
[Coding Index](assets/artificial-analysis-coding-index-2026-07-19.png) e
[Intelligence versus cost](assets/artificial-analysis-intelligence-cost-2026-07-19.png).
Os valores abaixo são a transcrição do estado capturado em 19/07/2026, com o
mesmo filtro de dez configurações; não são uma leitura do ranking sem filtro.
O endereço exato das duas abas e a ordem das dez configurações permanecem
versionados no [contrato de atualização da comparação](../../skills/think-with-me/references/model-comparison.md#refresh-contract),
para que uma nova fotografia possa repetir o filtro sem depender do histórico
da conversa.

O [Coding Index](https://artificialanalysis.ai/models/capabilities/coding)
explica que é um índice composto de Terminal-Bench v2.1 e SciCode, e que o
custo/tarefa é calculado pelos tokens e preços aplicáveis ao índice. A página
[GPT-5.6 benchmarks](https://artificialanalysis.ai/articles/gpt-5-6-has-landed/)
afirma que, nos seus gráficos, Luna e Sol ficam à frente de Terra na fronteira
de inteligência versus custo; isso não é DeepSWE e não substitui a tabela.

| Configuração | Coding Index | Intelligence Index v4.1 | Custo médio/tarefa exibido |
| --- | ---: | ---: | ---: |
| Sol XHigh | 78,3 | 57,7 | US$ 0,68 |
| Sol Max | 77,4 | 58,9 | US$ 1,04 |
| Sol High | 77,2 | 55,9 | US$ 0,46 |
| Terra Max | 76,7 | 55,0 | US$ 0,55 |
| Sol Medium | 76,3 | 53,6 | US$ 0,31 |
| GPT-5.5 High | 71,6 | 53,1 | US$ 0,67 |
| Luna Max | 71,4 | 51,2 | US$ 0,21 |
| Terra XHigh | 70,6 | 51,6 | US$ 0,32 |
| Luna XHigh | 68,6 | 49,1 | US$ 0,15 |
| Terra High | 67,1 | 49,0 | US$ 0,24 |

### Cálculos derivados do recorte AA

- Luna Max fica 0,2 ponto abaixo de GPT-5.5 High no Coding Index
  (`71,4 − 71,6`) e 1,9 ponto abaixo no Intelligence Index (`51,2 − 53,1`).
- O custo exibido de Luna Max é US$ 0,46 menor (`0,21 − 0,67`), ou 68,7% menor
  (`0,46 / 0,67`) que o de GPT-5.5 High no mesmo recorte.

Os recortes não exibem intervalos de confiança, tokens ou passos para esses dez
pontos. Logo, não demonstram diferença estatística de capacidade entre Luna Max
e GPT-5.5 High e não permitem atribuir tokens/passos a esse índice.

## 3. DeepSWE v1.1: fatos explícitos do artefato

O [artefato preservado](assets/deepswe-v1.1-leaderboard-2026-07-20.json), obtido do
[`leaderboard-live.json`](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json),
declara 113 tarefas, quatro runs completos/configuração e `mini-swe-agent` como
harness destas linhas. Define `pass@1` como taxa de tentativas aprovadas e o
intervalo como 95% run-to-run, `1,96 × std(runs) / √R`. A página
[DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1) descreve a
revisão; o JSON é a fonte de Pass@1, custo, tokens e passos abaixo.

| Configuração | Pass@1 (tentativas) | IC 95% run-to-run | Custo médio/tarefa | Output tokens médios | Passos médios |
| --- | ---: | ---: | ---: | ---: | ---: |
| GPT-5.5 High | 64,38% (291/452) | ±3,12 pp | US$ 5,1004 | 31.159,5 | 61,92 |
| Sol Medium | 61,06% (276/452) | ±1,58 pp | US$ 1,8620 | 18.425,2 | 30,91 |
| Sol High | 69,40% (313/451) | ±1,43 pp | US$ 3,4698 | 28.450,3 | 36,89 |
| Sol XHigh | 70,73% (319/451) | ±0,82 pp | US$ 4,7037 | 40.744,6 | 44,00 |
| Sol Max | 72,67% (327/450) | ±2,83 pp | US$ 8,3864 | 60.013,6 | 61,25 |
| Terra Max | 69,62% (314/451) | ±2,56 pp | US$ 4,9458 | 71.938,6 | 75,93 |
| Luna Max | 67,19% (301/448) | ±3,99 pp | US$ 3,0281 | 73.399,7 | 101,68 |

### Cálculos derivados do DeepSWE

Comparação Luna Max − GPT-5.5 High, exclusivamente neste benchmark:

| Medida | Diferença absoluta | Variação relativa, base GPT-5.5 High |
| --- | ---: | ---: |
| Pass@1 | +2,81 pp | +4,37% |
| Custo médio | −US$ 2,0723 | −40,63% |
| Output tokens | +42.240,2 | +135,56% |
| Passos | +39,76 | +64,20% |

Os intervalos publicados são 63,20%–71,18% (Luna Max) e 61,26%–67,50%
(GPT-5.5 High), sobrepostos entre 63,20% e 67,50%. Fato: há sobreposição.
Não demonstrado: superioridade ou inferioridade estatística, pois sobreposição
de ICs run-to-run não é, por si, teste formal entre configurações.

Comparação Terra Max − Sol High, somente no DeepSWE:

| Medida | Diferença absoluta | Variação relativa, base Sol High |
| --- | ---: | ---: |
| Pass@1 | +0,22 pp | +0,32% |
| Custo médio | +US$ 1,4760 | +42,54% |
| Output tokens | +43.488,3 | +152,86% |
| Passos | +39,04 | +105,83% |

Os intervalos são 67,07%–72,18% (Terra Max) e 67,97%–70,83% (Sol High), também
sobrepostos. O artefato isolado não permite transformar 0,22 pp em conclusão
de superioridade estatística.

## 4. Resultado verificável e limites

- A OpenAI publica famílias, esforços e preços API; não publica benchmark de
  qualidade para a conversa local.
- No recorte AA preservado, Luna Max custa menos/tarefa que GPT-5.5 High, mas
  tem os dois índices exibidos menores: 71,4 vs. 71,6; 51,2 vs. 53,1.
- No DeepSWE, Luna Max tem Pass@1 observada maior e custo médio menor que
  GPT-5.5 High, mas também mais output tokens e passos; os ICs se sobrepõem.

Portanto, “Luna Max é melhor que GPT-5.5 High” sem indicar métrica e fonte não
é provado pelas três fontes. Formulação sustentada: no DeepSWE v1.1, Luna Max
teve média observada de Pass@1 maior e custo médio menor; nos dois índices AA
preservados, Luna Max ficou abaixo de GPT-5.5 High; nenhuma fonte mede a
equivalência para conversas do projeto.

Não se deve fundir os índices AA e DeepSWE: medem benchmarks/harnesses
diferentes. Custo AA é do próprio índice; custo DeepSWE é `mean_cost_usd` do
seu harness; nenhum é conversão documentada para créditos, cota, latência ou
custo do Codex. A OpenAI lista `xhigh`, mas não afirma identidade comportamental
entre o campo `reasoning_effort: "xhigh"` do benchmark e qualquer interface de
produto. Nenhuma das três fontes mede conversa longa em português com as
ferramentas, instruções e critérios deste repositório.

## Fontes diretas, conferidas em 19/07/2026

- OpenAI: [catálogo](https://developers.openai.com/api/docs/models), [Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol), [Terra](https://developers.openai.com/api/docs/models/gpt-5.6-terra), [Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna).
- Artificial Analysis: [Coding Index](https://artificialanalysis.ai/models/capabilities/coding) e [GPT-5.6 benchmarks](https://artificialanalysis.ai/articles/gpt-5-6-has-landed/); valores específicos nos dois recortes filtrados da seção 2.
- DeepSWE/DataCurve: [v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1) e [artefato](https://deepswe.datacurve.ai/artifacts/v1.1/leaderboard-live.json).
