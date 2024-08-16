IF OBJECT_ID('Encomenda_Possui', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Possui;
IF OBJECT_ID('Encomenda_Items', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Items;
IF OBJECT_ID('Encomenda_Encomenda', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Encomenda;
IF OBJECT_ID('Encomenda_Fornecedor', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Fornecedor;
IF OBJECT_ID('Encomenda_Produtos', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Produtos;
IF OBJECT_ID('Encomenda_Tipo_Fornecedor', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Tipo_Fornecedor;
IF OBJECT_ID('Encomenda_Condicoes_Pagamento', 'U') IS NOT NULL
	DROP TABLE dbo.Encomenda_Condicoes_Pagamento;

CREATE TABLE Encomenda_Condicoes_Pagamento (
    Designacao varchar(128) NOT NULL,
    Codigo int NOT NULL,
    PRIMARY KEY (Codigo),
)

CREATE TABLE Encomenda_Tipo_Fornecedor (
    Designacao varchar(128) NOT NULL,
    Codigo int NOT NULL,
    PRIMARY KEY (Codigo),
)

CREATE TABLE Encomenda_Produtos (
    Nome varchar(128) NOT NULL,
    Taxa_IVA float NOT NULL,
    Preco float NOT NULL,
    Codigo int NOT NULL,
    Unidades int NOT NULL,
    PRIMARY KEY (Codigo),
)

CREATE TABLE Encomenda_Fornecedor (
    Morada varchar(512) NOT NULL,
    Nome varchar(128) NOT NULL,
    Nif BIGINT NOT NULL CHECK (Nif > 100000000),
    Num_fax varchar(10) NOT NULL,
    Codigo_tipo_fornecedor int NOT NULL REFERENCES Encomenda_Tipo_Fornecedor(Codigo),
    Codigo_condicoes_pagamento int NOT NULL REFERENCES Encomenda_Condicoes_Pagamento(Codigo),
    PRIMARY KEY (Nif),
)

CREATE TABLE Encomenda_Encomenda (
    Numero int NOT NULL,
    [Data] date NOT NULL,
    Nif BIGINT CHECK (Nif > 100000000) NOT NULL REFERENCES Encomenda_Fornecedor(Nif),
    PRIMARY KEY (Numero),
)

CREATE TABLE Encomenda_Items (
    Produto_codigo int NOT NULL REFERENCES Encomenda_Produtos(Codigo),
    Quantidade int NOT NULL,
    PRIMARY KEY (Produto_codigo),
)

CREATE TABLE Encomenda_Possui (
    Produto_codigo int NOT NULL REFERENCES Encomenda_Items(Produto_codigo),
    Encomenda_numero int NOT NULL REFERENCES Encomenda_Encomenda(Numero),
    PRIMARY KEY (Produto_codigo, Encomenda_numero),
)


