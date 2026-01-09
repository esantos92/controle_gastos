# Quickstart: Controle de gastos com dashboards visuais

## Pre-requisitos

- Ruby 3.3
- Rails 7.1
- PostgreSQL 16

## Configuracao rapida

1. Configurar variaveis de banco de dados no ambiente local.
2. Instalar dependencias do projeto:

```bash
bundle install
```

3. Criar e preparar o banco:

```bash
rails db:create
rails db:migrate
```

4. Iniciar a aplicacao:

```bash
rails server
```

5. Acessar no navegador:

```text
http://localhost:3000
```

## Fluxo basico de uso

- Registrar despesas com data, valor e categoria.
- Visualizar o dashboard mensal com totais e distribuicao por categoria.
- Comparar meses para identificar recorrencias.
