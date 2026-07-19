# Think With Me — correção factual do roteamento GPT-5.6

**Status histórico:** a correção factual deste documento foi implementada, validada e sincronizada globalmente no release de 18 de julho de 2026.
**Status atual da candidata:** não sincronizada globalmente.
**Data:** 18 de julho de 2026

## Objetivo

Corrigir a referência canônica de roteamento da skill `think-with-me` para
separar fatos oficiais da família GPT-5.6 das políticas conversacionais locais,
sem alterar o contrato de resposta de três campos.

## Escopo

Modificar o pacote instalável, suas avaliações e o gate de evidência.

- Descrever Sol como o modelo de fronteira para trabalho profissional complexo,
  inclusive análise técnica e arquitetura difícil, não apenas riscos críticos.
- Manter Terra High como padrão equilibrado **desta skill** para entender,
  comparar e planejar, sem apresentá-lo como padrão universal da OpenAI.
- Recomendar Luna apenas para síntese, classificação ou refinamento já
  delimitados quando custo, latência ou volume forem relevantes.
- Registrar os níveis `none`, `low`, `medium`, `high`, `xhigh` e `max` como
  disponíveis para a família na API; mencionar `ultra` somente como capacidade
  do Codex dependente de acesso/plano.
- Adicionar fontes oficiais da OpenAI e data de revisão no próprio arquivo.
- Manter `think-with-me` ativo somente enquanto a skill estiver carregada no turno atual,
  inclusive após concordância ou aprovação de uma direção; sair dele apenas
  temporariamente diante de uma instrução operacional que identifique a ação e
  a mudança esperada, retomando o fechamento se o mesmo assunto continuar e o
  host a carregar novamente.
- Renderizar a recomendação como uma linha compacta em código inline, com
  exatamente um modelo e esforço para o `Próximo passo` apresentado logo acima.
- Calcular a recomendação somente depois de formular `Minha visão` e `Próximo
  passo`; o rodapé não escolhe um modelo para a conversa em abstrato.
- Fundamentar a escolha no objetivo, no trabalho restante, na ambiguidade e no
  risco, combinados com evidências de saúde da conversa: avanço ou repetição,
  correções, contradições, atrito, perda de confiança e convergência.
- Considerar modelos e esforços já tentados somente quando essa trajetória
  estiver explícita na conversa ou disponível no contexto; nunca inventar qual
  modelo está ativo.
- Tratar sentimento e atrito como sinais de falta de convergência, nunca como
  justificativa isolada para escalar modelo ou esforço.
- Buscar valor máximo pelo ajuste entre modelo e próximo passo, não escolhendo
  `Max`, `Sol` ou outro nível superior automaticamente.
- Explicar a recomendação com uma razão concreta ligada ao próximo passo e à
  evidência observada na conversa, sem categorias genéricas como `decidir`,
  `risco` ou `consolidar` desacompanhadas de contexto.
- Não prever uma segunda fase: omitir setas, `agora`, `depois`, modelos
  alternativos e instruções de troca futura.
- Não usar HTML para reduzir a fonte: o renderer do Codex pode exibir as tags
  literalmente, e Markdown não oferece controle confiável de tamanho.
- Reavaliar modelo e esforço em toda mudança material de fase, sem reter Terra
  por inércia.

## Fora de escopo

- Alterar a autoridade somente leitura ou iniciar execução sem uma instrução
  operacional que identifique tanto a ação quanto a mudança esperada.
- Mudar a família/modelo de uma conversa já em andamento por inércia.
- Criar regras baseadas em benchmarks ou prometer custo, disponibilidade ou
  limites de plano.

## Design

A tabela continuará descrevendo a aptidão geral de cada família e esforço, mas
não determinará a resposta sozinha. O roteamento acontecerá em duas camadas:

1. Classificar o próximo passo concreto por tipo de raciocínio, ambiguidade,
   risco, custo e necessidade de síntese.
2. Ajustar a escolha com evidências da trajetória da conversa, sobretudo quando
   tentativas anteriores não convergiram ou quando a direção já se estabilizou.

A fonte oficial será declarada como base factual; as recomendações
conversacionais e os limites para escalar serão tratados como política local da
skill.

O fechamento continuará um blockquote contínuo. Seus campos serão `Minha
visão`, `Próximo passo` e uma única linha final com o modelo em código inline,
escrita somente depois dos dois campos anteriores. Ela conterá exatamente uma
recomendação e uma justificativa contextual curta:

```md
> **Minha visão:** as correções repetidas mostram que a regra ainda precisa de julgamento preciso.
>
> **Próximo passo:** fechar a formulação única que eliminaria a ambiguidade restante.
>
> `Sol High` · integrar as correções repetidas sem reabrir a regra.
```

No caso que originou esta revisão, a trajetória explícita `Terra High` → `Max`
→ `Sol`, as correções repetidas e a falta de convergência tornam `Sol High`
coerente para fechar o contrato. A justificativa não deve apenas repetir que o
trabalho é uma “decisão”; ela deve registrar por que este próximo passo ainda
exige maior precisão.

Exemplos de adaptação contextual:

- Migração irreversível: recomendar `Sol High` para comprovar integridade e
  recuperação antes de autorizar a migração.
- Texto com direção já aprovada: recomendar `Luna Medium` para condensar o
  conteúdo sem reabrir decisões.
- Comparação comum que está convergindo: recomendar `Terra High` para fechar o
  trade-off específico ainda pendente.

Cada resposta recalcula uma única recomendação. Uma possível mudança futura só
será avaliada na resposta em que ela se tornar o próximo passo real.

## Validação

1. Registrar um cenário que reproduza a falha atual: diante de correções
   repetidas e de uma trajetória de modelos explícita, a skill ainda emite
   `agora → depois` em vez de recomendar um modelo para o próximo passo.
2. Confirmar que esse cenário falha antes de alterar o contrato instalável.
3. Atualizar o gate estático, as avaliações e os exemplos para exigir uma única
   recomendação contextual e rejeitar setas ou previsões de modelo futuro.
4. Executar `bash tests/evidence-gate-v1.sh` para preservar o contrato
   comportamental.
5. Executar uma conversa nova com o cenário aprovado e confirmar que a resposta
   considera próximo passo, correções e convergência sem inventar o modelo
   ativo.
6. Executar um cenário em que uma edição com mudança esperada é concluída e
   confirmar que o relatório retoma o fechamento quando o assunto continua.
7. Executar `bash scripts/verify-global-install.sh` antes da sincronização,
   confirmando que a divergência esperada é apenas a alteração local.
8. Sincronizar os quatro arquivos do pacote com a instalação global aprovada.
9. Executar novamente `bash scripts/verify-global-install.sh`,
   `bash tests/evidence-gate-v1.sh` e `git diff --check`.

## Critério de aceite

A referência deixa claro o papel de Sol, Terra e Luna e a distinção entre
família e esforço, contém fontes oficiais datadas, recalcula uma única
recomendação a partir do próximo passo e da saúde da conversa, nunca inventa o
modelo ativo e preserva o blockquote público compacto somente enquanto a skill
estiver carregada no turno atual, inclusive depois de uma execução
explicitamente delimitada.
