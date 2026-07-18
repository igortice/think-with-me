# Evidência — simplificação conversacional

> **Histórico e substituído:** este registro valida o contrato anterior de dois campos. Ele não comprova o contrato atual `Minha visão` / `Próximo passo` / `Modelo`; consulte a evidência mais recente para o comportamento vigente.

## Candidato

- Data: 2026-07-17
- Base commit: `00a6c312b322bb133e8c145628fdbede8c0884be`
- `PACKAGE_SHA256`: `67380c39692ec120c65f7e60778384fb5622526fee72c3eb0811d06e2f6a8488`
- `CANDIDATE_ID` antes da inclusão deste registro: `db59582ed5cbf6687cf91198dc7713c16465f8fd78a6566e86c4cde15f3f1f99`
- Fonte: `skills/think-with-me/`, carregada explicitamente; cópia global ignorada.

## TWM-03 e TWM-M03 — decisão comum e follow-up

- Execução de avaliação: cenário independente A.
- Prompt inicial: comparar centralização de uma regra imatura com distribuição imediata entre três serviços.
- Follow-up: “Por que você não escolheria distribuir desde já?”

| Invariante | Resultado | Evidência |
| --- | --- | --- |
| Contexto antes do fechamento | pass | A resposta explicou divergência, domínio e reversibilidade antes de concluir. |
| Ponto de vista único e declarativo | pass | Recomendou centralizar; não havia pergunta no campo final. |
| Modelo único e contextual | pass | GPT-5.6 Terra High, condicional, com razão ligada à comparação arquitetural. |
| Continuidade | pass | O follow-up preservou a direção e respondeu diretamente. |
| Relevância | pass | Nenhum assunto de versionamento, distribuição da skill ou estado interno apareceu. |
| Markdown visual | pass | Os dois campos apareceram em negrito e em parágrafos separados na transcrição detalhada. |

## TWM-06 — risco crítico

- Execução de avaliação: cenário independente B.
- Prompt: migração irreversível em produção com risco de corrupção de dados.

| Invariante | Resultado | Evidência |
| --- | --- | --- |
| Contexto antes do fechamento | pass | A resposta tratou ensaio, restauração, integridade e critério de abortar. |
| Pergunta fora do ponto de vista | pass | A pergunta de recuperação apareceu antes do fechamento. |
| Ponto de vista único e declarativo | pass | Recomendou não avançar antes de reduzir ou controlar a irreversibilidade. |
| Modelo único e contextual | pass | GPT-5.6 Sol High, condicional, devido ao risco crítico de integridade. |
| Markdown visual | pass | Os dois campos apareceram em negrito e em parágrafos separados. |

## Observação do monitor

O resumo compacto de `wait_threads` removeu a marcação Markdown e produziu a impressão de um falso negativo. A leitura detalhada com `read_thread` preservou os asteriscos e confirmou o passe visual. Para futuras avaliações, o artefato autoritativo é a transcrição detalhada.

## Forward-test da instalação global

- Execução de avaliação: cenário de instalação global.
- Invocação: `$think-with-me`, sem instrução para ler a fonte do repositório.
- Paridade: `bash scripts/verify-global-install.sh` confirmou que os quatro arquivos globais correspondem à fonte local; `SKILL.md` teve o mesmo SHA-256 nos dois locais.
- Resultado: **pass**. A resposta centralizou a regra imatura, não vazou processos internos e terminou com `Meu ponto de vista` e `Modelo para continuar` em Markdown, recomendando GPT-5.6 Terra High.

## Veredito

- Resultado: **pass** para os três comportamentos executados.
- Limite histórico: estes resultados foram registrados em etapas diferentes da simplificação e não representam o estado final da instalação. A evidência vigente, incluindo a paridade e o forward-test global, está em `evidence-2026-07-17-next-step-contract.md`.
