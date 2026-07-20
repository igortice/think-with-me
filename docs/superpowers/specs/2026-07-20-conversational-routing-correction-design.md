# Correção do roteamento conversacional da Think With Me

**Status:** aprovado pelo usuário para implementação

**Data:** 20 de julho de 2026

## Problema

O portfólio contextual anterior diversificou corretamente o roteamento dentro
do domínio DeepSWE, mas manteve `Sol High` como piso para quase todo julgamento
conversacional fora de um benchmark correspondente. Em confirmações de status,
exploração longa e elaboração revisável, isso elimina as demais candidatas
antes de comparar a forma real do próximo passo. O rodapé volta, na prática, a
um default que a política declara não possuir.

O erro também aparece quando um assunto já está resolvido: a resposta inventa
um trabalho futuro, como decidir um push, para poder recomendar um modelo. A
recomendação deve descrever o trabalho cognitivo da resposta atual ou o próximo
passo real do usuário, nunca uma pendência criada pelo assistente.

## Objetivo

Adicionar uma matriz conversacional provisória, separada das duas matrizes de
benchmark, que permita escolher configurações diferentes no uso cotidiano sem
transferir métricas de coding ou engenharia para conversa em português.

## Abordagens consideradas

1. **Manter o fallback atual e apenas variar exemplos.** Rejeitada porque os
   exemplos não mudariam a elegibilidade e `Sol High` continuaria vencendo.
2. **Adicionar uma matriz conversacional provisória.** Aprovada porque cria
   rotas explícitas, honestas sobre a falta de benchmark conversacional, e
   permite validação local gradual.
3. **Transformar as duas matrizes em um ranking geral.** Rejeitada porque
   misturaria domínios e criaria equivalência sem evidência.

## Matriz conversacional provisória

Esta matriz é uma política de uso e avaliação local, não uma terceira fonte de
benchmark. Ela usa a forma do trabalho, reversibilidade, possibilidade de
revisão, consequência do erro e saúde da conversa.

| Próximo passo conversacional | Configuração elegível preferida | Limite |
| --- | --- | --- |
| Confirmação de status, explicação cotidiana ou análise delimitada, reversível, barata de corrigir e sem julgamento profissional escondido | `Sol Medium` | Rota provisória; não alegar equivalência geral com o baseline histórico. |
| Exploração longa, organização de contexto e síntese aberta cujo resultado será revisado antes de uma decisão consequencial | `Terra Max` | Piloto conversacional; não alegar vantagem econômica ou equivalência comprovada. |
| Elaboração longa e estruturada, sensível a custo, com mais tokens, passos e duração aceitáveis e revisão antes do uso consequencial | `Luna Max` | Piloto conversacional revisável; não usar para decisão final sem evidência local. |
| Julgamento profissional compacto, decisão consequencial ou síntese final com trade-offs reais | `Sol High` | Piso conservador somente para esse contrato, não para toda conversa aberta. |
| Ambiguidade residual material, restrições transversais ou correções repetidas de enquadramento | `Sol XHigh` | Exige evidência concreta da dificuldade residual. |
| Problema excepcionalmente difícil e delimitado, com profundidade máxima explicitamente necessária | `Sol Max` | Mantém o gate de profundidade máxima. |
| Transformação mecânica em volume, direção fechada e validação automática barata | `Luna Medium` | Somente piloto até evidência local qualificada. |

As configurações sem rota preferencial continuam registradas no portfólio.

## Algoritmo corrigido

1. Formular a visão e o trabalho cognitivo real da resposta atual.
2. Se existe um próximo passo real do usuário, formular exatamente esse passo;
   se o assunto está resolvido, registrar que não há ação pendente sem inventar
   uma nova decisão.
3. Identificar se o trabalho é rotina reversível, exploração revisável,
   elaboração longa, julgamento consequencial, ambiguidade difícil,
   profundidade máxima ou transformação mecânica.
4. Aplicar primeiro a matriz conversacional quando o domínio é conversa; usar
   as matrizes externas somente em domínios correspondentes.
5. Declarar rotas sem evidência conversacional direta como provisórias e
   revisáveis.
6. Recomendar exatamente uma configuração no rodapé e recalcular quando a
   forma do trabalho mudar.

## Contrato para assunto resolvido

Quando não há próximo passo real, `Próximo passo` deve dizer que nenhuma ação é
necessária. O modelo recomendado descreve a carga cognitiva da resposta atual,
como uma confirmação delimitada, e não uma tarefa futura inventada. Uma
confirmação simples e verificável pode selecionar `Sol Medium` sem exigir
pressão material de custo; boundedness, reversibilidade e ausência de julgamento
escondido são suficientes para essa rota cotidiana provisória.

## Evidência e honestidade

- Artificial Analysis e DeepSWE continuam separados e inalterados.
- A matriz conversacional não recebe números próprios nem herda custos das
  matrizes externas.
- `Terra Max` e `Luna Max` entram como pilotos conversacionais revisáveis,
  sustentados por posicionamento de família, resultados indiretos e avaliação
  local futura, não por equivalência já demonstrada.
- Decisões profissionais finais continuam preservando `Sol High` quando não há
  evidência local suficiente para reduzir o contrato.
- Sucesso e falha dos pilotos devem ser preservados em capturas versionadas.

## Validação

A correção estará pronta quando:

1. um caso resolvido recomendar `Sol Medium` sem inventar push, publicação ou
   outra pendência;
2. uma exploração longa revisável recomendar `Terra Max` como piloto;
3. uma elaboração longa sensível a custo recomendar `Luna Max` como piloto;
4. um julgamento profissional compacto continuar recomendando `Sol High`;
5. um caso com correções repetidas e ambiguidade material recomendar
   `Sol XHigh`;
6. uma sequência multietapas recomputar a recomendação ao mudar a forma do
   trabalho;
7. todos os gates, a revisão independente e a paridade global passarem.

## Fora de escopo

- Trocar automaticamente o modelo ativo do host.
- Prometer qualidade conversacional acima do baseline sem avaliação local.
- Alterar ou fundir as duas tabelas de benchmark.
- Publicar ou fazer push sem autorização separada.
