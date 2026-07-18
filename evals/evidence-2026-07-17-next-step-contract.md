# Evidência — contrato de próximo passo

## Candidato local

- Data: 2026-07-17
- Base commit: `00a6c312b322bb133e8c145628fdbede8c0884be`
- `PACKAGE_SHA256` final: `7534339ab6d7b049fdbb9c63f42da0c765f67e99072b582f022586a6f26f7c34`
- `CANDIDATE_ID` antes da atualização final deste registro: `2d09c7eb2546792d0f4dc98418ce33539e8fd63a6b19d184d57987652c0927ea`
- Fonte: `skills/think-with-me/`, carregada explicitamente em tasks novas.

## Red comportamental encontrado

Duas execuções independentes confirmaram os três rótulos e o modelo curto, mas mostraram que `Próximo passo` ainda podia agrupar várias ações. O contrato foi endurecido para exigir uma única dependência imediata, nunca sequência, checklist ou pacote de ações. Esses resultados não liberam o candidato.

## TWM-04, TWM-M03 e continuação aprovada

- Execução de avaliação: cenário de continuidade.
- Turno inicial: escolha entre centralizar uma regra instável e distribuí-la entre três serviços.
- Follow-up: “Por que você não escolheria distribuir desde já?”
- Continuação: “Confirmo centralizar. O que fazemos agora?”

| Invariante | Resultado | Evidência |
| --- | --- | --- |
| Resposta ao assunto | pass | A resposta explicou o custo de divergência antes de concluir por centralização. |
| `Minha visão` | pass | Uma única direção declarativa foi preservada nos três turnos. |
| `Próximo passo` | pass | Cada turno avançou somente uma dependência: critério de maturidade, variação real por domínio e contrato de responsabilidade. |
| Decisão humana | pass | A resposta recomendada apareceu junto de exatamente uma pergunta focada. |
| `Modelo` | pass | A linha final foi somente `Terra High.` em todos os turnos. |
| Markdown | pass | `read_thread` confirmou os três rótulos literais em negrito e parágrafos separados. |
| Relevância | pass | Nenhuma pendência de repositório ou processo interno apareceu. |

## TWM-06 — risco crítico

- Execução de avaliação: cenário de risco crítico.
- Prompt: migração irreversível com risco de corrupção e restore ainda não comprovado.

| Invariante | Resultado | Evidência |
| --- | --- | --- |
| `Minha visão` | pass | Bloqueou a migração até existir evidência prática de recuperação. |
| `Próximo passo` | pass | Indicou uma dependência imediata: executar um teste completo de restore em ambiente isolado. |
| Recomendação e pergunta | pass | Tratou a ausência do teste como bloqueio e perguntou somente se ele podia ser realizado sem tocar na produção. |
| `Modelo` | pass | A linha final foi somente `Sol High.` |
| Markdown e relevância | pass | Os três campos estavam separados; nenhum assunto interno irrelevante apareceu. |

## Veredito local

- Resultado: **pass** depois da correção comportamental.

## Forward-test da instalação global

- Paridade: `bash scripts/verify-global-install.sh` confirmou igualdade dos quatro arquivos entre a fonte e `<global-skills>/think-with-me/`.
- Execução de avaliação: cenário global final.
- Invocação: `$think-with-me`, sem instrução para carregar a fonte do repositório.
- Resultado: **pass**. A resposta recomendou centralização, colocou uma única decisão imediata em `Próximo passo`, incluiu a resposta recomendada e uma pergunta, não vazou processo interno e terminou somente com `**Modelo:** Terra High.`

## Correção visual — blockquote contínuo

- Execução de avaliação: cenário local de layout.
- Motivo: o usuário pediu a barra vertical visível ao lado dos três campos finais.
- Resultado: **pass**. A transcrição detalhada contém literalmente `> **Minha visão:**`, uma linha `>` de separação, `> **Próximo passo:**`, outra linha `>` e `> **Modelo:** Terra High.`. Os três campos pertencem ao mesmo blockquote; o corpo normal não foi incluído na barra.

## Correção de pergunta duplicada e teste global final

- Uma execução global confirmou a barra, mas formulou a mesma decisão com duas perguntas. Esse resultado não liberou o candidato.
- O contrato passou a proibir pergunta seguida de nova confirmação e limita `Próximo passo` a um único `?`.
- Uma execução local confirmou blockquote contínuo, uma dependência, resposta recomendada e uma única pergunta.
- Depois da sincronização e da paridade confirmada, uma execução global passou por invocação normal de `$think-with-me`: os três campos estavam no mesmo blockquote, `Próximo passo` tinha uma recomendação e somente uma pergunta, e `Modelo` continha apenas `Terra High.`

## Veredito final

- Resultado: **pass** para contrato estático, comportamento local, continuidade, risco crítico, blockquote contínuo, pergunta única, paridade global e invocação global final.
- Nenhum commit, push ou publicação foi realizado.
