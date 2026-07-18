# Think With Me — evidência do layout de fechamento

**Data:** 18 de julho de 2026  
**Escopo:** validar o contrato visual ativo: uma visão, um próximo passo e uma recomendação curta de modelo sem rótulo redundante.

## Candidato

- `PACKAGE_SHA256`: `7c8a500c15b656b512c69a0f2a191a93c9b855d2499f99d4d2a6a61ef96e2784`
- Fonte: `skills/think-with-me/`
- Instalação verificada: `<global-skills>/think-with-me/`

## Contrato aprovado

O fechamento contínuo usa exatamente esta estrutura. O texto vem logo após os dois-pontos nos dois primeiros campos; a recomendação final é uma etiqueta de código inline, seguida de uma razão curta e contextual.

```md
> **Minha visão:** a fonte está correta no GitHub, mas o catálogo ainda mostra um snapshot antigo; alterar novamente a skill não corrige essa divergência externa.
>
> **Próximo passo:** confirmar se busca e página pública convergem após a atualização do índice.
>
> `Terra High` · validar a divergência entre fonte e catálogo.
```

O contrato proíbe, na terceira linha, `Modelo para o próximo passo`, itálico, negrito, travessão, HTML, mais de um modelo, setas e transições como `agora` ou `depois`.

## Contract validation passed

- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-skill.sh` retornou `Structural validation passed.`
- `bash tests/evidence-gate-v1.sh` valida o template canônico em português e inglês, cada exemplo ativo e fixtures negativos para o formato antigo, HTML, dois modelos, setas, previsões futuras, instrução operacional incompleta, retomada após execução e separação entre fato e inferência.
- `git diff --check` não encontrou erro de espaço em branco.

## Paridade global

- `NPM_CONFIG_CACHE=.cache/npm npx --yes skills add . --skill think-with-me -g -a codex -y` reinstalou a cópia global a partir da fonte local validada.
- `bash scripts/verify-global-install.sh` retornou `Global think-with-me installation matches the repository source.`

## Runtime limitation

O Codex CLI ainda emitiu o aviso local de cache `missing field supports_reasoning_summaries`, mas as sessões efêmeras completaram e geraram respostas. Foram aprovados quatro forward tests sobre a instalação global atual: (1) uma solicitação de edição sem mudança esperada não alterou arquivo e manteve o fechamento da skill; (2) uma inspeção distinguiu fatos compatíveis de uma preocupação ainda não provada; (3) o caso concreto A/B escolheu a centralização da regra instável e preservou o fechamento; e (4) em uma cópia isolada do repositório, uma edição explicitamente definida alterou somente o título solicitado, verificou o diff e retomou o fechamento da decisão no mesmo tema. Os avisos de cache e de estado são não bloqueantes neste ambiente, mas devem continuar sendo observados em futuras execuções.

## Limites

- O gate cobre o contrato visual e semântico, mas uma skill em linguagem natural continua probabilística.
- A prévia do `skills.sh` pode continuar exibindo um snapshot externo antigo; ela não é a fonte de verdade da instalação pelo CLI.

No implementation commit, push, or publication was made before this evidence record.
