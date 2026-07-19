# Think With Me — roteamento baseado em evidências e piso de qualidade

**Status:** desenho aprovado conceitualmente; aguardando revisão do documento antes da implementação  
**Data:** 19 de julho de 2026

## Contexto

A skill `think-with-me` já possui um contrato conversacional estável: entende o
contexto antes de agir, apresenta uma visão, avança uma única dependência e só
então recomenda uma configuração de modelo. Ela também separa reflexão de
autorização operacional, preserva o idioma do usuário e considera correções,
atrito e convergência.

O problema está no conteúdo do roteamento. A política atual escolhe primeiro uma
família a partir de categorias amplas de tarefa e escolhe o esforço depois. Ela
usa `Terra High` como recomendação-base para compreender contexto, comparar,
planejar e escrever especificações; reserva `Sol High` para julgamento difícil;
e usa `Luna Medium` para síntese delimitada com pressão de custo, latência ou
volume.

Essa divisão nasceu principalmente do posicionamento oficial das famílias, não
de uma comparação empírica entre configurações completas. A documentação
oficial é apropriada para confirmar disponibilidade, preço e finalidade
declarada, mas não prova que uma configuração preserva a qualidade percebida do
antigo `GPT-5.5 High` nem qual configuração entrega a melhor relação entre
resultado e custo por tarefa.

O cruzamento feito em 19 de julho de 2026 reuniu quatro tipos de evidência:

1. documentação oficial da OpenAI sobre Sol, Terra, Luna, esforços e preços;
2. Artificial Analysis Intelligence Index e Coding Index, incluindo custo por
   tarefa;
3. DeepSWE v1.1, com tarefas longas de engenharia, taxa de sucesso, custo,
   tokens, passos e intervalos de confiança;
4. experiência explícita do usuário, para quem `GPT-5.5 High` era o padrão de
   boa conversa e `XHigh` era necessário apenas em poucos casos.

As fontes convergem em pontos importantes: `Sol High` é o piso conservador mais
defensável para preservar ou superar a experiência de `GPT-5.5 High` quando o
trabalho exige julgamento; `Terra High`, `Terra XHigh` e `Luna XHigh` não
demonstram esse piso; e os ganhos de `XHigh` e `Max` apresentam retornos
decrescentes. As fontes também divergem: `Sol Medium` aparece acima do baseline
no Coding Index, mas abaixo dele no DeepSWE. Essa divergência impede tratá-lo
como substituto universal sem uma avaliação específica do domínio.

## Objetivo

Substituir a política de roteamento atual por uma política que:

- preserve `GPT-5.5 High` como baseline histórico de qualidade;
- use `Sol High` como piso presumido para decisões abertas que exigem contexto
  e julgamento;
- selecione configurações completas de família e esforço;
- diferencie qualidade preservada de economia deliberada;
- mantenha evidências separadas por domínio e harness;
- trate incerteza, empates e divergências explicitamente;
- avalie custo total da tarefa, não apenas preço por token;
- não force uma rota preferencial para cada família;
- preserve sem regressão o contrato de resposta, continuidade e autorização da
  skill;
- possa ser atualizada quando novos modelos, preços ou resultados surgirem sem
  reescrever o núcleo conversacional.

## Fora de escopo

- Alterar `Minha visão`, `Próximo passo` ou o formato compacto da recomendação.
- Alterar a fronteira entre reflexão e execução.
- Prometer que uma skill se mantém carregada entre turnos independentemente do
  host.
- Criar uma fórmula universal que misture benchmarks heterogêneos em uma única
  nota.
- Declarar que um benchmark externo mede qualidade de conversa em português.
- Automatizar troca de modelo no host; a skill apenas recomenda.
- Garantir preço, disponibilidade ou desempenho futuro.
- Criar um roteador estatístico com pesos arbitrários antes de existir evidência
  local suficiente.

## Princípios de decisão

### 1. Configuração é a unidade de escolha

Uma configuração é o par indivisível `família + esforço`, por exemplo
`Sol High` ou `Luna Medium`. A política não seleciona uma família e tenta ajustar
o esforço depois. Esforços com o mesmo nome não são presumidos equivalentes
entre famílias.

### 2. Qualidade e economia são contratos diferentes

O modo padrão da `think-with-me` é preservar qualidade. Enquanto a direção
estiver aberta e o próximo passo exigir interpretação, comparação, planejamento
ou julgamento, uma configuração abaixo do piso não será apresentada como
equivalente apenas por ser mais barata.

Uma configuração econômica só pode ser escolhida quando o trabalho estiver
delimitado, o erro for barato de detectar ou reverter e custo, latência ou volume
forem requisitos materiais. A justificativa deve deixar claro o caráter
delimitado da tarefa, sem transformar a linha de modelo em um catálogo.

### 3. Nenhuma família recebe uma rota por simetria

Sol, Terra e Luna não precisam aparecer em proporções equilibradas. Uma família
sem vantagem demonstrada pode ficar sem rota preferencial. A política será
alterada somente quando nova evidência relevante mostrar uma configuração não
dominada para um domínio real da skill.

### 4. Fontes respondem a perguntas diferentes

- Documentação oficial confirma produto, disponibilidade, preço e intenção.
- Índices gerais aproximam capacidade ampla, mas não reproduzem uma conversa.
- Benchmarks de coding medem tarefas técnicas sob um harness específico.
- Avaliações locais medem o contrato real da `think-with-me`.
- A experiência explícita do usuário informa o baseline percebido e falhas reais.

Essas fontes serão cruzadas, nunca somadas em uma média única.

### 5. Incerteza faz parte da recomendação

Diferenças pequenas não serão tratadas como vitórias definitivas quando os
intervalos de confiança se sobrepõem. Quando duas configurações estiverem
empatadas no mesmo domínio e harness, a de menor custo total pode ser preferida.
Quando fontes relevantes divergirem, a configuração inferior não receberá
status de equivalência ao piso; a rota preservará qualidade ou pedirá evidência
local.

## Arquitetura da política

O roteamento terá três camadas independentes.

### Camada 1 — evidências versionadas

Um novo arquivo `references/model-evidence.md` registrará somente evidências
necessárias à política. Cada registro conterá:

- data da revisão;
- configuração completa;
- fonte e URL;
- domínio medido;
- harness ou ambiente;
- versão do benchmark;
- métrica de qualidade;
- intervalo de confiança, quando disponível;
- custo por tarefa;
- tokens e passos, quando disponíveis;
- relação com o baseline;
- limitações de generalização;
- decisão de política que a evidência suporta.

O arquivo distinguirá três estados:

- **sustentado:** evidência suficiente para uma rota atual;
- **candidato:** promissor, mas ainda sem equivalência comprovada;
- **não preferencial:** abaixo do piso ou dominado no domínio analisado.

### Camada 2 — decisão de roteamento

`references/model-routing.md` deixará de começar por uma tabela de papéis das
famílias. A decisão seguirá esta ordem:

1. formular `Minha visão` e exatamente um `Próximo passo`;
2. classificar o contrato de qualidade do próximo passo;
3. identificar o domínio relevante;
4. avaliar ambiguidade, risco e alcance temporal da tarefa;
5. filtrar configurações que atendem ao piso requerido;
6. aplicar evidências da saúde da conversa;
7. comparar custo total apenas entre candidatas elegíveis;
8. escolher exatamente uma configuração e escrever uma razão contextual curta.

### Camada 3 — avaliação comportamental

As avaliações serão separadas em:

1. **contrato de saída:** idioma, ordem, blockquote e uma recomendação;
2. **política:** piso, domínio, incerteza, economia e conflito de evidências;
3. **qualidade da conversa:** compreensão, uso da correção mais recente,
   contextualização, posição, próximo passo e necessidade de retrabalho.

O gate estático continuará protegendo a estrutura, mas não poderá usar a
presença literal de `Terra High` como prova de correção semântica.

## Baseline e estado inicial das configurações

### Baseline histórico

`GPT-5.5 High` é o baseline histórico informado pelo usuário. Ele não é uma
configuração recomendada da nova família; é a referência para avaliar se uma
rota preserva a qualidade esperada.

### Configuração sustentada para qualidade

`Sol High` será a recomendação padrão para:

- compreender contexto e intenção ainda abertos;
- comparar opções com trade-offs reais;
- planejar ou escrever especificações que exigem julgamento;
- integrar várias fontes ou requisitos;
- tomar decisões profissionais ou técnicas;
- arquitetura e programação agentiva de horizonte longo;
- situações em que não há evidência específica suficiente para reduzir o piso.

Essa é uma política conservadora: ela prioriza evitar regressão de qualidade.

### Escalada seletiva

`Sol XHigh` será elegível quando o próximo passo ainda exigir julgamento e
houver pelo menos um destes sinais materiais:

- ambiguidade transversal que afeta várias decisões;
- evidências relevantes que precisam ser reconciliadas e permanecem em tensão;
- correções repetidas que mostram falha de enquadramento;
- segurança, autorização, integridade de dados, concorrência ou mudança
  irreversível com alto custo de erro;
- tarefa profissional limitada em que uma falha seria difícil de detectar.

A seleção pode ocorrer desde o início diante de risco evidente; ela não depende
de primeiro produzir uma resposta ruim.

`Sol Max` será reservado a um problema incomumente difícil e delimitado quando o
usuário pedir explicitamente a análise mais profunda disponível ou quando
evidência concreta mostrar que o nível anterior não resolveu a ambiguidade. A
importância genérica do tema não é suficiente.

### Rota econômica candidata

`Sol Medium` será registrado como candidato de valor, não como equivalente ao
baseline. Ele poderá ser recomendado somente para análise delimitada e de baixo
risco, quando a redução de custo for material e o resultado puder ser verificado
de forma barata. A divergência entre Artificial Analysis e DeepSWE aparecerá no
registro de evidências.

`Luna Medium` permanecerá elegível apenas para transformação mecânica,
classificação, extração ou condensação em grande volume quando:

- a direção já estiver fechada;
- não restar decisão substantiva escondida;
- custo, latência ou volume forem materiais;
- o resultado tiver formato verificável;
- uma falha individual tiver baixo impacto.

Essa rota decorre do posicionamento oficial e deve ser tratada como provisória
até ser validada pelas avaliações locais de síntese. Ela não representa o piso
de boa conversa.

### Configurações sem rota preferencial inicial

Terra não terá rota preferencial na primeira versão da nova política. Os dados
atuais não demonstram uma região em que uma configuração Terra preserve o piso
e supere simultaneamente as alternativas elegíveis em custo total. O arquivo de
evidências continuará registrando Terra para permitir revisão futura.

Luna XHigh e Terra High/XHigh não serão usadas como substitutas do baseline.
Luna Max e Terra Max podem permanecer registradas para comparação, mas seus
resultados atuais não justificam uma rota padrão da `think-with-me`.

## Regras de custo e valor

O roteamento usará esta ordem:

1. determinar a qualidade mínima;
2. remover configurações que não demonstram esse piso no domínio relevante;
3. tratar configurações estatisticamente próximas como empate prático;
4. entre candidatas empatadas, preferir menor custo total por tarefa;
5. usar tokens, passos e latência como diagnósticos de eficiência;
6. nunca inferir economia apenas pelo nome da família ou preço nominal por
   milhão de tokens.

Quando houver taxa de sucesso e custo por tentativa, a avaliação poderá registrar
`custo médio / taxa de sucesso` como aproximação de custo por sucesso. Essa
métrica não substituirá a inspeção de qualidade nem será calculada entre
benchmarks diferentes.

## Regras de conflito e generalização

- Um resultado geral não substitui uma avaliação de domínio.
- Um benchmark de coding não decide qualidade de conversa em português.
- Um benchmark executado com `mini-swe-agent` não representa automaticamente o
  Codex nativo.
- Um único resultado favorável não transforma uma configuração em baseline.
- Quando o ponto estimado for melhor, mas a incerteza impedir conclusão, a
  documentação usará “empate prático” ou “candidato”, não “superior”.
- Quando dois benchmarks relevantes discordarem, a política explicará a
  divergência e preservará a opção conservadora.
- A experiência explícita do usuário pode vetar uma rota que falhou repetidamente,
  mas não altera silenciosamente fatos oficiais ou resultados publicados.

## Saúde da conversa

A saúde da conversa será aplicada depois do piso de qualidade, não para reparar
uma escolha-base fraca.

- Progresso normal não reduz automaticamente a configuração.
- Direção aceita permite redução somente se o trabalho realmente se tornou
  delimitado e a economia é material.
- Correções repetidas podem elevar a profundidade quando ainda resta julgamento.
- Mais esforço com o mesmo enquadramento errado não conta como avanço.
- Frustração isolada não escolhe modelo.
- Histórico de modelos só entra quando fornecido pelo usuário ou pelo host.
- Uma configuração mais barata nunca será descrita como equivalente ao baseline
  sem evidência adequada.

## Alterações previstas por arquivo

### Pacote instalável

- `skills/think-with-me/SKILL.md`
  - trocar a classificação genérica por um resumo do gate de qualidade;
  - manter o fechamento e a fronteira de execução intactos;
  - apontar para a referência de evidências quando houver recomendação.
- `skills/think-with-me/references/model-routing.md`
  - substituir família-primeiro pelo algoritmo por configuração;
  - registrar baseline, piso, economia, escalada, incerteza e custo total;
  - remover Terra como padrão obrigatório.
- `skills/think-with-me/references/model-evidence.md`
  - novo registro versionado das fontes, resultados, limitações e decisões.
- `skills/think-with-me/references/output-contract.md`
  - preservar o contrato;
  - atualizar somente exemplos cujo modelo codifique a política antiga.

### Avaliações e gates

- `evals/think-with-me-cases.md`
  - substituir expectativas genéricas de Terra por expectativas ligadas ao piso;
  - adicionar conflito entre benchmarks, empate e economia verificável.
- `evals/think-with-me-multiturn-cases.md`
  - adicionar redução válida e redução inválida depois de uma decisão;
  - preservar os casos de continuidade já aprovados.
- `evals/model-routing-cases.md`
  - novo conjunto dedicado à qualidade da seleção.
- `evals/model-routing-evidence-template.md`
  - registrar configuração candidata, resposta bruta, critérios e resultado.
- `tests/evidence-gate-v1.sh`
  - remover dependência semântica da presença literal de Terra;
  - exigir baseline, algoritmo por configuração e regras de incerteza;
  - preservar todos os invariantes estruturais atuais.
- `scripts/verify-evidence-record.sh`
  - verificar o novo registro comportamental após a execução das avaliações.

### Documentação e release

- `README.md`
  - atualizar o exemplo para uma configuração coerente com o novo piso;
  - explicar que redução de custo é uma exceção delimitada.
- novo registro de evidências datado em `evals/`;
- atualização do runbook somente se os comandos ou superfícies de validação
  mudarem;
- sincronização da instalação global somente depois de todos os gates passarem.

## Estratégia de testes

### Testes estáticos

Devem comprovar:

- exatamente uma configuração no fechamento;
- seleção por configuração completa;
- presença do baseline histórico;
- presença do piso conservador;
- regra de conflito e intervalo de confiança;
- distinção entre qualidade e economia;
- ausência de rota obrigatória para Terra;
- ausência de fórmula que misture benchmarks;
- preservação integral dos limites de execução e ativação.

### Avaliações comportamentais

O conjunto mínimo incluirá:

1. ideia de produto vaga com decisão ainda aberta;
2. comparação comum que exige integrar contexto;
3. especificação técnica com trade-offs reais;
4. migração irreversível e integridade de dados;
5. correções repetidas e enquadramento que não convergiu;
6. direção fechada com uma única condensação curta;
7. transformação em grande volume com formato verificável;
8. coding agentivo de horizonte longo;
9. divergência entre benchmark geral e benchmark de domínio;
10. empate prático com custos totais diferentes;
11. pedido explícito por máxima profundidade;
12. frustração sem aumento de risco ou ambiguidade.

Cada resposta será avaliada por:

- recuperação correta do contexto;
- aplicação da informação mais recente;
- identificação da decisão real;
- posição clara e sustentada;
- uma dependência imediata;
- configuração compatível com o piso;
- justificativa ligada à evidência observável;
- ausência de alegações de equivalência não sustentadas;
- preservação do contrato de saída.

### Avaliação comparativa local

Quando o host permitir selecionar explicitamente configurações, os roteiros mais
representativos serão executados com o mesmo contexto. A avaliação comparará
qualidade da resposta, necessidade de correção, aderência ao contrato e custo
observável. A comparação não usará o nome do modelo como critério de qualidade e
registrará limitações do harness.

## Fluxo de implementação e release

1. atualizar primeiro os casos de avaliação para expressar a nova política;
2. confirmar que os novos casos detectam a política antiga;
3. criar o registro de evidências;
4. alterar o roteamento e os exemplos do pacote;
5. atualizar gates sem remover invariantes anteriores;
6. executar validação estrutural, gate de evidências e `git diff --check`;
7. executar avaliações comportamentais em sessões novas;
8. registrar respostas reais e desvios;
9. fazer uma revisão independente somente leitura;
10. corrigir achados relevantes e repetir os gates;
11. sincronizar a instalação global;
12. verificar paridade entre repositório e instalação;
13. confirmar que a skill carregada em uma sessão nova contém a política nova;
14. somente então preparar commit de implementação e publicação.

## Critérios de aceite

A mudança estará completa somente quando:

- `Sol High` for o piso documentado para decisão aberta e julgamento contextual;
- `GPT-5.5 High` estiver registrado como baseline histórico;
- a unidade de decisão for configuração completa;
- Terra não for recomendado por obrigação de cobertura da família;
- configurações econômicas forem descritas como exceções delimitadas;
- divergência entre Artificial Analysis e DeepSWE para `Sol Medium` estiver
  registrada;
- custo total, tokens e passos estiverem separados de preço nominal;
- intervalos, empates e conflito de evidências tiverem regras explícitas;
- o gate não exigir Terra em templates ou exemplos;
- os casos comportamentais cobrirem qualidade, economia e incerteza;
- o contrato de saída, continuidade e autorização continuar passando;
- a instalação global corresponder ao pacote aprovado;
- uma sessão nova demonstrar a política nova no texto bruto da resposta;
- nenhuma regressão relevante permanecer na revisão independente.

## Decisão recomendada

Implementar esta arquitetura em vez de apenas trocar `Terra High` por
`Sol High`. A troca mínima corrigiria o sintoma imediato, mas manteria família
primeiro, custo incompleto, ausência de incerteza e testes que confundem texto
presente com qualidade da recomendação. O desenho baseado em evidências corrige
essas causas sem reabrir as partes estáveis da skill.
