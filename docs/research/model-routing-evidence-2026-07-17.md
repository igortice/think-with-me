# Evidência para roteamento de modelos — 2026-07-17

**Escopo.** Fundamentar regras da skill `think-with-me` para GPT-5.6 no Codex. Registro de fontes primárias consultadas em **17 de julho de 2026** (horário de Fortaleza). “Primária” significa documentação da OpenAI para produto/preço e publicação/leaderboard do próprio DeepSWE para o benchmark. Não há preço, cota ou regra operacional inferida além do que as fontes declaram.

## Conclusão

Há base documental forte para usar **Sol** em trabalho complexo e aberto; **Terra** no trabalho cotidiano equilibrado; e **Luna** em trabalho claro, repetível, rápido e econômico. A OpenAI recomenda começar pelo menor esforço que entregue o resultado e elevá-lo quando a tarefa precisar de mais planejamento, análise ou checagem. [Modelos do Codex — OpenAI](https://learn.chatgpt.com/docs/models)

No leaderboard público do DeepSWE v1.1, a visualização **Best** mostra os três GPT-5.6 em **Max**: Sol **73%±3%, US$ 8,39** de custo médio por tarefa; Terra **70%±3%, US$ 4,95**; Luna **67%±4%, US$ 3,03**. O artefato bruto oficial do mesmo benchmark também contém trials de High e XHigh; uma agregação reproduzível deles aparece abaixo, separada do leaderboard porque ela não inclui a mesma apresentação de incerteza. Isto não prova a melhor escolha para toda tarefa do usuário, mas sustenta que, nesse benchmark específico, Terra e Luna tiveram menor custo médio observado que Sol. [DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1)

## Evidência relevante

### 1. Produto, modelos, esforços, limites e créditos da OpenAI

| Tema | Fato documentado | Fonte primária |
| --- | --- | --- |
| Modelos no Codex | Codex oferece GPT-5.6 Sol, Terra e Luna. A OpenAI descreve Sol para detalhe/polimento e trabalho complexo/aberto; Terra como generalista pragmático; Luna para tarefas claras e repetíveis, de alto volume. | [Modelos do Codex](https://learn.chatgpt.com/docs/models) |
| Esforço | O Codex lista Low/Light, Medium, High, Extra High, Max e Ultra. High/Extra High são para trabalho difícil com múltiplas etapas, fontes ou trade-offs. Max dá mais tempo ao modelo selecionado em **uma** tarefa; Ultra usa subagentes para partes separadas. Esforço maior pode melhorar resultados, mas demora mais e usa mais tokens. | [Modelos do Codex](https://learn.chatgpt.com/docs/models) |
| Disponibilidade | Sol, Terra e Luna estão no Codex para Plus, Pro, Business e Enterprise; Terra também para Free/Go. Na API OpenAI, os três estão disponíveis. Terra e Luna não são selecionáveis em conversas padrão do ChatGPT. | [GPT-5.6 no ChatGPT](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt) |
| Créditos do Codex | Por 1M tokens de entrada/cache/saída: Sol 125/12,50/750 créditos; Terra 62,50/6,250/375; Luna 25/2,50/150. O consumo real depende da mistura dos três tipos de token. | [Codex rate card](https://help.openai.com/en/articles/20001106-codex-rate-card) |
| Limites | Limites variam por plano, modelo, tamanho/complexidade, contexto, raciocínio, ferramentas, retrieval e cache. Para Plus, a documentação publica faixas de mensagens locais por 5h: Sol 15–90, Terra 20–110 e Luna 50–280; limites semanais adicionais podem ocorrer. As faixas não são promessa por tarefa. | [Preços e limites do Codex](https://learn.chatgpt.com/docs/pricing) |
| Créditos e compartilhamento | Work e Codex compartilham uso, preços, créditos e limites quando aplicável; créditos podem prolongar uso em planos elegíveis. Fast mode consome créditos mais rapidamente. | [Preços e limites do Codex](https://learn.chatgpt.com/docs/pricing) |

**Caveat de versão/semântica.** No produto, a interface chama `Extra High`; no DeepSWE aparece `xhigh`. Esta pesquisa não assume que sejam configurações idênticas entre produto, API e harness de benchmark. A OpenAI não documenta aqui uma equivalência entre o `xhigh` do DeepSWE e o seletor do Codex.

### 2. DeepSWE: leaderboard público e artefato bruto verificável

O DeepSWE v1.1 informa **113 tarefas** e atualização em **16 de julho de 2026**. Avalia somente o diff commitado em contêiner limpo e isolado; deixou de reportar tempo de parede por depender muito da máquina anfitriã e da carga do provedor. [DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1)

**Leaderboard.** Na visualização pública `Best`, os três GPT-5.6 aparecem em Max, com os valores e incertezas citados na conclusão. Isso não significa que High e XHigh não foram executados.

**Artefato bruto.** O endpoint primário [`trials.json`](https://deepswe.datacurve.ai/artifacts/v1.1/trials.json) contém rows por trial, incluindo `model`, `reasoning_effort`, `score_value`, `cost_usd`, `n_output_tokens` e `n_agent_steps`. Em 17/07/2026, apliquei o filtro abaixo, agrupei por modelo/esforço e tirei médias aritméticas dos rows restantes. As contagens variaram de 448 a 452 trials por grupo; por isso esta tabela não inventa um intervalo de confiança.

```text
source == "deep-swe"
eval_scope == "full"
included_in_score == true
model in {gpt-5-6-sol, gpt-5-6-terra, gpt-5-6-luna}
reasoning_effort in {high, xhigh, max}
```

| Modelo | Esforço | Trials | Média de `score_value` | Média de `cost_usd` | Output médio | Steps médios |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| Luna | High | 452 | 44,25% | US$ 0,78 | 25,8k | 49,0 |
| Luna | XHigh | 452 | 56,86% | US$ 1,54 | 44,7k | 71,1 |
| Luna | Max | 448 | 67,19% | US$ 3,03 | 73,4k | 101,7 |
| Terra | High | 452 | 53,76% | US$ 1,13 | 21,5k | 33,5 |
| Terra | XHigh | 452 | 60,18% | US$ 2,13 | 39,6k | 43,1 |
| Terra | Max | 451 | 69,62% | US$ 4,95 | 71,9k | 75,9 |
| Sol | High | 451 | 69,40% | US$ 3,47 | 28,5k | 36,9 |
| Sol | XHigh | 451 | 70,73% | US$ 4,70 | 40,7k | 44,0 |
| Sol | Max | 450 | 72,67% | US$ 8,39 | 60,0k | 61,3 |

**O que os números significam.** O DeepSWE define o score como resolver a tarefa, não reproduzir a estrutura da solução do autor. A publicação original descreve 113 tarefas, três trials, verifiers escritos à mão que testam comportamento observável e execução de todos os modelos no `mini-swe-agent` para consistência. [Metodologia DeepSWE v1](https://deepswe.datacurve.ai/blog/deepswe)

**Custo API: estado da evidência.** A tabela v1.1 rotula o campo apenas como `Avg cost` e exibe dólares; o artefato bruto expõe `cost_usd` por trial. Nenhuma dessas fontes, no material consultado, especifica uma conversão para créditos do Codex. Assim, os valores acima são custos reportados pelo harness do DeepSWE; não devem ser reconvertidos para créditos sem telemetria do run ou fórmula explicitamente publicada.

**Limites de comparabilidade com cota/créditos do Codex.**

- `Avg cost` do DeepSWE mede um harness (`mini-swe-agent`), tarefas e configuração específicos; créditos do Codex cobrem tokens de entrada, cache e saída e dependem também de contexto, ferramentas, retrieval, cache e velocidade.
- A OpenAI documenta que limites são faixas dinâmicas e que tarefas aparentemente semelhantes podem consumir parcelas diferentes da franquia. Não existe conversão documentada de “US$ por tarefa DeepSWE” para “créditos ou mensagens Codex”.
- A visualização `Best` destaca Max para estes três GPT-5.6, mas o artefato bruto possui High/XHigh. A agregação direta é evidência de benchmark, não uma equivalência oficial entre o seletor do Codex e o harness `mini-swe-agent`.
- Não é válido usar esses números para concluir que Max seja sempre o melhor custo-benefício no trabalho do usuário.
- As incertezas ±3%/±4% tornam frágil converter a diferença Sol–Terra em regra absoluta de superioridade de qualidade.

### 3. Artificial Analysis: fonte e limitação

Há uma metodologia publicada pelo próprio Artificial Analysis. Ela informa que o **Coding Agent Index** agrega DeepSWE (113 tarefas, três repetições), Terminal-Bench v2 e SWE-Atlas-QnA; cada score por avaliação é a média de pass@1, e o custo é média por tentativa baseada em preço API pay-per-token do provedor. [Metodologia do Coding Agent Index — Artificial Analysis](https://artificialanalysis.ai/methodology/coding-agents-benchmarking)

Esta é fonte primária **para a metodologia do Artificial Analysis**, mas não é fonte primária do produto OpenAI nem substitui o DeepSWE para os números acima. Nesta pesquisa não foram usados rankings, preços ou recomendações editoriais de terceiros. A metodologia do AA não deve preencher lacunas do DeepSWE.

## Regras de uso suportadas pela evidência

1. Para tarefa clara, repetível, de alto volume ou em que velocidade/custo pesam, iniciar com **Luna** e o menor esforço que entregue qualidade suficiente.
2. Para trabalho diário com raciocínio e ferramentas, sem exigir a maior profundidade, iniciar com **Terra**.
3. Para tarefa ambígua, difícil, de alto valor, com julgamento, pesquisa profunda ou mudança complexa, usar **Sol**; aumentar esforço apenas quando a tarefa exigir planejamento/análise/checagem adicionais.
4. Reservar **Max** aos problemas mais difíceis, em que profundidade importa mais que velocidade e consumo; reservar **Ultra** a tarefas que se dividem em partes significativas e independentes.
5. Para estimar consumo real, observar Usage ou `/status` e a taxa de créditos vigente do plano; não estimar por custo DeepSWE.

## Regras que ainda são hipóteses a validar pelo usuário

1. Que **Terra High** seja o padrão de `think-with-me`: o artefato bruto mostra seu comportamento no harness, mas o benchmark não mede planejamento conversacional no repositório do usuário.
2. Que **Luna High** seja suficiente para tarefas pequenas no fluxo do usuário: o artefato bruto mostra sua relação observada no harness, mas não mede os checkpoints humanos e o tipo de mudança local.
3. Que **Sol Max** justifique o consumo extra nas tarefas do usuário: DeepSWE mede engenharia de software de longo horizonte, não o mix local de conversa, análise, documentação e código.
4. Qual esforço é o menor suficiente por tipo de tarefa. Validar com uma amostra real, registrando modelo, esforço, resultado aceito, duração e créditos consumidos.

## Próximo passo

Implementar as regras suportadas como defaults conservadores e registrar a decisão de roteamento por tarefa. Após uma amostra representativa, comparar qualidade aceita e créditos efetivamente consumidos antes de promover qualquer hipótese a regra fixa.

## URLs consultadas

- OpenAI: [Modelos do Codex](https://learn.chatgpt.com/docs/models), [Preços e limites do Codex](https://learn.chatgpt.com/docs/pricing), [Codex rate card](https://help.openai.com/en/articles/20001106-codex-rate-card), [GPT-5.6 no ChatGPT](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt).
- DeepSWE/DataCurve: [leaderboard](https://deepswe.datacurve.ai/), [DeepSWE v1](https://deepswe.datacurve.ai/blog/deepswe), [DeepSWE v1.1](https://deepswe.datacurve.ai/blog/deepswe-v1-1), [artefato bruto v1.1](https://deepswe.datacurve.ai/artifacts/v1.1/trials.json), [repositório do benchmark](https://github.com/datacurve-ai/deep-swe).
- Artificial Analysis: [Coding Agent Index Methodology](https://artificialanalysis.ai/methodology/coding-agents-benchmarking).
