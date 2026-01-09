---
description: Gerar um tasks.md acionavel e ordenado por dependencias para a funcionalidade com base nos artefatos disponiveis.
handoffs:
  - label: Analisar Consistencia
    agent: speckit.analyze
    prompt: Rodar analise de consistencia do projeto
    send: true
  - label: Implementar Projeto
    agent: speckit.implement
    prompt: Iniciar implementacao em fases
    send: true
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

1. **Preparacao**: Rodar `.specify/scripts/bash/check-prerequisites.sh --json` na raiz
   do repositorio e interpretar FEATURE_DIR e AVAILABLE_DOCS. Todos os caminhos devem
   ser absolutos. Para aspas simples em argumentos como "I'm Groot", use escape:
   ex. 'I'\''m Groot' (ou aspas duplas se possivel: "I'm Groot").

2. **Carregar documentos de design**: Ler de FEATURE_DIR:
   - **Obrigatorios**: plan.md (stack, bibliotecas, estrutura), spec.md (historias e prioridades)
   - **Opcionais**: data-model.md (entidades), contracts/ (endpoints), research.md (decisoes), quickstart.md (cenarios de teste)
   - Nota: Nem todo projeto tem todos os docs. Gere tarefas com base no que existir.

3. **Executar fluxo de geracao de tarefas**:
   - Carregar plan.md e extrair stack, bibliotecas, estrutura do projeto
   - Carregar spec.md e extrair historias com prioridades (P1, P2, P3 etc.)
   - Se data-model.md existir: extrair entidades e mapear para historias
   - Se contracts/ existir: mapear endpoints para historias
   - Se research.md existir: extrair decisoes para tarefas de setup
   - Gerar tarefas organizadas por historia (ver Regras abaixo)
   - Gerar grafo de dependencias com ordem de conclusao por historia
   - Criar exemplos de execucao paralela por historia
   - Validar completude (cada historia com tarefas necessarias e testaveis)

4. **Gerar tasks.md**: Usar `.specify/templates/tasks-template.md` e preencher com:
   - Nome correto da funcionalidade do plan.md
   - Fase 1: tarefas de preparacao (inicializacao)
   - Fase 2: tarefas de fundacao (bloqueantes)
   - Fase 3+: uma fase por historia (ordem de prioridade)
   - Cada fase inclui: objetivo, criterio de teste independente, testes (se solicitados), implementacao
   - Fase final: refinamento e preocupacoes transversais
   - Todas as tarefas devem seguir o formato estrito (ver Regras abaixo)
   - Caminhos de arquivo claros em cada tarefa
   - Secao de dependencias com ordem de conclusao
   - Exemplos de execucao paralela por historia
   - Estrategia de implementacao (MVP primeiro, entrega incremental)

5. **Reportar**: Informar caminho do tasks.md e resumo:
   - Total de tarefas
   - Total por historia
   - Oportunidades de paralelo
   - Criterios de teste independente por historia
   - Escopo MVP sugerido (tipicamente Historia de Usuario 1)
   - Validacao de formato: confirmar que TODAS as tarefas seguem o checklist

Contexto para geracao: $ARGUMENTS

O tasks.md deve ser imediatamente executavel - cada tarefa deve ser especifica o
suficiente para que um LLM conclua sem contexto adicional.

## Regras de Geracao de Tarefas

**CRITICO**: Tarefas DEVEM ser organizadas por historia de usuario para permitir
implementacao e testes independentes.

**Testes sao OPCIONAIS**: So gerar tarefas de teste se solicitado na especificacao
ou se o usuario pedir abordagem TDD.

### Formato de Checklist (OBRIGATORIO)

Toda tarefa DEVE seguir estritamente este formato:

```text
- [ ] [IDTarefa] [P?] [Historia?] Descricao com caminho de arquivo
```

**Componentes do Formato**:

1. **Checkbox**: Sempre iniciar com `- [ ]`
2. **ID da tarefa**: Numero sequencial (T001, T002, T003...) na ordem de execucao
3. **Marcador [P]**: Incluir SOMENTE se a tarefa for paralelizavel (arquivos diferentes, sem dependencias)
4. **Rotulo [Historia]**: OBRIGATORIO apenas nas fases de historias
   - Formato: [HU1], [HU2], [HU3] etc. (mapeia historias do spec.md)
   - Fase de Preparacao: sem rotulo
   - Fase de Fundacao: sem rotulo
   - Fases de Historia: DEVEM ter rotulo
   - Fase de Refinos: sem rotulo
5. **Descricao**: Acao clara com caminho de arquivo exato

**Exemplos**:

- CORRETO: `- [ ] T001 Criar estrutura do projeto conforme o plano`
- CORRETO: `- [ ] T005 [P] Implementar middleware de autenticacao em src/middleware/auth.py`
- CORRETO: `- [ ] T012 [P] [HU1] Criar modelo Usuario em src/models/usuario.py`
- CORRETO: `- [ ] T014 [HU1] Implementar ServicoUsuario em src/services/servico_usuario.py`
- ERRADO: `- [ ] Criar modelo Usuario` (sem ID e rotulo de historia)
- ERRADO: `T001 [HU1] Criar modelo` (sem checkbox)
- ERRADO: `- [ ] [HU1] Criar modelo Usuario` (sem ID)
- ERRADO: `- [ ] T001 [HU1] Criar modelo` (sem caminho de arquivo)

### Organizacao das Tarefas

1. **A partir das Historias (spec.md)** - ORGANIZACAO PRINCIPAL:
   - Cada historia (P1, P2, P3...) recebe sua propria fase
   - Mapear componentes relacionados a historia:
     - Modelos necessarios
     - Servicos necessarios
     - Endpoints/UI necessarios
     - Se testes solicitados: testes especificos
   - Marcar dependencias entre historias (a maioria deve ser independente)

2. **A partir dos Contratos**:
   - Mapear cada contrato/endpoint para a historia correspondente
   - Se testes solicitados: cada contrato -> tarefa de teste de contrato [P] antes da implementacao

3. **A partir do Modelo de Dados**:
   - Mapear cada entidade para as historias que a usam
   - Se entidade servir varias historias: colocar na historia mais cedo ou na Preparacao
   - Relacionamentos -> tarefas na camada de servico da historia apropriada

4. **A partir de Preparacao/Infraestrutura**:
   - Infra compartilhada -> Fase de Preparacao (Fase 1)
   - Tarefas bloqueantes -> Fase de Fundacao (Fase 2)
   - Setup especifico de historia -> dentro da fase da historia

### Estrutura de Fases

- **Fase 1**: Preparacao (inicializacao)
- **Fase 2**: Fundacao (bloqueante - DEVE concluir antes das historias)
- **Fase 3+**: Historias em ordem de prioridade (P1, P2, P3...)
  - Dentro de cada historia: Testes (se solicitados) -> Modelos -> Servicos -> Endpoints -> Integracao
  - Cada fase deve ser incremento completo e testavel
- **Fase Final**: Refinos e Preocupacoes Transversais
