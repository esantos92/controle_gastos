---
description: Criar ou atualizar a constituicao do projeto com base em principios fornecidos, mantendo templates dependentes sincronizados.
handoffs:
  - label: Criar Especificacao
    agent: speckit.specify
    prompt: Implementar a especificacao da funcionalidade com base na constituicao atualizada. Quero construir...
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

Voce esta atualizando a constituicao do projeto em `.specify/memory/constitution.md`.
Este arquivo e um MODELO com placeholders entre colchetes (ex.: `[PROJECT_NAME]`,
`[PRINCIPLE_1_NAME]`). Seu trabalho e (a) coletar/derivar valores concretos,
(b) preencher o modelo com precisao e (c) propagar alteracoes para artefatos
dependentes.

Siga este fluxo:

1. Carregue o modelo em `.specify/memory/constitution.md`.
   - Identifique todo placeholder do tipo `[ALL_CAPS_IDENTIFIER]`.
   **IMPORTANTE**: O usuario pode exigir menos ou mais principios do que no modelo.
   Se um numero for especificado, respeite-o e ajuste o documento.

2. Colete/derive valores para placeholders:
   - Se a conversa fornecer valor, use-o.
   - Caso contrario, inferir do contexto do repo (README, docs, versoes anteriores).
   - Para datas de governanca: `RATIFICATION_DATE` e a data original (se desconhecida,
     pedir ou marcar TODO), `LAST_AMENDED_DATE` e hoje se houver mudancas.
   - `CONSTITUTION_VERSION` deve seguir semver:
     - MAJOR: mudancas incompativeis ou remocao/redefinicao de principios.
     - MINOR: novo principio/secao ou expansao material.
     - PATCH: esclarecimentos, ajustes de texto, correcoes.
   - Se o tipo de incremento for ambiguo, explique o raciocinio antes de finalizar.

3. Redija o conteudo atualizado:
   - Substitua todos os placeholders por texto concreto (sem tokens restantes,
     exceto se intencional e justificado).
   - Preservar hierarquia de titulos; comentarios podem ser removidos apos substituicao.
   - Cada principio deve ter: nome conciso, regras nao negociaveis, e racional se necessario.
   - A secao de Governanca deve listar procedimento de emenda, politica de versionamento
     e expectativa de revisao de conformidade.

4. Checklist de propagacao (validacoes ativas):
   - Ler `.specify/templates/plan-template.md` e alinhar "Verificacao da Constituicao".
   - Ler `.specify/templates/spec-template.md` e alinhar escopo/requisitos.
   - Ler `.specify/templates/tasks-template.md` e alinhar categorias de tarefas.
   - Ler comandos em `.specify/templates/commands/*.md` (incluindo este) para remover
     referencias desatualizadas.
   - Ler docs de orientacao em tempo de execucao (ex.: `README.md`, `docs/quickstart.md`)
     e atualizar referencias aos principios.

5. Produzir Relatorio de Impacto de Sincronizacao (comentario HTML no topo):
   - Alteracao de versao: antiga -> nova
   - Lista de principios modificados (titulo antigo -> novo se renomeado)
   - Secoes adicionadas
   - Secoes removidas
   - Templates que exigiram atualizacao (OK atualizado / PENDENTE) com caminhos
   - TODOs de acompanhamento se houver placeholders adiados

6. Validacao antes de finalizar:
   - Nenhum placeholder sem explicacao.
   - Linha de versao combina com o relatorio.
   - Datas em formato ISO YYYY-MM-DD.
   - Principios declarativos, testaveis e sem linguagem vaga ("deve"/"deveria").

7. Grave a constituicao final em `.specify/memory/constitution.md` (sobrescrever).

8. Responda ao usuario com:
   - Nova versao e racional do incremento.
   - Arquivos com pendencias de acompanhamento.
   - Mensagem de commit sugerida (ex.: `docs: atualizar constituicao para vX.Y.Z`).

Requisitos de formato e estilo:

- Usar titulos exatamente como no modelo (nao promover/diminuir niveis).
- Quebrar linhas longas para legibilidade (ate ~100 caracteres quando possivel).
- Manter um espaco em branco entre secoes.
- Evitar espacos em branco no final das linhas.

Se o usuario fornecer atualizacoes parciais (ex.: so um principio), ainda execute
validacoes e decisao de versao.

Se informacao critica faltar (ex.: data de ratificacao), inserir
`TODO(<FIELD_NAME>): explicacao` e incluir no relatorio.

Nao criar novo modelo; sempre operar no arquivo existente.
