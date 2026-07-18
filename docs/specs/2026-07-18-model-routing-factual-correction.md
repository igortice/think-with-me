# Think With Me — correção factual do roteamento GPT-5.6

**Status:** implementada e validada local/globalmente
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
- Manter `think-with-me` ativo durante a mesma conversa de entendimento,
  inclusive após concordância ou aprovação de uma direção; sair dele apenas
  diante de uma instrução operacional explícita.
- Substituir a linha seca de modelo por uma linha compacta com recomendação e
  motivo contextual: `**Modelo:** **Terra High** — motivo curto.`
- Permitir uma segunda linha opcional, em itálico, para registrar uma mudança
  de modelo ou uma alternativa condicional relevante, sem listar modelos por
  rotina.
- Reavaliar modelo e esforço em toda mudança material de fase, sem reter Terra
  por inércia.

## Fora de escopo

- Alterar a autoridade somente leitura ou iniciar execução sem uma instrução
  operacional explícita.
- Mudar a família/modelo de uma conversa já em andamento por inércia.
- Criar regras baseadas em benchmarks ou prometer custo, disponibilidade ou
  limites de plano.

## Design

A tabela continuará escolhendo uma família e esforço principais para o próximo
trecho da conversa. Ela terá uma linha de escopo para cada família, uma seção
curta para a escala de esforço e sinais de transição que exigem nova escolha. A
fonte oficial será declarada como base factual; as recomendações de Terra High e
o limite para escalar serão explicitamente tratados como política local da
skill.

O fechamento continuará um blockquote contínuo. Seus campos serão `Minha
visão`, `Próximo passo` e `Modelo`; o último conterá um modelo principal em
negrito, um motivo de até uma frase curta e, apenas quando útil, uma linha
itálica de alternativa ou transição. Exemplo:

```md
> **Modelo:** **Terra High** — refinando contrato e trade-offs.
> _Se mudar:_ **Sol High** para conflito difícil · **Luna Medium** para síntese final.
```

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
família e esforço, contém fontes oficiais datadas, recalcula a recomendação por
fase e preserva o blockquote público compacto.
