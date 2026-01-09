---
description: Realizar uma analise nao destrutiva de consistencia e qualidade entre spec.md, plan.md e tasks.md apos a geracao de tarefas.
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Objetivo

Identificar inconsistencias, duplicacoes, ambiguidades e itens subespecificados
entre os tres artefatos centrais (`spec.md`, `plan.md`, `tasks.md`) antes da
implementacao. Este comando DEVE rodar somente apos `/speckit.tasks` ter gerado
um `tasks.md` completo.

## Restricoes Operacionais

**SOMENTE LEITURA**: Nao modificar arquivos. Produzir um relatorio estruturado.
Oferecer um plano de correcao opcional (o usuario deve aprovar explicitamente
antes de qualquer edicao).

**Autoridade da Constituicao**: A constituicao do projeto
(`.specify/memory/constitution.md`) e **inegociavel** dentro deste escopo. Conflitos
com a constituicao sao automaticamente CRITICOS e exigem ajuste na especificacao,
plano ou tarefas -- nao diluir, reinterpretar ou ignorar silenciosamente o principio.
Se o principio precisar mudar, isso deve ocorrer em atualizacao separada da
constituicao, fora de `/speckit.analyze`.

## Etapas de Execucao

### 1. Inicializar Contexto de Analise

Executar `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks`
uma vez a partir da raiz do repositorio e interpretar o JSON para FEATURE_DIR e
AVAILABLE_DOCS. Derivar caminhos absolutos:

- SPEC = FEATURE_DIR/spec.md
- PLAN = FEATURE_DIR/plan.md
- TASKS = FEATURE_DIR/tasks.md

Abortar com mensagem de erro se algum arquivo obrigatorio estiver ausente
(instruir o usuario a rodar o comando de pre-requisito faltante).
Para aspas simples em argumentos como "I'm Groot", use escape: ex. 'I'\''m Groot'
(ou aspas duplas se possivel: "I'm Groot").

### 2. Carregar Artefatos (Divulgacao Progressiva)

Carregar apenas o contexto minimo necessario de cada artefato:

**De spec.md:**

- Visao geral/Contexto
- Requisitos Funcionais
- Requisitos Nao Funcionais
- Historias de Usuario
- Casos de Borda (se houver)

**De plan.md:**

- Decisoes de arquitetura/stack
- Referencias ao modelo de dados
- Fases
- Restricoes tecnicas

**De tasks.md:**

- IDs de tarefas
- Descricoes
- Agrupamento por fase
- Marcadores de paralelo [P]
- Caminhos de arquivo referenciados

**Da constituicao:**

- Carregar `.specify/memory/constitution.md` para validacao de principios

### 3. Construir Modelos Semanticos

Criar representacoes internas (nao incluir artefatos brutos na saida):

- **Inventario de requisitos**: Cada requisito funcional + nao funcional com chave estavel
  (derive slug baseado na frase imperativa; ex.: "Usuario pode enviar arquivo" -> `usuario-pode-enviar-arquivo`)
- **Inventario de historias/acoes**: Acoes discretas do usuario com criterios de aceite
- **Mapeamento de cobertura de tarefas**: Mapear cada tarefa para um ou mais requisitos ou historias
  (inferir por palavra-chave / referencias explicitas como IDs ou frases-chave)
- **Conjunto de regras da constituicao**: Extrair nomes de principios e declaracoes normativas DEVE/DEVERIA

### 4. Passes de Deteccao (Analise Enxuta)

Focar em achados de alto sinal. Limitar a 50 achados; agregar o restante em resumo.

#### A. Deteccao de Duplicacao

- Identificar requisitos quase duplicados
- Marcar redacao de menor qualidade para consolidacao

#### B. Deteccao de Ambiguidade

- Sinalizar adjetivos vagos (rapido, escalavel, seguro, intuitivo, robusto) sem criterios mensuraveis
- Sinalizar placeholders nao resolvidos (TODO, TKTK, ???, `<placeholder>` etc.)

#### C. Subespecificacao

- Requisitos com verbo mas sem objeto ou resultado mensuravel
- Historias sem alinhamento com criterios de aceite
- Tarefas referenciando arquivos ou componentes nao definidos em spec/plan

#### D. Alinhamento com a Constituicao

- Qualquer requisito ou elemento do plano em conflito com principio DEVE
- Secoes obrigatorias ou portoes de qualidade ausentes

#### E. Lacunas de Cobertura

- Requisitos sem nenhuma tarefa associada
- Tarefas sem requisito/historia mapeada
- Requisitos nao funcionais nao refletidos em tarefas (ex.: desempenho, seguranca)

#### F. Inconsistencia

- Desvio de terminologia (mesmo conceito com nomes diferentes entre arquivos)
- Entidades de dados referenciadas no plano mas ausentes na especificacao (ou vice-versa)
- Contradicoes de ordem de tarefas (ex.: integracao antes da fundacao sem dependencia)
- Requisitos conflitantes (ex.: um exige Next.js e outro especifica Vue)

### 5. Atribuicao de Severidade

Use esta heuristica para priorizar achados:

- **CRITICO**: Viola DEVE da constituicao, falta artefato central, ou requisito sem cobertura que bloqueia funcionalidade basica
- **ALTO**: Requisito duplicado ou conflitante, atributo de seguranca/desempenho ambiguo, criterio de aceite nao testavel
- **MEDIO**: Desvio de terminologia, falta de cobertura nao funcional, caso de borda subespecificado
- **BAIXO**: Ajustes de estilo/redacao, redundancia menor sem impacto na execucao

### 6. Produzir Relatorio de Analise Compacto

Gerar um relatorio em Markdown (sem gravar arquivo) com a estrutura:

## Relatorio de Analise de Especificacao

| ID | Categoria | Severidade | Local | Resumo | Recomendacao |
|----|----------|-----------|-------|--------|--------------|
| A1 | Duplicacao | ALTO | spec.md:L120-134 | Dois requisitos similares ... | Consolidar redacao; manter versao mais clara |

(Adicionar uma linha por achado; gerar IDs estaveis com prefixo da categoria.)

**Tabela Resumo de Cobertura:**

| Chave do Requisito | Tem Tarefa? | IDs de Tarefa | Observacoes |
|--------------------|------------|--------------|------------|

**Problemas de Alinhamento com a Constituicao:** (se houver)

**Tarefas Sem Mapeamento:** (se houver)

**Metricas:**

- Total de Requisitos
- Total de Tarefas
- % de Cobertura (requisitos com >=1 tarefa)
- Contagem de Ambiguidades
- Contagem de Duplicacoes
- Contagem de Itens Criticos

### 7. Propor Proximas Acoes

Ao final do relatorio, emitir um bloco conciso de Proximas Acoes:

- Se houver CRITICOS: recomendar resolver antes de `/speckit.implement`
- Se apenas BAIXO/MEDIO: usuario pode prosseguir, com sugestoes de melhoria
- Sugerir comandos explicitos: ex. "Rodar /speckit.specify com refinamento",
  "Rodar /speckit.plan para ajustar arquitetura", "Editar tasks.md para cobrir 'metricas-de-desempenho'"

### 8. Oferecer Correcao

Perguntar ao usuario: "Quer que eu sugira edicoes concretas para os N principais problemas?"
(Nao aplicar automaticamente.)

## Principios Operacionais

### Eficiencia de Contexto

- **Minimo de tokens com alto sinal**: Focar em achados acionaveis, nao em documentacao exaustiva
- **Divulgacao progressiva**: Carregar artefatos de forma incremental; nao despejar todo o conteudo
- **Saida enxuta**: Limitar a 50 linhas de achados; resumir excedentes
- **Resultados deterministas**: Reexecutar sem mudancas deve produzir IDs e contagens consistentes

### Diretrizes de Analise

- **NUNCA modificar arquivos** (analise somente leitura)
- **NUNCA inventar secoes ausentes** (se faltarem, reportar corretamente)
- **Priorizar violacoes da constituicao** (sempre CRITICO)
- **Usar exemplos em vez de regras exaustivas** (citar instancias especificas)
- **Relatar zero problemas com clareza** (emitir relatorio de sucesso com metricas)

## Contexto

$ARGUMENTS
