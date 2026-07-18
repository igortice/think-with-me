# Think With Me — evidência de recomendação contextual para o próximo passo

**Data:** 18 de julho de 2026
**Escopo:** validação RED-GREEN da recomendação de exatamente um modelo e
esforço depois de formular `Minha visão` e `Próximo passo`.

## Candidato

- `PACKAGE_SHA256`: `64cb4bc8b11d51430d70b08425f1fb756a8817574a8d376ef76663e041f3eb10`
- `CANDIDATE_ID` antes desta atualização do registro: `e5eca66f3d77516908ec894a03d7bdb8d9588a101ec0c41abbb34c5f8b8ae5c2`
- Fonte: `skills/think-with-me/`
- Instalação testada: `/Users/igortice/.agents/skills/think-with-me/`

## Cenário

A fixture informou que a conversa começou em Terra High, não convergiu, passou
para Max, recebeu novas correções e depois chegou a Sol High. O usuário explicou
que a recomendação deveria considerar o que funcionou, o atrito e o próximo
passo, e perguntou qual modelo usar para fechar corretamente a regra.

Invariantes avaliados:

1. `Minha visão` aparece antes de um único `Próximo passo`.
2. O rodapé recomenda exatamente uma família e esforço para esse próximo passo.
3. A justificativa combina o trabalho concreto com evidências de convergência.
4. A resposta não inventa o modelo ativo.
5. O rodapé não contém `agora`, `depois`, `now`, `later`, seta, HTML,
   alternativa ou previsão futura.
6. A justificativa não nomeia outra família ou esforço.

## RED observado

Cinco agentes em contextos independentes leram a fonte rejeitada anterior à
correção e responderam à mesma fixture. Resultado: **0/5** cumpriram o novo
contrato completo.

- Três encerraram com a razão genérica `(fechar)`.
- Uma encerrou com `Modelo: Sol High agora (fechar)`.
- Uma voltou ao formato `Sol High agora → Luna Medium depois`.
- Nenhuma usou o campo `Modelo para o próximo passo` com uma razão concreta
  derivada do trabalho e da falta de convergência.

O gate estático também falhou antes da mudança com:

```text
FAIL: missing text in skills/think-with-me/SKILL.md: _Modelo para o próximo passo:
```

## Forward test passed

A correção foi refinada em três rodadas independentes contra a mesma fixture:

1. A primeira rodada ficou em **4/5** sob a leitura literal da especificação:
   uma justificativa usou `agora`, embora não previsse outra fase.
2. Depois de proibir `agora`, `depois`, `now`, `later`, setas e HTML, a segunda
   rodada ficou em **4/5**: uma justificativa recomendou Sol High, mas também
   nomeou Terra High e Max ao descrever o histórico.
3. Depois de exigir que o histórico seja resumido como evidência de conversa,
   sem nomear outra família ou esforço no rodapé, cinco novos agentes passaram.

Resultado final: **5/5** cumpriram todos os invariantes.

Resultado representativo observado:

```md
> **Minha visão:** a regra deve recomendar um único modelo com base no próximo passo concreto e na capacidade observada de a conversa convergir, sem antecipar fases futuras.
>
> **Próximo passo:** consolidar a redação final da regra preservando esse contrato sem ambiguidades.
>
> _Modelo para o próximo passo: **Sol High** — integrar as correções repetidas e fechar a regra sem reintroduzir ambiguidade._
```

Nas cinco amostras, a recomendação foi `Sol High` porque o próximo passo ainda
exigia integrar correções repetidas em um contrato preciso. Nenhuma amostra
listou um segundo modelo, nomeou outro esforço na justificativa, previu uma fase
futura ou escalou apenas por importância.

Uma matriz suplementar com cinco contextos diferentes também passou:

- progresso normal em trade-off comum recomendou `Terra High`;
- frustração isolada não provocou escalada e recomendou `Terra High`;
- ausência de modelo ativo conhecido não produziu inferência de runtime;
- síntese em alto volume com custo e latência materiais recomendou `Luna Medium`;
- resumo jurídico único, sem pressão de custo/latência/volume e com nuance
  profissional dominante, recomendou `Sol High`, não Luna por inércia.

## Validação estática e paridade

- `UV_CACHE_DIR=.cache/uv UV_TOOL_DIR=.cache/uv-tools XDG_DATA_HOME=.cache/xdg bash scripts/validate-structure.sh` retornou `Structural validation passed.`
- `bash scripts/verify-global-install.sh` retornou `Global think-with-me installation matches the repository source.`
- O SHA-256 de `SKILL.md` foi `d1550b65097d3431b4fbee20778977a4267f7c2a3158b0f8abae82f0ceb1a065` tanto na fonte quanto na instalação global.
- O gate rejeitou fixtures negativas com `Agora`, setas ASCII e símbolos
  Unicode (incluindo setas emoji), HTML,
  `Sol High / Max`, razão vazia e outra família ou esforço dentro da
  justificativa, inclusive em caixa diferente.
- `git diff --check` não encontrou erro de espaço em branco.

## Limites

- Skills em linguagem natural não são determinísticas; as cinco repetições
  finais e a matriz de cinco contextos reduzem o risco, mas não provam todas as
  conversas.
- O teste usa apenas trajetórias de modelo explicitamente informadas. A skill
  continua proibida de inventar o modelo ativo quando o host não o fornece.
- A seleção do modelo no Codex continua sendo uma ação do usuário ou do host; a
  skill apenas recomenda o modelo para o próximo passo.

No implementation commit, push, or publication was made before this evidence record.
