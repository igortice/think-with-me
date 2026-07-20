# Think With Me — publicação no skills.sh

Este documento é um runbook de manutenção. Ele não autoriza nenhuma ação externa por si só.

## O que já está pronto localmente

- A skill instalável está em `skills/think-with-me/SKILL.md`.
- O frontmatter usa o nome da pasta e uma descrição orientada a ativação.
- A licença MIT vive na raiz do repositório, fora da skill instalável.
- `bash scripts/validate-skill.sh` executa a validação portátil do padrão Agent Skills.
- Os casos de comportamento e de ativação ficam em `evals/`.
- Não há `skills.sh.json`: com uma única skill, ele não acrescenta valor.
- O README público explica o valor da skill, mostra os quadros separados de DeepSWE v1.1 e Artificial Analysis, apresenta uma saída curta, declara a compatibilidade com Codex/GPT-5.6 e deixa claro que os rótulos finais acompanham o idioma da conversa.

## Sequência de publicação

1. Rodar a validação estrutural e o gate semântico:

   ```bash
   bash scripts/sync-model-comparison.sh --check
   bash scripts/validate-skill.sh
   bash tests/evidence-gate-v1.sh
   git diff --check
   ```

2. Revisar `skills/think-with-me/references/model-evidence.md` e a comparação portátil `skills/think-with-me/references/model-comparison.md`; exercitar casos representativos de `evals/think-with-me-cases.md`, `evals/think-with-me-multiturn-cases.md`, `evals/model-routing-cases.md` e `evals/trigger-cases.md`, preservar as respostas brutas em `evals/runtime-captures-2026-07-20.md` e registrar os resultados da candidata atual em `evals/evidence-2026-07-20-model-comparison-routing.md`. O registro de 19 de julho permanece histórico e imutável. Em particular, executar `TWM-M12` como limite de ativação do host — uma resposta sem a skill carregada não é resultado da candidata —, `TWM-M13` para confirmar que uma nova menção explícita recupera o contexto e `MR-19` para provar que uma instalação contendo somente o pacote consegue mostrar os dois quadros separados.
3. No Codex App, inspecionar a transcrição bruta `agentMessage.text` retornada por `read_thread`; o resumo normalizado de `wait_threads` pode esconder os marcadores `>` do blockquote.
4. Apresentar o diff local para revisão humana.
5. Fazer commit e push somente após autorização explícita para cada ação.
6. Revisar os arquivos rastreados para remover caminhos pessoais, IDs internos e instruções locais que não devem ser públicos.
7. Tornar o repositório `igortice/think-with-me` público somente após autorização explícita.
8. Conferir o README público e o comando de instalação:

   ```bash
   npx skills add igortice/think-with-me --skill think-with-me -g -a codex
   ```

9. Executar ou pedir uma primeira instalação pública pelo CLI. O skills.sh descobre repositórios por telemetria de instalação; a indexação e a página podem levar alguns minutos por causa do cache.
10. Verificar separadamente a cópia candidata local, repositório GitHub e página do skills.sh. A instalação global é uma quarta superfície de runtime e só deve ser sincronizada após revisão e autorização.
    O gate local pode passar com `GLOBAL_PARITY_STATUS: not-run` e
    `POST_INSTALL_RUNTIME_STATUS: not-run`; esses marcadores são limites
    explícitos, não alegações de publicação. Depois de uma instalação ou
    atualização autorizada, criar um novo registro datado para a paridade
    global e o smoke test pós-instalação, sem reescrever a evidência local.
11. Conferir a página esperada:

   ```text
   https://www.skills.sh/igortice/think-with-me/think-with-me
   ```

    Confirmar que a página individual renderiza a seção `Model quality and cost at a glance`, com as duas tabelas renderizadas na página individual da skill: DeepSWE v1.1 primeiro e Artificial Analysis como perspectiva separada. Verificar também que o recorte continua datado, que o Artificial Analysis não recebe intervalo inventado e que a página não combina as fontes numa nota única.

12. Conferir se auditorias apareceram. Elas são automáticas depois da primeira instalação e podem levar alguns minutos.

## Atualização das tabelas de modelos

`skills/think-with-me/references/model-comparison.md` é a fonte canônica da
comparação pública. Não edite as tabelas do README ou do `SKILL.md`
separadamente.

Os verificadores de dados exigem `jq`; o workflow de CI instala essa
dependência explicitamente.

Quando uma fonte externa mudar:

1. Trate o resultado existente como snapshot histórico imutável; crie um novo
   registro datado e preserve o artefato bruto ou os recortes filtrados com
   hashes.
2. Confira no contrato de atualização o filtro exato do Artificial Analysis,
   as abas usadas, o endpoint bruto do DeepSWE e a distinção entre valores da
   fonte e cálculos derivados.
3. Atualize o bloco canônico, incluindo data, números e cálculos derivados.
4. Sincronize e valide:

   ```bash
   bash scripts/sync-model-comparison.sh
   bash scripts/sync-model-comparison.sh --check
   bash scripts/validate-skill.sh
   bash tests/evidence-gate-v1.sh
   git diff --check
   ```

O sincronizador apenas replica Markdown já revisado. Ele não coleta números
dos sites nem decide se uma metodologia nova continua comparável.

## Depois da publicação

- Mantenha `skills/think-with-me/` como o único artefato instalável.
- Atualize a versão global local apenas depois de revisão e autorização, com `npx skills update -g think-with-me -y` e `bash scripts/verify-global-install.sh`.
- Adicione `skills.sh.json` somente se o repositório passar a ter várias skills e precisar agrupá-las visualmente.
- Use issues e alterações revisadas para evoluir a descrição e os casos de ativação; não altere o comportamento por pressão de métricas de instalação.
