-- SQLBook: Code

IF OBJECT_ID('Projeto_Doacao', 'U') IS NOT NULL
    DROP TABLE Projeto_Doacao;

IF OBJECT_ID('Projeto_Tem_Tratamento_Tratador_Animal', 'U') IS NOT NULL
    DROP TABLE Projeto_Tem_Tratamento_Tratador_Animal;
    
IF OBJECT_ID('Projeto_Tratamento', 'U') IS NOT NULL
    DROP TABLE Projeto_Tratamento;

IF OBJECT_ID('Projeto_Tratador', 'U') IS NOT NULL
    DROP TABLE Projeto_Tratador;

IF OBJECT_ID('Projeto_Doador', 'U') IS NOT NULL
    DROP TABLE Projeto_Doador;

IF OBJECT_ID('Projeto_Funcionario', 'U') IS NOT NULL
    DROP TABLE Projeto_Funcionario;

IF OBJECT_ID('Projeto_Tem_Vacina', 'U') IS NOT NULL
    DROP TABLE Projeto_Tem_Vacina;

IF OBJECT_ID('Projeto_Vacina', 'U') IS NOT NULL
    DROP TABLE Projeto_Vacina;

IF OBJECT_ID('Projeto_Historial_Clinico', 'U') IS NOT NULL
    DROP TABLE Projeto_Historial_Clinico;

IF OBJECT_ID('Projeto_Desparasitacao_externa', 'U') IS NOT NULL
    DROP TABLE Projeto_Desparasitacao_externa;

IF OBJECT_ID('Projeto_Desparasitacao_interna', 'U') IS NOT NULL
    DROP TABLE Projeto_Desparasitacao_interna;

IF OBJECT_ID('Projeto_Tem_Desparasitacao', 'U') IS NOT NULL
    DROP TABLE Projeto_Tem_Desparasitacao;

IF OBJECT_ID('Projeto_Desparasitacao', 'U') IS NOT NULL
    DROP TABLE Projeto_Desparasitacao;

IF OBJECT_ID('Projeto_Animal', 'U') IS NOT NULL
    DROP TABLE Projeto_Animal;

IF OBJECT_ID('Projeto_Adotante', 'U') IS NOT NULL
    DROP TABLE Projeto_Adotante;

IF OBJECT_ID('Projeto_PESSOA', 'U') IS NOT NULL
    DROP TABLE Projeto_PESSOA;

IF OBJECT_ID('Projeto_Abrigo', 'U') IS NOT NULL
    DROP TABLE Projeto_Abrigo;

CREATE TABLE Projeto_Abrigo (
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(512) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(128) NOT NULL,
    PRIMARY KEY (Email)
);

CREATE TABLE Projeto_PESSOA (
    NIF INT  NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(512) NOT NULL,    
    Email VARCHAR(128) NOT NULL,
    PRIMARY KEY (NIF),
    Aemail VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email)
);
CREATE TABLE Projeto_Adotante (
    Telefone VARCHAR(20) NOT NULL,
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(512) NOT NULL,
    Email VARCHAR(128) NOT NULL,
    Data_Adocao DATE NOT NULL,
    ID INT PRIMARY KEY NOT NULL,
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    AEMAIL VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email)
);

CREATE TABLE Projeto_Animal (
    Nome VARCHAR(128) NOT NULL,
    Altura DECIMAL(5,2) NOT NULL,
    Idade INT NOT NULL,
    Peso DECIMAL(5,2) NOT NULL,
    Origem_Historia VARCHAR(1024),
    Data_Entrada DATE NOT NULL,
    Numero_Microchip INT NOT NULL,
    AEMAIL VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email),
    PRIMARY KEY (NOME)
);

CREATE TABLE Projeto_Desparasitacao (
    [Data] DATE NOT NULL,
    Desparasitante VARCHAR(512) NOT NULL,
    PRIMARY KEY ([Data])
);

CREATE TABLE Projeto_TEM_Desparasitacao(
    ANOME VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Animal(Nome),
    Ddata DATE FOREIGN KEY REFERENCES Projeto_Desparasitacao([DATA])
)


CREATE TABLE Projeto_Desparasitacao_interna (
    Desparasitante VARCHAR(512) NOT NULL,
    
    Ddata DATE FOREIGN KEY REFERENCES Projeto_Desparasitacao([DATA])
);

CREATE TABLE Projeto_Desparasitacao_externa (
    Desparasitante VARCHAR(512) NOT NULL,
    
    Ddata DATE FOREIGN KEY REFERENCES Projeto_Desparasitacao([DATA])
);

CREATE TABLE Projeto_Historial_Clinico (
    [Data] DATE NOT NULL,
    Patologia VARCHAR(255) NOT NULL,
    Medicacao VARCHAR(255) NOT NULL,

    PRIMARY KEY (Data),
    ANOME VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Animal(Nome)
);

CREATE TABLE Projeto_Vacina (
    [Data] DATE NOT NULL,
    Tipo VARCHAR(128) NOT NULL,
    Dose INT NOT NULL,

    PRIMARY KEY (Data)
);

CREATE TABLE Projeto_Tem_Vacina (
    ANOME VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Animal(Nome),
    Vdata DATE FOREIGN KEY REFERENCES Projeto_Vacina([DATA])
);

CREATE TABLE Projeto_Funcionario (
    Num_func INT PRIMARY KEY NOT NULL,
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    Abrigo_Email VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email),
    Telefone VARCHAR(20) NOT NULL,
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(1024) NOT NULL,
    Email VARCHAR(128) NOT NULL,
    Horario DATETIME DEFAULT GETDATE() NOT NULL
)

CREATE TABLE Projeto_Doador (
    ID INT PRIMARY KEY NOT NULL,
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    Abrigo_Email VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email),
    Telefone VARCHAR(20) NOT NULL,
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(1024) NOT NULL,
    Email VARCHAR(128) NOT NULL,
)

CREATE TABLE Projeto_Tratador (
    Num_tratador INT PRIMARY KEY NOT NULL,
    NIF BIGINT NOT NULL CHECK (NIF > 100000000),
    Abrigo_Email VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Abrigo(Email),
    Telefone VARCHAR(20) NOT NULL,
    Nome VARCHAR(128) NOT NULL,
    Endereco VARCHAR(1024) NOT NULL,
    Email VARCHAR(128) NOT NULL,
    Horario DATETIME DEFAULT GETDATE() NOT NULL
 
);

CREATE TABLE Projeto_Tratamento (
    [Data] DATE NOT NULL,
    Tipo VARCHAR(128) NOT NULL,

	PRIMARY KEY([Data])
);

CREATE TABLE Projeto_Tem_Tratamento_Tratador_Animal (
    Num_tratador INT FOREIGN KEY REFERENCES Projeto_Tratador(Num_tratador),
    Animal_Nome VARCHAR(128) FOREIGN KEY REFERENCES Projeto_Animal(Nome),
    Tdata DATE FOREIGN KEY REFERENCES Projeto_Tratamento([Data])
);

CREATE TABLE Projeto_Doacao (
    ID INT PRIMARY KEY NOT NULL,
    Doador_ID INT FOREIGN KEY REFERENCES Projeto_Doador(ID),
    Quantidade DECIMAL(5,2) NOT NULL,
    Tipo VARCHAR(128) NOT NULL,
    [Data] DATE NOT NULL
);



