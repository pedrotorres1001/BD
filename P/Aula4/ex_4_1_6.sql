IF OBJECT_ID('Escola_Tem_Aluno_Pessoa_com_Autorizacao', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Tem_Aluno_Pessoa_com_Autorizacao;
IF OBJECT_ID('Escola_Tem_Turma_Atividade', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Tem_Turma_Atividade;
IF OBJECT_ID('Escola_Pessoa_Com_Autorizacao', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Pessoa_Com_Autorizacao;
IF OBJECT_ID('Escola_Aluno', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Aluno;
IF OBJECT_ID('Escola_Encarregado_Educacao', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Encarregado_Educacao;
IF OBJECT_ID('Escola_Turma', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Turma;
IF OBJECT_ID('Escola_Professor', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Professor;
IF OBJECT_ID('Escola_Atividade', 'U') IS NOT NULL
	DROP TABLE dbo.Escola_Atividade;

CREATE TABLE Escola_Atividade (
    ID int NOT NULL,
    Designacao varchar(128) NOT NULL,
    Custo float NOT NULL,
    PRIMARY KEY (ID),
)

CREATE TABLE Escola_Professor (
    Numero_Funcionario int NOT NULL,
    Nome varchar(128) NOT NULL,
    Email varchar(128) NOT NULL,
    Numero_CC BIGINT NOT NULL CHECK (Numero_CC > 10000000),
    Morada varchar(512) NOT NULL,
    [Data_Nascimento] date NOT NULL,
    Telefone varchar(10) NOT NULL,
    PRIMARY KEY (Numero_CC),
)

CREATE TABLE Escola_Turma (
    ID int NOT NULL,
    Ano_Letivo int NOT NULL,
    Designacao varchar(128) NOT NULL,
    Classe int NOT NULL,
    Quantidade_Maxima int NOT NULL,
    Numero_CC_Prof BIGINT NOT NULL CHECK (Numero_CC_Prof > 10000000) REFERENCES Escola_Professor(Numero_CC),
    PRIMARY KEY (ID),
)

CREATE TABLE Escola_Encarregado_Educacao (
    Nome varchar(128) NOT NULL,
    Numero_CC BIGINT NOT NULL CHECK (Numero_CC > 10000000),
    Morada varchar(512) NOT NULL,
    [Data_Nascimento] date NOT NULL,
    Telefone varchar(10) NOT NULL,
    Email varchar(128) NOT NULL,
    Relacao varchar(50) NOT NULL,
    PRIMARY KEY (Numero_CC),
)

CREATE TABLE Escola_Aluno (
    Nome varchar(128) NOT NULL,
    Numero_CC BIGINT NOT NULL CHECK (Numero_CC > 10000000),
    Morada varchar(512) NOT NULL,
    [Data_Nascimento] date NOT NULL,
    Numero_CC_EE BIGINT NOT NULL CHECK (Numero_CC_EE > 10000000) REFERENCES Escola_Encarregado_Educacao(Numero_CC),
    Turma_ID int NOT NULL REFERENCES Escola_Turma(ID),
    PRIMARY KEY (Numero_CC),
)

CREATE TABLE Escola_Pessoa_Com_Autorizacao (
    Numero_CC BIGINT NOT NULL CHECK (Numero_CC > 10000000),
    Nome varchar(128) NOT NULL,
    Morada varchar(512) NOT NULL,
    [Data_Nascimento] date NOT NULL,
    Telefone varchar(10) NOT NULL,
    Email varchar(128) NOT NULL,
    Relacao varchar(50) NOT NULL,
    PRIMARY KEY (Numero_CC),
)

CREATE TABLE Escola_Tem_Turma_Atividade (
    Turma_ID int NOT NULL REFERENCES Escola_Turma(ID),
    Atividade_ID int NOT NULL REFERENCES Escola_Atividade(ID),
    PRIMARY KEY (Turma_ID,Atividade_ID),
)

CREATE TABLE Escola_Tem_Aluno_Pessoa_com_Autorizacao (
    Aluno_Numero_CC BIGINT NOT NULL CHECK (Aluno_Numero_CC > 10000000) REFERENCES Escola_Aluno(Numero_CC),
    Pessoa_com_Autorizacao_Numero_CC BIGINT NOT NULL CHECK (Pessoa_com_Autorizacao_Numero_CC > 10000000) REFERENCES Escola_Pessoa_Com_Autorizacao(Numero_CC),
    PRIMARY KEY (Aluno_Numero_CC,Pessoa_com_Autorizacao_Numero_CC),
)