# Portfólio contextual de modelos da Think With Me

**Status:** aprovado pelo usuário para implementação

**Data:** 20 de julho de 2026

## Contexto

A skill já preserva duas visões de comparação sem fundi-las: Artificial
Analysis e DeepSWE v1.1. O DeepSWE mantém `Sol Max`, `Sol XHigh`, `Terra Max`,
`Sol High` e `Luna Max` simultaneamente na faixa superior observada, com
diferenças de custo, tokens e passos. A política de roteamento, porém, ainda
converge quase sempre para `Sol High` em conversas abertas e reserva papéis
muito estreitos às demais configurações. Isso transforma um portfólio de
evidências em um default quase fixo e impede a recomendação de refletir a
natureza do próximo passo.

O usuário confirmou que não quer um modelo permanente para a conversa. A
recomendação deve mudar quando o próximo passo mudar e deve considerar de forma
real as configurações preservadas nas matrizes.

## Objetivo

Fazer a skill escolher exatamente uma configuração para o próximo passo a
partir de um portfólio contextual de candidatas, sem impor um default permanente
e sem transferir resultados entre domínios.

A implementação deve:

- preservar as duas matrizes e seus limites de generalização;
- manter as cinco configurações da faixa superior do DeepSWE como candidatas
  reais no domínio medido;
- permitir configurações fora dessa faixa para usos simples, delimitados ou de
  volume quando houver evidência e critérios apropriados;
- usar qualidade requerida, domínio, custo total, duração, tokens, passos,
  tolerância a retries e saúde da conversa para filtrar e escolher candidatas;
- dar a `Terra Max` e `Luna Max` rotas contextuais explícitas sem alegar
  equivalência conversacional não demonstrada;
- recalcular a recomendação quando o próximo passo mudar materialmente;
- manter uma única configuração no rodapé da resposta.

## Fora de escopo

- Criar uma nota composta que misture Artificial Analysis e DeepSWE.
- Declarar que qualquer uma das matrizes mede diretamente conversa em português.
- Automatizar a troca do modelo ativo no host.
- Garantir que todas as famílias apareçam com a mesma frequência.
- Alterar o formato `Minha visão`, `Próximo passo` e recomendação compacta.
- Alterar a fronteira entre reflexão e autorização operacional.

## Abordagens consideradas

### 1. Patch textual mínimo

Adicionar frases dizendo que Terra e Luna também podem ser usadas. É pequeno,
mas não muda o algoritmo de elegibilidade nem impede que a resposta continue
caindo no mesmo default.

### 2. Portfólio contextual

Construir o conjunto de configurações elegíveis para o próximo passo e escolher
uma delas pelos trade-offs sustentados no domínio aplicável. Esta é a abordagem
aprovada porque transforma a comparação já versionada em comportamento
testável sem inventar uma nota universal.

### 3. Fórmula ponderada

Combinar qualidade, preço, tokens e passos em um score. Foi rejeitada porque os
campos pertencem a fontes e harnesses diferentes e os pesos seriam arbitrários.

## Desenho da decisão

O roteamento seguirá esta ordem:

1. formular a visão e exatamente um próximo passo;
2. identificar o domínio do próximo passo;
3. declarar o contrato de qualidade e as prioridades materiais;
4. formar o conjunto de configurações elegíveis usando apenas evidência
   aplicável ao domínio;
5. aplicar sinais da conversa, como correções repetidas, ambiguidade residual e
   convergência;
6. comparar custo total, tokens, passos e duração somente entre candidatas ainda
   elegíveis;
7. recomendar exatamente uma configuração com uma razão ligada ao próximo
   passo.

Não haverá configuração-base permanente. Um mesmo assunto pode receber outra
recomendação quando o próximo passo mudar de exploração para revisão crítica,
execução longa, transformação mecânica ou investigação excepcional.

## Portfólio e rotas iniciais

As rotas abaixo são elegibilidades, não garantias universais:

| Configuração | Rota contextual sustentada ou candidata |
| --- | --- |
| `Sol Max` | Profundidade máxima para problema delimitado excepcionalmente difícil, quando o usuário a pede explicitamente ou a profundidade anterior não resolveu a ambiguidade material. |
| `Sol XHigh` | Trabalho difícil, crítico ou longo com ambiguidade residual concreta; no DeepSWE, alternativa de valor próxima ao maior ponto observado. |
| `Terra Max` | Candidata da faixa superior para trabalho longo compatível com o domínio medido quando uma execução extensa é aceitável; não deve ser chamada de econômica nem de equivalente em conversa sem evidência local. |
| `Sol High` | Candidata compacta da faixa superior para julgamento profissional interativo e trabalho longo quando qualidade, duração e custo total favorecem essa forma de execução. |
| `Luna Max` | Candidata da faixa superior para trabalho longo sensível a custo quando muitos tokens, mais passos e maior duração são aceitáveis; não é default de conversa rápida. |
| `Sol Medium` | Candidata de valor para análise delimitada, de baixo risco e verificação barata; não é equivalente universal ao baseline. |
| `Luna Medium` | Piloto representativo para transformação mecânica ou extração em volume com formato fechado e validação automática. |

As demais configurações continuam registradas, mas sem rota preferencial até
que evidência comparável sustente um trade-off distinto.

## Fontes e limites

- Artificial Analysis continua sendo uma visão ampla e de coding sem intervalo
  de confiança no recorte preservado.
- DeepSWE continua sendo evidência de engenharia de software longa no harness
  `mini-swe-agent`.
- Posicionamento oficial de família é apenas um prior de produto.
- Experiência do usuário e avaliações locais podem decidir entre candidatas
  quando medirem o uso real, mas devem registrar falhas e sucessos.
- Estar na faixa superior do DeepSWE torna uma configuração elegível naquele
  domínio; não a transforma automaticamente em recomendação conversacional.

## Arquivos afetados

- `skills/think-with-me/SKILL.md`: resumo do portfólio contextual e proibição de
  default permanente.
- `skills/think-with-me/references/model-routing.md`: algoritmo de elegibilidade,
  rotas contextuais e recálculo por próximo passo.
- `skills/think-with-me/references/model-evidence.md`: estados do portfólio e
  limites de `Terra Max` e `Luna Max`.
- `skills/think-with-me/references/output-contract.md`: exemplos que mostram
  recomendações diferentes sem criar catálogo no rodapé.
- `README.md`: explicação pública da seleção contextual.
- `evals/model-routing-cases.md`: casos positivos e near-miss para cada rota.
- `evals/think-with-me-multiturn-cases.md`: mudança de recomendação após mudança
  material do próximo passo.
- `tests/evidence-gate-v1.sh`: invariantes contra default permanente e contra
  exclusão silenciosa das candidatas da faixa superior.
- registro de evidência da candidata e capturas de runtime, quando executadas.

## Comportamento em limites e conflitos

- Se nenhuma candidata tiver evidência suficiente para o contrato exigido, a
  resposta preserva a incerteza e não inventa uma equivalência.
- Se duas candidatas permanecerem elegíveis no mesmo domínio, custo total e
  forma de execução podem desempatar; a alternativa próxima fica na prosa
  somente quando puder mudar a decisão do usuário.
- Se as fontes medirem domínios diferentes, elas permanecem separadas.
- Frustração sozinha não aumenta profundidade; correções repetidas com
  ambiguidade material podem fazê-lo.
- Uma tarefa curta não reduz automaticamente a configuração, e uma tarefa longa
  não exige automaticamente a configuração mais cara.

## Validação

A implementação será considerada pronta somente quando:

1. os gates estruturais e de evidência passarem;
2. houver caso positivo e near-miss para `Sol Max`, `Sol XHigh`, `Terra Max`,
   `Sol High`, `Luna Max`, `Sol Medium` e `Luna Medium`;
3. um caso multietapas provar que a recomendação muda quando o próximo passo
   muda materialmente;
4. um caso impedir que qualquer configuração vire default permanente;
5. os mirrors da comparação permanecerem sincronizados;
6. a instalação global corresponder ao pacote do repositório;
7. `git diff --check` não reportar erros.

## Critério de sucesso

Diante de conversas diferentes, a skill consegue recomendar configurações
diferentes por razões rastreáveis ao próximo passo, sem fundir benchmarks, sem
inventar equivalência conversacional e sem cair sistematicamente em um único
modelo.
