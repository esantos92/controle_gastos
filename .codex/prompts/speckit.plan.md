---
description: Executar o fluxo de planejamento de implementacao usando o modelo de plano para gerar artefatos de design.
handoffs:
  - label: Criar Tarefas
    agent: speckit.tasks
    prompt: Quebrar o plano em tarefas
    send: true
  - label: Criar Checklist
    agent: speckit.checklist
    prompt: Criar um checklist para o seguinte dominio...
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

1. **Preparacao**: Rodar `.specify/scripts/bash/setup-plan.sh --json` na raiz do repositorio
   e interpretar o JSON para FEATURE_SPEC, IMPL_PLAN, SPECS_DIR, BRANCH.
   Para aspas simples em argumentos como "I'm Groot", use escape: ex. 'I'\''m Groot'
   (ou aspas duplas se possivel: "I'm Groot").

2. **Carregar contexto**: Ler FEATURE_SPEC e `.specify/memory/constitution.md`.
   Carregar o modelo IMPL_PLAN (ja copiado).

3. **Executar fluxo do plano**: Seguir a estrutura do IMPL_PLAN para:
   - Preencher Contexto Tecnico (marcar incertos como "PRECISA DE CLAREZA")
   - Preencher Verificacao da Constituicao
   - Avaliar portoes (ERRO se violacoes sem justificativa)
   - Fase 0: Gerar research.md (resolver todos os "PRECISA DE CLAREZA")
   - Fase 1: Gerar data-model.md, contracts/, quickstart.md
   - Fase 1: Atualizar contexto do agente rodando o script
   - Reavaliar Verificacao da Constituicao apos o design

4. **Parar e reportar**: O comando termina apos o planejamento da Fase 2.
   Reportar branch, caminho do IMPL_PLAN e artefatos gerados.

## Fases

### Fase 0: Esboco e Pesquisa

1. **Extrair incertos do Contexto Tecnico** acima:
   - Para cada PRECISA DE CLAREZA -> tarefa de pesquisa
   - Para cada dependencia -> tarefa de boas praticas
   - Para cada integracao -> tarefa de padroes

2. **Gerar e despachar agentes de pesquisa**:

   ```text
   Para cada incerto no Contexto Tecnico:
     Tarefa: "Pesquisar {incerto} para {contexto da funcionalidade}"
   Para cada escolha de tecnologia:
     Tarefa: "Buscar boas praticas para {tech} em {dominio}"
   ```

3. **Consolidar achados** em `research.md` usando formato:
   - Decisao: [o que foi escolhido]
   - Racional: [por que foi escolhido]
   - Alternativas consideradas: [o que mais foi avaliado]

**Saida**: research.md com todos os "PRECISA DE CLAREZA" resolvidos

### Fase 1: Design e Contratos

**Pre-requisitos:** `research.md` concluido

1. **Extrair entidades da especificacao** -> `data-model.md`:
   - Nome da entidade, campos, relacoes
   - Regras de validacao dos requisitos
   - Transicoes de estado se aplicavel

2. **Gerar contratos de API** a partir de requisitos funcionais:
   - Para cada acao de usuario -> endpoint
   - Usar padroes REST/GraphQL
   - Saida do esquema OpenAPI/GraphQL em `/contracts/`

3. **Atualizacao de contexto do agente**:
   - Rodar `.specify/scripts/bash/update-agent-context.sh codex`
   - Esses scripts detectam o agente de IA em uso
   - Atualizar o arquivo de contexto apropriado
   - Adicionar apenas nova tecnologia do plano atual
   - Preservar adicoes manuais entre marcadores

**Saida**: data-model.md, /contracts/*, quickstart.md, arquivo do agente

## Regras-chave

- Usar caminhos absolutos
- ERRO em falhas de portao ou esclarecimentos pendentes
