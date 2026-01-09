# Especificacao da Funcionalidade: [NOME DA FUNCIONALIDADE]

**Branch da Funcionalidade**: `[###-feature-name]`
**Criado**: [DATA]
**Status**: Rascunho
**Entrada**: Descricao do usuario: "$ARGUMENTS"

## Cenarios de Usuario e Validacao *(obrigatorio)*

<!--
  IMPORTANTE: As historias de usuario devem ser PRIORIZADAS como jornadas
  ordenadas por importancia. Cada historia/jornada deve ser VALIDAVEL DE FORMA
  INDEPENDENTE - ou seja, se voce implementar apenas UMA delas, ainda deve ter
  um produto minimo viavel (MVP) que entregue valor.

  Atribua prioridades (P1, P2, P3 etc.) a cada historia, onde P1 e a mais critica.
  Pense em cada historia como um recorte de funcionalidade que pode ser:
  - Desenvolvida de forma independente
  - Validada de forma independente (manual ou automatizada)
  - Implantada de forma independente
  - Demonstrada aos usuarios de forma independente
-->

### Historia de Usuario 1 - [Titulo Breve] (Prioridade: P1)

[Descreva esta jornada do usuario em linguagem simples]

**Por que esta prioridade**: [Explique o valor e por que tem esse nivel]

**Validacao Independente**: [Descreva como validar de forma independente - ex.: "Pode ser validado por [acao especifica] e entrega [valor especifico]"]

**Cenarios de Aceite**:

1. **Dado** [estado inicial], **Quando** [acao], **Entao** [resultado esperado]
2. **Dado** [estado inicial], **Quando** [acao], **Entao** [resultado esperado]

---

### Historia de Usuario 2 - [Titulo Breve] (Prioridade: P2)

[Descreva esta jornada do usuario em linguagem simples]

**Por que esta prioridade**: [Explique o valor e por que tem esse nivel]

**Validacao Independente**: [Descreva como validar de forma independente]

**Cenarios de Aceite**:

1. **Dado** [estado inicial], **Quando** [acao], **Entao** [resultado esperado]

---

### Historia de Usuario 3 - [Titulo Breve] (Prioridade: P3)

[Descreva esta jornada do usuario em linguagem simples]

**Por que esta prioridade**: [Explique o valor e por que tem esse nivel]

**Validacao Independente**: [Descreva como validar de forma independente]

**Cenarios de Aceite**:

1. **Dado** [estado inicial], **Quando** [acao], **Entao** [resultado esperado]

---

[Adicione mais historias de usuario conforme necessario, cada uma com prioridade]

### Casos de Borda

<!--
  ACAO OBRIGATORIA: O conteudo desta secao e um placeholder.
  Preencha com os casos de borda corretos.
-->

- O que acontece quando [condicao de contorno]?
- Como o sistema lida com [cenario de erro]?

## Requisitos *(obrigatorio)*

<!--
  ACAO OBRIGATORIA: O conteudo desta secao e um placeholder.
  Preencha com os requisitos funcionais corretos.
-->

### Requisitos Funcionais

- **RF-001**: O sistema DEVE [capacidade especifica, ex.: "permitir criar contas"]
- **RF-002**: O sistema DEVE [capacidade especifica, ex.: "validar emails"]
- **RF-003**: Os usuarios DEVEM conseguir [interacao chave, ex.: "redefinir senha"]
- **RF-004**: O sistema DEVE [requisito de dados, ex.: "persistir preferencias"]
- **RF-005**: O sistema DEVE [comportamento, ex.: "registrar eventos de seguranca"]

*Exemplo de requisito com falta de clareza:*

- **RF-006**: O sistema DEVE autenticar usuarios via [PRECISA DE CLAREZA: metodo nao especificado - email/senha, SSO, OAuth?]
- **RF-007**: O sistema DEVE reter dados por [PRECISA DE CLAREZA: periodo nao especificado]

### Entidades Principais *(inclua se a funcionalidade envolver dados)*

- **[Entidade 1]**: [O que representa, atributos chave sem implementacao]
- **[Entidade 2]**: [O que representa, relacoes com outras entidades]

## Criterios de Sucesso *(obrigatorio)*

<!--
  ACAO OBRIGATORIA: Defina criterios mensuraveis.
  Eles devem ser agnosticos de tecnologia e mensuraveis.
-->

### Resultados Mensuraveis

- **CS-001**: [Metrica mensuravel, ex.: "Usuarios concluem cadastro em menos de 2 minutos"]
- **CS-002**: [Metrica mensuravel, ex.: "Sistema lida com 1000 usuarios simultaneos sem degradacao"]
- **CS-003**: [Metrica de satisfacao, ex.: "90% dos usuarios concluem tarefa principal na primeira tentativa"]
- **CS-004**: [Metrica de negocio, ex.: "Reduzir tickets sobre [X] em 50%"]
