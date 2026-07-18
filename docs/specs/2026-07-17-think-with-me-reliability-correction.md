# Think With Me — correção de confiabilidade

**Status:** contrato de três campos validado localmente e na instalação global; aguardando somente revisão e commit local
**Data:** 17 de julho de 2026

## Falha observada

O fechamento `Minha sugestão` virou um recipiente para posição, pergunta, modelo, agentes, aprovação, pendências e próximos passos. Isso permitiu respostas tecnicamente aderentes ao contrato, mas semanticamente erradas para a conversa. Os forward-tests anteriores não detectaram o problema porque seus critérios avaliavam a posição do modelo e a presença do rótulo, não a pureza da recomendação.

## Correção

- Reduzir o pacote instalável ao comportamento conversacional necessário.
- Substituir o fechamento sobrecarregado por `Minha visão`, `Próximo passo` e `Modelo`.
- Exigir uma conclusão declarativa em `Minha visão`.
- Exigir um único próximo passo que venha do objetivo atual, em vez de apenas opinar e encerrar.
- Quando houver uma decisão humana, incluir em `Próximo passo` a resposta recomendada e exatamente uma pergunta.
- Recomendar exatamente um modelo para a conversa atual, em uma linha sem justificativa.
- Impedir que contexto interno e operações não solicitadas vazem para a posição final.
- Remover do núcleo roteamento de execução, delegação e governança de repositório.

## Garantia prática

Confiabilidade é medida em quatro camadas:

1. validação estrutural do pacote;
2. teste estático dos invariantes do fechamento;
3. casos comportamentais em conversas novas;
4. comparação explícita entre a fonte candidata e a instalação usada pelo host antes de distribuição.

Nenhuma camada isolada prova a experiência. A versão só pode ser considerada pronta quando todas concordarem.

## Fora de escopo

Commit, push e publicação continuam exigindo autorização separada. A sincronização global desta correção foi autorizada pelo usuário e foi concluída depois dos testes locais.
