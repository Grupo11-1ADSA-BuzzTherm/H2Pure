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


