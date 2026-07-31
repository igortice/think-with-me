# Model Matrix

Last reviewed: **2026-07-31**.

## Which model should I use?

| Situation | Model |
| --- | --- |
| Ordinary conversation, project understanding, research, or reversible analysis when extra startup delay is acceptable | `Luna Max` |
| Fast interactive conversation or rapid context recovery | `Sol Medium` |
| Architecture, technical specification, or professional judgment | `Sol High` |
| Quality-first agents, tools, or interdependent execution with a closed contract | `Terra Max` |
| Residual ambiguity, conflicting constraints, or hard-to-detect risk | `Sol XHigh` |
| A bounded critical problem still unresolved after `Sol XHigh` | `Sol Max` |

## Cross-checked data

| Model | DeepSWE Pass@1 | DeepSWE trajectory cost after price overlay | AA Intelligence Index v4.1 | AA time to first answer |
| --- | ---: | ---: | ---: | ---: |
| Sol Max | 72.67% | $8.39 | — | — |
| Sol XHigh | 70.73% | $4.70 | — | — |
| Terra Max | 69.62% | $3.96 | 54.95 | 152.99 s |
| Sol High | 69.40% | $3.47 | 55.87 | 13.25 s |
| Luna Max | 67.19% | $0.61 | 51.24 | 117.02 s |
| Sol Medium | 61.06% | $1.86 | 53.59 | 4.31 s |

Luna Max and Terra Max costs apply the documented 31 July price overlay to
preserved DeepSWE trajectories; this is not a new benchmark run. A dash means
that the value was not captured in the selected 31 July Artificial Analysis
snapshot.

DeepSWE and Artificial Analysis use different harnesses. Do not combine the two benchmark scores into one ranking.
[Detailed evidence](model-evidence.md) explains sources, pricing, limitations,
and the refresh boundary.
