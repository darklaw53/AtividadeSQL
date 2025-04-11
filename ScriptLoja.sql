CREATE SEQUENCE Seq_Pessoa
  START WITH 1
  INCREMENT BY 1;
GO

CREATE TABLE Pessoa (
  idPessoa INT NOT NULL PRIMARY KEY DEFAULT NEXT VALUE FOR Seq_Pessoa,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL
);
GO

CREATE TABLE PessoaFisica (
  idPessoa INT NOT NULL PRIMARY KEY,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
);
GO

CREATE TABLE PessoaJuridica (
  idPessoa INT NOT NULL PRIMARY KEY,
  cnpj VARCHAR(14) NOT NULL UNIQUE,
  FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa)
);
GO

CREATE TABLE Usuario (
  idUsuario INT NOT NULL IDENTITY PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  senha VARCHAR(255) NOT NULL
);
GO

CREATE TABLE Produto (
  idProduto INT NOT NULL IDENTITY PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  quantidade INT NOT NULL,
  preco DECIMAL(10, 2) NOT NULL
);
GO

CREATE TABLE Compra (
  idCompra INT NOT NULL IDENTITY PRIMARY KEY,
  idUsuario INT NOT NULL,
  idPessoaJuridica INT NOT NULL,
  idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  precoUnitario DECIMAL(10, 2) NOT NULL,
  dataHora DATETIME NOT NULL DEFAULT GETDATE(),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
  FOREIGN KEY (idPessoaJuridica) REFERENCES PessoaJuridica(idPessoa),
  FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);
GO

CREATE TABLE Venda (
  idVenda INT NOT NULL IDENTITY PRIMARY KEY,
  idUsuario INT NOT NULL,
  idPessoaFisica INT NOT NULL,
  idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  precoUnitario DECIMAL(10, 2) NOT NULL,
  dataHora DATETIME NOT NULL DEFAULT GETDATE(),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
  FOREIGN KEY (idPessoaFisica) REFERENCES PessoaFisica(idPessoa),
  FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);
GO