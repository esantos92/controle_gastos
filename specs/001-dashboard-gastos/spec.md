# Especificacao da Funcionalidade: Controle de gastos com dashboards visuais

**Branch da Funcionalidade**: `001-dashboard-gastos`
**Criado**: 2026-01-09
**Status**: Rascunho
**Entrada**: Descricao do usuario: "vamos criar um projeto de controles de gastos proprios, com dahsboards de graficos para um controle mais visual (despesas mensais, tipos de gastos mais recorrentes, comparativo de meses)"

## Cenarios de Usuario e Validacao *(obrigatorio)*

### Historia de Usuario 1 - Registrar despesas pessoais (Prioridade: P1)

Como usuario, quero registrar despesas com data, valor e categoria para manter
meu controle financeiro organizado.

**Por que esta prioridade**: Sem despesas registradas nao existe base para os
relatorios visuais.

**Validacao Independente**: Registrar tres despesas em datas do mes atual e
confirmar que aparecem na lista do mes e somam no total mensal.

**Cenarios de Aceite**:

1. **Dado** que estou na tela de cadastro, **Quando** informo data, valor e
   categoria validos, **Entao** a despesa e salva e aparece na lista do mes.
2. **Dado** uma despesa existente, **Quando** edito ou excluo, **Entao** a lista
   e o total mensal refletem a alteracao.

---

### Historia de Usuario 2 - Visualizar dashboard mensal (Prioridade: P2)

Como usuario, quero visualizar um dashboard mensal com total de despesas e
distribuicao por categoria para entender onde gasto mais.

**Por que esta prioridade**: O controle visual e o valor principal da
funcionalidade.

**Validacao Independente**: Selecionar um mes com despesas e verificar total
mensal e distribuicao por categoria somando o mesmo total.

**Cenarios de Aceite**:

1. **Dado** um mes com despesas registradas, **Quando** abro o dashboard, **Entao**
   vejo total mensal e distribuicao por categoria.
2. **Dado** um mes sem despesas, **Quando** abro o dashboard, **Entao** vejo total
   zero e uma mensagem indicando ausencia de dados.

---

### Historia de Usuario 3 - Comparar meses e recorrencias (Prioridade: P3)

Como usuario, quero comparar meses e identificar tipos de gastos recorrentes
para acompanhar tendencias ao longo do tempo.

**Por que esta prioridade**: Ajuda a detectar padroes e orientar ajustes de
habitos de consumo.

**Validacao Independente**: Selecionar um periodo de meses e confirmar que o
comparativo mostra valores por mes e categorias mais recorrentes.

**Cenarios de Aceite**:

1. **Dado** despesas em meses diferentes, **Quando** seleciono um periodo, **Entao**
   vejo o comparativo de valores por mes.
2. **Dado** categorias usadas com frequencia, **Quando** visualizo recorrencias,
   **Entao** vejo a lista das categorias mais frequentes no periodo.

---

### Casos de Borda

- O que acontece quando o valor informado e zero ou negativo? Deve ser rejeitado.
- Como o sistema lida com data futura? Deve impedir o registro para evitar
  distorcao do comparativo.
- O que acontece quando a categoria nao e informada? Deve registrar como
  "Sem categoria".
- Como o dashboard se comporta quando todas as despesas de um mes sao excluidas?
  Deve exibir total zero e mensagem de ausencia de dados.

## Requisitos *(obrigatorio)*

### Requisitos Funcionais

- **RF-001**: O sistema DEVE permitir registrar despesas com valor, data e
  categoria, e descricao opcional.
- **RF-002**: O sistema DEVE permitir editar e excluir despesas registradas.
- **RF-003**: O sistema DEVE listar despesas filtradas por mes com total mensal.
- **RF-004**: O sistema DEVE exibir dashboard mensal com total e distribuicao por
  categoria.
- **RF-005**: O sistema DEVE destacar os tipos de gastos mais recorrentes no
  periodo selecionado.
- **RF-006**: O sistema DEVE permitir comparar meses dentro de um periodo
  selecionavel (padrao: ultimos 3 meses).
- **RF-007**: O sistema DEVE preservar os dados cadastrados localmente na mesma
  maquina entre sessoes de uso.
- **RF-008**: O sistema DEVE permitir exportar despesas em formato CSV.
- **RF-009**: O sistema DEVE permitir importar despesas em formato CSV.

### Entidades Principais *(inclua se a funcionalidade envolver dados)*

- **Despesa**: Registro de gasto com valor, data, categoria e descricao opcional.
- **Categoria**: Classificacao das despesas para agrupamento e recorrencia.
- **PeriodoComparacao**: Intervalo de meses selecionado para comparativos.

## Premissas

- Uso pessoal e individual, sem perfis multiplos.
- Nao ha necessidade de autenticacao.
- Valores seguem a moeda local do usuario.
- Dados armazenados localmente na mesma maquina.

## Clarifications

### Session 2026-01-09

- Q: Onde os dados devem ficar armazenados? -> A: Banco local na mesma maquina (app web local).
- Q: Voce quer importacao/exportacao de dados? -> A: Importar e exportar CSV.
- Q: Precisa de controle de acesso ou apenas uso local sem autenticacao? -> A: Sem autenticacao (uso local).

## Criterios de Sucesso *(obrigatorio)*

### Resultados Mensuraveis

- **CS-001**: Usuarios conseguem registrar uma despesa completa em ate 1 minuto.
- **CS-002**: O total mensal exibido reflete 100% das despesas registradas no mes.
- **CS-003**: O comparativo apresenta corretamente ate 12 meses quando selecionado.
- **CS-004**: Em revisao manual, categorias recorrentes aparecem entre as tres
  mais frequentes do periodo.
