CREATE DATABASE Concessionaria;
USE DATABASE Concessionaria;

CREATE TABLE TblCliente(
  CPF varchar(12) not null
    constraint pk_cliente PRIMARY KEY,
  nome varchar(50) not null,
  RG char(9) not null,
  telefone varchar(30)
  
);

CREATE TABLE TblFinanciamento(
  cod_carro int not null
    constraint pk_financiamento PRIMARY KEY,
  CPF varchar(12) not null
    constraint fk_TblFinanciamento_CPF FOREIGN KEY
    references TblCliente(CPF),
  dataParcela date,
  entrada date not null,
  parcelas int not null
);

CREATE TABLE TblTesteDrive(
  cod_TesteDrive int not null
    constraint pk_TesteDrive PRIMARY KEY,
  CPF varchar(12) not null
    constraint fk_TblTesteDrive_CPF FOREIGN KEY
    references TblCliente(CPF),
  tipo char(2) not null constraint ck_TblTesteDrive_tipo check (tipo in('C','M','V')),
  cod_serviço int not null,
  quantidade int,
  
);

CREATE TABLE TblVendedor(
  cod_vendedor int not null
    constraint pk_vendedor PRIMARY KEY,
  nome varchar(50) not null,
  CEP varchar(10),
  salario decimal(10,2)
);

CREATE TABLE TblRelatorioVendas(
  cod_relatorio int not null
    constraint pk_relatorioVendas PRIMARY KEY,
  cod_vendedor int not null
    constraint fk_TblRelatorioVendas_vendedor FOREIGN KEY
    references TblVendedor(cod_vendedor),
  numero_vendas int,
  data date,
  valor_total decimal(10,2) not null
);

CREATE TABLE TblPedido(
  cod_venda int not null
    constraint pk_pedido PRIMARY KEY,
  CPF varchar(12) not null
    constraint fk_TblPedido_CPF
    references TblCliente(CPF),
  cod_vendedor int not null
    constraint fk_TblPedido_cod_vendedor FOREIGN KEY
    references TblVendedor(cod_vendedor),
  data date,
  preco decimal(10,2) not null,
  pagamento varchar(2) not null 
  constraint ck_TblPedido_tipo check (pagamento in('D','C','P')),
  
);

CREATE TABLE TblModelo(
  cod_modelo int not null
    constraint pk_modelo PRIMARY KEY,
  nome varchar(20),
  marca varchar(20),
  categoria varchar(20)
);

CREATE TABLE TblEstoque(
  cod_estoque int not null
    constraint pk_estoque PRIMARY KEY,
  localizacao varchar(50),
  dataEntrega date not null,
  status varchar(20)
);

CREATE TABLE TblVeiculo(
  CRV varchar(20) not null
    constraint pk_veiculo PRIMARY KEY,
  cod_modelo int not null
    constraint fk_TblVeiculo_cod_modelo FOREIGN KEY
    references TblModelo(cod_modelo)
);

CREATE TABLE TblFornecedor(
  CNPJ varchar(12) not null
    constraint pk_fornecedor PRIMARY KEY,
  cod_estoque int not null
    constraint fk_TblFornecedor_cod_estoque FOREIGN KEY
    references TblEstoque(cod_estoque),
  CEF varchar(50) not null,
  cod_produto int,
  nome varchar(50) not null
);

CREATE TABLE TblServico(
  OS int not null
    constraint pk_servico PRIMARY KEY,
  CRV varchar(20) not null
    constraint fk_TblServico_CRV FOREIGN KEY
    references TblVeiculo(CRV),
  
  tipo varchar(4)
    constraint ck_TipoServico check (tipo in ('R', 'A', 'B', 'T')),
  preco decimal(10,2),
  data date,
);



CREATE TABLE TblInsumo(
  nome int not null
    constraint pk_insumo PRIMARY KEY,
  tipo varchar(4)
    constraint ck_TipoInsumo check(tipo in('O','V','PA','PN')),
  quantidade int not null,
  cod_servico int
);

CREATE TABLE TblUso(
  OS int not null
    constraint fk_TblUso_OS FOREIGN KEY
    references TblEstoque(cod_estoque),
  nome int not null
    constraint fk_TblUso_nome FOREIGN KEY
    references TblInsumo(nome)
  
);



