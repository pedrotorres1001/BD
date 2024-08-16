IF OBJECT_ID('SNS_Tem', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Tem;
IF OBJECT_ID('SNS_Prescricao', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Prescricao;
IF OBJECT_ID('SNS_Vende', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Vende;
IF OBJECT_ID('SNS_Farmacia', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Farmacia;
IF OBJECT_ID('SNS_Farmaco', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Farmaco;
IF OBJECT_ID('SNS_Farmaceutica', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Farmaceutica;
IF OBJECT_ID('SNS_Paciente', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Paciente;
IF OBJECT_ID('SNS_Medico', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Medico;
IF OBJECT_ID('SNS_Especialidade', 'U') IS NOT NULL
	DROP TABLE dbo.SNS_Especialidade;

CREATE TABLE SNS_Especialidade (
    Codigo int NOT NULL,
    Designacao varchar(128) NOT NULL,
    PRIMARY KEY (Codigo),
)

CREATE TABLE SNS_Medico (
    SNS int NOT NULL,
    Nome varchar(128) NOT NULL,
    Codigo_Especialidade int NOT NULL REFERENCES SNS_Especialidade(Codigo),
    PRIMARY KEY (SNS),
)

CREATE TABLE SNS_Paciente (
    Numero_utente int NOT NULL,
    Nome varchar(128) NOT NULL,
    Morada varchar(512) NOT NULL,
    [Data_nascimento] date NOT NULL,
    PRIMARY KEY (Numero_utente),
)

CREATE TABLE SNS_Farmaceutica (
    Numero_Registo_Nacional int NOT NULL,
    Morada varchar(512) NOT NULL,
    Telefone varchar(10) NOT NULL,
    Nome varchar(128) NOT NULL,
    PRIMARY KEY (Numero_Registo_Nacional),
)

CREATE TABLE SNS_Farmaco (
    Nome_Unico varchar(128) NOT NULL,
    Nome_Comercial varchar(128) NOT NULL,
    Formula varchar(128) NOT NULL,
    Farmaco_Numero_Registo_Nacional int NOT NULL REFERENCES SNS_Farmaceutica(Numero_Registo_Nacional),
    PRIMARY KEY (Nome_Unico),
)

CREATE TABLE SNS_Farmacia (
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    Nome varchar(128) NOT NULL,
    Morada varchar(512) NOT NULL,
    Telefone varchar(10) NOT NULL,
    PRIMARY KEY (NIF),
)

CREATE TABLE SNS_Vende (
    Farmaco_Nome_Unico varchar(128) NOT NULL REFERENCES SNS_Farmaco(Nome_Unico),
    NIF BIGINT NOT NULL CHECK (NIF > 100000000) REFERENCES SNS_Farmacia(NIF),
    PRIMARY KEY (Farmaco_Nome_Unico, NIF),
)

CREATE TABLE SNS_Prescricao (
    Numero_Unico int NOT NULL,
    Nome varchar(128) NOT NULL,
    Numero_utente int NOT NULL REFERENCES SNS_Paciente(Numero_utente),
    Medico_SNS int NOT NULL REFERENCES SNS_Medico(SNS),
    PRIMARY KEY (Numero_Unico),
)

CREATE TABLE SNS_Tem (
    Farmaco_Nome_Unico varchar(128) NOT NULL REFERENCES SNS_Farmaco(Nome_Unico),
    Prescricao_Numero_Unico int NOT NULL REFERENCES SNS_Prescricao(Numero_Unico),
    PRIMARY KEY (Farmaco_Nome_Unico, Prescricao_Numero_Unico),
)

