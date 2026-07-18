# Think With Me — design das superfícies públicas

**Status:** proposta aprovada para especificação; aguarda revisão desta versão escrita antes da implementação.

## Objetivo

Fazer a skill legível como produto público no skills.sh e no GitHub sem perder
o contrato comportamental usado pelo Codex. Cada superfície deve responder ao
que seu público precisa saber, sem expor a história interna da criação da
skill ou detalhes de validação que não ajudam quem a instala.

## Decisão

Separar a apresentação pública do contrato detalhado:

1. `skills/think-with-me/SKILL.md` será o núcleo público e operacional. Ele
   ficará inteiramente em inglês, conciso e sem mencionar `grilling` ou outra
   origem interna. Explicará finalidade, limites, regra de idioma da mensagem
   atual, os três papéis finais e a necessidade do blockquote contínuo.
2. `references/output-contract.md` conterá os templates literais, os exemplos
   completos em inglês e português e as regras precisas de uma pergunta e do
   rodapé. Esses detalhes continuam disponíveis para a skill sem dominar a
   prévia do skills.sh.
3. `references/model-routing.md` continuará contendo a matriz e a evidência de
   roteamento. O núcleo apontará para a referência quando a recomendação exigir
   escolha de modelo.
4. `README.md` será uma página de produto para GitHub: proposta de valor,
   quando usar, saída renderizada, instalação canônica para Codex, limites,
   idioma e compatibilidade. Estrutura do pacote, validação e runbook ficarão
   no fim para mantenedores.

## Contrato público do SKILL.md

O núcleo deve conter somente estes blocos, em inglês:

- uma frase de propósito alinhada ao frontmatter;
- `Understand the conversation` com recuperação do objetivo e fatos atuais;
- `Advance one decision` com uma dependência imediata e uma pergunta somente
  quando a pessoa deve decidir;
- `Close clearly` com os papéis `view`, `next step` e `model recommendation`,
  a regra de derivar o idioma da mensagem atual e o blockquote contínuo;
- `Choose the model from the next step` com encaminhamento para
  `references/model-routing.md`;
- `Keep the boundary clear` proibindo execução antes de ordem operacional
  direta.

O núcleo não deve conter exemplos em português, templates completos, frases
híbridas entre inglês e português, menções a skills de origem, caminhos locais
ou instruções de governança do repositório.

## README público

O README seguirá esta ordem:

1. título e promessa curta;
2. `Why use it` com os resultados práticos;
3. `What a response looks like` com um exemplo renderizado em inglês;
4. `Install for Codex` com um único comando principal;
5. `Use it` com invocação explícita e esclarecimento da descoberta implícita;
6. `Language, compatibility, and boundaries` explicando que a saída acompanha
   a mensagem atual, que o modelo ativo não é inferido e que a skill não inicia
   operações;
7. `For maintainers` com layout, validação e link para o runbook;
8. licença.

O comando principal do README continuará sendo global para Codex. A alternativa
de autodetecção será removida da página principal para não criar duas escolhas
equivalentes para quem quer começar.

## Testes e evidência

- O gate manterá validação de idioma inglês e português, mas os templates
  literais podem viver em `references/output-contract.md` em vez do núcleo.
- O gate verificará que o `SKILL.md` não contém `grilling`, o rótulo português
  literal nem exemplos de idioma específico.
- A validação estrutural, a paridade global e o forward-test do TWM-13 serão
  repetidos antes da publicação.
- A revisão pública confirmará que o skills.sh mostra um núcleo em inglês sem
  histórico interno e que o README do GitHub renderiza o exemplo como
  blockquote.

## Fora do escopo

- Não mudar a política de seleção de modelos, os três papéis finais ou a
  fronteira entre conversa e execução.
- Não mudar a visibilidade pública, licença ou o identificador da skill.
- Não criar uma segunda tradução integral do README neste ciclo.

## Critérios de aceite

1. A prévia do skills.sh não cita `grilling`, não contém texto de instrução em
   português e não expõe templates extensos.
2. O README explica claramente valor, instalação e limites antes dos detalhes
   de manutenção.
3. A resposta da skill continua localizada pela mensagem atual, com um único
   blockquote final e uma única recomendação de modelo.
4. Os gates locais e a instalação global validam a fonte publicada.
