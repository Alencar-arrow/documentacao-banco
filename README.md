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
| unidade_medida | VARCHAR | Unidade de venda/controle (Un, Kg, L, Cx) |

### Tabela: MERCADO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_mercado** | PK | Identificador único do ponto de venda |
| id_condominio | FK ➔ CONDOMINIO(id_condominio) | Condomínio ao qual o mercado pertence |
| nome | VARCHAR | Nome/identificação do mercado (ex: "Mercado Bloco A") |
| localizacao | VARCHAR | Localização dentro do condomínio |
| status_ativo | BOOLEAN | Indica se o ponto de venda está em operação |

### Tabela: MERCADO_PRODUTO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_mercado** | PK, FK ➔ MERCADO(id_mercado) | Identificador do mercado |
| **id_produto** | PK, FK ➔ PRODUTO(id_produto) | Identificador do produto |
| status_ativo | BOOLEAN | Indica se o produto está ativo neste ponto de venda |

### Tabela: ESTOQUE_DO_MERCADO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_estoque** | PK | Identificador do registro de estoque |
| id_mercado | FK ➔ MERCADO(id_mercado) | Mercado correspondente |
| id_produto | FK ➔ PRODUTO(id_produto) | Produto em estoque |
| qtd_disponivel | INT | Quantidade atual física |
| qtd_minima | INT | Alerta de estoque mínimo para reposição |
| preco_local | DECIMAL | Preço de venda praticado neste local |
| data_primeira_entrada | DATE | Data do primeiro lote registrado |
| *(constraint)* | UNIQUE (id_mercado, id_produto) | Garante um único registro de estoque por produto/mercado |

---

## 📌 Tabelas de Fornecimento e Compras

### Tabela: FORNECEDOR

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_fornecedor** | PK | Identificador do fornecedor |
| razao_social | VARCHAR | Razão social |
| nome_fantasia | VARCHAR | Nome fantasia |
| cnpj | VARCHAR (Unique) | CNPJ |
| telefone | VARCHAR | Telefone de contato |
| email | VARCHAR | E-mail de contato |
| endereco | VARCHAR | Endereço |
| status | VARCHAR / ENUM | Domínio: Ativo, Inativo, Bloqueado |

### Tabela: FORNECEDOR_PRODUTO

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_fornecedor_produto** | PK | Identificador do vínculo |
| id_fornecedor | FK ➔ FORNECEDOR(id_fornecedor) | Fornecedor |
| id_produto | FK ➔ PRODUTO(id_produto) | Produto fornecido |
| preco_custo | DECIMAL | Preço de tabela do fornecedor |
| prazo_entrega | INT | Prazo em dias |
| codigo_produto_fornecedor | VARCHAR | Código interno do fornecedor para o produto |
| ativo | BOOLEAN | Indica se o vínculo está ativo |

### Tabela: PEDIDO_COMPRA

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_pedido** | PK | Identificador do pedido |
| id_mercado | FK ➔ MERCADO(id_mercado) | Mercado para o qual a compra é destinada |
| id_fornecedor | FK ➔ FORNECEDOR(id_fornecedor) | Fornecedor do pedido |
| data_pedido | DATE | Data de emissão |
| data_previsao_entrega | DATE | Previsão de entrega |
| status | VARCHAR / ENUM | Domínio: Pendente, Aprovado, Em Trânsito, Recebido, Cancelado |
| valor_total | DECIMAL | Valor total do pedido |

### Tabela: ITEM_PEDIDO_COMPRA

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_item** | PK | Identificador do item |
| id_pedido | FK ➔ PEDIDO_COMPRA(id_pedido) | Pedido relacionado |
| id_produto | FK ➔ PRODUTO(id_produto) | Produto pedido |
| quantidade_solicitada | INT | Quantidade solicitada |
| preco_unitario | DECIMAL | Preço unitário negociado no pedido |
| subtotal | DECIMAL | quantidade_solicitada × preco_unitario |

### Tabela: ENTRADA_ESTOQUE

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_entrada** | PK | Identificador da entrada |
| id_mercado | FK ➔ MERCADO(id_mercado) | Mercado que recebeu a mercadoria |
| id_fornecedor | FK ➔ FORNECEDOR(id_fornecedor) | Fornecedor da entrega |
| id_pedido | FK ➔ PEDIDO_COMPRA(id_pedido) | Pedido de origem |
| data_entrada | DATE | Data do recebimento |
| nota_fiscal | VARCHAR | Número da nota fiscal |
| valor_total | DECIMAL | Valor total da nota |
| responsavel | VARCHAR | Responsável pelo recebimento |

### Tabela: LOTE

| Atributo | Tipo / Restrição | Descrição |
| :--- | :--- | :--- |
| **id_lote** | PK | Identificador do lote |
| id_entrada | FK ➔ ENTRADA_ESTOQUE(id_entrada) | Nota fiscal/recebimento de origem |
| id_produto | FK ➔ PRODUTO(id_produto) | Produto do lote |
| id_fornecedor | FK ➔ FORNECEDOR(id_fornecedor) | Fornecedor do lote |
| codigo_lote | VARCHAR | Código do lote (fabricante) |
| data_fabricacao | DATE | Data de fabricação |
| data_validade | DATE | Data de validade |
| data_recebimento | DATE | Data de recebimento físico |
| quantidade_recebida | INT | Quantidade recebida neste lote |
| custo_unitario | DECIMAL | Custo real pago por unidade neste lote |

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
