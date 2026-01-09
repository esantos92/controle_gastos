# Pesquisa: Controle de gastos com dashboards visuais

## Decisao 1: Ruby on Rails 8.0 com Hotwire para paginas reativas

- **Decisao**: Usar Ruby on Rails 8.0 com Hotwire (Turbo + Stimulus) para
  reatividade de paginas e atualizacao de estados.
- **Racional**: Hotwire entrega reatividade sem SPA completa, reduz dependencias
  e mantem o fluxo simples para um projeto-laboratorio.
- **Alternativas consideradas**: SPA com React/Vue (mais dependencia e complexidade),
  renderizacao tradicional com reload completo (menos responsivo a estados).

## Decisao 2: PostgreSQL como banco de dados

- **Decisao**: Persistir despesas e agregados em PostgreSQL.
- **Racional**: Banco relacional simples, confiavel e compativel com Rails.
- **Alternativas consideradas**: SQLite (mais simples, menos robusto para consultas
  de agregacao), arquivos locais (limitado para consultas de comparativo).

## Decisao 3: Bootstrap para estilizacao

- **Decisao**: Usar Bootstrap para layout e componentes basicos.
- **Racional**: Rapido para prototipar e consistente sem exigir design system
  complexo.
- **Alternativas consideradas**: Tailwind (exige mais configuracao), CSS puro
  (mais tempo de implementacao).

## Decisao 4: Chart.js para graficos

- **Decisao**: Usar Chart.js para graficos de total mensal, categorias e
  comparativo de meses.
- **Racional**: Biblioteca leve, ampla documentacao e suficiente para os
  graficos necessarios.
- **Alternativas consideradas**: D3.js (complexo), Chartkick (camada extra de
  dependencia).

## Decisao 5: Sem autenticacao no MVP

- **Decisao**: Nao incluir autenticacao ou multiusuarios.
- **Racional**: Uso pessoal e individual, reduz escopo e dependencias.
- **Alternativas consideradas**: Login simples (aumenta escopo e manutencao).
