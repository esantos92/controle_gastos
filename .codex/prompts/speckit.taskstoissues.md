---
description: Converter tarefas existentes em issues GitHub acionaveis e ordenadas por dependencia para a funcionalidade com base nos artefatos disponiveis.
tools: ['github/github-mcp-server/issue_write']
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
1. A partir do script executado, extrair o caminho para **tasks**.
1. Obter o remote Git rodando:

```bash
git config --get remote.origin.url
```

> [!ATENCAO]
> PROSSIGA SOMENTE SE O REMOTE FOR UMA URL DO GITHUB

1. Para cada tarefa, usar o servidor MCP do GitHub para criar uma issue no repositorio
   correspondente ao remote Git.

> [!ATENCAO]
> NUNCA CRIAR ISSUES EM REPOSITORIOS QUE NAO CORRESPONDEM AO REMOTE
