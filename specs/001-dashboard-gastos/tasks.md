---

description: "Modelo de lista de tarefas para implementacao de funcionalidade"
---

# Tarefas: Controle de gastos com dashboards visuais

**Entrada**: Documentos de design em `/specs/001-dashboard-gastos/`
**Pre-requisitos**: plan.md (obrigatorio), spec.md (obrigatorio para historias), research.md, data-model.md, contracts/

**Testes**: Testes nao foram solicitados; validacao manual por historia.

**Organizacao**: As tarefas sao agrupadas por historia de usuario para permitir implementacao e validacao independentes.

## Formato: `[ID] [P?] [Historia] Descricao`

- **[P]**: Pode rodar em paralelo (arquivos diferentes, sem dependencias)
- **[Historia]**: A qual historia esta tarefa pertence (ex.: US1, US2, US3)
- Inclua caminhos exatos de arquivos nas descricoes

## Convencoes de Caminho

- **Projeto web Rails**: `app/`, `config/`, `db/`, `app/javascript/`, `app/assets/`
- Os caminhos abaixo assumem projeto Rails unico

## Fase 1: Preparacao (Infraestrutura Compartilhada)

**Proposito**: Inicializacao do projeto e estrutura basica

- [x] T001 Inicializar aplicacao Rails na raiz do repositorio e gerar `Gemfile`
- [x] T002 Configurar PostgreSQL em `config/database.yml`
- [x] T003 [P] Registrar dependencias base (pg, hotwire-rails) em `Gemfile` e pin do Chart.js em `config/importmap.rb`
- [x] T004 [P] Configurar importacoes JS e CSS base em `app/javascript/application.js` e `app/assets/stylesheets/application.css`
- [x] T005 Criar configuracao inicial de rotas em `config/routes.rb`

---

## Fase 2: Fundacao (Pre-requisitos Bloqueantes)

**Proposito**: Infraestrutura central que DEVE estar pronta antes de qualquer historia

**CRITICO**: Nenhuma historia pode iniciar ate esta fase estar concluida

- [x] T006 Criar layout base com navegacao em `app/views/layouts/application.html.erb`
- [x] T007 [P] Configurar componentes visuais base em `app/views/shared/_navbar.html.erb`
- [x] T008 [P] Adicionar helpers de formatacao de moeda/data em `app/helpers/application_helper.rb`
- [x] T009 Preparar assets para graficos em `app/javascript/controllers/chart_controller.js`

**Checkpoint**: Fundacao pronta - historias podem iniciar em paralelo

---

## Fase 3: Historia de Usuario 1 - Registrar despesas pessoais (Prioridade: P1) Produto minimo viavel (MVP)

**Objetivo**: Permitir cadastrar, editar, excluir e listar despesas do mes atual

**Validacao Independente**: Registrar tres despesas e confirmar listagem, total do mes e atualizacoes ao editar/excluir

### Implementacao da Historia de Usuario 1

- [x] T010 [US1] Criar migracao de despesas em `db/migrate/202601090001_create_despesas.rb`
- [x] T011 [US1] Implementar modelo e validacoes em `app/models/despesa.rb`
- [x] T012 [US1] Implementar controller CRUD em `app/controllers/despesas_controller.rb`
- [x] T013 [US1] Criar partial de formulario em `app/views/despesas/_form.html.erb`
- [x] T014 [US1] Criar listagem e total mensal em `app/views/despesas/index.html.erb`
- [x] T015 [P] [US1] Criar telas de novo/edicao em `app/views/despesas/new.html.erb` e `app/views/despesas/edit.html.erb`
- [x] T016 [US1] Ajustar rotas de despesas em `config/routes.rb`
- [x] T017 [US1] Adicionar atualizacao reativa da lista via Turbo em `app/views/despesas/create.turbo_stream.erb`
- [x] T018 [US1] Adicionar exportacao CSV no controller e rota em `app/controllers/despesas_controller.rb` e `config/routes.rb`
- [x] T019 [US1] Adicionar importacao CSV e formulario em `app/controllers/despesas_controller.rb` e `app/views/despesas/index.html.erb`

**Checkpoint**: Aqui, a Historia de Usuario 1 deve estar funcional e validavel de forma independente

---

## Fase 4: Historia de Usuario 2 - Visualizar dashboard mensal (Prioridade: P2)

**Objetivo**: Exibir dashboard mensal com total e distribuicao por categoria

**Validacao Independente**: Selecionar um mes e conferir total e distribuicao por categoria somando o mesmo total

### Implementacao da Historia de Usuario 2

- [x] T020 [US2] Criar controller de dashboard mensal em `app/controllers/dashboards_controller.rb`
- [x] T021 [US2] Implementar consulta agregada por categoria em `app/models/despesa.rb`
- [x] T022 [US2] Criar view do dashboard mensal em `app/views/dashboards/mensal.html.erb`
- [x] T023 [US2] Integrar grafico mensal com Chart.js em `app/javascript/controllers/chart_controller.js`
- [x] T024 [US2] Adicionar filtro de mes e atualizacao com Turbo em `app/views/dashboards/_filtro_mes.html.erb`
- [x] T025 [US2] Ajustar rotas do dashboard mensal em `config/routes.rb`

**Checkpoint**: Aqui, as Historias de Usuario 1 e 2 devem funcionar de forma independente

---

## Fase 5: Historia de Usuario 3 - Comparar meses e recorrencias (Prioridade: P3)

**Objetivo**: Comparar meses e destacar categorias recorrentes no periodo

**Validacao Independente**: Selecionar periodo e confirmar comparativo e lista de recorrencias

### Implementacao da Historia de Usuario 3

- [x] T026 [US3] Implementar consulta comparativa por mes em `app/models/despesa.rb`
- [x] T027 [US3] Implementar consulta de recorrencias por categoria em `app/models/despesa.rb`
- [x] T028 [US3] Criar view de comparativo em `app/views/dashboards/comparativo.html.erb`
- [x] T029 [US3] Adicionar grafico comparativo em `app/javascript/controllers/chart_controller.js`
- [x] T030 [US3] Adicionar selecao de periodo em `app/views/dashboards/_filtro_periodo.html.erb`
- [x] T031 [US3] Ajustar rotas do comparativo em `config/routes.rb`

**Checkpoint**: Todas as historias devem estar funcionais de forma independente

---

## Fase N: Refinos e Preocupacoes Transversais

**Proposito**: Melhorias que afetam varias historias

- [x] T032 [P] Ajustar responsividade e estilos gerais em `app/assets/stylesheets/application.css`
- [x] T033 [P] Adicionar estados vazios padronizados em `app/views/shared/_empty_state.html.erb`
- [x] T034 Atualizar textos de ajuda e mensagens em `app/views/shared/_flash.html.erb`
- [x] T035 Revisar consistencia de moeda e datas em `app/helpers/application_helper.rb`
- [x] T036 Validar quickstart e atualizar se necessario em `specs/001-dashboard-gastos/quickstart.md`

---

## Estrategia de Implementacao

- Entregar primeiro o MVP com a Historia 1 (cadastro e listagem de despesas).
- Em seguida, adicionar o dashboard mensal (Historia 2).
- Finalizar com comparativos e recorrencias (Historia 3).
- Refinos por ultimo para evitar retrabalho.

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
- **Historia de Usuario 2 (P2)**: Depende da HU1 para dados existentes
- **Historia de Usuario 3 (P3)**: Depende de HU1 e HU2 para comparativos e recorrencias

### Dentro de Cada Historia

- Modelos antes de controllers
- Controllers antes de views
- Views antes de ajustes reativos com Turbo/JS
- Concluir a historia antes de seguir para a proxima prioridade

### Oportunidades de Paralelo

- T003 e T004 podem rodar em paralelo na Preparacao
- T006, T007, T008 e T009 podem rodar em paralelo na Fundacao
- T013 e T015 podem rodar em paralelo na HU1
- T022 e T024 podem rodar em paralelo na HU2
- T028 e T030 podem rodar em paralelo na HU3
- T032, T033 e T034 podem rodar em paralelo nos Refinos

---

## Exemplo de Paralelo: Historia de Usuario 1

```bash
# Pode executar em paralelo
T013 (formulario) + T015 (telas new/edit)
```
