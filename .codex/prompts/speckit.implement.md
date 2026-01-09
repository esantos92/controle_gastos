---
description: Executar o plano de implementacao processando e executando todas as tarefas definidas em tasks.md
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

1. Rodar `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks`
   na raiz do repositorio e interpretar FEATURE_DIR e AVAILABLE_DOCS. Todos os
   caminhos devem ser absolutos. Para aspas simples em argumentos como "I'm Groot",
   use escape: ex. 'I'\''m Groot' (ou aspas duplas se possivel: "I'm Groot").

2. **Checar status de checklists** (se FEATURE_DIR/checklists/ existir):
   - Escanear todos os arquivos em checklists/
   - Para cada checklist, contar:
     - Total: linhas com `- [ ]` ou `- [X]` ou `- [x]`
     - Concluidos: linhas com `- [X]` ou `- [x]`
     - Pendentes: linhas com `- [ ]`
   - Criar tabela de status:

     ```text
     | Checklist | Total | Concluidos | Pendentes | Status |
     |-----------|-------|------------|-----------|--------|
     | ux.md     | 12    | 12         | 0         | PASS   |
     | teste.md  | 8     | 5          | 3         | FAIL   |
     | seguranca.md | 6  | 6          | 0         | PASS   |
     ```

   - Calcular status geral:
     - **PASS**: todos com 0 pendentes
     - **FAIL**: um ou mais com pendentes

   - **Se algum checklist estiver pendente**:
     - Exibir a tabela
     - **PARAR** e perguntar: "Ha checklists pendentes. Deseja prosseguir? (sim/nao)"
     - Aguardar resposta
     - Se usuario disser "nao" ou "esperar" ou "parar", interromper
     - Se usuario disser "sim" ou "prosseguir" ou "continuar", ir para o passo 3

   - **Se todos estiverem completos**:
     - Exibir a tabela com todos PASS
     - Prosseguir automaticamente

3. Carregar e analisar o contexto de implementacao:
   - **OBRIGATORIO**: Ler tasks.md para lista completa e plano de execucao
   - **OBRIGATORIO**: Ler plan.md para stack, arquitetura e estrutura de arquivos
   - **SE EXISTIR**: Ler data-model.md para entidades e relacionamentos
   - **SE EXISTIR**: Ler contracts/ para especificacoes de API e requisitos de teste
   - **SE EXISTIR**: Ler research.md para decisoes e restricoes
   - **SE EXISTIR**: Ler quickstart.md para cenarios de integracao

4. **Verificacao de Setup do Projeto**:
   - **OBRIGATORIO**: Criar/verificar arquivos ignore conforme o setup real:

   **Logica de Deteccao e Criacao**:
   - Checar se o comando abaixo identifica um repo git (criar/verificar .gitignore se sim):

     ```sh
     git rev-parse --git-dir 2>/dev/null
     ```

   - Se existir Dockerfile* ou Docker no plan.md -> criar/verificar .dockerignore
   - Se existir .eslintrc* -> criar/verificar .eslintignore
   - Se existir eslint.config.* -> garantir `ignores` cobrindo padroes necessarios
   - Se existir .prettierrc* -> criar/verificar .prettierignore
   - Se existir .npmrc ou package.json -> criar/verificar .npmignore (se publicar)
   - Se existir arquivos terraform (*.tf) -> criar/verificar .terraformignore
   - Se houver charts helm -> criar/verificar .helmignore

   **Se ignore ja existir**: Verificar se contem padroes essenciais; acrescentar faltantes
   **Se ignore faltar**: Criar com conjunto completo para a tecnologia detectada

   **Padroes comuns por tecnologia** (da stack no plan.md):
   - **Node.js/JavaScript/TypeScript**: `node_modules/`, `dist/`, `build/`, `*.log`, `.env*`
   - **Python**: `__pycache__/`, `*.pyc`, `.venv/`, `venv/`, `dist/`, `*.egg-info/`
   - **Java**: `target/`, `*.class`, `*.jar`, `.gradle/`, `build/`
   - **C#/.NET**: `bin/`, `obj/`, `*.user`, `*.suo`, `packages/`
   - **Go**: `*.exe`, `*.test`, `vendor/`, `*.out`
   - **Ruby**: `.bundle/`, `log/`, `tmp/`, `*.gem`, `vendor/bundle/`
   - **PHP**: `vendor/`, `*.log`, `*.cache`, `*.env`
   - **Rust**: `target/`, `debug/`, `release/`, `*.rs.bk`, `*.rlib`, `*.prof*`, `.idea/`, `*.log`, `.env*`
   - **Kotlin**: `build/`, `out/`, `.gradle/`, `.idea/`, `*.class`, `*.jar`, `*.iml`, `*.log`, `.env*`
   - **C++**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.so`, `*.a`, `*.exe`, `*.dll`, `.idea/`, `*.log`, `.env*`
   - **C**: `build/`, `bin/`, `obj/`, `out/`, `*.o`, `*.a`, `*.so`, `*.exe`, `Makefile`, `config.log`, `.idea/`, `*.log`, `.env*`
   - **Swift**: `.build/`, `DerivedData/`, `*.swiftpm/`, `Packages/`
   - **R**: `.Rproj.user/`, `.Rhistory`, `.RData`, `.Ruserdata`, `*.Rproj`, `packrat/`, `renv/`
   - **Universal**: `.DS_Store`, `Thumbs.db`, `*.tmp`, `*.swp`, `.vscode/`, `.idea/`

   **Padroes por ferramenta**:
   - **Docker**: `node_modules/`, `.git/`, `Dockerfile*`, `.dockerignore`, `*.log*`, `.env*`, `coverage/`
   - **ESLint**: `node_modules/`, `dist/`, `build/`, `coverage/`, `*.min.js`
   - **Prettier**: `node_modules/`, `dist/`, `build/`, `coverage/`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
   - **Terraform**: `.terraform/`, `*.tfstate*`, `*.tfvars`, `.terraform.lock.hcl`
   - **Kubernetes/k8s**: `*.secret.yaml`, `secrets/`, `.kube/`, `kubeconfig*`, `*.key`, `*.crt`

5. Interpretar estrutura de tasks.md e extrair:
   - **Fases**: Preparacao, Testes, Core, Integracao, Refinos
   - **Dependencias**: regras de execucao sequencial vs paralelo
   - **Detalhes**: ID, descricao, caminhos, marcadores [P]
   - **Fluxo de execucao**: ordem e dependencias

6. Executar a implementacao seguindo o plano:
   - **Fase por fase**: concluir cada fase antes da proxima
   - **Respeitar dependencias**: tarefas sequenciais em ordem; [P] podem rodar juntas
   - **Seguir TDD**: executar testes antes das tarefas de implementacao
   - **Coordenacao por arquivo**: tarefas no mesmo arquivo devem ser sequenciais
   - **Checkpoints**: verificar conclusao de cada fase

7. Regras de execucao da implementacao:
   - **Setup primeiro**: inicializar estrutura, dependencias, configuracao
   - **Testes antes do codigo**: se precisar escrever testes de contratos, entidades e integracao
   - **Desenvolvimento core**: implementar modelos, servicos, comandos CLI, endpoints
   - **Integracao**: conexoes de banco, middleware, logs, servicos externos
   - **Refino e validacao**: testes unitarios, otimizacao, documentacao

8. Acompanhar progresso e tratar erros:
   - Reportar progresso apos cada tarefa concluida
   - Parar se tarefa nao paralela falhar
   - Para tarefas [P], continuar as bem-sucedidas e reportar falhas
   - Fornecer mensagens de erro com contexto
   - Sugerir proximos passos se nao puder continuar
   - **IMPORTANTE**: Marcar tarefas concluidas como [X] no tasks.md

9. Validacao de conclusao:
   - Verificar se todas as tarefas obrigatorias estao completas
   - Checar se funcionalidades implementadas atendem a especificacao
   - Validar se testes passam e cobertura atende requisitos
   - Confirmar aderencia ao plano tecnico
   - Reportar status final com resumo do trabalho concluido

Nota: Este comando assume tasks.md completo. Se faltarem tarefas, sugerir
rodar `/speckit.tasks` primeiro.
