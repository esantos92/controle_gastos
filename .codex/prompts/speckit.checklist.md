---
description: Gerar um checklist customizado para a funcionalidade atual com base nos requisitos do usuario.
---

## Proposito do Checklist: "Testes Unitarios para Ingles"

**CONCEITO CRITICO**: Checklists sao **TESTES UNITARIOS PARA ESCRITA DE REQUISITOS**
- validam qualidade, clareza e completude dos requisitos em um dominio.

**NAO para verificacao/teste de implementacao**:

- NAO "Verificar se o botao clica corretamente"
- NAO "Testar se o tratamento de erro funciona"
- NAO "Confirmar que a API retorna 200"
- NAO verificar se codigo/implementacao bate com a especificacao

**PARA validar qualidade dos requisitos**:

- "Os requisitos de hierarquia visual estao definidos para todos os tipos de card?" (completude)
- "'Exibicao proeminente' esta quantificada com tamanho/posicionamento especificos?" (clareza)
- "Os requisitos de estado hover (hover) estao consistentes entre elementos interativos?" (consistencia)
- "Ha requisitos de acessibilidade definidos para navegacao por teclado?" (cobertura)
- "A especificacao define o que acontece quando a imagem do logo falha ao carregar?" (casos de borda)

**Metafora**: Se a especificacao e codigo escrito em ingles, o checklist e sua suite de testes
unitarios. Voce testa se os requisitos estao bem escritos, completos, sem ambiguidade e prontos
para implementacao - NAO se a implementacao funciona.

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Etapas de Execucao

1. **Preparacao**: Rodar `.specify/scripts/bash/check-prerequisites.sh --json` na raiz do
   repositorio e interpretar o JSON para FEATURE_DIR e a lista AVAILABLE_DOCS.
   - Todos os caminhos devem ser absolutos.
   - Para aspas simples em argumentos como "I'm Groot", use escape: ex. 'I'\''m Groot'
     (ou aspas duplas se possivel: "I'm Groot").

2. **Esclarecer intencao (dinamico)**: Derivar ate TRES perguntas iniciais de esclarecimento.
   Elas DEVEM:
   - Ser geradas a partir da frase do usuario + sinais extraidos de spec/plan/tasks
   - Perguntar somente informacao que muda o checklist de forma material
   - Ser puladas individualmente se ja estiver claro em `$ARGUMENTS`
   - Preferir precisao em vez de amplitude

   Algoritmo de geracao:
   1. Extrair sinais: palavras-chave do dominio (ex.: autenticacao (auth), latencia, UX, API),
      indicadores de risco ("critico", "deve", "conformidade"),
      dicas de stakeholders ("QA", "revisao", "time de seguranca"),
      e entregaveis explicitos ("a11y", "reversao (rollback)", "contratos").
   2. Agrupar sinais em areas de foco candidatas (max 4) por relevancia.
   3. Identificar publico e momento (autor, revisor, QA, lancamento), se nao explicito.
   4. Detectar dimensoes faltantes: escopo, profundidade/rigor, foco em risco,
      limites de exclusao, criterios mensuraveis.
   5. Formular perguntas escolhidas destes arquetipos:
      - Refinamento de escopo (ex.: "Incluir pontos de integracao com X e Y ou limitar ao modulo local?")
      - Priorizacao de risco (ex.: "Quais areas de risco devem ter checagens obrigatorias?")
      - Calibragem de profundidade (ex.: "Lista leve de pre-commit ou ponto de controle formal de lancamento?")
      - Enquadramento por publico (ex.: "Uso pelo autor ou por pares em revisao de PR?")
      - Exclusao de limite (ex.: "Excluir itens de ajuste de desempenho nesta rodada?")
      - Lacuna de classe de cenario (ex.: "Nao ha fluxos de recuperacao - reversao/falha parcial estao no escopo?")

   Regras de formato das perguntas:
   - Se apresentar opcoes, gerar tabela compacta com: Opcao | Candidato | Por que importa
   - Limitar a A-E opcoes; omitir tabela se resposta livre for melhor
   - Nunca pedir para repetir o que ja foi dito
   - Evitar categorias especulativas (sem alucinacao). Se incerto: "Confirme se X entra no escopo."

   Padroes quando a interacao for impossivel:
   - Profundidade: Padrao
   - Publico: Revisor (PR) se for codigo; Autor caso contrario
   - Foco: Top 2 clusters por relevancia

   Saida das perguntas (rotular Q1/Q2/Q3). Depois das respostas: se >=2 classes
   de cenario (Alternativo / Excecao / Recuperacao / Nao Funcional) permanecerem
   incertas, voce PODE perguntar ate mais DUAS perguntas direcionadas (Q4/Q5) com
   justificativa de uma linha (ex.: "Risco de caminho de recuperacao nao resolvido").
   Nao exceder cinco perguntas. Nao escalar se o usuario recusar.

3. **Entender o pedido do usuario**: Combinar `$ARGUMENTS` + respostas:
   - Derivar tema do checklist (ex.: seguranca, revisao, implantacao, ux)
   - Consolidar itens obrigatorios mencionados
   - Mapear focos para a estrutura de categorias
   - Inferir contexto ausente de spec/plan/tasks (NAO alucinar)

4. **Carregar contexto da funcionalidade**: Ler de FEATURE_DIR:
   - spec.md: requisitos e escopo
   - plan.md (se existir): detalhes tecnicos, dependencias
   - tasks.md (se existir): tarefas de implementacao

   **Estrategia de carregamento**:
   - Carregar apenas partes necessarias para as areas de foco ativas (evitar despejo completo)
   - Preferir resumir secoes longas em itens concisos de cenarios/requisitos
   - Usar divulgacao progressiva: buscar mais apenas se houver lacunas
   - Se os docs forem grandes, gerar sumarios intermediarios em vez de texto bruto

5. **Gerar checklist** - Criar "Testes Unitarios para Requisitos":
   - Criar o diretorio `FEATURE_DIR/checklists/` se nao existir
   - Gerar nome unico do checklist:
     - Usar nome curto e descritivo por dominio (ex.: `ux.md`, `api.md`, `seguranca.md`)
     - Formato: `[dominio].md`
     - Se arquivo existir, anexar ao existente
   - Numerar itens a partir de CHK001
   - Cada execucao do `/speckit.checklist` cria um NOVO arquivo (nunca sobrescrever)

   **PRINCIPIO CENTRAL - Testar Requisitos, Nao Implementacao**:
   Cada item DEVE avaliar OS REQUISITOS em:
   - **Completude**: Existem todos os requisitos necessarios?
   - **Clareza**: Requisitos sao especificos e sem ambiguidade?
   - **Consistencia**: Requisitos nao entram em conflito?
   - **Mensurabilidade**: Requisitos podem ser verificados objetivamente?
   - **Cobertura**: Todos os cenarios/casos de borda estao cobertos?

   **Estrutura de Categorias** - Agrupar itens por dimensao de qualidade:
   - **Completude dos requisitos** (todos os requisitos foram documentados?)
   - **Clareza dos requisitos** (especificos e sem ambiguidade?)
   - **Consistencia dos requisitos** (alinhados, sem conflitos?)
   - **Qualidade de criterios de aceite** (criterios mensuraveis?)
   - **Cobertura de cenarios** (todos os fluxos/casos?)
   - **Cobertura de casos de borda** (condicoes de contorno?)
   - **Requisitos nao funcionais** (desempenho, seguranca, acessibilidade etc.)
   - **Dependencias e suposicoes** (documentadas e validadas?)
   - **Ambiguidades e conflitos** (o que precisa de clareza?)

   **COMO ESCREVER ITENS - "Testes Unitarios para Ingles"**:

   ERRADO (testando implementacao):
   - "Verificar se a pagina inicial mostra 3 cards"
   - "Testar se hover funciona no desktop"
   - "Confirmar que clicar no logo navega para inicio"

   CORRETO (testando qualidade de requisitos):
   - "O numero e layout de episodios em destaque estao especificados?" [Completude]
   - "'Exibicao proeminente' esta quantificada com tamanho/posicionamento?" [Clareza]
   - "Os requisitos de hover sao consistentes entre elementos interativos?" [Consistencia]
   - "Ha requisitos de navegacao por teclado para todos os elementos interativos?" [Cobertura]
   - "O comportamento de contingencia quando a imagem do logo falha esta especificado?" [Casos de Borda]
   - "Ha estados de carregamento definidos para dados assincronos?" [Completude]
   - "A especificacao define hierarquia visual para elementos concorrentes?" [Clareza]

   **ESTRUTURA DO ITEM**:
   Cada item deve seguir este padrao:
   - Formato de pergunta sobre qualidade do requisito
   - Foco no que esta ESCRITO (ou nao) na spec/plan
   - Incluir dimensao de qualidade entre colchetes [Completude/Clareza/Consistencia/etc.]
   - Referenciar secao da spec `[Especificacao Sec. X.Y]` ao checar requisitos existentes
   - Usar marcador `[Lacuna]` ao checar requisitos ausentes

   **EXEMPLOS POR DIMENSAO**:

   Completude:
   - "Ha requisitos de tratamento de erro para todos os modos de falha da API? [Lacuna]"
   - "Ha requisitos de acessibilidade para todos os elementos interativos? [Completude]"
   - "Ha requisitos de breakpoints mobile para layouts responsivos? [Lacuna]"

   Clareza:
   - "'Carregamento rapido' esta quantificado com limites? [Clareza, Especificacao Sec. NFR-2]"
   - "Os criterios de selecao de 'episodios relacionados' estao definidos? [Clareza, Especificacao Sec. FR-5]"
   - "'Proeminente' esta definido com propriedades visuais mensuraveis? [Ambiguidade, Especificacao Sec. FR-4]"

   Consistencia:
   - "Requisitos de navegacao estao alinhados em todas as paginas? [Consistencia, Especificacao Sec. FR-10]"
   - "Requisitos de card sao consistentes entre pagina inicial e detalhe? [Consistencia]"

   Cobertura:
   - "Ha requisitos para estado vazio (sem episodios)? [Cobertura, Caso de Borda]"
   - "Ha cenarios de interacao concorrente? [Cobertura, Lacuna]"
   - "Ha requisitos para falhas parciais de carga de dados? [Cobertura, Fluxo de Excecao]"

   Mensurabilidade:
   - "Requisitos de hierarquia visual sao mensuraveis/testaveis? [Criterios de Aceite, Especificacao Sec. FR-1]"
   - "'Peso visual balanceado' pode ser verificado objetivamente? [Mensurabilidade, Especificacao Sec. FR-2]"

   **Classificacao e Cobertura de Cenarios** (Foco em qualidade de requisitos):
   - Checar se existem requisitos para: Primario, Alternativo, Excecao/Erro, Recuperacao, Nao Funcional
   - Para cada classe: "Os requisitos de [tipo] estao completos, claros e consistentes?"
   - Se classe ausente: "Requisitos de [tipo] foram excluidos ou estao faltando? [Lacuna]"
   - Incluir resiliencia/reversao quando houver mutacao de estado: "Ha requisitos de reversao para falhas de migracao? [Lacuna]"

   **Rastreabilidade**:
   - MINIMO: >=80% dos itens DEVEM incluir referencia de rastreio
   - Cada item deve referenciar secao `[Especificacao Sec. X.Y]`, ou usar marcadores: `[Lacuna]`, `[Ambiguidade]`, `[Conflito]`, `[Suposicao]`
   - Se nao houver IDs: "Ha esquema de IDs para requisitos e criterios de aceite? [Rastreabilidade]"

   **Superficial e Resolver Problemas**:
   Perguntar sobre os requisitos:
   - Ambiguidades: "O termo 'rapido' esta quantificado com metricas? [Ambiguidade, Especificacao Sec. NFR-1]"
   - Conflitos: "Requisitos de navegacao conflitam entre Sec. FR-10 e Sec. FR-10a? [Conflito]"
   - Suposicoes: "A suposicao de 'API de podcast sempre disponivel' foi validada? [Suposicao]"
   - Dependencias: "Requisitos para API externa estao documentados? [Dependencia, Lacuna]"
   - Definicoes faltantes: "'Hierarquia visual' esta definida com criterios mensuraveis? [Lacuna]"

   **Consolidacao de Conteudo**:
   - Limite leve: se itens candidatos > 40, priorizar por risco/impacto
   - Mesclar quase duplicados que checam o mesmo aspecto
   - Se >5 casos de borda de baixo impacto, criar um item: "Casos de borda X, Y, Z estao cobertos? [Cobertura]"

   **PROIBIDO** - Isso transforma em teste de implementacao:
   - Itens iniciando com "Verificar", "Testar", "Confirmar", "Checar" + comportamento
   - Referencias a execucao de codigo, acoes do usuario, comportamento do sistema
   - "Exibe corretamente", "funciona corretamente", "como esperado"
   - "Clicar", "navegar", "renderizar", "carregar", "executar"
   - Casos de teste, planos de teste, procedimentos de QA
   - Detalhes de implementacao (frameworks, APIs, algoritmos)

   **PADROES OBRIGATORIOS** - Testam qualidade do requisito:
   - "Os requisitos de [tipo] estao definidos/especificados/documentados para [cenario]?"
   - "O termo [vago] esta quantificado/clarificado com criterios especificos?"
