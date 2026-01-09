---

description: "Modelo de lista de tarefas para implementacao de funcionalidade"
---

# Tarefas: [NOME DA FUNCIONALIDADE]

**Entrada**: Documentos de design em `/specs/[###-feature-name]/`
**Pre-requisitos**: plan.md (obrigatorio), spec.md (obrigatorio para historias), research.md, data-model.md, contracts/

**Testes**: Os exemplos abaixo incluem tarefas de teste. Testes nao sao obrigatorios neste projeto-laboratorio e so devem entrar se solicitados explicitamente na especificacao.

**Organizacao**: As tarefas sao agrupadas por historia de usuario para permitir implementacao e testes independentes.

## Formato: `[ID] [P?] [Historia] Descricao`

- **[P]**: Pode rodar em paralelo (arquivos diferentes, sem dependencias)
- **[Historia]**: A qual historia esta tarefa pertence (ex.: HU1, HU2, HU3)
- Inclua caminhos exatos de arquivos nas descricoes

## Convencoes de Caminho

- **Projeto unico**: `src/`, `tests/` na raiz do repositorio
- **Aplicacao web**: `backend/src/`, `frontend/src/`
- **Mobile**: `api/src/`, `ios/src/` ou `android/src/`
- Os caminhos abaixo assumem projeto unico - ajuste conforme a estrutura do plan.md

<!--
  ============================================================================
  IMPORTANTE: As tarefas abaixo sao APENAS EXEMPLOS para ilustracao.

  O comando /speckit.tasks DEVE substituir estes exemplos por tarefas reais com base em:
  - Historias de usuario do spec.md (com prioridades P1, P2, P3...)
  - Requisitos da funcionalidade no plan.md
  - Entidades do data-model.md
  - Endpoints de contracts/

  As tarefas DEVEM ser organizadas por historia de usuario para que cada historia possa ser:
  - Implementada de forma independente
  - Testada de forma independente
  - Entregue como incremento de produto minimo viavel (MVP)

  NAO mantenha estas tarefas de exemplo no arquivo tasks.md gerado.
  ============================================================================
-->

## Fase 1: Preparacao (Infraestrutura Compartilhada)

**Proposito**: Inicializacao do projeto e estrutura basica

- [ ] T001 Criar estrutura do projeto conforme o plano de implementacao
- [ ] T002 Inicializar projeto em [linguagem] com dependencias de [framework]
- [ ] T003 [P] Configurar ferramentas de lint e formatacao

---

## Fase 2: Fundacao (Pre-requisitos Bloqueantes)

**Proposito**: Infraestrutura central que DEVE estar pronta antes de qualquer historia

**CRITICO**: Nenhuma historia pode iniciar ate esta fase estar concluida

Exemplos de tarefas de fundacao (ajuste conforme o projeto):

- [ ] T004 Configurar esquema de banco e framework de migracoes
- [ ] T005 [P] Implementar framework de autenticacao/autorizacao
- [ ] T006 [P] Configurar roteamento de API e middleware
- [ ] T007 Criar modelos/entidades base que todas as historias dependem
- [ ] T008 Configurar tratamento de erros e infraestrutura de logs
- [ ] T009 Configurar gerenciamento de configuracao de ambiente

**Checkpoint**: Fundacao pronta - historias podem iniciar em paralelo

---

## Fase 3: Historia de Usuario 1 - [Titulo] (Prioridade: P1) Produto minimo viavel (MVP)

**Objetivo**: [Descricao breve do que esta historia entrega]

**Teste Independente**: [Como verificar que esta historia funciona sozinha]

### Testes para Historia de Usuario 1 (OPCIONAL - apenas se testes solicitados)

> **NOTA: Escreva estes testes PRIMEIRO e garanta que FALHEM antes de implementar**

- [ ] T010 [P] [HU1] Teste de contrato para [endpoint] em tests/contract/test_[nome].py
- [ ] T011 [P] [HU1] Teste de integracao para [jornada] em tests/integration/test_[nome].py

### Implementacao da Historia de Usuario 1

- [ ] T012 [P] [HU1] Criar modelo [Entidade1] em src/models/[entidade1].py
- [ ] T013 [P] [HU1] Criar modelo [Entidade2] em src/models/[entidade2].py
- [ ] T014 [HU1] Implementar [Servico] em src/services/[servico].py (depende de T012, T013)
- [ ] T015 [HU1] Implementar [endpoint/funcionalidade] em src/[local]/[arquivo].py
- [ ] T016 [HU1] Adicionar validacao e tratamento de erros
- [ ] T017 [HU1] Adicionar logs para operacoes da historia 1

**Checkpoint**: Aqui, a Historia de Usuario 1 deve estar funcional e testavel de forma independente

---

## Fase 4: Historia de Usuario 2 - [Titulo] (Prioridade: P2)

**Objetivo**: [Descricao breve do que esta historia entrega]

**Teste Independente**: [Como verificar que esta historia funciona sozinha]

### Testes para Historia de Usuario 2 (OPCIONAL - apenas se testes solicitados)

- [ ] T018 [P] [HU2] Teste de contrato para [endpoint] em tests/contract/test_[nome].py
- [ ] T019 [P] [HU2] Teste de integracao para [jornada] em tests/integration/test_[nome].py

### Implementacao da Historia de Usuario 2

- [ ] T020 [P] [HU2] Criar modelo [Entidade] em src/models/[entidade].py
- [ ] T021 [HU2] Implementar [Servico] em src/services/[servico].py
- [ ] T022 [HU2] Implementar [endpoint/funcionalidade] em src/[local]/[arquivo].py
- [ ] T023 [HU2] Integrar com componentes da Historia de Usuario 1 (se necessario)

**Checkpoint**: Aqui, as Historias de Usuario 1 e 2 devem funcionar de forma independente

---

## Fase 5: Historia de Usuario 3 - [Titulo] (Prioridade: P3)

**Objetivo**: [Descricao breve do que esta historia entrega]

**Teste Independente**: [Como verificar que esta historia funciona sozinha]

### Testes para Historia de Usuario 3 (OPCIONAL - apenas se testes solicitados)

- [ ] T024 [P] [HU3] Teste de contrato para [endpoint] em tests/contract/test_[nome].py
- [ ] T025 [P] [HU3] Teste de integracao para [jornada] em tests/integration/test_[nome].py

### Implementacao da Historia de Usuario 3

- [ ] T026 [P] [HU3] Criar modelo [Entidade] em src/models/[entidade].py
- [ ] T027 [HU3] Implementar [Servico] em src/services/[servico].py
- [ ] T028 [HU3] Implementar [endpoint/funcionalidade] em src/[local]/[arquivo].py

**Checkpoint**: Todas as historias devem estar funcionais de forma independente

---

[Adicione mais fases de historias conforme necessario, seguindo o mesmo padrao]

---

## Fase N: Refinos e Preocupacoes Transversais

**Proposito**: Melhorias que afetam varias historias

- [ ] TXXX [P] Atualizar documentacao em docs/
- [ ] TXXX Limpeza de codigo e refatoracao
- [ ] TXXX Otimizacao de desempenho em todas as historias
- [ ] TXXX [P] Testes unitarios adicionais (se solicitados) em tests/unit/
- [ ] TXXX Reforco de seguranca
- [ ] TXXX Validar quickstart.md

---

## Dependencias e Ordem de Execucao

### Dependencias por Fase

- **Preparacao (Fase 1)**: Sem dependencias - pode iniciar imediatamente
- **Fundacao (Fase 2)**: Depende da Preparacao - BLOQUEIA todas as historias
- **Historias (Fase 3+)**: Dependem da Fundacao concluida
  - Historias podem seguir em paralelo (se houver capacidade)
  - Ou em sequencia por prioridade (P1 -> P2 -> P3)
- **Refinos (Fase Final)**: Depende de todas as historias desejadas completas

### Dependencias entre Historias

- **Historia de Usuario 1 (P1)**: Pode iniciar apos a Fundacao - sem dependencias
- **Historia de Usuario 2 (P2)**: Pode iniciar apos a Fundacao - pode integrar com HU1, mas deve ser independente
- **Historia de Usuario 3 (P3)**: Pode iniciar apos a Fundacao - pode integrar com HU1/HU2, mas deve ser independente

### Dentro de Cada Historia

- Testes (se incluidos) DEVEM ser escritos e FALHAR antes da implementacao
- Modelos antes de servicos
- Servicos antes de endpoints
- Implementacao central antes de integracao
- Concluir a historia antes de seguir para a proxima prioridade

### Oportunidades de Paralelo

- Todas as tarefas de Preparacao marcadas [P] podem rodar em paralelo
- Todas as tarefas de Fundacao marcadas [P] podem rodar em paralelo (na Fase 2)
- Apos a Fundacao, todas as historias podem iniciar em paralelo (se houver equipe)
- Todos os testes de uma historia marcados [P] podem rodar em paralelo
- Modelos de uma historia marcados [P] podem rodar em paralelo
- Historias diferentes podem ser feitas em paralelo por pessoas diferentes

---

## Exemplo de Paralelo: Historia de Usuario 1

```bash
# Executar todos os testes da Historia de Usuario 1 juntos (se solicitados):
Tarefa: "Teste de contrato para [endpoint] em tests/contract/test_[nome].py"
Tarefa: "Teste de integracao para [jornada] em tests/integration/test_[nome].py"

# Executar todos os modelos da Historia de Usuario 1 juntos:
Tarefa: "Criar modelo [Entidade1] em src/models/[entidade1].py"
Tarefa: "Criar modelo [Entidade2] em src/models/[entidade2].py"
```

---

## Estrategia de Implementacao

### MVP Primeiro (apenas Historia de Usuario 1)

1. Concluir Fase 1: Preparacao
2. Concluir Fase 2: Fundacao (CRITICO - bloqueia todas as historias)
3. Concluir Fase 3: Historia de Usuario 1
4. **PARE e VALIDE**: Testar Historia de Usuario 1 de forma independente
5. Implantar/demonstrar se pronto

### Entrega Incremental

1. Concluir Preparacao + Fundacao -> Fundacao pronta
2. Adicionar Historia de Usuario 1 -> Testar de forma independente -> Implantar/Demonstrar (MVP)
3. Adicionar Historia de Usuario 2 -> Testar de forma independente -> Implantar/Demonstrar
4. Adicionar Historia de Usuario 3 -> Testar de forma independente -> Implantar/Demonstrar
5. Cada historia agrega valor sem quebrar as anteriores

### Estrategia de Equipe em Paralelo

Com varios desenvolvedores:

1. Equipe conclui Preparacao + Fundacao juntos
2. Quando a Fundacao estiver pronta:
   - Desenvolvedor A: Historia de Usuario 1
   - Desenvolvedor B: Historia de Usuario 2
   - Desenvolvedor C: Historia de Usuario 3
3. Historias concluem e integram de forma independente

---

## Observacoes

- Tarefas [P] = arquivos diferentes, sem dependencias
- Rotulo [Historia] mapeia a tarefa para a historia correspondente
- Cada historia deve ser concluida e testada de forma independente
- Verificar testes falhando antes de implementar
- Fazer commit apos cada tarefa ou grupo logico
- Parar em qualquer checkpoint para validar historia de forma independente
- Evitar: tarefas vagas, conflito no mesmo arquivo, dependencias cruzadas
