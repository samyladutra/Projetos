
CREATE TABLE Cidade (
  `CdCidade` INT NOT NULL AUTO_INCREMENT,
  `NmCidade` VARCHAR(45) NULL,
  `SgEstado` VARCHAR(2) NULL,
  PRIMARY KEY (`CdCidade`))
ENGINE = InnoDB;


CREATE TABLE Cliente (
  `CdCliente` INT NOT NULL AUTO_INCREMENT,
  `NmCliente` VARCHAR(45) NULL,
  `Sexo` VARCHAR(1) NULL,
  `CPF` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Rua` VARCHAR(45) NULL,
  `Numero` INT NULL,
  `Complemento` VARCHAR(45) NULL,
  `Bairro` VARCHAR(45) NULL,
  `CdCidade` INT NOT NULL,
  PRIMARY KEY (`CdCliente`),
    FOREIGN KEY (`CdCidade`) REFERENCES Cidade (`CdCidade`)
    )
ENGINE = InnoDB;


CREATE TABLE Profissional (
  `CdProfissional` INT NOT NULL AUTO_INCREMENT,
  `NmProfissional` VARCHAR(45) NULL,
  `Sexo` VARCHAR(1) NULL,
  `CPF` VARCHAR(45) NULL,
  `RG` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Rua` VARCHAR(45) NULL,
  `Numero` VARCHAR(45) NULL,
  `Complemento` INT NULL,
  `Bairro` VARCHAR(45) NULL,
  `CdCidade` INT NOT NULL,
  `Profissao` VARCHAR(50),
  PRIMARY KEY (`CdProfissional`),
    FOREIGN KEY (`CdCidade`) REFERENCES Cidade (`CdCidade`)
    )
ENGINE = InnoDB;

CREATE TABLE TelefoneProfissional (
  `Numero` VARCHAR(15) NOT NULL,
  `CdProfissional` INT NOT NULL,
  PRIMARY KEY (`Numero`, `CdProfissional`),
    FOREIGN KEY (`CdProfissional`) REFERENCES Profissional (`CdProfissional`)
    )
ENGINE = InnoDB;


CREATE TABLE TelefoneCliente (
  `Numero` VARCHAR(15) NOT NULL,
  `CdCliente` INT NOT NULL,
  PRIMARY KEY (`Numero`, `CdCliente`),
    FOREIGN KEY (`CdCliente`) REFERENCES Cliente (`CdCliente`)
   )
ENGINE = InnoDB;



CREATE TABLE Servico (
  `CdServico` INT NOT NULL AUTO_INCREMENT,
  `NmServico` VARCHAR(45) NULL,
  `PorcentagemProf` DOUBLE NULL,
  `Preco` DOUBLE NULL,
   Duracao int NOT NULL,
   Descricao VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CdServico`))
ENGINE = InnoDB;

alter table Servico drop column PorcentagemProf;
alter table Servico drop column Duracao;


CREATE TABLE Atendimento (
  `CdAtendimento` INT NOT NULL AUTO_INCREMENT,
  `Situacao` TINYINT(1) NULL,
  `Data` DATE NULL,
  `CdProfissional` INT NOT NULL,
  `CdCliente` INT NOT NULL,
  `CdServico` INT NOT NULL,
  PRIMARY KEY (`CdAtendimento`),
  primary key (CdServico),
    FOREIGN KEY (`CdProfissional`) REFERENCES Profissional (`CdProfissional`),
    FOREIGN KEY (`CdCliente`) REFERENCES Cliente (`CdCliente`),
    FOREIGN KEY (`CdServico`) REFERENCES Servico (`CdServico`)
    )
ENGINE = InnoDB;


alter table Atendimento ADD Comissao double;
alter table Atendimento ADD HorarioInicio int;
alter table Atendimento ADD HorarioFim int;
alter table Atendimento ADD Valor double;

CREATE TABLE Venda (
  `CdVenda` INT NOT NULL AUTO_INCREMENT,
  `ValorTotal` DOUBLE NOT NULL,
  `Data` DATE NULL,
  PRIMARY KEY (`CdVenda`))
ENGINE = InnoDB;

alter table Venda add column Status boolean;
alter table Venda add column CdCliente int;
alter table Venda add foreign key (CdCliente) references Cliente(CdCliente);


CREATE TABLE Pagamento (
  `CdPagamento` INT NOT NULL AUTO_INCREMENT,
  `ValorPagamento` DOUBLE NULL,
  `NumParcelas` INT NULL,
  `CdVenda` INT NOT NULL,
  PRIMARY KEY (`CdPagamento`),
    FOREIGN KEY (`CdVenda`) REFERENCES Venda (`CdVenda`)
    )
ENGINE = InnoDB;

alter table Pagamento add column Entrada double;

CREATE TABLE ParcelasPagamento (
  `CdParcelasPagamento` INT NOT NULL AUTO_INCREMENT,
  `Valor` DOUBLE NULL,
  `ParcelasPagamentocol` VARCHAR(45) NULL,
  `CdPagamento` INT NOT NULL,
  PRIMARY KEY (`CdParcelasPagamento`),
     FOREIGN KEY (`CdPagamento`) REFERENCES Pagamento (`CdPagamento`)
    )
ENGINE = InnoDB;

CREATE TABLE Fornecedor (
  `CdFornecedor` INT NOT NULL AUTO_INCREMENT,
  `NmFornecedor` VARCHAR(45) NULL,
  `Sexo` VARCHAR(1) NULL,
  `CPF` VARCHAR(45) NULL, -- CNPJ
  `RG` VARCHAR(45) NULL, -- Empresa
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`CdFornecedor`))
ENGINE = InnoDB;

-- rever marca e produto

CREATE TABLE Produto (
  `CdProduto` INT NOT NULL AUTO_INCREMENT,
  `NmProduto` VARCHAR(45) NULL,
  `ValorUnitario` DOUBLE NULL,
  `Quantidade` INT NULL,
  `Marca` VARCHAR(30),
 `Area`VARCHAR(20),
 `Descricao` VARCHAR(100),
  PRIMARY KEY (`CdProduto`)
 )
ENGINE = InnoDB;

create table Marca(
CdMarca int not null auto_increment,
NmMarca varchar(30),
primary key(CdMarca)
)engine=innodb;


CREATE TABLE Administrador (
  `Usuario` VARCHAR(20) NOT NULL,
  `Senha` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Usuario`))
ENGINE = InnoDB;


CREATE TABLE Despesas (
  `CdDespesa` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NULL,
  `Valor` DOUBLE NULL,
  `DtRegistro` Date,
  `DtVencimento` Date,
  `DtPagamento` Date,
  `FormaPagamento` varchar(50),
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`CdDespesa`))
ENGINE = InnoDB;

drop table PagamentoProfissional;


create table PagamentoProfissional(
`CdPagamento` int not null auto_increment,
`DtInicial` Date,
`DtFinal` Date,
`DtPagamento` Date,
`CdProfissional` int,
`CdAtendimento` int,
`Salario` double,
primary key(CdPagamento, CdProfissional, CdAtendimento),
foreign key (CdProfissional) references Profissional(CdProfissional),
foreign key (CdAtendimento) references Atendimento(CdAtendimento)
)engine=innodb;


CREATE TABLE Atendimento_has_Venda (
  `CdAtendimento` INT NOT NULL,
  `CdVenda` INT NOT NULL,
  PRIMARY KEY (`CdAtendimento`, `CdVenda`),
    FOREIGN KEY (`CdAtendimento`) REFERENCES Atendimento (`CdAtendimento`),
     FOREIGN KEY (`CdVenda`) REFERENCES Venda (`CdVenda`))
ENGINE = InnoDB;


CREATE TABLE Venda_has_Produto (
  `CdVenda` INT NOT NULL,
  `CdProduto` INT NOT NULL,
  PRIMARY KEY (`CdVenda`, `CdProduto`),
    FOREIGN KEY (`CdVenda`) REFERENCES Venda (`CdVenda`),
    FOREIGN KEY (`CdProduto`) REFERENCES Produto (`CdProduto`)
    )ENGINE = InnoDB;
    
    alter table Venda_has_Produto add column Quantidade int;


CREATE TABLE TelefoneFornecedor (
 
 `Numero` VARCHAR(15) NOT NULL,
  
`CdFornecedor` INT NOT NULL,
 
 PRIMARY KEY (Numero, CdFornecedor),
 
 FOREIGN KEY (`CdFornecedor`)
  REFERENCES `Fornecedor` (`CdFornecedor`)
    
)
ENGINE = InnoDB;

CREATE TABLE Login(
    CdProfissional int NOT NULL , 
    Usuario VARCHAR(20) NOT NULL , 
    Senha Varchar(20) NOT NULL , 
    PRIMARY KEY (CdProfissional),
    FOREIGN KEY (CdProfissional) REFERENCES Profissional (CdProfissional) 
   )ENGINE = INNODB;
   
   CREATE TABLE Venda_has_Servico (
  `CdVenda` INT NOT NULL,
  `CdServico` INT NOT NULL,
   VlVenda INT NOT NULL,
  PRIMARY KEY (`CdVenda`, `CdServico`),
    FOREIGN KEY (`CdVenda`) REFERENCES Venda (`CdVenda`),
    FOREIGN KEY (`CdServico`) REFERENCES Servico (`CdServico`)
    )ENGINE = InnoDB;
   
   
   create table horario(
	hrInicio int,
	hrFim int,
	DiaSemana varchar(30),
	CdProfissional int,
	primary key(hrInicio),
	primary key(hrFim),
	primary key(DiaSemana),
	primary key(CdProfissional),
	foreign key(CdProfissional)
   )engine=innodb;

