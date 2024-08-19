--DDL
create table Cliente(
	id_cliente integer Primary Key,
	nome varchar(50) not null,
	email varchar(100) not null unique,
	data_nascimento date
	);
create table Produto(
	id_produto integer Primary Key,
	nome varchar(60) not null,
	descrição varchar(200),
	preço float not null
);
create table pedido(
	id_pedido integer Primary key,
	data_pedido date,
	fk_id_cliente integer not null,
	foreign key (fk_id_cliente) references Cliente(id_cliente)
);
create table avaliacao(
	id_avaliação integer Primary Key,
	nota integer,
	comentario text,
	fk_id_produto integer not null,
	fk_id_cliente integer not null,
	foreign key (fk_id_produto) references produto(id_produto),
	foreign key (fk_id_cliente) references Cliente(id_cliente)
);
create table categoria(
	id_categoria integer Primary key,
	nome varchar(99)
);
create table categoria_produto(
	fk_id_categoria integer not null,
	fk_id_produto integer not null,
	primary key(fk_id_categoria,fk_id_produto),
	foreign key(fk_id_categoria) references categoria(id_categoria),
	foreign key(fk_id_produto) references Produto(id_produto)
);
create table pedido_produto(
	fk_id_pedido integer not null,
	fk_id_produto integer not null,
	quantidade integer not null,
	primary key(fk_id_pedido,fk_id_produto),
	foreign key(fk_id_pedido) references pedido(id_pedido),
	foreign key(fk_id_produto) references Produto(id_produto)
);
--DML
insert into Cliente (id_cliente,nome,email,data_nascimento) values
('1','joao','joao@gmail.com','12-11-2000'),
('2','maria','maria@gmail.com','21-04-1986'),
('3','clovis','clovis@gmail.com','13-06-1998');

insert into produto (id_produto,nome,descrição,preço) values
('10','ferramenta','descrição1','20.99'),
('11','perfume','descrição2','259.99'),
('12','relogio','descrição3','129.99');

insert into pedido (id_pedido,data_pedido,fk_id_cliente) values
('20','21-02-2024','1'),
('21','20-05-2024','2'),
('22', '22-06-2024','3');

insert into avaliacao (id_avaliação,nota,comentario,fk_id_produto,fk_id_cliente) values
('30','9','bom prefume','11','3'),
('31','5','bom produto mas não e resistente','10','1'),
('32','10','relogio muito bom','12','2');

insert into categoria(id_categoria,nome) values
('40','ferramentas'),
('41','acessorios'),
('42','perfumaria');

insert into categoria_produto(fk_id_categoria,fk_id_produto) values
('40','10'),
('41','12'),
('42','11');

insert into pedido_produto(fk_id_pedido,fk_id_produto,quantidade) values
('20','10','2'),
('21','11','1'),
('22','12','2');

--INNER´S JOIN´S
--1(Listar todos os clientes e os pedidos associados a eles)
select Cliente.id_cliente,Cliente.nome as nome_cliente,Pedido.id_pedido,Pedido.data_pedido
from Cliente
inner join Pedido on Cliente.id_cliente = Pedido.fk_id_cliente;
--2(Listar todos os pedidos e os produtos associados a eles)
select Pedido.id_pedido,Produto.id_produto,Produto.nome as nome_produto,
Pedido_Produto.quantidade from Pedido
inner join Pedido_Produto on Pedido.id_pedido = Pedido_Produto.fk_id_pedido
inner join Produto on Pedido_Produto.fk_id_produto = Produto.id_produto;
--3(Listar todos os produtos e as categorias associadas a eles)
select Produto.id_produto,Produto.nome as nome_produto,Categoria.id_categoria,
Categoria.nome as nome_categoria from Produto
inner join categoria_produto on Produto.id_produto = categoria_produto.fk_id_produto
inner join Categoria on categoria_produto.fk_id_categoria = Categoria.id_categoria;
--4(Listar todas as avaliações feitas por clientes e os produtos avaliados)
select avaliacao.id_avaliação,avaliacao.nota,avaliacao.comentario, Produto.id_produto,
Produto.nome as nome_produto from avaliacao
inner join Produto on avaliacao.fk_id_produto = Produto.id_produto;
--5(Listar todos os produtos em um pedido específico)
select Pedido.id_pedido,Pedido.data_pedido,Produto.id_produto,Produto.nome as nome_produto,
Pedido_Produto.quantidade from Pedido
inner join Pedido_Produto on Pedido.id_pedido = Pedido_Produto.fk_id_pedido
inner join Produto on Pedido_Produto.fk_id_produto = Produto.id_produto;
--6(Listar todos os pedidos feitos por um cliente específico)
select Cliente.id_cliente,Cliente.nome as nome_cliente,Pedido.id_pedido,Produto.nome as nome_produto,
Pedido_Produto.quantidade from Cliente
inner join Pedido on Cliente.id_cliente = Pedido.fk_id_cliente
inner join Pedido_Produto on Pedido.id_pedido = Pedido_Produto.fk_id_pedido
inner join Produto on Pedido_Produto.fk_id_produto = Produto.id_produto
where Cliente.id_cliente=1;
--7(Listar todos os produtos e suas avaliações)
select avaliacao.id_avaliação,avaliacao.nota,
Produto.nome as nome_produto from avaliacao 
inner join Produto on Avaliacao.fk_id_produto = Produto.id_produto;
--8(Listar todas as categorias e os produtos pertencentes a elas)
select Produto.id_produto,Produto.nome as nome_produto,Categoria.id_categoria,
Categoria.nome as nome_categoria from Produto
inner join Categoria_Produto on Produto.id_produto = Categoria_Produto.fk_id_produto
inner join Categoria on Categoria_Produto.fk_id_categoria = Categoria.id_categoria;
--9(Listar todos os produtos comprados por um cliente específico)
select Cliente.id_cliente,Cliente.nome as nome_cliente,Produto.id_produto,Produto.nome as nome_produto,
Pedido_Produto.quantidade from Cliente inner join Pedido on Cliente.id_cliente = Pedido.fk_id_cliente
inner join Pedido_Produto on Pedido.id_pedido = Pedido_Produto.fk_id_pedido
inner join Produto on Pedido_Produto.fk_id_produto = Produto.id_produto
where Cliente.id_cliente =1;
--10(Listar todas as avaliações feitas em produtos de uma determinada categoria)
select avaliacao.id_avaliação,avaliacao.nota,avaliacao.comentario,Produto.id_produto,
Produto.nome as nome_produto,Categoria.id_categoria,Categoria.nome as nome_categoria
from avaliacao inner join Produto on avaliacao.fk_id_produto = Produto.id_produto
inner join Categoria_Produto on Produto.id_produto = Categoria_Produto.fk_id_produto
inner join Categoria on Categoria_Produto.fk_id_categoria = Categoria.id_categoria
where Categoria.id_categoria in (40,41,42);



