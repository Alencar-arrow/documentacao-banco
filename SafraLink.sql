-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: safralink
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acesso`
--

DROP TABLE IF EXISTS `acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acesso` (
  `id_acesso` bigint NOT NULL AUTO_INCREMENT COMMENT 'Identificador do acesso',
  `id_morador` int NOT NULL COMMENT 'Morador que tentou acessar',
  `id_mercado` int NOT NULL COMMENT 'Mercado acessado',
  `id_credencial` int NOT NULL COMMENT 'Credencial utilizada',
  `data_hora` datetime NOT NULL COMMENT 'Momento da tentativa',
  `tipo_acesso` varchar(10) NOT NULL COMMENT 'Forma de acesso',
  `resultado` varchar(10) NOT NULL COMMENT 'Resultado da validação (RN01, RNF03)',
  `motivo_negacao` varchar(25) DEFAULT NULL COMMENT 'Obrigatório quando NEGADO; nulo quando LIBERADO',
  PRIMARY KEY (`id_acesso`),
  KEY `fk_acesso_id_morador` (`id_morador`),
  KEY `fk_acesso_id_mercado` (`id_mercado`),
  KEY `fk_acesso_id_credencial` (`id_credencial`),
  CONSTRAINT `fk_acesso_id_credencial` FOREIGN KEY (`id_credencial`) REFERENCES `credencial_acesso` (`id_credencial`),
  CONSTRAINT `fk_acesso_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `fk_acesso_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `ck_acesso_motivo` CHECK ((((`resultado` = _utf8mb4'LIBERADO') and (`motivo_negacao` is null)) or ((`resultado` = _utf8mb4'NEGADO') and (`motivo_negacao` is not null)))),
  CONSTRAINT `ck_acesso_motivo_negacao` CHECK ((`motivo_negacao` in (_utf8mb4'CADASTRO_INATIVO',_utf8mb4'CREDENCIAL_REVOGADA',_utf8mb4'SEM_VINCULO_VIGENTE'))),
  CONSTRAINT `ck_acesso_resultado` CHECK ((`resultado` in (_utf8mb4'LIBERADO',_utf8mb4'NEGADO'))),
  CONSTRAINT `ck_acesso_tipo_acesso` CHECK ((`tipo_acesso` in (_utf8mb4'QR_CODE',_utf8mb4'BIOMETRIA')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Registro de cada tentativa de entrada no mercado com credencial reconhecida (RF15).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acesso`
--

LOCK TABLES `acesso` WRITE;
/*!40000 ALTER TABLE `acesso` DISABLE KEYS */;
INSERT INTO `acesso` VALUES (1,1,1,2,'2026-10-22 19:05:00','BIOMETRIA','LIBERADO',NULL),(2,3,1,4,'2026-10-20 08:10:00','QR_CODE','NEGADO','SEM_VINCULO_VIGENTE'),(3,3,2,4,'2026-11-01 08:55:00','QR_CODE','LIBERADO',NULL),(4,4,1,5,'2026-10-05 18:00:00','QR_CODE','NEGADO','CADASTRO_INATIVO'),(5,2,1,3,'2026-10-30 17:40:00','QR_CODE','LIBERADO',NULL);
/*!40000 ALTER TABLE `acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administrador_condominio`
--

DROP TABLE IF EXISTS `administrador_condominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador_condominio` (
  `id_admin` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do administrador',
  `id_pessoa` int NOT NULL COMMENT 'Nome, CPF e contato ficam em PESSOA',
  `id_condominio` int NOT NULL COMMENT 'Condomínio administrado',
  `cargo` varchar(60) NOT NULL COMMENT 'Ex.: síndico, administradora; aprova vínculos de moradores (RO02)',
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  KEY `fk_administrador_condominio_id_condominio` (`id_condominio`),
  CONSTRAINT `fk_administrador_condominio_id_condominio` FOREIGN KEY (`id_condominio`) REFERENCES `condominio` (`id_condominio`),
  CONSTRAINT `fk_administrador_condominio_id_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Síndico ou administradora responsável por um condomínio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador_condominio`
--

LOCK TABLES `administrador_condominio` WRITE;
/*!40000 ALTER TABLE `administrador_condominio` DISABLE KEYS */;
INSERT INTO `administrador_condominio` VALUES (1,6,1,'Síndico'),(2,7,2,'Síndica');
/*!40000 ALTER TABLE `administrador_condominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_produto`
--

DROP TABLE IF EXISTS `categoria_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_produto` (
  `id_categoria` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da categoria',
  `nome` varchar(60) NOT NULL COMMENT 'Ex.: bebidas, limpeza',
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Classificação dos produtos.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_produto`
--

LOCK TABLES `categoria_produto` WRITE;
/*!40000 ALTER TABLE `categoria_produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobranca`
--

DROP TABLE IF EXISTS `cobranca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cobranca` (
  `id_cobranca` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da cobrança',
  `id_contrato` int NOT NULL COMMENT 'Contrato que origina a cobrança (e o condomínio devedor)',
  `tipo` varchar(12) NOT NULL COMMENT 'Origem do valor',
  `competencia` date NOT NULL COMMENT 'Primeiro dia do mês de referência',
  `valor` decimal(12,2) NOT NULL COMMENT 'Mensalidade do contrato ou soma das taxas das vendas da competência menos estornos',
  `data_emissao` date NOT NULL COMMENT 'Data de geração',
  `data_vencimento` date NOT NULL COMMENT 'Usa o dia_vencimento do contrato',
  `status` varchar(10) NOT NULL COMMENT 'Atualizada a cada recebimento (RN16)',
  PRIMARY KEY (`id_cobranca`),
  UNIQUE KEY `uq_cobranca` (`id_contrato`,`tipo`,`competencia`),
  CONSTRAINT `fk_cobranca_id_contrato` FOREIGN KEY (`id_contrato`) REFERENCES `contrato` (`id_contrato`),
  CONSTRAINT `ck_cobranca_data_vencimento` CHECK ((`data_vencimento` >= `data_emissao`)),
  CONSTRAINT `ck_cobranca_status` CHECK ((`status` in (_utf8mb4'ABERTA',_utf8mb4'PARCIAL',_utf8mb4'QUITADA',_utf8mb4'CANCELADA'))),
  CONSTRAINT `ck_cobranca_tipo` CHECK ((`tipo` in (_utf8mb4'MENSALIDADE',_utf8mb4'TAXA_VENDAS'))),
  CONSTRAINT `ck_cobranca_valor` CHECK ((`valor` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Valor que o condomínio deve à operadora em uma competência (título a receber), gerado a partir do contrato (RF17, PO08).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobranca`
--

LOCK TABLES `cobranca` WRITE;
/*!40000 ALTER TABLE `cobranca` DISABLE KEYS */;
INSERT INTO `cobranca` VALUES (1,2,'MENSALIDADE','2026-09-01',1200.00,'2026-10-01','2026-10-05','QUITADA'),(2,2,'MENSALIDADE','2026-10-01',1200.00,'2026-11-01','2026-11-05','PARCIAL'),(3,3,'MENSALIDADE','2026-09-01',800.00,'2026-10-01','2026-10-10','ABERTA'),(4,3,'MENSALIDADE','2026-10-01',800.00,'2026-11-01','2026-11-10','ABERTA'),(5,3,'TAXA_VENDAS','2026-10-01',4.74,'2026-11-01','2026-11-10','ABERTA'),(6,1,'MENSALIDADE','2026-08-01',900.00,'2026-09-01','2026-09-10','QUITADA');
/*!40000 ALTER TABLE `cobranca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condominio`
--

DROP TABLE IF EXISTS `condominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condominio` (
  `id_condominio` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do condomínio',
  `nome` varchar(120) NOT NULL COMMENT 'Nome do condomínio',
  `endereco` varchar(200) NOT NULL COMMENT 'Endereço completo',
  `cnpj` char(14) DEFAULT NULL COMMENT 'CNPJ do condomínio; é o devedor das cobranças contratuais',
  PRIMARY KEY (`id_condominio`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Condomínio atendido pela plataforma.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condominio`
--

LOCK TABLES `condominio` WRITE;
/*!40000 ALTER TABLE `condominio` DISABLE KEYS */;
INSERT INTO `condominio` VALUES (1,'Residencial Jardim','Rua das Flores, 100','11111111000111'),(2,'Condomínio Vila Nova','Av. Central, 2500','22222222000122');
/*!40000 ALTER TABLE `condominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta_financeira`
--

DROP TABLE IF EXISTS `conta_financeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta_financeira` (
  `id_conta_financeira` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da conta',
  `id_empresa` int NOT NULL COMMENT 'Titular',
  `descricao` varchar(80) NOT NULL COMMENT 'Ex.: conta corrente, conta do meio de pagamento',
  `tipo` varchar(10) NOT NULL COMMENT 'Natureza da conta',
  `saldo_inicial` decimal(12,2) NOT NULL COMMENT 'Saldo na data de implantação',
  `data_saldo_inicial` date NOT NULL COMMENT 'Ponto de partida do fluxo de caixa',
  `ativa` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Conta encerrada mantém histórico',
  PRIMARY KEY (`id_conta_financeira`),
  KEY `fk_conta_financeira_id_empresa` (`id_empresa`),
  CONSTRAINT `fk_conta_financeira_id_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa_operadora` (`id_empresa`),
  CONSTRAINT `ck_conta_financeira_tipo` CHECK ((`tipo` in (_utf8mb4'BANCO',_utf8mb4'GATEWAY')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Conta bancária, caixa ou conta do meio de pagamento onde o dinheiro efetivamente entra e sai (RF18).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta_financeira`
--

LOCK TABLES `conta_financeira` WRITE;
/*!40000 ALTER TABLE `conta_financeira` DISABLE KEYS */;
INSERT INTO `conta_financeira` VALUES (1,1,'Conta corrente','BANCO',12000.00,'2026-08-01',1),(2,1,'Conta do meio de pagamento','GATEWAY',0.00,'2026-08-01',1);
/*!40000 ALTER TABLE `conta_financeira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conta_pagar`
--

DROP TABLE IF EXISTS `conta_pagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conta_pagar` (
  `id_conta_pagar` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do título',
  `id_fornecedor` int NOT NULL COMMENT 'Credor',
  `id_entrada` int DEFAULT NULL COMMENT 'Origem; nula para outras despesas com o fornecedor (ex.: frete)',
  `numero_parcela` int NOT NULL DEFAULT '1' COMMENT 'Parcela da obrigação',
  `valor` decimal(12,2) NOT NULL COMMENT 'Valor devido na parcela',
  `data_emissao` date NOT NULL COMMENT 'Data em que a obrigação surgiu',
  `data_vencimento` date NOT NULL COMMENT 'Vencimento',
  `status` varchar(10) NOT NULL COMMENT 'Atualizada a cada pagamento (RN16)',
  PRIMARY KEY (`id_conta_pagar`),
  UNIQUE KEY `uq_conta_pagar_parcela` (`id_entrada`,`numero_parcela`),
  KEY `fk_conta_pagar_id_fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_conta_pagar_id_entrada` FOREIGN KEY (`id_entrada`) REFERENCES `entrada_estoque` (`id_entrada`),
  CONSTRAINT `fk_conta_pagar_id_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `ck_conta_pagar_data_vencimento` CHECK ((`data_vencimento` >= `data_emissao`)),
  CONSTRAINT `ck_conta_pagar_numero_parcela` CHECK ((`numero_parcela` > 0)),
  CONSTRAINT `ck_conta_pagar_status` CHECK ((`status` in (_utf8mb4'ABERTA',_utf8mb4'PARCIAL',_utf8mb4'QUITADA',_utf8mb4'CANCELADA'))),
  CONSTRAINT `ck_conta_pagar_valor` CHECK ((`valor` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Obrigação da operadora com um fornecedor (título a pagar). Cada parcela é uma linha. A entrada de estoque mostra a chegada; esta tabela mostra a dívida (RF16).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conta_pagar`
--

LOCK TABLES `conta_pagar` WRITE;
/*!40000 ALTER TABLE `conta_pagar` DISABLE KEYS */;
INSERT INTO `conta_pagar` VALUES (1,1,3,1,139.20,'2026-10-12','2026-11-11','QUITADA'),(2,1,4,1,60.00,'2026-10-12','2026-11-11','ABERTA'),(3,1,1,1,25.20,'2026-10-20','2026-11-19','ABERTA'),(4,1,1,2,25.20,'2026-10-20','2026-12-19','ABERTA'),(5,2,2,1,107.40,'2026-10-28','2026-11-04','PARCIAL'),(6,1,5,1,12.00,'2026-08-01','2026-08-31','QUITADA');
/*!40000 ALTER TABLE `conta_pagar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato` (
  `id_contrato` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do contrato',
  `id_empresa` int NOT NULL COMMENT 'Empresa contratada (credora)',
  `id_condominio` int NOT NULL COMMENT 'Condomínio contratante (devedor)',
  `id_contrato_anterior` int DEFAULT NULL COMMENT 'Contrato substituído na renegociação; nulo no primeiro contrato',
  `valor_mensalidade` decimal(10,2) NOT NULL COMMENT 'Valor fixo mensal cobrado do condomínio (PO08)',
  `taxa_percentual` decimal(5,2) NOT NULL COMMENT 'Percentual sobre as vendas confirmadas, cobrado do condomínio (PO08)',
  `dia_vencimento` int NOT NULL COMMENT 'Dia de vencimento das cobranças mensais',
  `data_inicio` date NOT NULL COMMENT 'Início da vigência',
  `data_fim` date DEFAULT NULL COMMENT 'Nulo se prazo indeterminado; preenchido na renegociação ou rescisão',
  PRIMARY KEY (`id_contrato`),
  UNIQUE KEY `id_contrato_anterior` (`id_contrato_anterior`),
  KEY `fk_contrato_id_empresa` (`id_empresa`),
  KEY `fk_contrato_id_condominio` (`id_condominio`),
  CONSTRAINT `fk_contrato_id_condominio` FOREIGN KEY (`id_condominio`) REFERENCES `condominio` (`id_condominio`),
  CONSTRAINT `fk_contrato_id_contrato_anterior` FOREIGN KEY (`id_contrato_anterior`) REFERENCES `contrato` (`id_contrato`),
  CONSTRAINT `fk_contrato_id_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa_operadora` (`id_empresa`),
  CONSTRAINT `ck_contrato_data_fim` CHECK ((`data_fim` >= `data_inicio`)),
  CONSTRAINT `ck_contrato_dia_vencimento` CHECK ((`dia_vencimento` between 1 and 28)),
  CONSTRAINT `ck_contrato_taxa_percentual` CHECK ((`taxa_percentual` between 0 and 100)),
  CONSTRAINT `ck_contrato_valor_mensalidade` CHECK ((`valor_mensalidade` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Acordo entre a operadora e o condomínio que define mensalidade, taxa e vigência (RO03, RN14). Uma renegociação gera um novo contrato ligado ao anterior.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato`
--

LOCK TABLES `contrato` WRITE;
/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;
INSERT INTO `contrato` VALUES (1,1,1,NULL,900.00,5.00,10,'2025-03-01','2026-08-31'),(2,1,2,NULL,1200.00,4.50,5,'2025-06-01',NULL),(3,1,1,1,800.00,4.00,10,'2026-09-01',NULL);
/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato_mercado`
--

DROP TABLE IF EXISTS `contrato_mercado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato_mercado` (
  `id_contrato` int NOT NULL COMMENT 'Compõe a chave primária',
  `id_mercado` int NOT NULL COMMENT 'Compõe a chave primária',
  `data_inicio` date NOT NULL COMMENT 'Início da cobertura; dentro da vigência do contrato',
  `data_fim` date DEFAULT NULL COMMENT 'Fim da cobertura; nulo enquanto vigente',
  PRIMARY KEY (`id_contrato`,`id_mercado`),
  KEY `fk_contrato_mercado_id_mercado` (`id_mercado`),
  CONSTRAINT `fk_contrato_mercado_id_contrato` FOREIGN KEY (`id_contrato`) REFERENCES `contrato` (`id_contrato`),
  CONSTRAINT `fk_contrato_mercado_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `ck_contrato_mercado_data_fim` CHECK ((`data_fim` >= `data_inicio`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre CONTRATO e MERCADO: indica quais mercados cada contrato rege e em que período (RN14).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato_mercado`
--

LOCK TABLES `contrato_mercado` WRITE;
/*!40000 ALTER TABLE `contrato_mercado` DISABLE KEYS */;
INSERT INTO `contrato_mercado` VALUES (1,1,'2025-03-01','2026-08-31'),(2,2,'2025-06-01',NULL),(3,1,'2026-09-01',NULL);
/*!40000 ALTER TABLE `contrato_mercado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credencial_acesso`
--

DROP TABLE IF EXISTS `credencial_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credencial_acesso` (
  `id_credencial` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da credencial',
  `id_morador` int NOT NULL COMMENT 'Dono da credencial',
  `tipo` varchar(10) NOT NULL COMMENT 'Define qual campo é preenchido',
  `hash_biometria` varchar(255) DEFAULT NULL COMMENT 'Só no tipo biometria; criptografado (RNF04); apagado na desativação (PO06)',
  `data_consentimento` datetime DEFAULT NULL COMMENT 'Consentimento expresso para biometria (RO05)',
  `token_qr` varchar(64) DEFAULT NULL COMMENT 'Só no tipo QR Code',
  `status` varchar(10) NOT NULL COMMENT 'Credencial revogada não libera acesso',
  PRIMARY KEY (`id_credencial`),
  UNIQUE KEY `token_qr` (`token_qr`),
  KEY `fk_credencial_acesso_id_morador` (`id_morador`),
  CONSTRAINT `fk_credencial_acesso_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `ck_credencial_acesso_status` CHECK ((`status` in (_utf8mb4'ATIVA',_utf8mb4'REVOGADA'))),
  CONSTRAINT `ck_credencial_acesso_tipo` CHECK ((`tipo` in (_utf8mb4'QR_CODE',_utf8mb4'BIOMETRIA'))),
  CONSTRAINT `ck_credencial_tipo` CHECK ((((`tipo` = _utf8mb4'QR_CODE') and (`token_qr` is not null) and (`hash_biometria` is null)) or ((`tipo` = _utf8mb4'BIOMETRIA') and (`token_qr` is null) and ((`status` = _utf8mb4'REVOGADA') or ((`hash_biometria` is not null) and (`data_consentimento` is not null))))))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Credencial usada pelo morador para entrar no mercado (RF06).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credencial_acesso`
--

LOCK TABLES `credencial_acesso` WRITE;
/*!40000 ALTER TABLE `credencial_acesso` DISABLE KEYS */;
INSERT INTO `credencial_acesso` VALUES (1,1,'QR_CODE',NULL,NULL,'QR-ANA-01','ATIVA'),(2,1,'BIOMETRIA','sha256:9f2c1a','2025-01-05 10:00:00',NULL,'ATIVA'),(3,2,'QR_CODE',NULL,NULL,'QR-BRUNO-01','ATIVA'),(4,3,'QR_CODE',NULL,NULL,'QR-CARLA-01','ATIVA'),(5,4,'QR_CODE',NULL,NULL,'QR-DIEGO-01','REVOGADA'),(6,4,'BIOMETRIA',NULL,'2026-08-01 10:00:00',NULL,'REVOGADA');
/*!40000 ALTER TABLE `credencial_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponibilidade_produto`
--

DROP TABLE IF EXISTS `disponibilidade_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponibilidade_produto` (
  `id_mercado` int NOT NULL COMMENT 'Compõe a chave primária',
  `id_produto` int NOT NULL COMMENT 'Compõe a chave primária',
  `preco_venda` decimal(10,2) NOT NULL COMMENT 'Só a operadora altera (RO01, PO03)',
  `qtd_estoque` int NOT NULL COMMENT 'Igual à soma dos saldos dos lotes do produto no mercado; atualizada na mesma transação da entrada, da venda e da perda (RF08)',
  `qtd_reservada` int NOT NULL DEFAULT '0' COMMENT 'Disponível = qtd_estoque − qtd_reservada (RN09)',
  `estoque_minimo` int NOT NULL COMMENT 'Dispara o alerta de reposição (RF10, PO02)',
  `ativo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Retira do mix sem apagar histórico',
  PRIMARY KEY (`id_mercado`,`id_produto`),
  KEY `fk_disponibilidade_produto_id_produto` (`id_produto`),
  CONSTRAINT `fk_disponibilidade_produto_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `fk_disponibilidade_produto_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `ck_disponibilidade_produto_estoque_minimo` CHECK ((`estoque_minimo` >= 0)),
  CONSTRAINT `ck_disponibilidade_produto_preco_venda` CHECK ((`preco_venda` > 0)),
  CONSTRAINT `ck_disponibilidade_produto_qtd_estoque` CHECK ((`qtd_estoque` >= 0)),
  CONSTRAINT `ck_disponibilidade_produto_qtd_reservada` CHECK ((`qtd_reservada` between 0 and `qtd_estoque`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre MERCADO e PRODUTO com preço e estoque locais.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponibilidade_produto`
--

LOCK TABLES `disponibilidade_produto` WRITE;
/*!40000 ALTER TABLE `disponibilidade_produto` DISABLE KEYS */;
INSERT INTO `disponibilidade_produto` VALUES (1,1,4.50,18,2,5,1),(1,2,3.00,57,1,5,1),(1,3,6.00,22,0,5,1),(1,4,3.80,12,0,5,1),(1,5,9.90,10,0,5,1),(2,1,4.50,0,0,5,1),(2,2,3.00,22,0,5,1),(2,3,6.00,12,0,5,1),(2,4,3.80,0,0,5,1);
/*!40000 ALTER TABLE `disponibilidade_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa_operadora`
--

DROP TABLE IF EXISTS `empresa_operadora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa_operadora` (
  `id_empresa` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da empresa',
  `razao_social` varchar(150) NOT NULL COMMENT 'Nome jurídico',
  `cnpj` char(14) NOT NULL COMMENT 'CNPJ sem pontuação',
  `telefone` varchar(20) DEFAULT NULL COMMENT 'Telefone comercial',
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Empresa que implanta e opera os mercados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa_operadora`
--

LOCK TABLES `empresa_operadora` WRITE;
/*!40000 ALTER TABLE `empresa_operadora` DISABLE KEYS */;
INSERT INTO `empresa_operadora` VALUES (1,'SafraLink Operações Ltda.','12345678000190','1130000000');
/*!40000 ALTER TABLE `empresa_operadora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrada_estoque`
--

DROP TABLE IF EXISTS `entrada_estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrada_estoque` (
  `id_entrada` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da entrada',
  `id_mercado` int NOT NULL COMMENT 'Mercado que recebeu',
  `id_fornecedor` int NOT NULL COMMENT 'Fornecedor que entregou',
  `id_pedido` int DEFAULT NULL COMMENT 'Opcional: entrada sem pedido prévio',
  `id_funcionario` int NOT NULL COMMENT 'Quem conferiu e registrou',
  `data_entrada` date NOT NULL COMMENT 'Data do recebimento',
  `nota_fiscal` varchar(44) NOT NULL COMMENT 'Número ou chave da NF',
  `valor_total` decimal(12,2) NOT NULL COMMENT 'Valor da nota',
  PRIMARY KEY (`id_entrada`),
  UNIQUE KEY `uq_entrada_nf` (`id_fornecedor`,`nota_fiscal`),
  KEY `fk_entrada_estoque_id_mercado` (`id_mercado`),
  KEY `fk_entrada_estoque_id_pedido` (`id_pedido`),
  KEY `fk_entrada_estoque_id_funcionario` (`id_funcionario`),
  CONSTRAINT `fk_entrada_estoque_id_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_entrada_estoque_id_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `fk_entrada_estoque_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `fk_entrada_estoque_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido_compra` (`id_pedido`),
  CONSTRAINT `ck_entrada_estoque_valor_total` CHECK ((`valor_total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Recebimento de mercadoria com nota fiscal (RF09). Representa a chegada física; a obrigação de pagar fica em CONTA_PAGAR.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrada_estoque`
--

LOCK TABLES `entrada_estoque` WRITE;
/*!40000 ALTER TABLE `entrada_estoque` DISABLE KEYS */;
INSERT INTO `entrada_estoque` VALUES (1,1,1,1,1,'2026-10-20','4521',50.40),(2,1,2,NULL,1,'2026-10-28','B-889',107.40),(3,1,1,NULL,1,'2026-10-12','4380',139.20),(4,2,1,NULL,1,'2026-10-12','4381',60.00),(5,1,1,NULL,1,'2026-08-01','4100',12.00);
/*!40000 ALTER TABLE `entrada_estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estorno`
--

DROP TABLE IF EXISTS `estorno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estorno` (
  `id_estorno` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do estorno',
  `id_venda` int NOT NULL COMMENT 'Venda original',
  `id_funcionario` int DEFAULT NULL COMMENT 'Quem decidiu; nulo enquanto SOLICITADO',
  `data_solicitacao` datetime NOT NULL COMMENT 'Pedido feito no aplicativo',
  `data_decisao` datetime DEFAULT NULL COMMENT 'Aprovação ou recusa',
  `valor` decimal(10,2) NOT NULL COMMENT 'Valor a devolver (parcial ou total)',
  `motivo` varchar(200) NOT NULL COMMENT 'Motivo informado',
  `status` varchar(10) NOT NULL COMMENT 'DEVOLVIDO quando o valor sai do caixa',
  PRIMARY KEY (`id_estorno`),
  KEY `fk_estorno_id_venda` (`id_venda`),
  KEY `fk_estorno_id_funcionario` (`id_funcionario`),
  CONSTRAINT `fk_estorno_id_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `fk_estorno_id_venda` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `ck_estorno_decisao` CHECK ((((`status` = _utf8mb4'SOLICITADO') and (`id_funcionario` is null) and (`data_decisao` is null)) or ((`status` <> _utf8mb4'SOLICITADO') and (`id_funcionario` is not null) and (`data_decisao` is not null)))),
  CONSTRAINT `ck_estorno_status` CHECK ((`status` in (_utf8mb4'SOLICITADO',_utf8mb4'APROVADO',_utf8mb4'RECUSADO',_utf8mb4'DEVOLVIDO'))),
  CONSTRAINT `ck_estorno_valor` CHECK ((`valor` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Devolução total ou parcial do valor de uma venda, solicitada pelo app e decidida pela operadora (PO04).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estorno`
--

LOCK TABLES `estorno` WRITE;
/*!40000 ALTER TABLE `estorno` DISABLE KEYS */;
INSERT INTO `estorno` VALUES (1,1,1,'2026-10-23 08:00:00','2026-10-23 09:00:00',3.00,'Garrafa amassada','DEVOLVIDO'),(2,2,NULL,'2026-10-31 20:00:00',NULL,10.00,'Iogurte azedo','SOLICITADO');
/*!40000 ALTER TABLE `estorno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedor` (
  `id_fornecedor` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do fornecedor',
  `razao_social` varchar(150) NOT NULL COMMENT 'Nome jurídico',
  `nome_fantasia` varchar(100) DEFAULT NULL COMMENT 'Nome comercial',
  `cnpj` char(14) NOT NULL COMMENT 'CNPJ',
  `telefone` varchar(20) NOT NULL COMMENT 'Telefone de contato',
  `email` varchar(120) DEFAULT NULL COMMENT 'E-mail de contato',
  `endereco` varchar(200) DEFAULT NULL COMMENT 'Endereço',
  `status` varchar(10) NOT NULL COMMENT 'Inativos não recebem pedidos',
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE KEY `cnpj` (`cnpj`),
  CONSTRAINT `ck_fornecedor_status` CHECK ((`status` in (_utf8mb4'ATIVO',_utf8mb4'INATIVO')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Fornecedores de mercadorias.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,'Alfa Distribuidora Ltda.','Alfa','33333333000133','1131111111',NULL,NULL,'ATIVO'),(2,'Beta Alimentos S.A.','Beta','44444444000144','1132222222',NULL,NULL,'ATIVO');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecimento`
--

DROP TABLE IF EXISTS `fornecimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecimento` (
  `id_fornecedor` int NOT NULL COMMENT 'Compõe a chave primária',
  `id_produto` int NOT NULL COMMENT 'Compõe a chave primária',
  `preco_custo` decimal(10,2) NOT NULL COMMENT 'Custo praticado pelo fornecedor',
  `prazo_entrega_dias` int NOT NULL COMMENT 'Prazo médio em dias',
  `prazo_pagamento_dias` int NOT NULL COMMENT 'Prazo negociado para pagar; define o vencimento da conta a pagar (PO09)',
  PRIMARY KEY (`id_fornecedor`,`id_produto`),
  KEY `fk_fornecimento_id_produto` (`id_produto`),
  CONSTRAINT `fk_fornecimento_id_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_fornecimento_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `ck_fornecimento_prazo_entrega_dias` CHECK ((`prazo_entrega_dias` >= 0)),
  CONSTRAINT `ck_fornecimento_prazo_pagamento_dias` CHECK ((`prazo_pagamento_dias` >= 0)),
  CONSTRAINT `ck_fornecimento_preco_custo` CHECK ((`preco_custo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre FORNECEDOR e PRODUTO.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecimento`
--

LOCK TABLES `fornecimento` WRITE;
/*!40000 ALTER TABLE `fornecimento` DISABLE KEYS */;
INSERT INTO `fornecimento` VALUES (1,1,2.10,2,30),(1,2,1.00,2,30),(1,3,3.00,2,30),(1,4,1.60,2,30),(1,5,5.20,2,30),(2,1,2.20,1,7),(2,5,5.46,1,7);
/*!40000 ALTER TABLE `fornecimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do funcionário',
  `id_pessoa` int NOT NULL COMMENT 'Pessoa que é o funcionário',
  `id_empresa` int NOT NULL COMMENT 'Empresa que emprega o funcionário',
  `cargo` varchar(60) NOT NULL COMMENT 'Define o perfil de acesso (RNF09)',
  `data_admissao` date NOT NULL COMMENT 'Data de contratação',
  PRIMARY KEY (`id_funcionario`),
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  KEY `fk_funcionario_id_empresa` (`id_empresa`),
  CONSTRAINT `fk_funcionario_id_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa_operadora` (`id_empresa`),
  CONSTRAINT `fk_funcionario_id_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Papel de funcionário da empresa operadora.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,5,1,'Operações e financeiro','2025-02-01');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_pedido`
--

DROP TABLE IF EXISTS `item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_pedido` (
  `id_pedido` int NOT NULL COMMENT 'Compõe a chave primária',
  `id_produto` int NOT NULL COMMENT 'Compõe a chave primária',
  `quantidade` int NOT NULL COMMENT 'Quantidade solicitada',
  `custo_unitario` decimal(10,2) NOT NULL COMMENT 'Custo negociado',
  PRIMARY KEY (`id_pedido`,`id_produto`),
  KEY `fk_item_pedido_id_produto` (`id_produto`),
  CONSTRAINT `fk_item_pedido_id_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido_compra` (`id_pedido`),
  CONSTRAINT `fk_item_pedido_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `ck_item_pedido_custo_unitario` CHECK ((`custo_unitario` >= 0)),
  CONSTRAINT `ck_item_pedido_quantidade` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre PEDIDO_COMPRA e PRODUTO.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedido`
--

LOCK TABLES `item_pedido` WRITE;
/*!40000 ALTER TABLE `item_pedido` DISABLE KEYS */;
INSERT INTO `item_pedido` VALUES (1,1,24,2.10);
/*!40000 ALTER TABLE `item_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_venda`
--

DROP TABLE IF EXISTS `item_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_venda` (
  `id_venda` int NOT NULL COMMENT 'Compõe a chave primária',
  `id_produto` int NOT NULL COMMENT 'Compõe a chave primária',
  `quantidade` int NOT NULL COMMENT 'Quantidade vendida; igual à soma das saídas de lote do item',
  `preco_unitario` decimal(10,2) NOT NULL COMMENT 'Preço no momento da venda (PO03)',
  PRIMARY KEY (`id_venda`,`id_produto`),
  KEY `fk_item_venda_id_produto` (`id_produto`),
  CONSTRAINT `fk_item_venda_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `fk_item_venda_id_venda` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `ck_item_venda_preco_unitario` CHECK ((`preco_unitario` > 0)),
  CONSTRAINT `ck_item_venda_quantidade` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre VENDA e PRODUTO.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_venda`
--

LOCK TABLES `item_venda` WRITE;
/*!40000 ALTER TABLE `item_venda` DISABLE KEYS */;
INSERT INTO `item_venda` VALUES (1,1,10,4.50),(1,2,2,3.00),(2,1,8,4.50),(3,1,5,4.50),(3,3,2,6.00),(4,2,1,3.00),(5,2,2,3.00);
/*!40000 ALTER TABLE `item_venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lote`
--

DROP TABLE IF EXISTS `lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lote` (
  `id_lote` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do lote',
  `id_entrada` int NOT NULL COMMENT 'Entrada de origem (define o mercado)',
  `id_produto` int NOT NULL COMMENT 'Um único produto por lote',
  `codigo_lote` varchar(30) NOT NULL COMMENT 'Código do fabricante',
  `data_fabricacao` date DEFAULT NULL COMMENT 'Data de fabricação',
  `data_validade` date NOT NULL COMMENT 'Base da baixa por validade mais próxima (RN15)',
  `quantidade_recebida` int NOT NULL COMMENT 'Somada ao estoque do mercado',
  `custo_unitario` decimal(10,2) NOT NULL COMMENT 'Custo real por unidade; valoriza as perdas',
  PRIMARY KEY (`id_lote`),
  KEY `fk_lote_id_entrada` (`id_entrada`),
  KEY `fk_lote_id_produto` (`id_produto`),
  CONSTRAINT `fk_lote_id_entrada` FOREIGN KEY (`id_entrada`) REFERENCES `entrada_estoque` (`id_entrada`),
  CONSTRAINT `fk_lote_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `ck_lote_custo_unitario` CHECK ((`custo_unitario` >= 0)),
  CONSTRAINT `ck_lote_data_validade` CHECK ((`data_validade` >= `data_fabricacao`)),
  CONSTRAINT `ck_lote_quantidade_recebida` CHECK ((`quantidade_recebida` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Lote de um produto recebido em uma entrada. O mercado do lote é o da entrada. O saldo não é armazenado: é calculado pelas saídas (PO07).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lote`
--

LOCK TABLES `lote` WRITE;
/*!40000 ALTER TABLE `lote` DISABLE KEYS */;
INSERT INTO `lote` VALUES (1,1,1,'L-0911','2026-10-10','2026-10-30',24,2.10),(2,2,1,'L-0930','2026-10-25','2026-11-12',24,2.20),(3,2,5,'PF-1027','2026-10-27','2026-11-06',10,5.46),(4,3,2,'AG-1010','2026-10-01','2027-04-30',48,1.00),(5,3,3,'CV-0930','2026-09-30','2027-02-28',24,3.00),(6,3,4,'DT-0815','2026-08-15','2028-08-15',12,1.60),(7,4,2,'AG-1010B','2026-10-01','2027-04-30',24,1.00),(8,4,3,'CV-0930B','2026-09-30','2027-02-28',12,3.00),(9,5,2,'AG-0801','2026-07-25','2027-01-31',12,1.00);
/*!40000 ALTER TABLE `lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mercado`
--

DROP TABLE IF EXISTS `mercado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mercado` (
  `id_mercado` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do mercado',
  `id_condominio` int NOT NULL COMMENT 'Cada mercado pertence a um condomínio (RO03)',
  `nome` varchar(80) NOT NULL COMMENT 'Ex.: Mercado Bloco A',
  `localizacao` varchar(100) NOT NULL COMMENT 'Local dentro do condomínio',
  `status_ativo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Desativado mantém histórico',
  PRIMARY KEY (`id_mercado`),
  KEY `fk_mercado_id_condominio` (`id_condominio`),
  CONSTRAINT `fk_mercado_id_condominio` FOREIGN KEY (`id_condominio`) REFERENCES `condominio` (`id_condominio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mercado autônomo instalado em um condomínio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mercado`
--

LOCK TABLES `mercado` WRITE;
/*!40000 ALTER TABLE `mercado` DISABLE KEYS */;
INSERT INTO `mercado` VALUES (1,1,'Mercado Jardim','Térreo, ao lado da portaria',1),(2,2,'Mercado Vila Nova','Salão de festas',1);
/*!40000 ALTER TABLE `mercado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `morador`
--

DROP TABLE IF EXISTS `morador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `morador` (
  `id_morador` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do morador',
  `id_pessoa` int NOT NULL COMMENT 'Uma pessoa tem no máximo um cadastro de morador',
  `status_ativo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Cadastro ativo. Só é desativado quando não resta vínculo vigente ou a pedido (RN10)',
  `aceita_notificacoes` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Notificações personalizadas só se verdadeiro (RN12)',
  `reserva_suspensa_ate` datetime DEFAULT NULL COMMENT 'Preenchido após 3 expirações em 30 dias (RN07, PO01)',
  `data_desativacao` date DEFAULT NULL COMMENT 'Nulo enquanto ativo; histórico mantido (RN10, PO06)',
  PRIMARY KEY (`id_morador`),
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `fk_morador_id_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`),
  CONSTRAINT `ck_morador_desativacao` CHECK ((((`status_ativo` = true) and (`data_desativacao` is null)) or ((`status_ativo` = false) and (`data_desativacao` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Papel de morador de uma pessoa (especialização de PESSOA). O cadastro é único por pessoa, e os períodos em cada unidade ficam em VINCULO_RESIDENCIAL.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `morador`
--

LOCK TABLES `morador` WRITE;
/*!40000 ALTER TABLE `morador` DISABLE KEYS */;
INSERT INTO `morador` VALUES (1,1,1,1,NULL,NULL),(2,2,1,1,'2026-11-06 08:30:00',NULL),(3,3,1,1,NULL,NULL),(4,4,0,0,NULL,'2026-09-30');
/*!40000 ALTER TABLE `morador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacao_financeira`
--

DROP TABLE IF EXISTS `movimentacao_financeira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacao_financeira` (
  `id_movimentacao` bigint NOT NULL AUTO_INCREMENT COMMENT 'Identificador da movimentação',
  `id_conta_financeira` int NOT NULL COMMENT 'Conta movimentada',
  `tipo` varchar(7) NOT NULL COMMENT 'Sentido do dinheiro',
  `categoria` varchar(20) NOT NULL COMMENT 'Natureza da movimentação',
  `data_movimento` date NOT NULL COMMENT 'Data em que o dinheiro entrou ou saiu',
  `valor` decimal(12,2) NOT NULL COMMENT 'Valor movimentado',
  `id_conta_pagar` int DEFAULT NULL COMMENT 'Título pago (categoria PAGAMENTO_FORNECEDOR)',
  `id_cobranca` int DEFAULT NULL COMMENT 'Cobrança recebida (categoria RECEBIMENTO_COBRANCA)',
  `id_venda` int DEFAULT NULL COMMENT 'Venda creditada (categoria CREDITO_VENDA)',
  `id_estorno` int DEFAULT NULL COMMENT 'Estorno devolvido (categoria DEVOLUCAO_ESTORNO)',
  `descricao` varchar(150) DEFAULT NULL COMMENT 'Obrigatória nas categorias TRANSFERENCIA e OUTRA',
  PRIMARY KEY (`id_movimentacao`),
  UNIQUE KEY `id_venda` (`id_venda`),
  UNIQUE KEY `id_estorno` (`id_estorno`),
  KEY `fk_movimentacao_financeira_id_conta_financeira` (`id_conta_financeira`),
  KEY `fk_movimentacao_financeira_id_conta_pagar` (`id_conta_pagar`),
  KEY `fk_movimentacao_financeira_id_cobranca` (`id_cobranca`),
  CONSTRAINT `fk_movimentacao_financeira_id_cobranca` FOREIGN KEY (`id_cobranca`) REFERENCES `cobranca` (`id_cobranca`),
  CONSTRAINT `fk_movimentacao_financeira_id_conta_financeira` FOREIGN KEY (`id_conta_financeira`) REFERENCES `conta_financeira` (`id_conta_financeira`),
  CONSTRAINT `fk_movimentacao_financeira_id_conta_pagar` FOREIGN KEY (`id_conta_pagar`) REFERENCES `conta_pagar` (`id_conta_pagar`),
  CONSTRAINT `fk_movimentacao_financeira_id_estorno` FOREIGN KEY (`id_estorno`) REFERENCES `estorno` (`id_estorno`),
  CONSTRAINT `fk_movimentacao_financeira_id_venda` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `ck_mov_origem` CHECK ((((`categoria` = _utf8mb4'CREDITO_VENDA') and (`tipo` = _utf8mb4'ENTRADA') and (`id_venda` is not null) and (`id_conta_pagar` is null) and (`id_cobranca` is null) and (`id_estorno` is null)) or ((`categoria` = _utf8mb4'RECEBIMENTO_COBRANCA') and (`tipo` = _utf8mb4'ENTRADA') and (`id_cobranca` is not null) and (`id_conta_pagar` is null) and (`id_venda` is null) and (`id_estorno` is null)) or ((`categoria` = _utf8mb4'PAGAMENTO_FORNECEDOR') and (`tipo` = _utf8mb4'SAIDA') and (`id_conta_pagar` is not null) and (`id_cobranca` is null) and (`id_venda` is null) and (`id_estorno` is null)) or ((`categoria` = _utf8mb4'DEVOLUCAO_ESTORNO') and (`tipo` = _utf8mb4'SAIDA') and (`id_estorno` is not null) and (`id_conta_pagar` is null) and (`id_cobranca` is null) and (`id_venda` is null)) or ((`categoria` in (_utf8mb4'TRANSFERENCIA',_utf8mb4'OUTRA')) and (`descricao` is not null) and (`id_conta_pagar` is null) and (`id_cobranca` is null) and (`id_venda` is null) and (`id_estorno` is null)))),
  CONSTRAINT `ck_movimentacao_financeira_categoria` CHECK ((`categoria` in (_utf8mb4'CREDITO_VENDA',_utf8mb4'RECEBIMENTO_COBRANCA',_utf8mb4'PAGAMENTO_FORNECEDOR',_utf8mb4'DEVOLUCAO_ESTORNO',_utf8mb4'TRANSFERENCIA',_utf8mb4'OUTRA'))),
  CONSTRAINT `ck_movimentacao_financeira_tipo` CHECK ((`tipo` in (_utf8mb4'ENTRADA',_utf8mb4'SAIDA'))),
  CONSTRAINT `ck_movimentacao_financeira_valor` CHECK ((`valor` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cada entrada ou saída efetiva de dinheiro. É a liquidação dos títulos (pagamentos e recebimentos) e a base do fluxo de caixa (RF16 a RF18).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacao_financeira`
--

LOCK TABLES `movimentacao_financeira` WRITE;
/*!40000 ALTER TABLE `movimentacao_financeira` DISABLE KEYS */;
INSERT INTO `movimentacao_financeira` VALUES (1,2,'ENTRADA','CREDITO_VENDA','2026-08-15',3.00,NULL,NULL,4,NULL,NULL),(2,1,'SAIDA','PAGAMENTO_FORNECEDOR','2026-08-30',12.00,6,NULL,NULL,NULL,NULL),(3,1,'ENTRADA','RECEBIMENTO_COBRANCA','2026-09-10',900.00,NULL,6,NULL,NULL,NULL),(4,1,'ENTRADA','RECEBIMENTO_COBRANCA','2026-10-05',1200.00,NULL,1,NULL,NULL,NULL),(5,2,'ENTRADA','CREDITO_VENDA','2026-10-22',51.00,NULL,NULL,1,NULL,NULL),(6,2,'SAIDA','DEVOLUCAO_ESTORNO','2026-10-23',3.00,NULL,NULL,NULL,1,NULL),(7,2,'ENTRADA','CREDITO_VENDA','2026-10-25',36.00,NULL,NULL,2,NULL,NULL),(8,1,'ENTRADA','RECEBIMENTO_COBRANCA','2026-10-30',700.00,NULL,2,NULL,NULL,NULL),(9,1,'SAIDA','PAGAMENTO_FORNECEDOR','2026-10-31',139.20,1,NULL,NULL,NULL,NULL),(10,1,'SAIDA','PAGAMENTO_FORNECEDOR','2026-10-31',7.40,5,NULL,NULL,NULL,NULL),(11,2,'ENTRADA','CREDITO_VENDA','2026-11-01',6.00,NULL,NULL,5,NULL,NULL);
/*!40000 ALTER TABLE `movimentacao_financeira` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacao`
--

DROP TABLE IF EXISTS `notificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacao` (
  `id_notificacao` bigint NOT NULL AUTO_INCREMENT COMMENT 'Identificador da notificação',
  `id_morador` int NOT NULL COMMENT 'Destinatário (RN12)',
  `id_produto` int DEFAULT NULL COMMENT 'Opcional: avisos gerais não têm produto',
  `tipo` varchar(15) NOT NULL COMMENT 'Tipo da notificação',
  `titulo` varchar(100) NOT NULL COMMENT 'Título',
  `mensagem` varchar(500) NOT NULL COMMENT 'Texto',
  `data_hora` datetime NOT NULL COMMENT 'Envio',
  `lida` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Indica leitura',
  PRIMARY KEY (`id_notificacao`),
  KEY `fk_notificacao_id_morador` (`id_morador`),
  KEY `fk_notificacao_id_produto` (`id_produto`),
  CONSTRAINT `fk_notificacao_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `fk_notificacao_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `ck_notificacao_tipo` CHECK ((`tipo` in (_utf8mb4'NOVO_PRODUTO',_utf8mb4'REPOSICAO',_utf8mb4'SUGESTAO',_utf8mb4'AVISO_GERAL')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Mensagem enviada a um morador (RF11, RF12).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacao`
--

LOCK TABLES `notificacao` WRITE;
/*!40000 ALTER TABLE `notificacao` DISABLE KEYS */;
INSERT INTO `notificacao` VALUES (1,1,1,'REPOSICAO','Iogurte reposto','Chegou lote novo de iogurte natural.','2026-10-28 09:05:00',1),(2,3,2,'SUGESTAO','Sugestão para você','Água mineral disponível agora.','2026-11-01 09:30:00',0),(3,2,NULL,'AVISO_GERAL','Reservas suspensas','Suas reservas voltam em 06/11.','2026-10-30 08:31:00',0);
/*!40000 ALTER TABLE `notificacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_compra`
--

DROP TABLE IF EXISTS `pedido_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_compra` (
  `id_pedido` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do pedido',
  `id_mercado` int NOT NULL COMMENT 'Mercado solicitante',
  `id_fornecedor` int NOT NULL COMMENT 'Fornecedor (deve estar ativo)',
  `data_pedido` date NOT NULL COMMENT 'Data de emissão',
  `data_previsao_entrega` date DEFAULT NULL COMMENT 'Previsão de entrega',
  `status` varchar(10) NOT NULL COMMENT 'Situação do pedido',
  `valor_total` decimal(12,2) NOT NULL COMMENT 'Soma dos itens',
  PRIMARY KEY (`id_pedido`),
  KEY `fk_pedido_compra_id_mercado` (`id_mercado`),
  KEY `fk_pedido_compra_id_fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_pedido_compra_id_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`),
  CONSTRAINT `fk_pedido_compra_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `ck_pedido_compra_data_previsao_entrega` CHECK ((`data_previsao_entrega` >= `data_pedido`)),
  CONSTRAINT `ck_pedido_compra_status` CHECK ((`status` in (_utf8mb4'ABERTO',_utf8mb4'ENVIADO',_utf8mb4'RECEBIDO',_utf8mb4'CANCELADO'))),
  CONSTRAINT `ck_pedido_compra_valor_total` CHECK ((`valor_total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Solicitação de um mercado a um fornecedor.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_compra`
--

LOCK TABLES `pedido_compra` WRITE;
/*!40000 ALTER TABLE `pedido_compra` DISABLE KEYS */;
INSERT INTO `pedido_compra` VALUES (1,1,1,'2026-10-18','2026-10-20','RECEBIDO',50.40);
/*!40000 ALTER TABLE `pedido_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id_pessoa` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da pessoa',
  `nome` varchar(100) NOT NULL COMMENT 'Nome completo',
  `cpf` char(11) NOT NULL COMMENT 'CPF sem pontuação; não pode se repetir',
  `data_nascimento` date NOT NULL COMMENT 'Permite calcular a idade na data da reserva ou da venda (RO06, RN18)',
  `email` varchar(120) DEFAULT NULL COMMENT 'E-mail usado pelo aplicativo e pelo painel',
  `telefone` varchar(20) DEFAULT NULL COMMENT 'Pode ser informado posteriormente',
  PRIMARY KEY (`id_pessoa`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Dados pessoais comuns a moradores, funcionários e administradores (supertipo).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'Ana Souza','11122233344','1990-04-12','ana@exemplo.com',NULL),(2,'Bruno Lima','22233344455','2009-06-20','bruno@exemplo.com',NULL),(3,'Carla Mendes','33344455566','1985-01-30','carla@exemplo.com',NULL),(4,'Diego Rocha','44455566677','1978-09-09','diego@exemplo.com',NULL),(5,'Eva Martins','55566677788','1992-02-02','eva@safralink.com',NULL),(6,'Fábio Prado','66677788899','1970-05-05','fabio@jardim.com',NULL),(7,'Gina Alves','77788899900','1981-11-11','gina@vilanova.com',NULL);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do produto',
  `id_categoria` int NOT NULL COMMENT 'Categoria (RF02)',
  `nome` varchar(120) NOT NULL COMMENT 'Nome do produto',
  `descricao` text COMMENT 'Descrição opcional',
  `codigo_barras` varchar(14) DEFAULT NULL COMMENT 'Código EAN',
  `unidade_medida` varchar(5) NOT NULL COMMENT 'un, kg, L',
  `restricao_idade` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Verdadeiro para itens vendidos só a maiores de 18 (RO06, RN18)',
  `ativo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Produto desativado em vez de excluído (RF02)',
  PRIMARY KEY (`id_produto`),
  UNIQUE KEY `codigo_barras` (`codigo_barras`),
  KEY `fk_produto_id_categoria` (`id_categoria`),
  CONSTRAINT `fk_produto_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_produto` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo geral de produtos (preço e estoque ficam por mercado).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,1,'Iogurte natural 170 g',NULL,'7890000000001','un',0,1),(2,2,'Água mineral 500 mL',NULL,'7890000000002','un',0,1),(3,2,'Cerveja lata 350 mL',NULL,'7890000000003','un',1,1),(4,4,'Detergente 500 mL',NULL,'7890000000004','un',0,1),(5,3,'Pão de forma',NULL,'7890000000005','un',0,1);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `id_reserva` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da reserva',
  `id_morador` int NOT NULL COMMENT 'Máx. 10 ativas; bloqueado se suspenso (RN06, RN07)',
  `id_mercado` int NOT NULL COMMENT 'Mercado da reserva; exige vínculo vigente no condomínio (RN13)',
  `id_produto` int NOT NULL COMMENT 'Produto reservado (RN03, RN18)',
  `id_venda` int DEFAULT NULL COMMENT 'Venda que concretizou a reserva',
  `qtd_reservada` int NOT NULL COMMENT 'Não ultrapassa o disponível',
  `data_hora_inicio` datetime NOT NULL COMMENT 'Início da reserva',
  `data_hora_expiracao` datetime NOT NULL COMMENT 'Início + 30 minutos (RN04)',
  `data_hora_encerramento` datetime DEFAULT NULL COMMENT 'Momento da conclusão, do cancelamento ou da expiração',
  `status` varchar(10) NOT NULL COMMENT 'Expira automaticamente (RF05)',
  PRIMARY KEY (`id_reserva`),
  KEY `fk_reserva_id_morador` (`id_morador`),
  KEY `fk_reserva_id_produto` (`id_produto`),
  KEY `fk_reserva_id_venda` (`id_venda`),
  KEY `fk_reserva_disponibilidade` (`id_mercado`,`id_produto`),
  CONSTRAINT `fk_reserva_disponibilidade` FOREIGN KEY (`id_mercado`, `id_produto`) REFERENCES `disponibilidade_produto` (`id_mercado`, `id_produto`),
  CONSTRAINT `fk_reserva_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `fk_reserva_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `fk_reserva_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`),
  CONSTRAINT `fk_reserva_id_venda` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `ck_reserva_encerramento` CHECK (((`status` = _utf8mb4'ATIVA') = (`data_hora_encerramento` is null))),
  CONSTRAINT `ck_reserva_expiracao` CHECK ((`data_hora_expiracao` > `data_hora_inicio`)),
  CONSTRAINT `ck_reserva_qtd_reservada` CHECK ((`qtd_reservada` > 0)),
  CONSTRAINT `ck_reserva_status` CHECK ((`status` in (_utf8mb4'ATIVA',_utf8mb4'CONCLUIDA',_utf8mb4'EXPIRADA',_utf8mb4'CANCELADA'))),
  CONSTRAINT `ck_reserva_venda` CHECK (((`status` = _utf8mb4'CONCLUIDA') = (`id_venda` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Reserva de um produto em um mercado por 30 minutos.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,1,1,1,NULL,1,'2026-11-01 09:50:00','2026-11-01 10:20:00',NULL,'ATIVA'),(2,1,1,2,NULL,1,'2026-11-01 09:45:00','2026-11-01 10:15:00',NULL,'ATIVA'),(3,2,1,2,NULL,1,'2026-10-20 18:00:00','2026-10-20 18:30:00','2026-10-20 18:30:00','EXPIRADA'),(4,2,1,4,NULL,1,'2026-10-25 18:00:00','2026-10-25 18:30:00','2026-10-25 18:30:00','EXPIRADA'),(5,2,1,2,NULL,1,'2026-10-30 08:00:00','2026-10-30 08:30:00','2026-10-30 08:30:00','EXPIRADA'),(6,1,1,2,1,2,'2026-10-22 18:50:00','2026-10-22 19:20:00','2026-10-22 19:10:00','CONCLUIDA'),(7,3,1,4,NULL,1,'2026-10-10 12:00:00','2026-10-10 12:30:00','2026-10-10 12:05:00','CANCELADA'),(8,1,1,1,NULL,1,'2026-11-01 09:00:00','2026-11-01 09:30:00',NULL,'ATIVA');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida_lote`
--

DROP TABLE IF EXISTS `saida_lote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saida_lote` (
  `id_saida` bigint NOT NULL AUTO_INCREMENT COMMENT 'Identificador da saída',
  `id_lote` int NOT NULL COMMENT 'Lote de onde saíram as unidades',
  `tipo` varchar(20) NOT NULL COMMENT 'Natureza da saída',
  `quantidade` int NOT NULL COMMENT 'Unidades retiradas',
  `data_hora` datetime NOT NULL COMMENT 'Momento da saída',
  `id_venda` int DEFAULT NULL COMMENT 'Com id_produto, forma FK → ITEM_VENDA quando tipo = VENDA',
  `id_produto` int DEFAULT NULL COMMENT 'Produto do item vendido; igual ao produto do lote',
  `id_funcionario` int DEFAULT NULL COMMENT 'Quem retirou, nas perdas e ajustes',
  `motivo` varchar(200) DEFAULT NULL COMMENT 'Obrigatório nas perdas e ajustes',
  PRIMARY KEY (`id_saida`),
  KEY `fk_saida_lote_id_lote` (`id_lote`),
  KEY `fk_saida_lote_id_funcionario` (`id_funcionario`),
  KEY `fk_saida_item_venda` (`id_venda`,`id_produto`),
  CONSTRAINT `fk_saida_item_venda` FOREIGN KEY (`id_venda`, `id_produto`) REFERENCES `item_venda` (`id_venda`, `id_produto`),
  CONSTRAINT `fk_saida_lote_id_funcionario` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`),
  CONSTRAINT `fk_saida_lote_id_lote` FOREIGN KEY (`id_lote`) REFERENCES `lote` (`id_lote`),
  CONSTRAINT `ck_saida_lote_quantidade` CHECK ((`quantidade` > 0)),
  CONSTRAINT `ck_saida_lote_tipo` CHECK ((`tipo` in (_utf8mb4'VENDA',_utf8mb4'PERDA_VENCIMENTO',_utf8mb4'PERDA_AVARIA',_utf8mb4'AJUSTE_INVENTARIO'))),
  CONSTRAINT `ck_saida_tipo` CHECK ((((`tipo` = _utf8mb4'VENDA') and (`id_venda` is not null) and (`id_produto` is not null) and (`id_funcionario` is null)) or ((`tipo` <> _utf8mb4'VENDA') and (`id_venda` is null) and (`id_produto` is null) and (`id_funcionario` is not null) and (`motivo` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cada retirada de unidades de um lote: por venda ou por perda (vencimento, avaria ou ajuste de inventário) (RF19, PO07).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida_lote`
--

LOCK TABLES `saida_lote` WRITE;
/*!40000 ALTER TABLE `saida_lote` DISABLE KEYS */;
INSERT INTO `saida_lote` VALUES (1,1,'VENDA',10,'2026-10-22 19:10:00',1,1,NULL,NULL),(2,9,'VENDA',2,'2026-10-22 19:10:00',1,2,NULL,NULL),(3,1,'VENDA',8,'2026-10-25 10:40:00',2,1,NULL,NULL),(4,1,'PERDA_VENCIMENTO',6,'2026-10-31 07:00:00',NULL,NULL,1,'Validade vencida em 30/10'),(5,2,'PERDA_AVARIA',1,'2026-10-31 07:10:00',NULL,NULL,1,'Embalagem furada'),(6,2,'VENDA',5,'2026-10-31 18:15:00',3,1,NULL,NULL),(7,5,'VENDA',2,'2026-10-31 18:15:00',3,3,NULL,NULL),(8,9,'VENDA',1,'2026-08-15 08:30:00',4,2,NULL,NULL),(9,7,'VENDA',2,'2026-11-01 09:00:00',5,2,NULL,NULL);
/*!40000 ALTER TABLE `saida_lote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_habitacional`
--

DROP TABLE IF EXISTS `unidade_habitacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_habitacional` (
  `id_unidade` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da unidade',
  `id_condominio` int NOT NULL COMMENT 'Condomínio da unidade',
  `identificacao` varchar(50) NOT NULL COMMENT 'Ex.: Bloco A – Apto 101',
  PRIMARY KEY (`id_unidade`),
  UNIQUE KEY `uq_unidade` (`id_condominio`,`identificacao`),
  CONSTRAINT `fk_unidade_habitacional_id_condominio` FOREIGN KEY (`id_condominio`) REFERENCES `condominio` (`id_condominio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Apartamento ou casa de um condomínio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_habitacional`
--

LOCK TABLES `unidade_habitacional` WRITE;
/*!40000 ALTER TABLE `unidade_habitacional` DISABLE KEYS */;
INSERT INTO `unidade_habitacional` VALUES (1,1,'Bloco A – Apto 101'),(2,1,'Bloco B – Apto 202'),(4,1,'Bloco C – Apto 303'),(3,2,'Casa 12');
/*!40000 ALTER TABLE `unidade_habitacional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda`
--

DROP TABLE IF EXISTS `venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venda` (
  `id_venda` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador da venda',
  `id_morador` int NOT NULL COMMENT 'Comprador (RF07)',
  `id_mercado` int NOT NULL COMMENT 'Permite relatórios por condomínio (RF13)',
  `id_contrato` int NOT NULL COMMENT 'Contrato que regia o mercado na data da venda (RN14)',
  `data_hora` datetime NOT NULL COMMENT 'Momento da compra',
  `valor_total` decimal(12,2) NOT NULL COMMENT 'Soma dos itens',
  `forma_pagamento` varchar(10) NOT NULL COMMENT 'Só meios eletrônicos (RO04)',
  `status_pagamento` varchar(12) NOT NULL COMMENT 'Concluída só se confirmado (RN08); estornos ficam em ESTORNO',
  `data_prevista_credito` date DEFAULT NULL COMMENT 'Quando o meio de pagamento deve creditar o valor (projeção de caixa)',
  `taxa_percentual_aplicada` decimal(5,2) NOT NULL COMMENT 'Copiada do contrato indicado em id_contrato',
  `valor_taxa_plataforma` decimal(10,2) NOT NULL COMMENT 'valor_total × taxa_percentual_aplicada / 100',
  PRIMARY KEY (`id_venda`),
  KEY `fk_venda_id_morador` (`id_morador`),
  KEY `fk_venda_id_mercado` (`id_mercado`),
  KEY `fk_venda_contrato_mercado` (`id_contrato`,`id_mercado`),
  CONSTRAINT `fk_venda_contrato_mercado` FOREIGN KEY (`id_contrato`, `id_mercado`) REFERENCES `contrato_mercado` (`id_contrato`, `id_mercado`),
  CONSTRAINT `fk_venda_id_contrato` FOREIGN KEY (`id_contrato`) REFERENCES `contrato` (`id_contrato`),
  CONSTRAINT `fk_venda_id_mercado` FOREIGN KEY (`id_mercado`) REFERENCES `mercado` (`id_mercado`),
  CONSTRAINT `fk_venda_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `ck_venda_forma_pagamento` CHECK ((`forma_pagamento` in (_utf8mb4'CARTAO',_utf8mb4'PIX'))),
  CONSTRAINT `ck_venda_status_pagamento` CHECK ((`status_pagamento` in (_utf8mb4'PENDENTE',_utf8mb4'CONFIRMADO',_utf8mb4'RECUSADO'))),
  CONSTRAINT `ck_venda_valor_total` CHECK ((`valor_total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Compra realizada por um morador em um mercado, regida pelo contrato vigente na data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda`
--

LOCK TABLES `venda` WRITE;
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` VALUES (1,1,1,3,'2026-10-22 19:10:00',51.00,'PIX','CONFIRMADO','2026-10-22',4.00,2.04),(2,1,1,3,'2026-10-25 10:40:00',36.00,'PIX','CONFIRMADO','2026-10-25',4.00,1.44),(3,1,1,3,'2026-10-31 18:15:00',34.50,'CARTAO','CONFIRMADO','2026-11-02',4.00,1.38),(4,3,1,1,'2026-08-15 08:30:00',3.00,'PIX','CONFIRMADO','2026-08-15',5.00,0.15),(5,3,2,2,'2026-11-01 09:00:00',6.00,'PIX','CONFIRMADO','2026-11-01',4.50,0.27),(6,2,1,3,'2026-10-30 17:45:00',3.00,'CARTAO','RECUSADO',NULL,4.00,0.12);
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vinculo_residencial`
--

DROP TABLE IF EXISTS `vinculo_residencial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vinculo_residencial` (
  `id_vinculo` int NOT NULL AUTO_INCREMENT COMMENT 'Identificador do período de vínculo',
  `id_morador` int NOT NULL COMMENT 'Morador do período',
  `id_unidade` int NOT NULL COMMENT 'Unidade do período',
  `tipo_vinculo` varchar(15) NOT NULL COMMENT 'Tipo de vínculo no período',
  `data_inicio` date NOT NULL COMMENT 'Início do período',
  `data_fim` date DEFAULT NULL COMMENT 'Preenchido quando o morador deixa a unidade (RN10)',
  `id_admin_aprovador` int DEFAULT NULL COMMENT 'Quem aprovou o vínculo (RO02)',
  `data_aprovacao` datetime DEFAULT NULL COMMENT 'Vínculo só é vigente depois de aprovado',
  PRIMARY KEY (`id_vinculo`),
  UNIQUE KEY `uq_vinculo_periodo` (`id_morador`,`id_unidade`,`data_inicio`),
  KEY `fk_vinculo_residencial_id_unidade` (`id_unidade`),
  KEY `fk_vinculo_residencial_id_admin_aprovador` (`id_admin_aprovador`),
  CONSTRAINT `fk_vinculo_residencial_id_admin_aprovador` FOREIGN KEY (`id_admin_aprovador`) REFERENCES `administrador_condominio` (`id_admin`),
  CONSTRAINT `fk_vinculo_residencial_id_morador` FOREIGN KEY (`id_morador`) REFERENCES `morador` (`id_morador`),
  CONSTRAINT `fk_vinculo_residencial_id_unidade` FOREIGN KEY (`id_unidade`) REFERENCES `unidade_habitacional` (`id_unidade`),
  CONSTRAINT `ck_vinculo_residencial_data_fim` CHECK ((`data_fim` >= `data_inicio`)),
  CONSTRAINT `ck_vinculo_residencial_tipo_vinculo` CHECK ((`tipo_vinculo` in (_utf8mb4'PROPRIETARIO',_utf8mb4'INQUILINO',_utf8mb4'DEPENDENTE')))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Associativa entre MORADOR e UNIDADE_HABITACIONAL tratada como ocorrência temporal: cada linha é um período de residência, e a mesma pessoa pode ter vários períodos na mesma unidade (RN02, RN10).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vinculo_residencial`
--

LOCK TABLES `vinculo_residencial` WRITE;
/*!40000 ALTER TABLE `vinculo_residencial` DISABLE KEYS */;
INSERT INTO `vinculo_residencial` VALUES (1,1,1,'PROPRIETARIO','2025-01-01',NULL,1,'2025-01-01 09:00:00'),(2,2,1,'DEPENDENTE','2025-01-01',NULL,1,'2025-01-01 09:00:00'),(3,3,2,'INQUILINO','2026-01-01','2026-10-15',1,'2026-01-02 09:00:00'),(4,3,3,'PROPRIETARIO','2024-06-01',NULL,2,'2024-06-01 09:00:00'),(5,4,4,'INQUILINO','2026-01-01','2026-03-31',1,'2026-01-02 09:00:00'),(6,4,4,'INQUILINO','2026-08-01','2026-09-30',1,'2026-08-01 09:00:00'),(7,1,4,'INQUILINO','2026-11-01',NULL,NULL,NULL);
/*!40000 ALTER TABLE `vinculo_residencial` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-01 20:39:05
