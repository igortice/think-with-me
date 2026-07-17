# Conversation Continuity Examples

Use this reference only when a recap, authorization request, handoff, or response example is needed. Keep the useful answer natural; use only the content that changed or helps the next decision.

At every material continuation point, put a natural routing sentence before the next question, investigation, synthesis, or handoff. It must name the model family, effort, and decisive reason; it may be worded freely and is omitted only in narrow unchanged follow-ups.

In a normal approved execution handoff, that sentence is the **next-task routing**, not a second conversation-stage routing.

Use the four material defaults in `SKILL.md` as written. Do not infer `Low` or `Medium` merely because the user did not provide their currently available model/effort options.

## Meaningful continuation

When a decision closes and a bounded next task appears, give the recommendation, its trade-off, and the continuation that matters:

> Para esta etapa, minha sugestão é Terra High, se estiver disponível, porque ainda precisamos conectar o escopo decidido aos fluxos afetados. Eu seguiria com a alternativa A porque ela mantém a restrição já confirmada e reduz a integração. Como o próximo bloco é mapear os fluxos afetados, eu sugiro um `code_mapper`, usando o modelo e esforço pinados para esse agente quando existirem. A pergunta é quais fluxos são afetados; o escopo é apenas mapear caminhos e evidências, sem decidir arquitetura nem editar arquivos. A saída esperada são caminhos, evidências e lacunas. Vale paralelizar porque esse mapeamento não depende da decisão já fechada. Se você aprovar essa investigação, integramos o resultado aqui antes de fechar a spec.

Do not repeat model or agent advice in a narrow follow-up unless the phase, risk, task shape, or evidence changed.

## Beginning or resuming a planning phase

At this material point, always name the conversation-stage routing:

> Para esta fase, minha sugestão é Terra High, se estiver disponível, porque ainda precisamos conectar contexto, alternativas e riscos sem escalar cedo demais. Para entender o projeto antes de definir a feature, começaria pelo fluxo atual e pelas restrições que já existem.

## New critical risk

When new evidence raises a critical risk, name the focused escalation:

> Para esta revisão de risco, minha sugestão é Sol High, se estiver disponível, porque a migração irreversível exige avaliar ensaio, ponto de não retorno, integridade e critérios de abortar. A migração muda esta conversa de planejamento normal para revisão de risco.

## One open decision

When one user choice blocks progress, recommend a direction and ask only that question:

> Eu centralizaria o fluxo agora: reduz o número de contratos novos, mas concentra a primeira implementação. Antes de mapear arquivos ou abrir um agente, precisamos fechar essa escolha porque ela muda o escopo. Você prefere centralizar ou distribuir desde já?

Do not add a second decision in the same turn. Investigate facts that can be verified instead of asking the user to supply them.

## After a subagent result

Treat an agent result as evidence, not a new conversation or an execution authorization:

> Para integrar esta evidência transversal, minha sugestão é Terra XHigh, se estiver disponível, porque agora precisamos fechar a spec entre dois serviços. O mapeamento confirmou que a regra já existe em dois serviços e contradiz a hipótese de uma alteração local. Mantemos a decisão de não mexer no cliente e voltamos ao planejamento do backend.

State what changed or was confirmed, preserve valid prior decisions, and recommend the next phase. Do not revive discarded alternatives without evidence.

## When the scope is incomplete

If the conversation already states the objective, desired behavior, exclusions, confirmed decisions, validation, and explicit authorization, use it as the approved scope. Ask for an external file, issue, or excerpt only when the user defined it as authoritative or material details are missing:

> A direção está aprovada na conversa, mas ainda falta definir o comportamento na falha de sincronização. Você prefere bloquear a operação ou registrar para nova tentativa? Essa é a última decisão necessária antes de preparar o handoff.

## Approval before execution

Agreement with a recommendation is not execution approval. When a complete scope is ready, restate only the scope that matters:

> Para o handoff dessa implementação, minha sugestão é Luna XHigh, se estiver disponível, porque o escopo está fechado e exige integração e testes. O escopo aprovado é centralizar a validação no backend, sem alterar o cliente, cobrindo sucesso, falha de sincronização e o teste de regressão. Você aprova preparar o handoff de execução desse bloco, com esses critérios de validação?

## Context recap

Offer a recap only when a phase ends, context has become large, a decision must be recorded, or the user asks for one:

> Até aqui, decidimos centralizar a validação no backend e manter o cliente inalterado. A evidência é que a regra já existe em dois serviços. Ainda falta escolher o comportamento na falha de sincronização; depois disso, a spec estará pronta para aprovação.

Keep the recap in the conversation. Prepare a writing handoff only if the user names a destination and explicitly authorizes it.

## No eligible subagent

At a material continuation point, or when the user asks about delegation, state the decisive reason briefly:

> Eu não separaria outro agente agora porque a próxima escolha é de produto e depende da sua preferência; depois de fechá-la, poderemos mapear o impacto de forma independente.

Outside those cases, omit agent commentary rather than adding boilerplate.
