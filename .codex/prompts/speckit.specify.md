---
description: Criar ou atualizar a especificacao da funcionalidade a partir de uma descricao em linguagem natural.
handoffs:
  - label: Criar Plano Tecnico
    agent: speckit.plan
    prompt: Crie um plano para a especificacao. Estou construindo com...
  - label: Esclarecer Requisitos da Spec
    agent: speckit.clarify
    prompt: Esclarecer requisitos da especificacao
    send: true
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

O texto que o usuario digitou apos `/speckit.specify` e a descricao da
funcionalidade. Assuma que ela esta disponivel nesta conversa mesmo que
`$ARGUMENTS` apareca literalmente abaixo. Nao pedir para repetir a menos que a
entrada esteja vazia.

Dada a descricao, faca:

1. **Gerar um nome curto conciso** (2-4 palavras) para a branch:
   - Analisar a descricao e extrair palavras-chave relevantes
   - Criar nome de 2-4 palavras que capture a essencia
   - Usar formato verbo-substantivo quando possivel (ex.: "adicionar-auth-usuario")
   - Preservar termos tecnicos e siglas (OAuth2, API, JWT etc.)
   - Manter conciso e descritivo
   - Exemplos:
     - "Quero adicionar autenticacao" -> "auth-usuario"
     - "Implementar integracao OAuth2 para a API" -> "integracao-oauth2-api"
     - "Criar dashboard de analiticos" -> "dashboard-analiticos"
     - "Corrigir timeout do pagamento" -> "corrigir-timeout-pagamento"

2. **Checar branches existentes antes de criar nova**:

   a. Primeiro, buscar branches remotas:

      ```bash
      git fetch --all --prune
      ```

   b. Encontrar o maior numero de funcionalidade para o nome curto:
      - Branches remotas: `git ls-remote --heads origin | grep -E 'refs/heads/[0-9]+-<nome-curto>$'`
      - Branches locais: `git branch | grep -E '^[* ]*[0-9]+-<nome-curto>$'`
      - Diretorios specs: verificar `specs/[0-9]+-<nome-curto>`

   c. Determinar o proximo numero:
      - Extrair numeros das tres fontes
      - Encontrar o maior numero N
      - Usar N+1 para a nova branch

   d. Rodar `.specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS"` com o
      numero e nome curto calculados:
      - Passar `--number N+1` e `--short-name "seu-nome"` junto com a descricao
      - Exemplo Bash: `.specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS" --json --number 5 --short-name "auth-usuario" "Adicionar autenticacao"`
      - Exemplo PowerShell: `.specify/scripts/bash/create-new-feature.sh --json "$ARGUMENTS" -Json -Number 5 -ShortName "auth-usuario" "Adicionar autenticacao"`

   **IMPORTANTE**:
   - Checar as tres fontes (remotas, locais, diretorios)
   - So corresponder ao padrao exato do nome curto
   - Se nao existir nenhum, iniciar em 1
   - Rodar este script somente uma vez por funcionalidade
   - O JSON sai no terminal - sempre usar para obter os caminhos reais
   - O JSON contem BRANCH_NAME e SPEC_FILE
   - Para aspas simples em argumentos como "I'm Groot", use escape: ex. 'I'\''m Groot'
     (ou aspas duplas se possivel: "I'm Groot")

3. Carregar `.specify/templates/spec-template.md` para entender secoes obrigatorias.

4. Seguir este fluxo:

    1. Ler descricao do usuario em Entrada
       Se vazio: ERRO "Nenhuma descricao fornecida"
    2. Extrair conceitos-chave
       Identificar: atores, acoes, dados, restricoes
    3. Para aspectos incertos:
       - Fazer suposicoes informadas com base em contexto e padroes de mercado
       - Marcar com [PRECISA DE CLAREZA: pergunta especifica] apenas se:
         - Impacto significativo em escopo ou experiencia do usuario
         - Multiplas interpretacoes razoaveis com implicacoes diferentes
         - Sem default razoavel
       - **LIMITE: Maximo 3 marcadores [PRECISA DE CLAREZA]**
       - Priorizar por impacto: escopo > seguranca/privacidade > experiencia > detalhes tecnicos
    4. Preencher Cenarios de Usuario e Testes
       Se nao houver fluxo claro: ERRO "Nao e possivel determinar cenarios"
    5. Gerar Requisitos Funcionais
       Cada requisito deve ser testavel
       Usar defaults razoaveis (documentar suposicoes em Suposicoes)
    6. Definir Criterios de Sucesso
       Criar resultados mensuraveis e agnosticos de tecnologia
       Incluir metricas quantitativas (tempo, desempenho, volume) e qualitativas
       Cada criterio deve ser verificavel sem detalhes de implementacao
    7. Identificar Entidades Principais (se houver dados)
    8. Retornar: SUCESSO (spec pronta para planejamento)

5. Escrever a especificacao no SPEC_FILE usando o modelo e substituindo placeholders
   com detalhes concretos derivados da descricao (argumentos), preservando ordem e titulos.

6. **Validacao de Qualidade da Especificacao**: Depois de escrever a spec inicial,
   validar contra criterios de qualidade:

   a. **Criar Checklist de Qualidade**: Gerar `FEATURE_DIR/checklists/requirements.md`
      usando o modelo com estes itens:

      ```markdown
      # Checklist de Qualidade da Especificacao: [NOME DA FUNCIONALIDADE]

      **Proposito**: Validar completude e qualidade antes do planejamento
      **Criado**: [DATA]
      **Funcionalidade**: [Link para spec.md]

      ## Qualidade de Conteudo

      - [ ] Sem detalhes de implementacao (linguagens, frameworks, APIs)
      - [ ] Foco em valor do usuario e necessidades de negocio
      - [ ] Escrito para partes interessadas nao tecnicos
      - [ ] Todas as secoes obrigatorias completas

      ## Completude de Requisitos

      - [ ] Sem marcadores [PRECISA DE CLAREZA]
      - [ ] Requisitos testaveis e sem ambiguidade
      - [ ] Criterios de sucesso mensuraveis
      - [ ] Criterios de sucesso agnosticos de tecnologia
      - [ ] Todos os cenarios de aceite definidos
      - [ ] Casos de borda identificados
      - [ ] Escopo claramente delimitado
      - [ ] Dependencias e suposicoes identificadas

      ## Prontidao da Funcionalidade

      - [ ] Todos os requisitos funcionais tem criterios de aceite claros
      - [ ] Cenarios de usuario cobrem fluxos principais
      - [ ] Funcionalidade atende resultados mensuraveis
      - [ ] Nenhum detalhe de implementacao vazou para a spec

      ## Observacoes

      - Itens incompletos exigem ajuste antes de `/speckit.clarify` ou `/speckit.plan`
      ```

   b. **Rodar Checagem de Validacao**: Revisar a spec contra cada item:
      - Para cada item, determinar se passa ou falha
      - Documentar problemas especificos (citar secoes relevantes)

   c. **Tratar Resultados da Validacao**:

      - **Se todos passarem**: marcar checklist completo e seguir

      - **Se houver falhas (excluindo [PRECISA DE CLAREZA])**:
        1. Listar itens falhos e problemas
        2. Atualizar a spec para corrigir
        3. Revalidar ate todos passarem (max 3 iteracoes)
        4. Se ainda falhar apos 3, documentar nos comentarios e alertar o usuario

      - **Se houver marcadores [PRECISA DE CLAREZA]**:
        1. Extrair todos os marcadores da spec
        2. **CHECAGEM DE LIMITE**: Se houver mais de 3, manter apenas os 3 mais criticos
           (por impacto de escopo/seguranca/UX) e fazer suposicoes para o resto
        3. Para cada esclarecimento (max 3), apresentar opcoes:

           ```markdown
           ## Pergunta [N]: [Topico]

           **Contexto**: [Citar secao relevante]

           **O que precisamos saber**: [Pergunta especifica do marcador]

           **Respostas Sugeridas**:

           | Opcao | Resposta | Implicacoes |
           |--------|----------|------------|
           | A      | [Primeira resposta sugerida] | [Impacto na funcionalidade] |
           | B      | [Segunda resposta sugerida] | [Impacto na funcionalidade] |
           | C      | [Terceira resposta sugerida] | [Impacto na funcionalidade] |
           | Personalizado | Fornecer resposta propria | [Como fornecer entrada] |

           **Sua escolha**: _[Aguardar resposta]_ 
           ```

        4. **CRITICO - Formato da Tabela**: Garantir tabela Markdown correta:
           - Espacos consistentes com pipes alinhados
           - Cada celula com espacos: `| Conteudo |` nao `|Conteudo|`
           - Separador de cabecalho com pelo menos 3 tracos: `|--------|`
           - Validar renderizacao
        5. Numerar perguntas sequencialmente (Q1, Q2, Q3 - max 3)
        6. Apresentar todas as perguntas antes de aguardar respostas
        7. Esperar resposta do usuario com escolhas (ex.: "Q1: A, Q2: Personalizado - [detalhes], Q3: B")
        8. Atualizar a spec substituindo cada marcador pela resposta escolhida
        9. Revalidar apos todas as respostas

   d. **Atualizar Checklist**: Apos cada iteracao, atualizar status de passa/falha

7. Reportar conclusao com nome da branch, caminho da spec, resultados do checklist
   e prontidao para a proxima fase (`/speckit.clarify` ou `/speckit.plan`).

**NOTA:** O script cria e faz checkout da nova branch e inicializa o arquivo spec.

## Diretrizes Gerais

## Diretrizes Rapidas
