# Evidence-Based Model Routing

Recommend exactly one model and effort for the next step that has already been written. The recommendation diagnoses the remaining work and the conversation's ability to converge; it is not a generic label for the whole conversation or a prediction of a future phase.

## Start from the quality contract

Form the view and exactly one next step before routing. Then decide whether that step requires the quality-preserving contract for contextual judgment or qualifies for a deliberately bounded economic contract.

GPT-5.5 High is the historical quality baseline supplied by the user's experience. It is a reference for expected conversational quality, not a configuration recommended by this policy. Sol High is the conservative quality floor for unresolved contextual judgment, including open understanding, comparison with real trade-offs, planning, specification, source integration, professional decisions, and long-horizon technical work. When domain-matched evidence is insufficient or conflicting, preserve that floor rather than infer equivalence from a lower price or a different benchmark.

## Treat family and effort as one atomic configuration

Treat family and effort as one atomic configuration. Evaluate pairs such as `Sol High` and `Luna Medium` directly; do not select a family first and adjust its effort afterward. Efforts with the same name are not presumed equivalent across families, and a family's official positioning is a prior rather than evidence that a particular pair meets this skill's quality contract.

The output is one configuration for the written next step. It must remain compatible with the compact footer contract and must not expose a catalog of alternatives.

## Apply the current policy snapshot

Apply these five policy states from the dated evidence snapshot:

- Sustained quality floor: `Sol High` for unresolved contextual judgment and every case without sufficient domain-matched evidence to reduce.
- Selective depth: `Sol XHigh` for material residual ambiguity or difficult cross-cutting judgment; `Sol Max` only behind the explicit deepest-reasoning gate.
- Value candidate, not baseline-equivalent: `Sol Medium` for low-risk bounded analysis only when material economy pressure and cheap verification justify a local, provisional choice.
- Provisional bounded-volume route: `Luna Medium` for mechanical transformation after the direction is closed, subject to the boundedness and verification gates below.
- No preferred route: Terra has no preferred route in the current evidence snapshot.

These states are configuration-specific. Do not create a route merely to represent every family, and do not describe an economic candidate as equivalent to the historical baseline.

## Escalate selectively

Use `Sol XHigh` when the next step still requires judgment and concrete evidence identifies material residual ambiguity, such as cross-cutting constraints, unresolved tension between relevant sources, repeated framing corrections, or a difficult-to-detect failure involving security, authorization, integrity, concurrency, or irreversible change. Evident risk can justify selective depth immediately; do not wait for a failed response.

Use `Sol Max` only when the remaining problem is unusually difficult and bounded, and the user explicitly requests the deepest available reasoning or concrete evidence shows that the preceding depth did not resolve the material ambiguity. Importance, urgency, novelty, or frustration alone does not pass this gate.

## Use economy only for bounded work

An economic route is eligible only after the quality contract has filtered out configurations that do not meet the required floor. The work must be bounded, low risk, cheap to verify or reverse, and subject to material cost, latency, or volume pressure. A short or already accepted direction does not by itself justify reducing quality while substantive judgment remains.

`Sol Medium` is a non-equivalent value candidate for bounded, low-risk analysis whose result can be checked cheaply. Its cross-source evidence is conflicting, so any use remains domain-specific and provisional rather than a new default.

`Luna Medium` is a provisional route only for mechanical transformation, classification, extraction, or condensation at material volume when the direction is closed, no substantive decision is hidden, the output has a verifiable format, and an individual failure has low impact. Record the local reason for boundedness, volume pressure, cheap verification, retries, and total task cost. Do not generalize it to open conversation before local synthesis evidence establishes the required quality.

## Handle uncertainty and conflicting evidence

Keep each claim inside the domain, harness, metric, and uncertainty of its source. Official facts establish positioning, availability, effort support, and price; independent benchmarks compare configurations only in their declared harnesses; local behavioral results measure this skill's actual workload; explicit user outcomes define the historical acceptance baseline.

Do not average heterogeneous benchmarks or combine their scores into a universal ranking. An overlapping confidence interval in the same domain and harness is a practical tie, not proof of superiority. When relevant sources conflict, keep the disagreement visible and preserve `Sol High` until comparable local evidence resolves it. A coding benchmark does not establish Portuguese conversational quality, and a result from one agent harness does not automatically transfer to another.

## Compare total task cost after quality

First eliminate configurations that lack sufficient evidence for the quality contract. Only then compare total task cost among the eligible candidates, treating a statistically unresolved result in the same domain and harness as a practical tie when appropriate.

Use end-to-end cost, success rate, retries, token use, latency, and agent steps when available. Per-token price alone is not total task cost. Cost per successful result may be recorded as a domain-specific approximation when the same harness supplies both mean task cost and success rate; never calculate it across heterogeneous benchmarks or let it replace quality inspection.

## Apply conversation health without waiting for failure

Re-evaluate the recommendation whenever the conversation changes material phase: a new ambiguity, an irreversible or high-impact constraint, a truly bounded transformation, or material cost, latency, or volume pressure. Conversation health modifies next-step fit only after the quality floor has been applied.

Normal progress and an accepted direction do not automatically reduce the configuration. Repeated corrections may justify greater depth only when material judgment remains; more effort on the same wrong framing is not progress. Frustration and urgency without new ambiguity or risk call for clearer communication, not automatic escalation.

Never infer the active model from unavailable host state. Use model or effort history only when the user or host explicitly provides it, and treat reported outcomes as evidence rather than a command to preserve or replace a configuration.

## Render exactly one recommendation

Keep the closing in the user's language and preserve the output contract's order: localized view, localized next step, then one compact model line. The model line must be one physical Markdown line with an inline-code label containing exactly one atomic configuration, followed by ` · ` and a short reason tied to the concrete next step and decisive conversational evidence.

Valid policy-consistent examples:

```md
> `Sol High` · fechar o trade-off de ownership ainda em aberto.
> `Sol XHigh` · reconciliar as restrições transversais ainda ambíguas.
> `Luna Medium` · extrair o schema fechado em volume com validação automática.
> `Sol High` · resolve the remaining ownership trade-off in the user's language.
```

The reason must not name another model or effort, predict a transition, list alternatives, or add a second physical line. Recalculate the recommendation from the written next step on every response; stable evidence may legitimately produce the same configuration.

## Factual basis and review date

Last reviewed: 2026-07-19.

The versioned factual basis is [Model Evidence Snapshot](model-evidence.md). It records official OpenAI positioning, effort support, and price; the dated Artificial Analysis and DeepSWE results in their separate domains and harnesses; the explicit user baseline; local evidence status; uncertainty; limitations; and the policy decision each source can support. Revisit the policy states when a new dated record resolves a relevant limitation or changes the set of quality-eligible configurations.
