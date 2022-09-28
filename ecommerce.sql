CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE Cliente(
	idCliente int auto_increment primary key,
	nome VARCHAR(150) not null,
	CPF CHAR(11) not null,
	Endereço varchar(150),
	Email varchar(100),
	constraint unique_cpf_client unique (CPF)
);


CREATE TABLE Produto(
	idProduto int auto_increment primary key,
	nome_produto VARCHAR(45) not null,
	Valor float(10) not null,
	Categoria enum('eletrônicos','brinquedos','alimentos','roupas','esportes','livros', 'moveis') not null
);

CREATE TABLE Estoque(
	idEstoque int auto_increment primary key,
	QuantidadeProduto int default 1,
	Produto varchar(45),
	Endereço VARCHAR(45) not null
);

CREATE TABLE FormaDePagamento(
	idPagamento int auto_increment primary key,
	idCliente int,
	FormasDePagamento enum('cartão', 'cartão2', 'pix', 'boleto'),
	constraint fk_cliente_pagamento foreign key (idCliente) references Cliente(idCliente)
);

CREATE TABLE Pedido(
	idPedido int auto_increment primary key,
	Descrição VARCHAR(255),
	Frete float default 0,
	idPagamento int,
	StatusPedido enum('Processando','Aguardando Pagamento', 'Cancelado', 'Confirmado','Em transporte','Entregue') default 'Processando'
);

CREATE TABLE Fornecedor(
	idFornecedor int auto_increment primary key,
	RazãoSocial varchar(45) not null,
	CNPJ char(15),
	idProduto int,	
	Contato varchar(11) not null,
	Endereço varchar(45) not null,
	constraint unique_fornecedor unique (CNPJ)
);

CREATE TABLE VendedorTerceiro(
	idTerceiro int auto_increment primary key,
	RazãoSocial varchar(45),
	CNPJ char(15),
	idProduto int,	
	Produto varchar(45),
	Contato varchar(11) not null,
	Endereço varchar(45) not null,
	constraint unique_cnpj_vendedor unique (CNPJ),
	constraint unique_cpf_vendedor unique (CPF)
);

ALTER TABLE vendedorterceiro
	drop column produto;


CREATE TABLE VendedorDisponibiliza(
	idTerceiro int,
	idProduto int,
	Quantidade int default 1,
	primary key (idTerceiro, idProduto),
	constraint fk_produto_terceiro foreign key (idTerceiro) references VendedorTerceiro(idTerceiro), 
	constraint fk_produto_produto foreign key (idProduto) references Produto(idProduto)
);

CREATE TABLE ProdutoPedido(
	idProduto int,
	idPedido int,
	idCliente int,
	Quantidade int default 1,
	primary key (idProduto, idPedido, idCliente),
	constraint fk_produtopedido_pedido foreign key (idPedido) references Pedido(idPedido), 
	constraint fk_produtopedido_produto foreign key (idProduto) references Produto(idProduto),
	constraint fk_produtopedido_cliente foreign key (idCliente) references Cliente(idCliente)
);

CREATE TABLE ProdutoEstoque(
	idProduto int,
	idEstoque int,
	Quantidade int default 1,
	primary key (idProduto, idEstoque),
	constraint fk_produto_estoque foreign key (idProduto) references Produto(idProduto), 
	constraint fk_estoque_estoque foreign key (idEstoque) references Estoque(idEstoque)
);

ALTER table cliente auto_increment=1;
ALTER table formadepagamento auto_increment=1;
ALTER table fornecedor auto_increment=1;
ALTER table estoque auto_increment=1;
ALTER table pedido auto_increment=1;
ALTER table produto auto_increment=1;
