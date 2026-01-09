---
description: Identificar areas subespecificadas na especificacao atual fazendo ate 5 perguntas direcionadas e registrando respostas na spec.
handoffs:
  - label: Criar Plano Tecnico
    agent: speckit.plan
    prompt: Crie um plano para a especificacao. Estou construindo com...
---

## Entrada do Usuario

```text
$ARGUMENTS
```

Voce DEVE considerar a entrada do usuario antes de prosseguir (se nao estiver vazia).

## Roteiro

Objetivo: Detectar e reduzir ambiguidades ou pontos de decisao ausentes na
especificacao ativa e registrar esclarecimentos diretamente no arquivo spec.

Nota: Este fluxo de esclarecimento deve rodar (e ser concluido) ANTES de invocar
`/speckit.plan`. Se o usuario disser explicitamente que vai pular esclarecimento
(ex.: exploracao), voce pode prosseguir, mas DEVE alertar que o risco de retrabalho
aumenta.

Etapas de execucao:

1. Rodar `.specify/scripts/bash/check-prerequisites.sh --json --paths-only` na raiz
   do repositorio **uma vez** (modo combinado `--json --paths-only` / `-Json -PathsOnly`).
   Interpretar o JSON minimo:
   - `FEATURE_DIR`
   - `FEATURE_SPEC`
   - (Opcionalmente capturar `IMPL_PLAN`, `TASKS` para fluxos encadeados.)
   - Se a leitura do JSON falhar, abortar e instruir o usuario a rodar
     `/speckit.specify` ou verificar o ambiente da branch.
   - Para aspas simples em argumentos como "I'm Groot", use escape: ex. 'I'\''m Groot'
     (ou aspas duplas se possivel: "I'm Groot").

2. Carregar o arquivo spec atual. Fazer varredura estruturada de ambiguidade e
   cobertura com esta taxonomia. Para cada categoria, marcar: Claro / Parcial / Ausente.
   Produzir mapa interno para priorizacao (nao exibir bruto, a menos que nao haja perguntas).

   Escopo Funcional e Comportamento:
   - Objetivos centrais do usuario e criterios de sucesso
   - Declaracoes explicitas de fora do escopo
   - Diferenciacao de papeis/personas

   Dominio e Modelo de Dados:
   - Entidades, atributos, relacionamentos
   - Regras de identidade e unicidade
   - Transicoes de ciclo de vida/estado
   - Volume de dados/assuncoes de escala

   Interacao e Fluxo de UX:
   - Jornadas criticas / sequencias
   - Estados de erro/vazio/carregamento
   - Observacoes de acessibilidade ou localizacao

   Atributos de Qualidade Nao Funcionais:
   - Desempenho (latencia, throughput)
   - Escalabilidade (horizontal/vertical, limites)
   - Confiabilidade e disponibilidade (uptime, recuperacao)
   - Observabilidade (logs, metricas, rastreamento (tracing))
   - Seguranca e privacidade (authN/Z, protecao de dados, ameacas)
   - Conformidade/regulatorio (se houver)

   Integracao e Dependencias Externas:
   - Servicos/APIs externas e modos de falha
   - Formatos de importacao/exportacao de dados
   - Assuncoes de protocolo/versionamento

   Casos de Borda e Tratamento de Falhas:
   - Cenarios negativos
   - Rate limiting / throttling
   - Resolucao de conflitos (ex.: edicoes concorrentes)

   Restricoes e Compensacoes:
   - Restricoes tecnicas (linguagem, armazenamento, hospedagem)
   - Compensacoes explicitos ou alternativas rejeitadas

   Terminologia e Consistencia:
   - Termos canonicos de glossario
   - Sinonimos evitados / termos obsoletos

   Sinais de Conclusao:
   - Criterios de aceite testaveis
   - Indicadores mensuraveis de Definicao de Pronto (Definition of Done)

   Varios / Placeholders:
   - Marcadores TODO / decisoes pendentes
   - Adjetivos ambiguos ("robusto", "intuitivo") sem quantificacao

   Para cada categoria Parcial ou Ausente, adicionar candidato de pergunta a menos que:
   - O esclarecimento nao mude materialmente a implementacao ou validacao
   - A informacao seja melhor adiada para a fase de planejamento (anotar internamente)

3. Gerar (internamente) uma fila priorizada de perguntas (maximo 5). Nao exibir
   todas de uma vez. Aplicar:
    - Maximo de 10 perguntas na sessao inteira.
    - Cada pergunta deve ter resposta em:
       - Multipla escolha curta (2-5 opcoes exclusivas), OU
       - Resposta curta (<=5 palavras).
    - Apenas perguntas que impactem arquitetura, modelagem de dados, decomposicao de tarefas,
      testes, UX, prontidao operacional ou conformidade.
    - Balancear categorias: cobrir primeiro as mais impactantes; evitar duas perguntas de baixo impacto
      quando uma area critica (ex.: postura de seguranca) estiver pendente.
    - Excluir perguntas ja respondidas, preferencias triviais, ou detalhes de execucao de plano
      (a menos que bloqueiem a corretude).
    - Priorizar esclarecimentos que reduzam retrabalho ou previnam testes desalinhados.
    - Se mais de 5 categorias estiverem pendentes, escolher as 5 com maior (Impacto * Incerteza).

4. Loop de perguntas (interativo):
    - Apresentar EXATAMENTE UMA pergunta por vez.
    - Para perguntas de multipla escolha:
       - **Analisar todas as opcoes** e determinar a **opcao mais adequada** com base em:
          - Boas praticas para o tipo de projeto
          - Padroes comuns em implementacoes similares
          - Reducao de risco (seguranca, desempenho, manutencao)
          - Alinhamento com objetivos/restricoes explicitos na spec
       - Apresentar a **opcao recomendada** com justificativa (1-2 frases).
       - Formato: `**Recomendado:** Opcao [X] - <justificativa>`
       - Em seguida, renderizar tabela Markdown:

       | Opcao | Descricao |
       |-------|-----------|
       | A | <Descricao da Opcao A> |
       | B | <Descricao da Opcao B> |
       | C | <Descricao da Opcao C> (adicionar D/E ate 5) |
       | Curta | Fornecer resposta curta diferente (<=5 palavras) (apenas se apropriado) |

       - Depois da tabela, adicionar: `Voce pode responder com a letra (ex.: "A"),
         aceitar a recomendacao dizendo "sim" ou "recomendado", ou enviar sua propria resposta curta.`
    - Para perguntas de resposta curta (sem opcoes significativas):
       - Fornecer **resposta sugerida** com base em boas praticas e contexto.
       - Formato: `**Sugerido:** <resposta proposta> - <justificativa>`
       - Depois: `Formato: Resposta curta (<=5 palavras). Voce pode aceitar dizendo
         "sim" ou "sugerido", ou enviar sua resposta.`
    - Depois da resposta do usuario:
       - Se o usuario responder "sim", "recomendado" ou "sugerido", usar a recomendacao.
       - Caso contrario, validar se mapeia a uma opcao ou respeita <=5 palavras.
       - Se ambiguo, pedir desambiguacao rapida (mesma pergunta; nao avancar).
       - Ao aceitar, registrar em memoria de trabalho (nao gravar ainda) e seguir.
    - Parar quando:
       - Ambiguidades criticas resolvidas cedo (resto fica desnecessario), OU
       - Usuario sinaliza fim ("done", "ok", "sem mais"), OU
       - Atingir 5 perguntas.
    - Nunca revelar perguntas futuras.
    - Se nao houver perguntas validas no inicio, reportar sem ambiguidades criticas.

5. Integracao apos CADA resposta aceita (atualizacao incremental):
    - Manter representacao em memoria da spec (carregada no inicio) + conteudo bruto.
    - Para a primeira resposta integrada:
       - Garantir secao `## Esclarecimentos` (criar logo apos a secao contextual/visao geral se faltar).
       - Embaixo, criar subsecao `### Sessao YYYY-MM-DD` para hoje.
    - Adicionar linha de bullet: `- Q: <pergunta> -> A: <resposta final>`.
    - Aplicar esclarecimento na secao mais apropriada:
       - Ambiguidade funcional -> Atualizar/adicionar bullet em Requisitos Funcionais.
       - Interacao/ator -> Atualizar Historias de Usuario ou secao de Atores.
       - Dados/entidades -> Atualizar Modelo de Dados (campos, tipos, relacoes) mantendo ordem.
       - Nao funcional -> Adicionar/modificar criterio mensuravel em Qualidade.
       - Caso de borda/fluxo negativo -> Adicionar bullet em Casos de Borda/Erros.
       - Conflito terminologico -> Normalizar termo; manter antigo so se necessario com
         `(antes referido como "X")` uma vez.
    - Se o esclarecimento invalida declaracao anterior ambigua, substituir em vez de duplicar.
    - Salvar spec APOS cada integracao para reduzir risco de perda (sobrescrita atomica).
    - Preservar formato: nao reordenar secoes; manter hierarquia de titulos.
    - Manter cada esclarecimento minimo e testavel (evitar narrativas).

6. Validacao (apos CADA escrita + passagem final):
   - Sessao de esclarecimentos com exatamente um bullet por resposta aceita (sem duplicacao).
   - Total de perguntas aceitas <= 5.
   - Secoes atualizadas sem placeholders vagos relacionados.
   - Sem contradicoes antigas (remover alternativas invalidadas).
   - Estrutura Markdown valida; novos titulos permitidos: `## Esclarecimentos`, `### Sessao YYYY-MM-DD`.
   - Consistencia terminologica: mesmo termo canonico nas secoes atualizadas.

7. Gravar a spec atualizada em `FEATURE_SPEC`.

8. Reportar conclusao:
   - Numero de perguntas feitas e respondidas.
   - Caminho para a spec atualizada.
   - Secoes tocadas (listar nomes).
   - Tabela de cobertura com cada categoria e Status: Resolvido (era Parcial/Ausente e foi tratado),
     Adiado (passou do limite ou melhor no planejamento), Claro (ja suficiente),
     Pendente (ainda Parcial/Ausente, baixo impacto).
   - Se houver Pendente/Adiado, recomendar seguir para `/speckit.plan` ou rodar
     `/speckit.clarify` novamente apos o plano.
   - Sugerir proximo comando.

Regras de comportamento:

- Se nenhuma ambiguidade relevante for encontrada, responder:
  "Nenhuma ambiguidade critica detectada para esclarecimento formal." e sugerir avancar.
- Se spec faltar, instruir a rodar `/speckit.specify` primeiro (nao criar spec aqui).
- Nunca exceder 5 perguntas (repeticoes para desambiguar nao contam como novas).
- Evitar perguntas especulativas de stack se a ausencia nao bloquear clareza funcional.
- Respeitar sinais de encerramento do usuario ("stop", "done", "proceed").
- Se nao houver perguntas por cobertura completa, emitir resumo compacto e sugerir avancar.
- Se o limite for atingido com categorias criticas pendentes, marcar como Adiado com justificativa.

Contexto para priorizacao: $ARGUMENTS
