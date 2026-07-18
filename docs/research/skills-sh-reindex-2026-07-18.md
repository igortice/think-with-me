# skills.sh: atualização de snapshot e reindexação

Data: 2026-07-18
Escopo: página pública `igortice/think-with-me/think-with-me` exibindo um `SKILL.md` antigo após a atualização de `main`.

## Conclusão

Não há comando, endpoint ou GitHub Action público para um autor forçar a reindexação de uma skill no `skills.sh`.

A única ação documentada do lado do autor é uma instalação nova via `npx skills add`, pois a descoberta/listagem começa pela telemetria de instalações. `npx skills update` atualiza cópias locais e não é um mecanismo de publicação. Depois de uma instalação recente, o site pode continuar mostrando uma página em cache ou um snapshot anterior; se a divergência persistir, o caminho operacional é abrir uma issue em `vercel-labs/skills` pedindo reindexação.

## Como a atualização realmente funciona

Um `git push` não possui um reindex automático documentado. O fluxo observado e documentado é:

1. `npx skills add` clona ou baixa diretamente a fonte GitHub; por isso ele pode instalar a versão correta mesmo que o catálogo esteja desatualizado.
2. Após a instalação, o CLI tenta enviar telemetria anônima com fonte, skill, caminho de arquivos, agente e timestamp para o serviço da Vercel.
3. O backend agrega instalações de forma deduplicada, atualiza ranking/busca, snapshot/download e página pública em camadas que podem divergir.
4. A página e os endpoints usam cache. A documentação dá 30–60 segundos para busca/ranking e 5 minutos para detalhe, mas não oferece SLA para ingestão, snapshot ou reindexação após um push.

Portanto, `0 installs` não prova que a instalação falhou. A contagem é deduplicada, e a telemetria pode ser suprimida ou falhar silenciosamente sem fazer o CLI falhar. Também não é documentado se uma nova instalação força a recriação de um snapshot já existente.

## Controles verificados em 2026-07-18

- `DISABLE_TELEMETRY` e `DO_NOT_TRACK` não estavam definidos no ambiente.
- O CLI atual usado foi `skills@1.5.19`.
- O GitHub público informou `main` como branch padrão no commit `bb3d96fbcba92f052ce9106822a9d6cf1fbf651a`.
- `npx --yes skills@latest add igortice/think-with-me --list` clonou o repositório e encontrou exatamente uma skill: `think-with-me`.
- `npx --yes skills@latest find think-with-me` ainda não retornou `igortice/think-with-me`; retornou apenas um resultado não relacionado. Isso confirma que o problema também alcança o índice de busca, não somente o HTML da página.

Esses controles descartam os pré-requisitos documentados que estão sob responsabilidade do repositório. Eles não provam a ingestão pelo backend, porque o próprio CLI ignora falhas da chamada de telemetria para não interromper uma instalação.

## Ações que o autor pode fazer

1. Manter a skill em caminho de descoberta (`skills/<nome>/SKILL.md`) com frontmatter válido. O repositório atende esse requisito.
2. Executar uma instalação pública nova usando o CLI atual:

   ```bash
   npx --yes skills@latest add igortice/think-with-me --skill think-with-me -g -a codex -y
   ```

3. Confirmar que a instalação recebeu a fonte esperada:

   ```bash
   bash scripts/verify-global-install.sh
   ```

4. Consultar a página canônica e, quando disponível para o chamador autenticado, o endpoint de detalhe. O detalhe expõe `hash` e `files`, úteis para comparar o snapshot do catálogo com o commit no GitHub.
5. Se o snapshot continuar divergente após o ciclo de cache/indexação, reportar a falha no repositório oficial do CLI.

## Evidência desta investigação

- Em 2026-07-18, `npx --yes skills@latest add igortice/think-with-me --skill think-with-me -g -a codex -y` clonou `https://github.com/igortice/think-with-me.git`, encontrou a skill e concluiu a instalação.
- A checagem posterior retornou `Global think-with-me installation matches the repository source.`
- A página pública ainda mostrava o texto removido `The skill inherits the useful discipline of grilling`, enquanto o `SKILL.md` em `main` não contém essa frase. Portanto, a divergência está no snapshot/indexação do `skills.sh`, não na fonte nem na instalação do CLI.
- `skills.sh.json` não resolve este caso: ele apenas organiza a página de repositório e não altera o conteúdo de `SKILL.md` exibido pelo catálogo.

## Limites conhecidos

- A documentação pública informa cache de 30–60 segundos para leaderboard/busca e de 5 minutos para detalhes, mas não promete quando o backend relê o GitHub nem um SLA de reindexação.
- A telemetria de instalação é best-effort; a instalação pode concluir mesmo se o evento de telemetria falhar.
- Não repetir instalações como tentativa de forçar o índice: isso altera métricas sem garantia documentada de refrescar o snapshot.
- O código do CLI envia telemetria somente quando ela não foi desabilitada e, para GitHub, quando consegue confirmar que o repositório é público. Mesmo assim, o `fetch` é best-effort e falhas são ignoradas.
- A instalação, a busca, o contador, a página e o snapshot são superfícies diferentes. As issues oficiais #1242 e #1682 registram divergências persistentes entre elas após instalações recentes.

## Escalonamento recomendado

Abrir uma issue em [vercel-labs/skills](https://github.com/vercel-labs/skills/issues) com:

- repositório e URL canônica da skill;
- commit `main` esperado e caminho `skills/think-with-me/SKILL.md`;
- confirmação de uma instalação nova com `skills@latest`;
- trecho/URL da página antiga e a diferença para o GitHub;
- pedido explícito para reindexar o repositório/skill e atualizar o snapshot/auditorias, se necessário.

Modelo de título:

```text
[skills.sh] Re-index igortice/think-with-me — stale SKILL.md snapshot
```

## Fontes primárias

- [skills.sh — Customize repo pages](https://www.skills.sh/docs/customize): o catálogo vê alterações após o repositório ser observado pela telemetria e páginas podem ficar em cache; `skills.sh.json` só muda a apresentação.
- [skills.sh — FAQ](https://www.skills.sh/docs/faq): a listagem acontece automaticamente com telemetria após `npx skills add`.
- [skills.sh — API](https://www.skills.sh/docs/api): endpoint de detalhe, campos `hash`/`files` e janelas documentadas de cache.
- [vercel-labs/skills — CLI README](https://github.com/vercel-labs/skills): comandos `add`, `update` e caminhos de descoberta.
- [telemetria do CLI](https://github.com/vercel-labs/skills/blob/main/src/telemetry.ts) e [evento de instalação](https://github.com/vercel-labs/skills/blob/main/src/add.ts#L1743-L1804): a instalação envia telemetria best-effort.
- [Issue #1242](https://github.com/vercel-labs/skills/issues/1242), [Issue #1682](https://github.com/vercel-labs/skills/issues/1682) e [Issue #1711](https://github.com/vercel-labs/skills/issues/1711): precedentes no repositório oficial para divergência de telemetria, snapshot e busca, além de pedidos de indexação/reindexação.
