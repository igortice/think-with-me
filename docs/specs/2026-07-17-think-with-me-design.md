# Think With Me — especificação de design

**Status:** revisão ampliada para validação
**Data:** 17 de julho de 2026  
**Repositório:** `igortice/think-with-me` (privado durante a maturação)
**Decisão de produto:** esta skill recomenda; o usuário aprova; as skills próprias de execução executam.

## 1. Contexto e problema real

Esta skill nasce de um fluxo de trabalho específico, não de uma tabela genérica de benchmarks.

O usuário costuma trabalhar assim:

1. Recupera e registra contexto do projeto com `project-context` quando ele existe.
2. Conversa para entender o problema, o código, as regras de negócio e as alternativas.
3. Planeja e escreve ou revisa uma spec.
4. Aprova explicitamente o caminho.
5. Só então pede a execução.

Esse fluxo é deliberado: qualidade significa tomar uma decisão consciente antes de alterar código. O problema com GPT-5.6 é que a seleção deixou de ser somente “High ou XHigh”: há famílias Luna, Terra e Sol, cada uma com High, XHigh e Max. Usar a família ou o esforço mais caro por padrão em uma conversa longa pode consumir a cota rapidamente sem elevar proporcionalmente a qualidade da decisão.

Há três riscos a evitar:

- **economia falsa:** começar barato em uma tarefa ambígua e perder mais tempo corrigindo ou replanejando;
- **qualidade falsa:** deixar Sol/Max ligado durante todo o raciocínio, inclusive quando a tarefa já está clara;
- **automação prematura:** confundir uma boa recomendação com autorização para editar, delegar ou executar.

## 2. Tese de design

`$think-with-me` será a skill de colaboração deliberada. Ela não é um roteador automático de modelos nem uma skill de implementação. Sua função é tornar visível, em pontos decisivos da conversa:

1. **em que fase o trabalho está;**
2. **o que ainda precisa ser decidido ou verificado;**
3. **a posição e recomendação do assistente;**
4. **o menor próximo passo seguro;**
5. **qual modelo/esforço ou subagent faz sentido, se houver uma próxima tarefa concreta;**
6. **qual aprovação ainda falta antes de agir.**

O nome evita amarrar a skill a GPT-5.6. A política de roteamento pode mudar quando os modelos e limites mudarem, mas o jeito de pensar junto continua válido.

## 3. Limites e autoridade

### O que a skill faz

- Recupera decisões já tomadas e identifica lacunas reais de contexto.
- Faz perguntas decisivas uma por vez quando uma escolha permanece aberta.
- Oferece a escolha recomendada e explica o trade-off.
- Produz ou melhora o plano/spec até ficar pronto para aprovação.
- Recomenda um próximo passo, um modelo/esforço e, quando justificável, um subagent com escopo explícito.
- Orienta a compactação e o registro do contexto para evitar que uma conversa longa se transforme em contexto caro e confuso.

### O que a skill não faz

- Não altera arquivos, cria branches, abre PRs, roda comandos, instala coisas, cria repos ou despacha subagents automaticamente.
- Não substitui `project-context`, OpenSpec, diagnóstico, code review, execução de planos ou qualquer regra de aprovação do projeto.
- Não pressupõe que o usuário aprovou uma ação porque concordou com uma recomendação.
- Não inventa um custo de cota a partir de preços de API ou do DeepSWE.
- Não usa benchmark isolado como prova de que um modelo será melhor no repositório atual.

**Regra de autoridade:** fatos precisam de evidência; decisões de produto e o início de execução pertencem ao usuário; a recomendação técnica pertence ao assistente e deve ser assumida claramente como recomendação.

## 4. Forma de invocação e ergonomia

O uso será manual, no espírito de `grill-me`, para não carregar instruções em conversas que não pediram este modo:

```yaml
name: think-with-me
description: Collaboratively understand a problem or idea before acting. Use when the user wants to discuss, plan, assess options, receive a clear recommendation, identify the next step, or choose an appropriate model, effort, or subagent.
```

A invocação manual é configurada em `agents/openai.yaml` com `policy.allow_implicit_invocation: false`, mantendo o frontmatter no formato aceito pelo validador de skills.

O comportamento de entrevista é **condicional**, não obrigatório:

- Se uma decisão importante estiver aberta, perguntar uma coisa por vez, dizer por que ela importa e oferecer uma resposta recomendada.
- Se já existir evidência e contexto suficientes, não prolongar a conversa artificialmente: sintetizar, apontar risco residual e recomendar.
- Se a questão puder ser respondida por inspeção ou pesquisa, primeiro propor/realizar a verificação apropriada em vez de pedir ao usuário algo que a ferramenta pode descobrir.

## 5. Contrato de saída

Ao fechar uma decisão, mudança de fase ou bloco de planejamento, a skill continua uma conversa natural. Em vez de formulário, ela termina com uma posição clara: **“Minha visão: eu seguiria com [escolha] porque [motivo].”** Quando for relevante, acrescenta em frases curtas o modelo da conversa, uma sugestão de agente — ou o motivo para não abrir um — e o que precisa ser confirmado antes de executar.

O modelo da conversa atual deve aparecer no início da sessão e em mudanças de fase. O modelo da próxima tarefa aparece somente quando a tarefa estiver delimitada; a skill não exibe campos vazios. A recomendação de subagent também é natural: quando não for útil, explica brevemente por quê; quando for, informa papel, escopo, saída e o que falta aprovar. Sugerir paralelismo sem independência é desperdício e aumenta a chance de contexto divergente.

## 6. Máquina de fases

| Fase | Pergunta central | Saída que define conclusão | O que continua proibido |
|---|---|---|---|
| **Entendimento** | “O que existe, qual problema vale resolver e o que ainda não sabemos?” | mapa de contexto e perguntas decisivas | decidir/implementar por suposição |
| **Exploração** | “Quais opções existem e quais evidências faltam?” | alternativas, impactos, riscos e evidência necessária | tratar hipótese como fato |
| **Planejamento** | “Qual abordagem atende ao objetivo com menor risco?” | sequência, dependências, critérios de aceite e validação | iniciar execução antes da escolha |
| **Spec** | “A intenção está precisa o suficiente para alguém executar e validar?” | escopo, fora de escopo, comportamento, testes e rollout | considerar rascunho como aprovação |
| **Aguardando aprovação** | “O que exatamente será feito se o usuário disser sim?” | resumo curto do plano e pedido claro de confirmação | editar/rodar/delegar |
| **Execução aprovada** | “Qual unidade de trabalho pode ser feita e verificada agora?” | handoff para a skill de execução e validação | ampliar escopo sem nova confirmação |
| **Diagnóstico/revisão** | “Qual hipótese explica a falha e que evidência pode refutá-la?” | hipótese priorizada, coleta de evidência, critério de saída | aplicar correção sem diagnóstico/autoridade |

Uma conversa pode voltar de execução para planejamento se aparecer requisito novo, risco não aceito ou evidência que contradiz a spec. A skill deve nomear essa volta em vez de continuar silenciosamente.

## 7. Separar modelo, esforço e forma de trabalho

A recomendação precisa sempre distinguir três variáveis. Não usar frases vagas como “use o melhor modelo”.

| Variável | O que decide | Sinal de escolha errada |
|---|---|---|
| **Família (Luna/Terra/Sol)** | capacidade e custo-base adequados à clareza, risco e abertura do problema | Luna simplifica uma ambiguidade crítica; Sol é usado para trabalho claro e repetitivo |
| **Esforço (High/XHigh/Max)** | profundidade/tempo de raciocínio e exploração necessários para aquela chamada ou bloco | elevar esforço sem uma hipótese, critério de saída ou dificuldade observável |
| **Modo de trabalho** | conversa, pesquisa, spec, execução com checkpoints ou agente autônomo | escolher Max apenas porque a tarefa é importante, sem autonomia/escopo bem delimitado |

### 7.1 Heurística de esforço

- **High:** ponto de partida para trabalho que exige raciocínio real, mas tem escopo ou pergunta definidos.
- **XHigh:** usar quando há dependências transversais, ambiguidade que persistiu depois de uma primeira análise, ou quando a resposta precisa integrar muitas restrições.
- **Max:** reservar para execução autônoma longa, ou um único problema muito difícil, já enquadrado com uma pergunta clara, critérios de sucesso e validação. Não é o padrão para conversa contínua, planejamento inicial ou tarefa pequena.

Subir é uma decisão justificada por evidência; não é uma reação automática a “parece importante”. Descer ou encerrar também é uma decisão válida quando a incerteza foi resolvida.

## 8. Política operacional de roteamento

Esta é a política inicial para o fluxo do usuário. A tabela é um ponto de partida que será calibrado por telemetria do seu uso real, não uma promessa de consumo de cota.

| Situação concreta | Principal | Escalar somente se | Por que não começar no nível acima |
|---|---|---|---|
| Conversa para entender projeto, requisito, fluxo ou contexto | **Terra High** | **Terra XHigh** se muitas dependências ou ambiguidade permanecerem após uma primeira síntese | Max em conversa longa aumenta custo de contexto sem garantir decisão melhor |
| Investigar vários módulos e fechar um plano de feature normal | **Terra High** | **Terra XHigh** se o plano cruzar domínios, serviços ou contratos | Sol é melhor reservado para o risco específico encontrado, não para toda exploração |
| Elaborar spec que afeta várias áreas ou precisa conciliar restrições | **Terra XHigh** | **Sol High** como revisão curta se houver decisão arquitetural, segurança, migração ou risco operacional | Terra XHigh mantém a conversa/plano como trabalho principal com custo mais controlado |
| Revisar uma spec crítica já escrita | **Sol High**, intervenção curta | **Sol XHigh** se a primeira revisão ainda deixar conflito material sem resposta | O objetivo é uma crítica profunda e delimitada, não manter Sol ativo desde o começo |
| Arquitetura nova, autorização, dados sensíveis, migração arriscada, concorrência ou causa-raiz desconhecida | **Sol High** | **Sol XHigh** quando a hipótese inicial não resolve a incerteza | XHigh antes de uma pergunta/fato bem delimitado aumenta exploração sem direção |
| Busca, resumo, classificação, documentação ou levantamento repetitivo já delimitado | **Luna High** | **Luna XHigh** quando o resultado exigir integração de código/decisão maior | Terra/Sol não agregam valor proporcional em trabalho claro e de alto volume |
| Implementação pequena, clara, com poucos arquivos e checkpoints humanos | **Luna High** | **Luna XHigh** se a mudança envolver lógica normal, testes ou integração moderada | Max não é necessário se o usuário continuará acompanhando e corrigindo a direção |
| Implementação aprovada, normal, bem delimitada, com testes e critério de aceite | **Luna XHigh** | **Luna Max** se houver autonomia longa, muitas chamadas/ferramentas e validação explícita | Max não é sinônimo de “implementação importante”; depende de autonomia e duração |
| Execução longa e autônoma de uma spec madura, com escopo fechado, testes e rollback/validação definidos | **Luna Max** | **Sol High** se aparecer uma decisão difícil que a spec não resolveu; não aumentar automaticamente | Luna Max compra persistência e exploração para tarefa clara; Sol serve para a exceção ambígua |
| Último recurso para problema crítico, após tentativas de boa qualidade ou quando o custo de errar é claramente maior que a cota | **Sol Max** | não há escalonamento normal | Usar como padrão tira a capacidade de reservar profundidade para o que realmente precisa |

### 8.1 Regras de escalonamento e parada

Usar uma regra observável para toda subida:

1. Definir qual resposta, evidência ou artefato o nível atual não conseguiu produzir.
2. Formular a pergunta mais estreita possível antes de mudar de modelo/esforço.
3. Escalar apenas uma dimensão por vez quando possível: esforço **ou** família.
4. Depois da intervenção cara, voltar ao modelo da fase para incorporar a conclusão, atualizar a spec ou executar o trabalho claro.
5. Parar e pedir direção quando a divergência é de produto, prioridade ou risco aceitável — não tentar resolver preferência do usuário com mais raciocínio.

Exemplos de gatilhos válidos:

- Terra High apresentou duas interpretações plausíveis de requisitos conflitantes após consulta ao contexto → Terra XHigh.
- Terra XHigh fechou o plano, mas há uma migração irreversível → Sol High para revisão direcionada de segurança, dados e rollback.
- Luna XHigh está implementando a spec e encontra uma lacuna arquitetural → pausar, voltar ao planejamento/Sol High para aquela decisão; não insistir em Luna Max.
- Sol High respondeu à revisão crítica e não restam dúvidas materiais → voltar a Terra/Luna; não continuar a conversa inteira no Sol.

## 9. Conversas longas, memória e registro

Como o usuário quer deixar o raciocínio registrado, o recurso a preservar é a **qualidade do contexto**, não apenas a continuidade bruta do chat.

Ao final de uma fase ou quando o contexto ficar grande, a skill deve propor um `context packet` curto:

```md
## Decisões confirmadas
## Evidências e fontes
## Alternativas descartadas e motivo
## Riscos pendentes
## Spec/plano atual
## Próxima confirmação necessária
```

Regras:

- Em projeto com `project-context`, ler o estado existente primeiro e registrar apenas a continuidade relevante ao processo do projeto.
- Em projeto com OpenSpec, manter a fonte de verdade da spec nele; o chat é apoio de decisão, não um documento paralelo concorrente.
- Quando não houver processo formal, produzir esse pacote no chat ou no local que o usuário indicar antes de iniciar uma conversa/etapa nova.
- Preferir uma síntese verificável a manter centenas de mensagens antigas ativas em um modelo caro.

## 10. Política de subagents

Subagent é uma recomendação de estrutura de trabalho, não um botão de “mais inteligência”. A skill nunca cria um automaticamente.

### 10.1 Teste de elegibilidade

Só sugerir subagent se todas as condições forem verdadeiras:

1. A pergunta é independente de uma decisão pendente do usuário.
2. O escopo pode ser escrito sem sobreposição com o trabalho principal ou outro subagent.
3. Existe uma saída verificável: mapa, lista de evidências, hipótese testada, relatório ou patch delimitado.
4. O ganho de paralelismo supera o custo de leitura, consolidação e possível divergência de contexto.

### 10.2 Papéis iniciais

| Necessidade independente | Papel sugerido | Modelo/esforço inicial | Saída exigida |
|---|---|---|---|
| Mapear arquivos, símbolos, fluxos e dependências | `code_mapper`/`explorer` | Terra Medium | mapa com caminhos, evidência e lacunas |
| Confirmar documentação, APIs, versões e benchmarks | `docs_researcher` | Terra Medium | fontes primárias, data de consulta e limitações |
| Preparar texto/documento repetitivo já aprovado | `documentation_engineer` | Luna Medium | artefato delimitado e itens não resolvidos |
| Investigar falha, regressão ou causa-raiz | `debugger` | Sol High | hipótese, evidência, reprodução e próximos testes |
| Revisar risco, segurança, regressões ou plano crítico | `reviewer` | Sol High | achados priorizados e critérios de correção |

O output da skill deve sempre trazer: **papel, pergunta, escopo, saída, modelo/esforço, motivo de paralelizar e a frase explícita de que depende de aprovação antes de iniciar**.

## 11. Evidências, benchmarks e limites de inferência

O repositório manterá um relatório datado de evidências em `docs/research/`. Ele é a fonte de consulta para números; o `SKILL.md` não deve repetir tabelas grandes nem preços que podem envelhecer.

Princípios para interpretar evidência:

- Documentação oficial é a fonte para a finalidade declarada de modelos, esforços e regras do produto.
- DeepSWE e Artificial Analysis são sinais comparativos úteis para tarefas de agente/código, mas não medem perfeitamente qualidade de planejamento conversacional, seu repositório nem créditos do plano Codex.
- Preços médios de um benchmark de API não permitem prever a porcentagem da sua cota semanal.
- A configuração real do usuário — contexto, chamadas de ferramentas, duração, esforço, modo de serviço e retrabalho — pode dominar o consumo percebido.
- Quando uma fonte não permitir afirmar algo, a skill deve dizer “não confirmado” em vez de preencher a lacuna com uma regra.

## 12. Calibração por uso real

Depois da primeira versão, a política deve ser revisada por amostras de trabalho real. Não precisa registrar cada mensagem; basta registrar tarefas representativas.

| Campo | Pergunta a responder |
|---|---|
| fase e tipo de tarefa | era conversa, spec, execução, diagnóstico ou revisão? |
| modelo e esforço | qual combinação foi usada e por quanto tempo/blocos? |
| clareza inicial | a tarefa já estava delimitada ou a incerteza era material? |
| resultado | terminou certo, exigiu escalonamento, voltou ao planejamento ou falhou? |
| retrabalho | quantas correções ou mudanças de direção foram necessárias? |
| custo percebido | houve consumo extraordinário de cota? Use como sinal, não como preço exato |

Após algumas amostras por categoria, ajustar a tabela com base em sucesso e retrabalho, não apenas em sensação de velocidade. Antes disso, não declarar percentuais como “80% das tarefas” ou equivalências exatas com GPT-5.5.

## 13. Cenários de aceitação

| Cenário | Comportamento esperado |
|---|---|
| “Quero entender esse projeto antes de decidir a feature.” | Terra High; recuperar contexto; fazer perguntas decisivas; não criar plano final por suposição |
| “Já decidimos; gere a spec para revisão.” | Terra High/XHigh conforme abrangência; produzir spec e pedir confirmação antes de implementar |
| “Esta spec envolve autorização e migração de dados.” | Terra XHigh para fechar; Sol High em revisão curta e dirigida; registrar riscos e rollback |
| “Aprovado. Altere estes três arquivos e rode testes.” | Luna High ou XHigh conforme integração; encaminhar para execução; Max não é automático |
| “Execute sozinho esta spec grande, com testes, e me traga o resultado.” | Luna Max se a spec for madura e os critérios forem verificáveis; pausar/escalar se surgir decisão arquitetural nova |
| “O teste falha e não sei por quê.” | fase Diagnóstico; Terra High se a investigação é direta, Sol High se a causa é desconhecida/complexa; não sugerir correção antes de evidência |
| “O que você faria agora?” | sempre dar posição clara, trade-off, próximo passo e o que precisa de confirmação — não devolver uma lista neutra sem recomendação |
| “Use vários agentes para pensar.” | primeiro aplicar teste de elegibilidade; propor papéis sem sobreposição e pedir aprovação para dispará-los |

## 14. Arquitetura da primeira versão

Após esta spec estar aprovada, a skill terá somente os arquivos necessários para funcionar e evoluir sem inflar contexto:

```text
skills/think-with-me/
├── SKILL.md
├── agents/openai.yaml
└── references/
    ├── model-routing.md
    └── output-contract.md

README.md
docs/specs/2026-07-17-think-with-me-design.md
docs/research/model-routing-evidence-2026-07-17.md
docs/plans/2026-07-17-think-with-me-implementation.md
```

- `SKILL.md`: workflow, autoridade, classificação de fase, saída mínima e quando abrir cada referência.
- `references/model-routing.md`: matriz prática, gatilhos de subida/parada e subagents. Deve citar a data/escopo de sua evidência, sem fingir que é uma calculadora de cota.
- `references/output-contract.md`: exemplos curtos e copy-ready do fechamento, recapitulação de contexto e pedido de aprovação de subagent.
- `agents/openai.yaml`: metadados de interface gerados e mantidos em sincronia com a skill.
- `docs/research/`: documentação de manutenção humana, fora da pasta instalável da skill.

Não haverá script nesta primeira versão: as decisões são dependentes de contexto e um script criaria uma falsa precisão. Não haverá README dentro da pasta da skill; informações de desenvolvimento e publicação vivem na raiz do repositório. A licença será escolhida explicitamente antes de qualquer publicação pública; ela não é necessária para a validação privada local.

## 15. Critérios de aceite da versão 1

1. A invocação `$think-with-me` abre uma conversa de colaboração e não inicia execução.
2. A skill diferencia fase, família, esforço e modo de trabalho em vez de recomendar “o mais forte”.
3. Para decisão aberta, pergunta uma coisa por vez com recomendação; para contexto suficiente, sintetiza sem entrevista artificial.
4. Cada encaminhamento material termina com uma visão clara do assistente e, quando relevante, modelo da conversa, orientação sobre subagent e o que precisa de confirmação — sem formato obrigatório de relatório.
5. A recomendação de Luna Max exige tarefa clara, longa/autônoma e critérios de validação; não aparece automaticamente para toda implementação.
6. Sol é usado como intervenção delimitada para ambiguidade/risco, não como conversa inteira por padrão.
7. Subagent só aparece com escopo independente, saída verificável e aprovação explícita; nunca é disparado pela skill.
8. O processo respeita `project-context`, OpenSpec e a autoridade do usuário sobre aprovação.
9. Números e alegações de benchmark ficam em relatório datado com fontes e limitações, não escondidos como certeza na instrução da skill.
10. A skill passa na validação estrutural, é instalada localmente, é exercitada em cenários representativos e só depois considerada para publicação pública.

## 16. Estado atual

Aprovada a especificação, a implementação local pode criar a estrutura da skill, escrever `SKILL.md`, as referências e os metadados de agente; então validar e instalar localmente. A publicação no GitHub público continua bloqueada até haver uso real, ajustes e uma escolha explícita de licença.
