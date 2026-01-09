# Modelo de Dados: Controle de gastos com dashboards visuais

## Entidade: Despesa

**Descricao**: Registro de gasto individual do usuario.

**Campos**:
- id (identificador)
- valor (decimal, obrigatorio, maior que 0)
- data (date, obrigatorio, nao pode ser futura)
- categoria (string, opcional, padrao "Sem categoria")
- descricao (string, opcional)
- criado_em (datetime)
- atualizado_em (datetime)

**Regras/Validacoes**:
- valor > 0
- data <= hoje
- categoria default "Sem categoria" quando vazia

## Entidade: Categoria

**Descricao**: Agrupador logico para despesas, derivado do campo categoria.

**Campos**:
- nome (string)
- total_registros (inteiro, derivado)

**Regras/Validacoes**:
- nome nao pode ser vazio quando exibido em listagens

**Observacao**: Pode ser materializada por consulta agregada das despesas.

## Entidade: PeriodoComparacao

**Descricao**: Intervalo de meses usado para comparativos.

**Campos**:
- inicio (ano-mes)
- fim (ano-mes)

**Regras/Validacoes**:
- inicio <= fim
- intervalo maximo recomendado: 12 meses

**Observacao**: Entidade logica usada para filtros e agregacoes, nao persistida.

## Relacionamentos

- Despesa -> Categoria: relacao por nome da categoria (agrupamento logico).
- PeriodoComparacao -> Despesa: relacao por filtro de data.
