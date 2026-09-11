# documentacao-banco

Este documento mapeia as entidades, atributos e chaves do sistema de gestão de condomínios e mercados autônomos.

---

## 📌 Tabelas de Usuários e Acessos

### Tabela: PESSOA
*Entidade genérica (Supertipo).*

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_pessoa** | PK | Identificador único da pessoa |
| nome | VARCHAR | Nome completo |
| cpf | VARCHAR (Unique) | Cadastro de Pessoa Física |
| email | VARCHAR | Endereço de e-mail |
| telefone | VARCHAR | Telefone de contato |

### Tabela: FUNCIONARIO
*Subtipo de PESSOA.*

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_funcionario** | PK, FK ➔ PESSOA(id_pessoa) | Identificador (ligado à Pessoa) |
| id_empresa | FK ➔ EMPRESA_OPERADORA(id_empresa) | Empresa à qual o funcionário pertence |
| cargo | VARCHAR | Cargo ou função |
| data_admissao | DATE | Data de contratação |

### Tabela: MORADOR
*Subtipo de PESSOA.*

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_morador** | PK, FK ➔ PESSOA(id_pessoa) | Identificador (ligado à Pessoa) |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio onde o morador reside |

### Tabela: CREDENCIAL_DE_ACESSO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_credencial** | PK | Identificador da credencial |
| id_morador | FK ➔ MORADOR(id_morador) | Morador dono da credencial |
| hash_biometria | VARCHAR / TEXT | Dados criptografados da biometria |
| token_qr | VARCHAR | Token gerado para o QR Code |

---

## 📌 Tabelas Administrativas e Corporativas

### Tabela: EMPRESA_OPERADORA

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_empresa** | PK | Identificador único da empresa |
| razao_social | VARCHAR | Razão social da operadora |
| cnpj | VARCHAR (Unique) | CNPJ da empresa |
| telefone | VARCHAR | Telefone comercial |

### Tabela: CONDOMINIO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_condominio** | PK | Identificador único do condomínio |
| nome | VARCHAR | Nome do condomínio |
| endereco | VARCHAR | Endereço completo |
| cnpj | VARCHAR (Unique) | CNPJ do condomínio |

### Tabela: ADMINISTRADOR_DO_CONDOMINIO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_admin** | PK | Identificador do administrador |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio administrado |
| nome | VARCHAR | Nome do administrador |
| email | VARCHAR | E-mail corporativo |
| cargo | VARCHAR | Cargo administrativo |

### Tabela: CONTRATO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_contracto** | PK | Identificador do contrato |
| id_empresa | FK ➔ EMPRESA_OPERADORA(id_empresa) | Empresa contratada |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio contratante |
| valor_mensalidade | DECIMAL | Valor cobrado mensalmente |
| taxa_percentual | DECIMAL | Taxa ou comissão acordada |
| data_inicio | DATE | Início da vigência |
| data_fim | DATE | Fim da vigência |

---

## 📌 Tabelas de Catálogo e Estoque (Mercado)

### Tabela: CATEGORIA_DO_PRODUTO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_categoria** | PK | Identificador da categoria |
| nome | VARCHAR | Nome (ex: Bebidas, Doces, Limpeza) |

### Tabela: PRODUTO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_produto** | PK | Identificador único do produto |
| id_categoria | FK ➔ CATEGORIA_DO_PRODUTO(id_categoria) | Categoria do produto |
| nome | VARCHAR | Nome do produto |
| descricao | TEXT | Detalhes/especificações do produto |
| codigo_barras | VARCHAR (Unique) | Código de barras comercial (EAN) |

### Tabela: CONDOMINIO_PRODUTO
*Tabela associativa para gerenciar múltiplos mercados e produtos por condomínio.*

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_condominio** | PK, FK ➔ CONDOMINIO(id_condominio) | Identificador do condomínio |
| **id_produto** | PK, FK ➔ PRODUTO(id_produto) | Identificador do produto |
| numero_mercado | INT / VARCHAR | Identificador do ponto de venda/mercado específico |
| status_ativo | BOOLEAN | Indica se o produto está ativo neste ponto de venda |

### Tabela: ESTOQUE_DO_CONDOMINIO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_estoque** | PK | Identificador do registro de estoque |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio correspondente |
| id_produto | FK ➔ PRODUTO(id_produto) | Produto em estoque |
| qtd_disponivel | INT | Quantidade atual física |
| qtd_minima | INT | Alerta de estoque mínimo para reposição |
| preco_local | DECIMAL | Preço de venda praticado neste local |
| data_primeira_entrada | DATE | Data do primeiro lote registrado |

---

## 📌 Tabelas de Consumo e Transações

### Tabela: VENDA

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_venda** | PK | Identificador único da venda |
| id_morador | FK ➔ MORADOR(id_morador) | Morador que realizou a compra |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio onde a venda ocorreu |
| data_hora | DATETIME | Data e hora exata da transação |
| valor_total | DECIMAL | Valor total pago pelos produtos |
| taxa_percentual_aplicada | DECIMAL | Percentual de taxa aplicado na venda |
| valor_taxa_safralink | DECIMAL | Valor monetário retido pela Safralink |

### Tabela: RESERVA

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_reserva** | PK | Identificador da reserva de compra |
| id_morador | FK ➔ MORADOR(id_morador) | Morador que solicitou a reserva |
| id_estoque | FK ➔ ESTOQUE_DO_CONDOMINIO(id_estoque) | Registro do item estocado |
| id_venda | FK ➔ VENDA(id_venda) (Opcional) | Venda final vinculada a esta reserva |
| qtd_reservada | INT | Quantidade de itens reservados |
| data_hora_inicio | DATETIME | Momento em que a reserva foi feita |
| data_hora_expiracao | DATETIME | Limite para o morador retirar o produto |
| status | VARCHAR | Situação atual (Pendente, Retirado, Expirado) |
