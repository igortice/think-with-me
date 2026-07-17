# Think With Me — publicação no skills.sh

Este documento é um runbook de manutenção. Ele não autoriza nenhuma ação externa por si só.

## O que já está pronto localmente

- A skill instalável está em `skills/think-with-me/SKILL.md`.
- O frontmatter usa o nome da pasta e uma descrição orientada a ativação.
- A licença MIT vive na raiz do repositório, fora da skill instalável.
- `bash scripts/validate-skill.sh` executa a validação portátil do padrão Agent Skills.
- Os casos de comportamento e de ativação ficam em `evals/`.
- Não há `skills.sh.json`: com uma única skill, ele não acrescenta valor.

## Sequência de publicação

1. Rodar `bash scripts/validate-skill.sh` e a validação estrutural do Codex quando disponível.
2. Exercitar casos representativos de `evals/think-with-me-cases.md` e `evals/trigger-cases.md`.
3. Apresentar o diff local para revisão humana.
4. Fazer commit e push somente após autorização explícita para cada ação.
5. Tornar o repositório `igortice/think-with-me` público somente após autorização explícita.
6. Conferir o README público e o comando de instalação:

   ```bash
   npx skills add igortice/think-with-me --skill think-with-me
   ```

7. Executar ou pedir uma primeira instalação pública pelo CLI. O skills.sh descobre repositórios por telemetria de instalação; a indexação e a página podem levar alguns minutos por causa do cache.
8. Conferir a página esperada:

   ```text
   https://www.skills.sh/igortice/think-with-me/think-with-me
   ```

9. Conferir se auditorias apareceram. Elas são automáticas depois da primeira instalação e podem levar alguns minutos.

## Depois da publicação

- Mantenha `skills/think-with-me/` como o único artefato instalável.
- Atualize a versão global local apenas depois de revisão e autorização, com `npx skills update -g think-with-me -y` e `bash scripts/verify-global-install.sh`.
- Adicione `skills.sh.json` somente se o repositório passar a ter várias skills e precisar agrupá-las visualmente.
- Use issues e alterações revisadas para evoluir a descrição e os casos de ativação; não altere o comportamento por pressão de métricas de instalação.
