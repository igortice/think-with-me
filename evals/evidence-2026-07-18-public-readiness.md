# Think With Me — evidência de readiness público

**Data:** 18 de julho de 2026  
**Escopo:** validar a cópia global do candidato público, incluindo os rótulos finais no idioma da mensagem atual e a prévia pública enxuta.

## Candidato

- `PACKAGE_SHA256`: `0809a29031e2bd39385b52914e092d46e999b29ee0db13b464375b7911608f99`
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

## Regressão da prévia pública e forward-test final

Para reduzir a prévia do skills.sh, o núcleo público foi separado dos templates
multilíngues. A primeira versão compacta ficou curta demais: no mesmo caso
TWM-13 ela respondeu com `View` e um modelo genérico, sem a família escolhida.
Esse resultado falhou e não liberou o candidato.

A correção manteve o núcleo inteiramente em inglês, sem `grilling` e sem
rótulos em português, mas recolocou um único template completo em inglês e a
proibição explícita de usar português quando a mensagem atual estiver em
inglês. Os exemplos completos de outros idiomas permaneceram na referência de
contrato de saída.

O forward-test final, também efêmero e somente leitura, retornou:

```md
> **My view:** Choose option A: centralize the evolving eligibility rule in one service first. It gives you one authoritative interpretation, one test surface, and avoids three services drifting while the rule is still changing.
>
> **Next step:** Define the rule’s single-service contract: required inputs, eligibility outcomes, and ownership of rule changes. This establishes whether the central service can serve all three consumers cleanly before any rollout work begins.
>
> _Model for the next step: **Terra High** — define the shared contract from the still-evolving rule and the need to prevent cross-service divergence._
```

Resultado final: **pass**. A resposta ficou inteiramente em inglês, preservou
o blockquote contínuo e usou exatamente uma família e esforço no rodapé.

## Limites

- O teste confirma um caso real de regressão em inglês e não substitui a execução periódica dos demais casos de `evals/think-with-me-cases.md`.
- O comportamento de uma skill em linguagem natural continua probabilístico; mudanças comportamentais futuras exigem nova evidência e paridade antes da publicação.

No implementation commit, push, or publication was made before this evidence record.
