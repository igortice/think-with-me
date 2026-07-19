# Think With Me — evidência do layout de fechamento

**Data:** 19 de julho de 2026
**Escopo:** validar o contrato visual ativo, a fronteira honesta entre continuidade quando a skill está carregada e ativação em um turno posterior, e o método correto de inspecionar o Markdown produzido no Codex App.

## Candidato

- `PACKAGE_SHA256`: `c45bb01f4918df952942b5e698269d142a8d47a37ba68d987899aae565a5bd94`
- Fonte: `skills/think-with-me/`
- Instalação global de referência: `<global-skills>/think-with-me/` (release anterior; a candidata atual não foi sincronizada)

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
- `bash tests/evidence-gate-v1.sh` valida o template canônico em português e inglês, cada exemplo ativo e fixtures negativos para o formato antigo, HTML, dois modelos, setas, previsões futuras, instrução operacional incompleta, retomada após execução, separação entre fato e inferência, a proibição de prometer autoativação entre turnos e a retomada de contexto depois de uma nova menção explícita. Ele também exige que os roteiros usem a transcrição bruta do Codex App, não apenas o resumo de espera.
- `git diff --check` não encontrou erro de espaço em branco.

## Controles do code review

- O workflow de validação instala explicitamente `ripgrep`, depois declara tanto a verificação estrutural quanto `bash tests/evidence-gate-v1.sh`; uma alteração que enfraqueça o contrato semântico não deve passar apenas pela estrutura nem depender de uma ferramenta presente apenas na máquina local.
- O gate verifica os campos públicos de `agents/openai.yaml`, a política de ativação implícita e os limites declarados em `evals/trigger-cases.md`, incluindo `TWM-T09` para uma auditoria de documentação e testes antes de decidir uma correção.
- O gate exige que o runbook descreva M12, M13, `agentMessage.text` e as superfícies separadas de candidata local, GitHub e skills.sh. Essas verificações documentam a intenção e o release; elas não provam que o host selecionará implicitamente a skill em todo turno.

## Paridade global do release anterior

- `NPM_CONFIG_CACHE=.cache/npm npx --yes skills add . --skill think-with-me -g -a codex -y` reinstalou a cópia global a partir da fonte local validada.
- Em 18 de julho, `bash scripts/verify-global-install.sh` retornou `Global think-with-me installation matches the repository source.`

Current candidate has not been synchronized globally. A cópia global permanece como referência do release anterior; esta correção local não foi instalada, publicada, commitada ou enviada.

## Validação runtime da candidata local

Uma sessão isolada local (`019f7b83-26d9-7ed0-b0e8-1012c9d56bdc`) selecionou explicitamente a fonte candidata. A transcrição bruta, lida com `read_thread`, comprovou os dois passos de `TWM-M13`:

1. No primeiro turno, a candidata recomendou centralizar a regra instável, deixou somente a definição das saídas do contrato como dependência e encerrou com as cinco linhas do blockquote (`Minha visão`, separador, `Próximo passo`, separador e modelo).
2. No segundo turno, uma nova menção explícita recuperou a regra instável, a centralização e a dependência aberta sem pedir recapitulação; a resposta sobre o outro projeto também preservou o blockquote completo.

`wait_threads` entrega um resumo de texto normalizado que pode ocultar os marcadores Markdown `>`; ele fez o fechamento parecer texto corrido em uma leitura inicial. `read_thread` preserva `agentMessage.text` e é a fonte de verdade para avaliar o contrato visual. Os roteiros e o gate agora registram esse método, evitando um falso negativo sem adicionar uma regra especulativa à skill.

## Runtime limitation

O Codex CLI ainda emitiu o aviso local de cache `missing field supports_reasoning_summaries`, mas as sessões efêmeras completaram e geraram respostas. Foram aprovados quatro forward tests sobre a instalação global anterior: (1) uma solicitação de edição sem mudança esperada não alterou arquivo e manteve o fechamento da skill; (2) uma inspeção distinguiu fatos compatíveis de uma preocupação ainda não provada; (3) o caso concreto A/B escolheu a centralização da regra instável e preservou o fechamento; e (4) em uma cópia isolada do repositório, uma edição explicitamente definida alterou somente o título solicitado, verificou o diff e retomou o fechamento da decisão no mesmo tema.

O caso `TWM-M12` não tenta atribuir uma resposta sem a skill carregada à candidata. Ele registra a ausência de nova menção como fronteira de ativação do host e exige uma nova invocação explícita ou um mecanismo do host antes de avaliar o fechamento. O caso `TWM-M13` cobre a promessa positiva da skill pura: quando a pessoa menciona `$think-with-me` novamente, o contrato volta no turno atual sem apagar o contexto da conversa. A sessão local acima confirma esse comportamento no Codex App, mas não prova que outro host manterá a skill ativa sem nova menção.

## Limites

- O gate cobre o contrato visual e semântico, mas uma skill em linguagem natural continua probabilística.
- Uma skill não se recarrega nem supera uma instrução superior do host; continuidade entre turnos depende da seleção do host, de nova menção explícita ou de mecanismo externo compatível.
- A prévia do `skills.sh` pode continuar exibindo um snapshot externo antigo; ela não é a fonte de verdade da instalação pelo CLI.

No implementation commit, push, or publication was made before this evidence record.
