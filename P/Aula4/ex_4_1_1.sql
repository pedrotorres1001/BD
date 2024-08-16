DROP TABLE Rent_Ttipodeveiculo

IF OBJECT_ID('Rent_Aluguer', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Aluguer;
IF OBJECT_ID('Rent_Veiculo', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Veiculo;
IF OBJECT_ID('Rent_Balcao', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Balcao;
IF OBJECT_ID('Rent_Cliente', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Cliente;
IF OBJECT_ID('Rent_Pesado', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Pesado;
IF OBJECT_ID('Rent_Ligeiro', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Ligeiro;
IF OBJECT_ID('Rent_Similaridade', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Similaridade;
IF OBJECT_ID('Rent_Tipodeveiculo', 'U') IS NOT NULL
	DROP TABLE dbo.Rent_Tipodeveiculo;

CREATE TABLE Rent_Tipodeveiculo (
    Codigo int NOT NULL,
    Ar_condicionado bit NOT NULL,
    Designacao varchar(128) NOT NULL,
    PRIMARY KEY (Codigo),
)

CREATE TABLE Rent_Similaridade (
    Codigo_Similaridade_1 int NOT NULL REFERENCES Rent_Tipodeveiculo(Codigo),
    Codigo_Similaridade_2 int NOT NULL REFERENCES Rent_Tipodeveiculo(Codigo),
	PRIMARY KEY (Codigo_Similaridade_1, Codigo_Similaridade_2),
)

CREATE TABLE Rent_Ligeiro (
    ID int NOT NULL,
    Num_lugares int NOT NULL,
    Num_portas int NOT NULL,
    Tipo_combustivel varchar(128) NOT NULL,
    Tipo_veiculo_codigo int NOT NULL REFERENCES Rent_Tipodeveiculo(Codigo),
    PRIMARY KEY (ID),
)

CREATE TABLE Rent_Pesado (
    ID int NOT NULL,
    Passageiros int NOT NULL,
    Peso int NOT NULL,
    Tipo_veiculo_codigo int NOT NULL REFERENCES Rent_Tipodeveiculo(Codigo),
    PRIMARY KEY (ID),
)

CREATE TABLE Rent_Cliente (
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    Num_carta int NOT NULL,
    Nome varchar(128) NOT NULL,
    Endereco varchar(512) NOT NULL,
    PRIMARY KEY (NIF),
)

CREATE TABLE Rent_Balcao (
    Numero int NOT NULL,
    Nome varchar(128) NOT NULL,
    Endereco varchar(512) NOT NULL,
    PRIMARY KEY (Numero),
)

CREATE TABLE Rent_Veiculo (
    Matricula varchar(10) NOT NULL,
    Marca varchar(128) NOT NULL,
    Ano int NOT NULL,
    Tipo_veiculo_codigo int NOT NULL REFERENCES Rent_Tipodeveiculo(Codigo),
    PRIMARY KEY (Matricula),
)

CREATE TABLE Rent_Aluguer (
    Numero int NOT NULL,
    Data_inicio date NOT NULL,
    Data_fim date NOT NULL,
    Valor int NOT NULL,
    NIF BIGINT NOT NULL CHECK (NIF > 100000000) REFERENCES Rent_Cliente(NIF),
    Veiculo_Matricula varchar(10) NOT NULL REFERENCES Rent_Veiculo(Matricula),
    Balcao_Numero int NOT NULL REFERENCES Rent_Balcao(Numero),
    PRIMARY KEY (Numero),
)