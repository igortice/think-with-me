# Think With Me — publicação no skills.sh

Este documento é um runbook de manutenção. Ele não autoriza nenhuma ação externa por si só.

## O que já está pronto localmente

- A skill instalável está em `skills/think-with-me/SKILL.md`.
- O frontmatter usa o nome da pasta e uma descrição orientada a ativação.
- A licença MIT vive na raiz do repositório, fora da skill instalável.
- `bash scripts/validate-skill.sh` executa a validação portátil do padrão Agent Skills.
- Os casos de comportamento e de ativação ficam em `evals/`.
- Não há `skills.js` nem `skills.sh.json`: o catálogo é alimentado pelo
  repositório e, com uma única skill, um manifesto de agrupamento não acrescenta
  valor.
- O README público explica o valor da skill, mostra a matriz simples de uso e
  os dados cruzados sem combinar os benchmarks. O `SKILL.md` instalável mantém
  apenas o resumo normativo de roteamento; preços e benchmarks são carregados
  progressivamente pela referência `model-comparison.md` quando necessários.

## Sequência de publicação

1. Rodar a validação estrutural e o gate semântico:

   ```bash
   bash scripts/sync-model-comparison.sh --check
   bash scripts/validate-skill.sh
   bash tests/evidence-gate-v1.sh
   git diff --check
   ```

2. Revisar a política atual em `skills/think-with-me/references/model-evidence.md`, o snapshot histórico imutável em `skills/think-with-me/references/model-evidence-2026-07-20.md` e a matriz atual `skills/think-with-me/references/model-comparison.md`; exercitar casos representativos de `evals/think-with-me-cases.md`, `evals/think-with-me-multiturn-cases.md`, `evals/model-routing-cases.md` e `evals/trigger-cases.md`. O ciclo anterior preservado em `evals/runtime-captures-2026-07-20.md` e `evals/evidence-2026-07-20-model-comparison-routing.md` permanece histórico e imutável. Para a candidata atual, usar `evals/evidence-2026-08-14-progressive-disclosure.md` e `evals/install-2026-08-14-progressive-disclosure.md`; os registros de 31 de julho também permanecem históricos. Em particular, executar `TWM-M12` como limite de ativação do host — uma resposta sem a skill carregada não é resultado da candidata —, `TWM-M13` para confirmar que uma nova menção explícita recupera o contexto, `MR-19` para provar que uma instalação contendo somente o pacote consegue mostrar a matriz local e `MR-20` a `MR-32` mais `TWM-M17` e `TWM-M18` para validar os seis pares e o limite de controle do host.
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
    Para a candidata conversacional de 20 de julho, o registro histórico é
    `evals/install-2026-07-20-conversational-routing.md`. Para a candidata atual,
    preserve `evals/install-2026-08-14-progressive-disclosure.md` como registro
    fechado; em candidatas futuras, crie outro registro datado e confirme a
    paridade global mais os smoke tests das rotas de valor, velocidade,
    julgamento, execução e risco, sem transformar o registro de evidência local
    em alegação pós-instalação.
11. Conferir a página esperada:

   ```text
   https://www.skills.sh/igortice/think-with-me/think-with-me
   ```

    Verificar as superfícies sem exigir conteúdo idêntico: o README do GitHub
    renderiza `Which model should I use?` e `Cross-checked data`; a página
    individual do skills.sh, derivada do `SKILL.md`, renderiza o resumo
    `Which model should I use?` e não renderiza `Cross-checked data`. Na
    referência instalada, confirmar que a comparação completa continua datada,
    identifica o overlay de preços de Luna e Terra, mantém ausentes os valores
    de Artificial Analysis não capturados e não combina os dois benchmarks em
    uma nota única.

12. Conferir se auditorias apareceram. Elas são automáticas depois da primeira instalação e podem levar alguns minutos.

## Atualização das tabelas de modelos

`skills/think-with-me/references/model-comparison.md` é a fonte canônica. O
sincronizador produz duas projeções: a comparação completa no README público e
somente o resumo normativo de roteamento no `SKILL.md`. Não edite essas
projeções separadamente.

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

O sincronizador apenas projeta Markdown já revisado. Ele não coleta números
dos sites, não decide se uma metodologia nova continua comparável e não envia
alterações ao GitHub ou ao skills.sh.

## Depois da publicação

- Mantenha `skills/think-with-me/` como o único artefato instalável.
- Atualize a versão global local apenas depois de revisão e autorização, com `npx skills update -g think-with-me -y` e `bash scripts/verify-global-install.sh`.
- Adicione `skills.sh.json` somente se o repositório passar a ter várias skills e precisar agrupá-las visualmente.
- Use issues e alterações revisadas para evoluir a descrição e os casos de ativação; não altere o comportamento por pressão de métricas de instalação.
