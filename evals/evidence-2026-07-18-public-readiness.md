# Think With Me — evidência de readiness público

**Data:** 18 de julho de 2026  
**Escopo:** validar a cópia global do candidato público, incluindo os rótulos finais no idioma da mensagem atual.

## Candidato

- `PACKAGE_SHA256`: `82493e083bf69396332c6232643402379f37da232d4190136e5a7deb320f78e7`
- Fonte: `skills/think-with-me/`
- Instalação verificada: `<global-skills>/think-with-me/`

## Regressão encontrada

O primeiro forward-test do caso TWM-13 recebeu um prompt completamente em inglês, mas encerrou com os rótulos em português. O problema era a regra localizar os rótulos sem explicitar que o idioma deveria vir da mensagem atual, e não do idioma padrão do aplicativo.

A correção passou a exigir essa origem de idioma, proibiu rótulos em português quando a mensagem atual estiver em inglês e adicionou o requisito correspondente ao gate estático. A fonte corrigida foi instalada novamente antes do teste abaixo.

## Forward test passed

O Codex executou uma invocação normal de `$think-with-me` em uma sessão efêmera, somente leitura e fora do repositório. O prompt comparava centralizar uma regra de elegibilidade ainda evolutiva com distribuí-la imediatamente para três serviços. O resultado relevante foi:

```md
> **My view:** Start with Option A: central ownership minimizes policy drift while the rule is still changing.
>
> **Next step:** Define the central service’s eligibility decision contract—inputs, decision output, reason codes, and failure behavior—before any service integration.
>
> _Model for the next step: **Terra High** — it can turn the evolving-rule risk into a crisp, bounded contract without expanding into implementation._
```

Resultado: **pass**.

1. A resposta utilizou os três rótulos em inglês, na ordem exigida.
2. Os campos ficaram no mesmo blockquote contínuo.
3. `Next step` contém uma dependência imediata e não um checklist.
4. O rodapé recomenda exatamente `Terra High`, em uma linha, com uma razão ligada ao contrato restante e sem outro modelo, seta, HTML ou previsão de fase.
5. Nenhum arquivo ou serviço foi alterado pela execução do teste.

## Validação e paridade

- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh` retornou `Structural validation passed.`
- `bash scripts/verify-global-install.sh` retornou `Global think-with-me installation matches the repository source.`
- `npx skills add . --skill think-with-me -g -a codex -y` instalou a fonte local validada na cópia global do Codex.
- `git diff --check` não encontrou erro de espaço em branco.

## Limites

- O teste confirma um caso real de regressão em inglês e não substitui a execução periódica dos demais casos de `evals/think-with-me-cases.md`.
- O comportamento de uma skill em linguagem natural continua probabilístico; mudanças comportamentais futuras exigem nova evidência e paridade antes da publicação.

No implementation commit, push, or publication was made before this evidence record.
