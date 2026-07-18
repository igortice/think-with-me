# Model Routing for the Conversation

Recommend the model for the next part of the conversation, not for an imagined implementation. Recommend exactly one model and effort. Select it internally and emit only the short final field, such as `**Modelo:** Terra High.`

| Conversational need | Recommendation | Decisive reason |
| --- | --- | --- |
| Understanding context, comparing options, planning, refining an idea, or writing a specification | **Terra High** | Balanced reasoning is the best default for connecting context, alternatives, and ordinary risk. |
| Reviewing a critical ambiguity involving security, authorization, irreversible change, data integrity, concurrency, or a high cost of error | **Sol High** | The next discussion needs focused judgment and higher confidence on one bounded risk. |
| Summarizing, classifying, or polishing a direction that is already clear and repeatable | **Luna High** | The remaining conversation is synthesis rather than open-ended judgment. |

Use `XHigh` only when a first serious discussion leaves material cross-cutting ambiguity. Use `Max` only for an unusually hard, bounded problem that the user explicitly wants to pursue deeply. Importance alone is not a reason to escalate.

If the context changes, choose again. Otherwise keep the same recommendation. Never describe a model as active or instruct the user to remain on it.
