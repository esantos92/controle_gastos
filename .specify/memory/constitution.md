<!--
Relatorio de Impacto de Sincronizacao
- Alteracao de versao: 1.0.0 -> 1.1.0
- Principios modificados: N/D
- Principios adicionados: Projeto laboratorio: testes opcionais e dependencias enxutas
- Secoes adicionadas: Regras de laboratorio e dependencias
- Secoes removidas: N/D
- Modelos que exigiram atualizacao:
  - ✅ .specify/templates/plan-template.md
  - ✅ .specify/templates/spec-template.md
  - ✅ .specify/templates/tasks-template.md
- TODOs de acompanhamento:
  - TODO(RATIFICATION_DATE): data de ratificacao original nao informada
-->
# Constituicao do Controle de Gastos

## Principios Centrais

### Idioma padrao e exclusivo (prioridade maxima)
Todo conteudo fora de blocos de codigo DEVE ser escrito em Portugues do Brasil
(pt-BR). Esta regra tem prioridade maxima e se aplica a planos, tarefas,
especificacoes, prompts de CLI, exemplos, comentarios, titulos, arquivos
gerados, nomes de secoes e qualquer texto. E proibido misturar idiomas; use
termos em ingles apenas quando for codigo, nome proprio, ou termo tecnico sem
traducao comum (neste caso, usar traducao + termo original entre parenteses na
primeira ocorrencia). Racional: garantir consistencia, clareza e comunicacao
inequivoca no projeto.

### Projeto laboratorio: testes opcionais e dependencias enxutas
Este projeto e um laboratorio de estudos e praticas. Nao ha necessidade de
criar testes unitarios, de integracao, e2e ou similares; a validacao pode ser
manual quando suficiente. Evitar excesso de dependencias: adicionar bibliotecas
apenas quando forem essenciais e justificar a escolha. Racional: manter o foco
no aprendizado, na simplicidade e na manutencao leve.

## Regras de idioma e comunicacao

- Todo texto fora de blocos de codigo DEVE estar em pt-BR, sem mistura de idiomas.
- Termos tecnicos sem traducao comum DEVEM vir com traducao + termo original na
  primeira ocorrencia.
- Nao usar termos em ingles para titulos, nomes de secoes, exemplos ou comentarios.
- Excecoes permitidas: codigo, nomes proprios, bibliotecas, ferramentas e servicos.
- Revisar a conformidade com estas regras antes de finalizar qualquer entrega.

## Regras de laboratorio e dependencias

- Testes automatizados nao sao obrigatorios neste projeto-laboratorio.
- Validacoes manuais sao aceitaveis quando cobrem o comportamento principal.
- Novas dependencias DEVEM ser minimas e justificadas no contexto.
- Evitar frameworks ou bibliotecas redundantes quando houver alternativa mais simples.

## Fluxo de trabalho e revisao de conformidade

- Todo artefato novo ou atualizado DEVE passar por revisao de idioma antes de ser
  considerado concluido.
- Ajustes de idioma em templates e prompts DEVEM ser propagados para evitar
  inconsistencias futuras.
- Se houver necessidade de excecao, documentar a justificativa no artefato
  afetado e registrar na governanca.

## Governanca

- A Constituicao prevalece sobre praticas locais e templates.
- Alteracoes exigem documentacao, justificativa e atualizacao dos templates
  dependentes.
- Versionamento semantico: MAJOR para mudancas incompativeis, MINOR para novas
  regras ou expansoes materiais, PATCH para ajustes de texto sem impacto.
- Toda revisao deve verificar conformidade com os principios e regras de idioma.

**Versao**: 1.1.0 | **Ratificada**: TODO(RATIFICATION_DATE): data de ratificacao original nao informada | **Ultima Alteracao**: 2026-01-09
