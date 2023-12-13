-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql - banco local - ambiente de desenvolvimento
*/

CREATE DATABASE h2pure;

USE h2pure;

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	razaoSocial VARCHAR(50),
	cnpj CHAR(14)
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
);


create table esteira (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	setor VARCHAR(45),
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

create table leitura (
	id INT PRIMARY KEY AUTO_INCREMENT,
	fkEsteira INT,
    apta tinyint,
    dataHora datetime default current_timestamp,
	FOREIGN KEY (fkEsteira) REFERENCES esteira(id)
);

-- Inserir empresas
INSERT INTO empresa (razaoSocial, cnpj) VALUES
('Tecnologia Inovadora Ltda', '12345678901234'),
('Soluções Empresariais S.A.', '56789012345678'),
('Logística Eficiente Ltda', '90123456789012');

-- Inserir usuários associados a empresas
-- Para a Tecnologia Inovadora Ltda
INSERT INTO usuario (nome, email, senha, fkEmpresa) VALUES
('João Silva', 'joao.silva@email.com', 'senha123', 1),
('Ana Silva', 'ana.silva@email.com', 'senha456', 1);

-- Para a Soluções Empresariais S.A.
INSERT INTO usuario (nome, email, senha, fkEmpresa) VALUES
('Maria Oliveira', 'maria.oliveira@email.com', 'senha789', 2),
('Pedro Oliveira', 'pedro.oliveira@email.com', 'senha101', 2),
('Fernanda Oliveira', 'fernanda.oliveira@email.com', 'senha112', 2);

-- Para a Logística Eficiente Ltda
INSERT INTO usuario (nome, email, senha, fkEmpresa) VALUES
('Carlos Santos', 'carlos.santos@email.com', 'senha131', 3),
('Camila Santos', 'camila.santos@email.com', 'senha141', 3);

-- Inserir esteiras associadas a empresas
-- Para a Tecnologia Inovadora Ltda
INSERT INTO esteira (setor, fkEmpresa) VALUES
('Setor 21', 1),
('Setor 22', 1),
('Setor 23', 1);

-- Para a Soluções Empresariais S.A.
INSERT INTO esteira (setor, fkEmpresa) VALUES
('Setor A', 2),
('Setor B', 2),
('Setor C', 2),
('Setor D', 2),
('Setor E', 2);

-- Para a Logística Eficiente Ltda
INSERT INTO esteira (setor, fkEmpresa) VALUES
('Setor 0', 3),
('Setor 1', 3);

-- Inserir leituras associadas a esteiras

-- Para a Empresa do João Silva (Esteiras 1, 2, 3)
INSERT INTO leitura (fkEsteira, apta) VALUES
(1, 1),  -- Leitura válida na Esteira 1
(1, 0),  -- Leitura inválida na Esteira 1
(1, 1),  -- Leitura válida na Esteira 1
(1, 1)  -- Leitura válida na Esteira 1
;

-- Para a Empresa da Maria Oliveira (Esteiras 4, 5, 6, 7, 8)
INSERT INTO leitura (fkEsteira, apta) VALUES
(4, 1),  -- Leitura válida na Esteira 4
(4, 0),  -- Leitura inválida na Esteira 4
(4, 1),  -- Leitura válida na Esteira 4
(4, 1),  -- Leitura válida na Esteira 4

(5, 1),  -- Leitura válida na Esteira 5
(5, 1),  -- Leitura válida na Esteira 5
(5, 0),  -- Leitura inválida na Esteira 5
(5, 1)  -- Leitura válida na Esteira 5
;

-- Para a Empresa do Carlos Santos (Esteiras 9, 10)
INSERT INTO leitura (fkEsteira, apta) VALUES
(9, 1),  -- Leitura válida na Esteira 9
(9, 1),  -- Leitura válida na Esteira 9
(9, 1),  -- Leitura válida na Esteira 9
(9, 0),  -- Leitura inválida na Esteira 9

(10, 1), -- Leitura válida na Esteira 10
(10, 1), -- Leitura válida na Esteira 10
(10, 1), -- Leitura válida na Esteira 10
(10, 1) -- Leitura válida na Esteira 10
;

select * from empresa;
select * from usuario;
select * from esteira;
select * from leitura;


-- Empresa 1:
select 
date(dataHora) dia,
count(apta) prod
from  empresa e 
join esteira es 
on es.fkEmpresa = e.id
join leitura l 
on es.id = l.fkEsteira 
where apta = 1
and e.id =1
group by dia;

-- Empresa 2:
select 
date(dataHora) dia,
count(apta) prod
from  empresa e 
join esteira es 
on es.fkEmpresa = e.id
join leitura l 
on es.id = l.fkEsteira 
where apta = 1
and e.id =2
group by dia;

-- Empresa 3
select 
date(dataHora) dia,
count(apta) prod
from  empresa e 
join esteira es 
on es.fkEmpresa = e.id
join leitura l 
on es.id = l.fkEsteira 
where apta = 1
and e.id =3
group by dia;