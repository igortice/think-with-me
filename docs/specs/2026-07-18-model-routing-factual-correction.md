# Think With Me — correção factual do roteamento GPT-5.6

**Status:** design aprovado para implementação
**Data:** 18 de julho de 2026

## Objetivo

Corrigir a referência canônica de roteamento da skill `think-with-me` para
separar fatos oficiais da família GPT-5.6 das políticas conversacionais locais,
sem alterar o contrato de resposta de três campos.

## Escopo

Modificar somente `skills/think-with-me/references/model-routing.md`.

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

## Fora de escopo

- Alterar o gatilho, a autoridade somente leitura, o blockquote final ou os
  exemplos da skill.
- Mudar a família/modelo de uma conversa já em andamento por inércia.
- Criar regras baseadas em benchmarks ou prometer custo, disponibilidade ou
  limites de plano.

## Design

A tabela continuará escolhendo uma única família e esforço para o próximo
trecho da conversa. Ela terá uma linha de escopo para cada família e uma seção
curta para a escala de esforço. A fonte oficial será declarada como base factual;
as recomendações de Terra High e o limite para escalar serão explicitamente
tratados como política local da skill.

## Validação

1. Executar `bash tests/evidence-gate-v1.sh` para preservar o contrato
   comportamental.
2. Executar `bash scripts/verify-global-install.sh` antes da sincronização,
   confirmando que a divergência esperada é apenas a alteração local.
3. Sincronizar os quatro arquivos do pacote com a instalação global aprovada.
4. Executar novamente `bash scripts/verify-global-install.sh`,
   `bash tests/evidence-gate-v1.sh` e `git diff --check`.

## Critério de aceite

A referência deixa claro o papel de Sol, Terra e Luna e a distinção entre
família e esforço, contém fontes oficiais datadas e preserva todos os gates e o
formato público existentes.
