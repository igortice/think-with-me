# Current Strong-Model Policy Evidence

Policy review date: **2026-07-30**.

This file records the current evidence boundary for Think With Me. The routing
contract itself is [Evidence-Based Model Routing](model-routing.md). Historical
benchmarks remain available in the
[Historical model evidence snapshot — 2026-07-20](model-evidence-2026-07-20.md)
and the [portable comparison](model-comparison.md); neither historical source
can authorize a configuration outside the current policy.

## Current policy authority

Every recommendation uses exactly one of these atomic pairs: `Sol Medium`,
`Sol High`, `Sol XHigh`, `Sol Max`, `Terra Max`, and `Luna Max`.

All other family and effort combinations are ineligible for recommendation by
this skill. Benchmark rows may remain visible for historical comparison, but
visibility is not eligibility.

The user-defined quality contract controls the current roles:

- Sol covers project conversation, architecture, professional judgment,
  residual ambiguity, and maximum-depth critical gates from Medium through Max.
- Terra Max covers heterogeneous agent execution, tool-heavy coordination, and
  heavy multi-step processing after the decision contract is defined.
- Luna Max covers homogeneous high-volume transformation only when the schema
  is fixed, items are independent, and automatic validation is cheap.

## Current official pricing

The current OpenAI Standard API prices are US$5/30 per 1M input/output tokens
for Sol, US$2/12 for Terra, and US$0.20/1.20 for Luna. These values come from
the [official OpenAI pricing table](https://developers.openai.com/api/docs/pricing).

Per-token price is not total task cost. Reasoning tokens, retries, tool steps,
latency, verification, and successful completion remain part of any economic
comparison. A lower price never weakens the quality requirement.

## Evidence limits

Artificial Analysis and DeepSWE measure different domains and harnesses. Their
scores are not averaged, and neither proves Portuguese conversational quality
or universal model equivalence. Current routing therefore combines:

1. the explicit six-pair quality floor chosen by the user;
2. the observable shape of the immediate next step;
3. source-scoped benchmark evidence when the task actually matches the source;
4. fresh local runtime evidence before publication.

The skill recommends a pair; it cannot select, retry, replace, or verify the
host's active model. When the host exposes a mismatch, the response reports it
without presenting an unapproved replacement as compliant.
