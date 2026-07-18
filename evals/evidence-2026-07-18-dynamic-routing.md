# Think With Me — evidência de roteamento dinâmico

**Data:** 18 de julho de 2026
**Escopo:** validação da instalação global após a correção de continuidade,
roteamento dinâmico e apresentação compacta do modelo.

## Candidato

- `PACKAGE_SHA256`: `3615f1c47c72a09a0c852f512190e2cf44c361356cc63d28bc18283b27304c64`
- `CANDIDATE_ID`: `a729e1d03876a09830f23e6bab3d65491606736df2110f0a07501d4870c47092`
- Fonte: `skills/think-with-me/`
- Instalação testada: `<global-skills>/think-with-me/`

## Validação estática e paridade

- `bash scripts/verify-global-install.sh` retornou `Global think-with-me installation matches the repository source.`
- `UV_CACHE_DIR=.cache/uv bash scripts/validate-structure.sh` retornou
  `Structural validation passed.`
- `git diff --check` não encontrou erro de espaço em branco.

## Forward test passed

Foi executada uma invocação nova e efêmera do Codex com `$think-with-me`, sem
pedir edição de arquivos. O cenário informou que a conversa anterior usava
Terra High para uma migração comum e acrescentou que a migração era irreversível
e podia comprometer a integridade dos dados.

Resultado observado no fechamento:

```md
> **Modelo:** **Sol High** — substitui Terra High porque a conversa passou a envolver irreversibilidade e integridade de dados.
```

O resultado demonstrou os três comportamentos necessários: reavaliação por
mudança material de fase, troca de Terra para Sol e razão curta ligada ao
contexto. O modelo de runtime que executou a invocação era `gpt-5.6-terra` com
esforço `high`; a skill recomenda qual modelo usar na próxima fase, mas não
troca automaticamente o modelo ativo do host.

## Limites

- O cenário validou a escalada Terra → Sol. A redução para Luna Medium está
  coberta pelos casos multi-turno e exemplos do pacote, mas não foi uma segunda
  invocação externa nesta rodada.
- A seleção automática da skill pelo host continua sendo responsabilidade do
  host; o forward test a invocou explicitamente por `$think-with-me`.

No implementation commit, push, or publication was made before this evidence record.
