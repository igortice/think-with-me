# Think With Me — publicação no skills.sh

Este documento é um runbook de manutenção. Ele não autoriza nenhuma ação externa por si só.

## O que já está pronto localmente

- A skill instalável está em `skills/think-with-me/SKILL.md`.
- O frontmatter usa o nome da pasta e uma descrição orientada a ativação.
- A licença MIT vive na raiz do repositório, fora da skill instalável.
- `bash scripts/validate-skill.sh` executa a validação portátil do padrão Agent Skills.
- Os casos de comportamento e de ativação ficam em `evals/`.
- Não há `skills.sh.json`: com uma única skill, ele não acrescenta valor.
- O README público explica o valor da skill, mostra uma saída curta, declara a compatibilidade com Codex/GPT-5.6 e deixa claro que os rótulos finais acompanham o idioma da conversa.

## Sequência de publicação

1. Rodar a validação estrutural e o gate semântico:

   ```bash
   bash scripts/validate-skill.sh
   bash tests/evidence-gate-v1.sh
   git diff --check
   ```

2. Exercitar casos representativos de `evals/think-with-me-cases.md`, `evals/think-with-me-multiturn-cases.md` e `evals/trigger-cases.md`. Em particular, executar `TWM-M12` como limite de ativação do host — uma resposta sem a skill carregada não é resultado da candidata — e `TWM-M13` para confirmar que uma nova menção explícita recupera o contexto.
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
11. Conferir a página esperada:

   ```text
   https://www.skills.sh/igortice/think-with-me/think-with-me
   ```

12. Conferir se auditorias apareceram. Elas são automáticas depois da primeira instalação e podem levar alguns minutos.

## Depois da publicação

- Mantenha `skills/think-with-me/` como o único artefato instalável.
- Atualize a versão global local apenas depois de revisão e autorização, com `npx skills update -g think-with-me -y` e `bash scripts/verify-global-install.sh`.
- Adicione `skills.sh.json` somente se o repositório passar a ter várias skills e precisar agrupá-las visualmente.
- Use issues e alterações revisadas para evoluir a descrição e os casos de ativação; não altere o comportamento por pressão de métricas de instalação.
