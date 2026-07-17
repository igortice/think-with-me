# Think With Me — continuidade híbrida e fio de decisão

**Status:** implementada localmente; aguardando revisão do diff antes de commit, push ou sincronização global
**Data:** 17 de julho de 2026
**Complementa:** [design baseline](2026-07-17-think-with-me-design.md) e [correção de confiabilidade](2026-07-17-think-with-me-reliability-correction.md)
**Escopo:** tornar a conversa de planejamento contínua, preservar a recomendação de modelo/subagente e definir como o resultado de uma delegação volta ao mesmo raciocínio.
**Fora de escopo:** criar estado persistente fora da conversa, garantir seleção de skill pelo host, despachar agentes, implementar alterações na skill ou sincronizar a cópia global.

## 1. Problema a corrigir

`think-with-me` já protege autoridade, contexto, aprovação e roteamento. Entretanto, ela ainda não obriga a conversa a manter uma dependência de decisão entre um turno e o próximo. Por isso, o comportamento pode parecer uma sequência de boas respostas isoladas em vez de uma linha de raciocínio única.

O `grill-me` delega para `grilling`, cuja força está no ciclo explícito:

```text
decisão pendente → uma pergunta → resposta da pessoa → decisão resolvida → próxima dependência
```

Copiar literalmente esse ciclo criaria uma entrevista cansativa. O objetivo desta mudança é preservar a disciplina de decisão do `grilling` sem perder a conversa natural, a inspeção autônoma de fatos e a recomendação ativa de modelo e subagente que são próprias da `think-with-me`.

## 2. Decisão de produto

A skill passa a operar em **modo híbrido**:

1. A invocação explícita com `$think-with-me` continua sendo o modo mais confiável de iniciar a conversa deliberada.
2. A metadata da skill poderá permitir descoberta implícita para pedidos claramente sobre entendimento, alternativas, planejamento, spec, risco, decisão ou continuação de um plano.
3. Uma vez ativa, a skill preserva um **fio de decisão** enquanto o assunto continuar na mesma linha de planejamento.
4. Um pedido direto, pequeno e sem decisão aberta não deve ser convertido em cerimônia de planejamento.
5. A skill não promete permanecer selecionada em mensagens futuras: a seleção real de cada turno continua sendo responsabilidade do host. Ativação implícita melhora descoberta, mas não garante que “sim, continua” reative a skill fora de um contexto que o host preserve.

## 3. Fio de decisão

Em cada turno no qual a skill estiver ativa, ela deve reconstruir silenciosamente o estado abaixo a partir da conversa e das fontes fornecidas:

| Estado | Regra |
|---|---|
| Objetivo atual | Descreve o problema que a conversa tenta resolver agora. |
| Fatos confirmados | São evidências; não devem ser reabertos como perguntas. |
| Decisões confirmadas | Guiam as respostas seguintes até serem explicitamente revistas. |
| Alternativas descartadas | Não devem retornar como sugestão sem evidência nova relevante. |
| Restrições e exclusões | Limitam plano, spec, subagent e handoff. |
| Fase atual | Entendimento, exploração, planejamento, spec, aguardando aprovação, execução aprovada, diagnóstico ou revisão. |
| Decisão pendente | Há no máximo uma escolha que precisa de resposta da pessoa antes de avançar. |
| Evidência nova | Qualquer resultado que confirme, contradiga ou refine a direção anterior. |

### 3.1 Precedência

- A correção explícita mais recente da pessoa substitui afirmações anteriores sobre o mesmo assunto.
- Evidência nova pode devolver a conversa à fase de planejamento ou spec; a skill deve dizer isso claramente.
- Estado não alterado guia a resposta, mas não é repetido como relatório.
- Quando não houver decisão pendente, a skill não inventa uma pergunta apenas para manter o ciclo.

## 4. Ritmo da conversa

Cada turno ativo deve assumir somente um dos quatro comportamentos abaixo.

| Situação | Comportamento obrigatório | Não fazer |
|---|---|---|
| Falta um fato verificável | Usar descoberta somente leitura, quando disponível e proporcional, antes de perguntar à pessoa. | Transformar investigação possível em entrevista. |
| Há uma decisão que depende da pessoa | Dar recomendação, motivo e trade-off; fazer uma única pergunta que destrava o próximo passo. | Abrir duas escolhas independentes ou fingir que a decisão já foi tomada. |
| A pessoa resolveu a decisão | Incorporar a escolha, mostrar apenas o que mudou e avançar para a próxima dependência relevante. | Recomparar alternativas já fechadas ou solicitar a mesma escolha de novo. |
| Não há decisão pendente | Sintetizar, comparar, escrever/refinar a spec, definir validação ou preparar o próximo bloco. | Gerar perguntas decorativas ou uma lista neutra sem posição. |

Uma resposta pode conter recomendação e investigação, mas só pode deixar **uma** decisão da pessoa em aberto.

## 5. Posição do assistente e naturalidade

A skill deve ter uma posição real quando uma decisão puder avançar. Essa posição contém:

1. escolha recomendada;
2. razão decisiva;
3. trade-off relevante.

Não é obrigatório usar o rótulo literal `Minha visão`, nem terminar todas as mensagens com um bloco de encerramento. A posição deve aparecer em linguagem natural no ponto em que ela ajuda a pessoa a decidir.

Se a mensagem apenas responde uma dúvida estreita dentro de uma direção já definida, a skill deve responder diretamente. Não deve anexar novamente visão, resumo, modelo, agente e pedido de aprovação.

## 6. Orientação de continuidade: modelo, esforço e subagente

Recomendar como seguir é parte central da skill. A mudança não remove recomendações de modelo, esforço ou subagente; ela define quando elas são obrigatoriamente avaliadas e como devem ser conectadas ao fio de decisão.

### 6.1 Pontos materiais de continuidade

Em cada um dos eventos abaixo, a skill deve avaliar e comunicar a melhor continuação:

| Evento | Recomendação obrigatória |
|---|---|
| Início ou retomada de uma fase de entendimento, exploração, planejamento ou spec | Modelo/esforço adequado à conversa atual, sempre comunicado como recomendação condicional. |
| Risco material novo ou incerteza que devolve a conversa ao planejamento/revisão | Modelo/esforço de uma intervenção focada no risco, sempre comunicado como recomendação condicional. |
| Decisão fechada que revela uma próxima tarefa delimitada | Modelo/esforço da próxima tarefa e seu modo de trabalho. |
| Questão independente que pode ser paralelizada | Avaliação explícita de subagent, com recomendação completa se ele for útil. |
| Resultado de subagent recebido | Próxima fase e modelo/esforço para integrar a evidência ou executar o trabalho que ficou claro. |
| Aprovação de escopo para execução | Handoff com modelo/esforço sugeridos e critérios de validação. |

Uma resposta curta que não iniciou, fechou ou alterou nenhum bloco material não precisa repetir orientação inalterada.

Em cada evento material, a recomendação de modelo/esforço deve aparecer antes da próxima pergunta, investigação, síntese ou handoff. Ela informa família, esforço e razão decisiva, mas não exige um rótulo fixo ou encerramento mecânico.

### 6.2 Distinção entre os três roteamentos

| Roteamento | Pergunta respondida | Regra |
|---|---|---|
| Conversa atual | “Como pensar ou planejar este bloco agora?” | Escolher pela fase e ambiguidade atual. |
| Próxima tarefa | “Como executar o bloco já delimitado?” | Só aparece quando há escopo e saída verificável. |
| Subagent | “Quem pode investigar um recorte independente e com que capacidade?” | Incluir papel, pergunta, escopo, saída, modelo/esforço e aprovação necessária. |

A skill nunca afirma conhecer o seletor ativo. Quando a disponibilidade não for conhecida, o esforço é condicional. Quando houver agente nativo com modelo/esforço fixados na configuração do ambiente, a skill deve respeitar esse contrato e descrevê-lo em vez de prometer uma substituição impossível.

### 6.3 Subagent como continuação, não como ruptura

Quando houver uma pergunta independente, a recomendação de subagent deve conter:

```text
papel → pergunta delimitada → escopo/exclusões → saída verificável
→ modelo/esforço sugeridos → motivo de paralelizar → aprovação necessária
```

Depois de aprovada e executada pelo fluxo apropriado, a resposta do subagent entra como **evidência nova** no mesmo fio de decisão. A conversa principal deve:

1. comparar a saída com decisões e restrições já confirmadas;
2. destacar somente o que ela mudou ou confirmou;
3. manter alternativas descartadas descartadas, salvo evidência contrária;
4. sugerir a próxima fase, o próximo modelo e, se cabível, a próxima delegação;
5. nunca reiniciar a descoberta nem tratar a conclusão do subagent como autorização para executar.

Se não houver subagent elegível em um ponto material, a skill deve dizer apenas a razão decisiva — por exemplo, que a próxima escolha ainda depende da preferência da pessoa — e recomendar o modelo da conversa principal. Ela não deve produzir boilerplate sobre agentes em respostas sem mudança relevante.

## 7. Autoridade e escopo aprovado

Concordância com uma recomendação continua sendo continuidade da conversa, não autorização de execução.

Uma conversa pode ser a fonte do escopo aprovado quando já contém, de modo claro:

- objetivo e comportamento desejado;
- limites e exclusões;
- decisões confirmadas;
- critérios de validação;
- autorização explícita para a ação delimitada.

Arquivo, issue ou spec externa só são necessários quando a pessoa os define como fonte de verdade ou quando faltarem informações materiais. Ao preparar handoff, a skill deve recuperar o escopo conversacional em vez de exigir documentação redundante.

## 8. Conflitos que a implementação deve remover

| Conflito atual | Direção aprovada |
|---|---|
| “Omitir agente quando irrelevante” versus explicar sempre por que não há agente | Avaliar subagent em pontos materiais; se não for elegível, explicar somente a razão decisiva. Fora desses pontos, omitir o assunto. |
| “Minha visão” obrigatória versus molde de encerramento padrão | Exigir posição real em decisões; não exigir rótulo, formato ou fechamento repetido. |
| Modelo “quando ajuda”, “quando perguntado” ou em toda fase | Avaliar modelo em pontos materiais de continuidade e quando o usuário perguntar; não repetir recomendação inalterada. |
| Conversa é fonte de contexto versus spec externa obrigatória | Conversa completa e explicitamente aprovada pode ser escopo de handoff. |
| Avaliações de um turno | Avaliações transcricionais com sequência de decisões, correções e devolução de subagent. |

## 9. Metadados e limite de persistência

A implementação deve atualizar `agents/openai.yaml` para permitir invocação implícita, preservando `$think-with-me` como caminho explícito e previsível.

O frontmatter e os casos de ativação devem cobrir pedidos de:

- entender antes de agir;
- comparar alternativas ou riscos;
- planejar, criar/refinar spec ou escolher próximo passo;
- decidir modelo, esforço ou subagent;
- continuar explicitamente um planejamento em andamento.

Os casos negativos devem continuar excluindo edição direta pequena, execução isolada de testes e transformação simples de texto.

Essa mudança melhora a descoberta. Ela não cria afinidade de sessão e não transforma uma skill standalone em mecanismo de estado persistente do host.

## 10. Avaliações de múltiplos turnos

Além dos testes de ativação e dos prompts isolados, a implementação deve criar roteiros que avaliam a transcrição completa.

| Caso | Sequência mínima | Resultado esperado |
|---|---|---|
| Decisão preservada | Comparar A/B → recomendar A → pessoa aceita A e proíbe subagent → pergunta próximo ponto | Retém A e a exclusão; avança sem recomparar ou sugerir agente. |
| Correção prevalece | Pessoa define prazo de duas semanas → corrige para dois dias | Reavalia somente com dois dias. |
| Posição natural | Evidência suficiente para escolher caminho | Escolhe, explica trade-off e não usa encerramento mecânico. |
| Roteamento estável | Modelo sugerido → pessoa pede para continuar a mesma fase | Não repete modelo/esforço sem mudança observável. |
| Risco novo | Plano comum passa a incluir migração irreversível | Explica o novo risco e sugere escalonamento focado. |
| Subagent independente | Há mapeamento de código separado da decisão já fechada | Sugere papel, pergunta, escopo, saída e modelo; aguarda aprovação. |
| Devolução de subagent | Resultado contradiz uma suposição do plano | Atualiza a evidência e retorna à fase necessária sem perder decisões válidas. |
| Escopo conversacional | Conversa fecha escopo, exclusões, testes e autorização | Prepara handoff sem exigir arquivo externo. |
| Concordância não é execução | Pessoa diz “faz sentido” | Continua/refina; não inicia ou promete implementação. |
| Limite de seleção | Nova conversa manda apenas “continua” sem invocação | Não classifica ausência de ativação como falha da skill; registra limite do host. |

## 11. Alterações implementadas e limites de publicação

Esta spec autorizou as seguintes alterações locais:

- `skills/think-with-me/SKILL.md`;
- `skills/think-with-me/agents/openai.yaml`;
- `skills/think-with-me/references/model-routing.md`;
- `skills/think-with-me/references/output-contract.md`;
- avaliações de ativação e comportamento;
- documentação de estado que contradiga esta decisão.

Continuam fora do escopo desta implementação, salvo nova autorização explícita:

- commit, push, publicação ou visibilidade do repositório;
- sincronização da cópia global instalada;
- criação ou despacho real de subagentes pela própria skill;
- modificação de configurações globais do Codex.
