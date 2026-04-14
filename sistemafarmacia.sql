--criar um banco de dados 
CREATE DATABASE farmacianova;

--criando a primeira tabela
CREATE TABLE farmacia (
cnpj VARCHAR(14) PRIMARY KEY,
telefone VARCHAR(11) NOT NULL,
nomefarmacia VARCHAR (255) NOT NULL,
rua VARCHAR(255) NOT NULL,
numero CHAR(8) NOT NULL,
complemento VARCHAR(200),
bairro VARCHAR(100) NOT NULL,
cidade VARCHAR(100) NOT NULL,
estado CHAR(2) NOT NULL,
CEP VARCHAR(8) NOT NULL
);

--criando a segunda tabela
CREATE TABLE farmaceutico (
    rg INT PRIMARY KEY,
    nomefarmaceutico VARCHAR (255) NOT NULL,
    cnpj_farmacia VARCHAR (14),
    FOREIGN KEY (cnpj_farmacia)
    REFERENCES farmacia(cnpj)
);  

--criando a terceira tabela

CREATE TABLE produto(
    codproduto INT AUTO_INCREMENT PRIMARY KEY,
    quantproduto INT NOT NULL,
    valorproduto DECIMAL (10,2) NOT NULL,
    cnpj_farmacia VARCHAR (14),
    FOREIGN KEY (cnpj_farmacia)
    REFERENCES farmacia (cnpj)
);

--alterando o nome de uma coluna existente
ALTER TABLE farmacia
change estado UF CHAR(2) NOT NULL;

--deletando as tabelas
DROP TABLE farmacia;
DROP TABLE farmaceutico;
DROP TABLE produto;

--deletando o banco de dados
DROP DATABASE farmacianova;

--inserindo um dado na primeira tabela
INSERT INTO farmacia (
    cnpj, telefone, nomefarmacia, rua, numero, complemento,
    bairro, cidade, UF, CEP
) VALUES
(
    '12345678000199',
    '11987654321',
    'Farmácia Saúde Total',
    'Rua das Flores',
    '120',
    'Próximo ao hospital',
    'Centro',
    'São Paulo',
    'SP',
    '01310000'
);

--inserindo vários dados ao mesmo tempo na primeira tabela
INSERT INTO farmacia (
    cnpj, telefone, nomefarmacia, rua, numero, complemento,
    bairro, cidade, UF, CEP
) VALUES
(
    '98765432000188',
    '11991234567',
    'Farmácia Bem Viver',
    'Avenida Paulista',
    '1500',
    'Loja 12',
    'Bela Vista',
    'São Paulo',
    'SP',
    '01310000'
),
(
    '45678912000177',
    '1133445566',
    'Farmácia Popular',
    'Rua Independência',
    '350',
    NULL,
    'Jardim América',
    'Campinas',
    'SP',
    '13020010'
),
(
    '32165498000166',
    '1140098877',
    'Farmácia Vida e Saúde',
    'Rua Rio Branco',
    '890',
    'Esquina com a praça',
    'Centro',
    'Santos',
    'SP',
    '11013001'   
);

--inserindo dois dados na segunda tabela
INSERT INTO farmaceutico (
    rg,
    nomefarmaceutico,
    cnpj_farmacia
) VALUES
(
    123456789,
    'Carlos Henrique Almeida',
    '12345678000199'
),
(
    987654321,
    'Fernanda Souza Lima',
    '98765432000188'
);  

--inserindo quatro dados na terceira tabela
INSERT INTO produto (
    codproduto,
    quantproduto,
    valorproduto,
    cnpj_farmacia
) VALUES
(
    1,
    50,
    12.90,
    '12345678000199'
),
(
    2,
    30,
    25.50,
    '98765432000188'
),
(
    3,
    100,
    8.75,
    '45678912000177'
),
(
    4,
    20,
    45.00,
    '32165498000166'
);

--alterando um dado na tabela farmacia
UPDATE farmacia
SET telefone = '11999998888'
WHERE cnpj = '12345678000199'

--alterando dois dados ao mesmo tempo na tabela de produto
UPDATE produto
SET quantproduto = 80,
valorproduto = 14.50
WHERE codproduto = 1;

--deletando um dado da tabela
DELETE FROM produto
WHERE codproduto = 4;

--inserindo dado sem passar o código pois é autoincrement
INSERT INTO produto (
    quantproduto,
    valorproduto,
    cnpj_farmacia
) VALUES
(
    25,
    45.40,
    '32165498000166'
);

--selecionando todos os dados de todas as colunas
SELECT * FROM farmacia;

--selecionando com filtro
SELECT * FROM farmacia
WHERE cidade = 'São Paulo';

--selecionando com WHERE e AND
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' AND UF = 'SP';

--selecionando com WHERE e OR
SELECT * FROM farmacia
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';

--selecionando uma coluna com WHERE e OR
SELECT telefone
FROM farmacia
WHERE cidade = 'São Paulo' OR cidade = 'Campinas';

--selecionando com BETWEEN e AND
SELECT * FROM produto
WHERE valorproduto BETWEEN 10.00 AND 30.00;

--selecionando com maior que (>)
SELECT * FROM produto
WHERE valorproduto > 20.00;

--selecionando com igual a (=)
SELECT * FROM produto
WHERE valorproduto = 45.40;

--selecionando com menor ou igual a (<=)
SELECT * FROM produto
WHERE valorproduto <= 50;

--selecionando combinando > AND <=
SELECT * FROM produto
WHERE valorproduto > 10.00 AND valorproduto <= 30.00;

--selecionando com WHERE e LIKE
SELECT * FROM farmacia
WHERE nomefarmacia LIKE 'Farmácia%';

SELECT * FROM farmacia
WHERE nomefarmacia LIKE '%Vida%';

SELECT * FROM farmacia
WHERE nomefarmacia LIKE '%a%';

--selecionando com ordem ascendente/crescente
SELECT * FROM farmacia
ORDER BY nomefarmacia ASC;

--selecionando com ordem descendente/decrescente
SELECT * FROM farmacia
ORDER BY nomefarmacia DESC;

--selecionando com LIMIT

SELECT * FROM produto
LIMIT 2;

--selecionando WHERE, ORDER BY e LIMIT juntos
SELECT * FROM produto
WHERE valorproduto > 20.00
ORDER BY valorproduto DESC
LIMIT 1;

--selecionando com JOIN ON
SELECT * FROM farmacia
JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia;

--selecionando com INNER JOIN ON
SELECT * FROM farmacia
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia;

--selecionando com INNER JOIN com WHERE
SELECT nomefarmacia, nomefarmaceutico
FROM farmacia
INNER JOIN farmaceutico
ON farmacia.cnpj = farmaceutico.cnpj_farmacia
WHERE farmacia.cidade = 'São Paulo';

--selecionando com INNER JOIN e ORDER BY ASC
SELECT nomefarmacia, valorproduto
FROM farmacia
INNER JOIN produto
ON farmacia.cnpj = produto.cnpj_farmacia
ORDER BY valorproduto ASC;

--criando novo usuario de banco de dados
  CREATE USER  'usuario_farmacia'@'localhost'
  IDENTIFIED BY 'senha123';
 
  --concedendo permissoes - Total
  GRANT ALL PRIVILEGES
  ON farmacianova.*
  TO 'usuario_farmacia'@'localhost';
 
  GRANT SELECT
  ON farmacianova.*
  TO 'usuario_farmacia'@'localhost'
 
--revogando permissoes de um usuario
  GRANT SELECT, INSERT
  ON farmacianova.*
  TO 'usuario_farmacia'@'localhost';
 
--revogando todas as permissoes do usuario
REVOKE ALL PRIVILEGES
ON farmacianova.*
FROM 'usuario_farmacia'@'localhost';
 
 
--excluindo usuário
DROP USER 'usuario_farmacia'@'localhost';
 
--procedure: listar produtos de uma farmácia
DELIMITER $$
 
CREATE PROCEDURE lista_produtos_farmacia (IN cnpjFarm VARCHAR (14))
BEGIN
  SELECT codproduto, quantproduto, valorproduto
  FROM produto
  WHERE cnpj_farmacia = cnpjFarm;
  END$$
  DELIMITER ;
 
--executando o procedure
  CALL lista_produtos_farmacia ('12345678000199')
 
DELIMITER $$
 
  CREATE PROCEDURE atualizar_valor_produto(
    IN p_cod INT,
    IN p_valor DECIMAL(10,2)
  )
  BEGIN
    UPDATE produto
    SET valorproduto = p_valor
    WHERE codproduto = p_cod;
END$$
 
DELIMITER ;
 
--executando o procedure acima
CALL atualizar_valor_produto(1,19.90);
 
--funcition: calcular o valor total
DELIMITER $$
 
CREATE FUNCTION valor_total_produto(p_cod INT)
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL (10,2);
 
    SELECT quantproduto * valorproduto
    INTO total
    FROM produto
    WHERE codproduto = p_cod;
 
    RETURN total;
    END$$
 
    DELIMITER ;  

--usando a função acima
    SELECT valor_total_produto(1) AS total_em_estoque;
 
--function: quantidade de produtos por farmácia
DELIMITER $$
 
CREATE FUNCTION qtd_produtos_farmacia(p_cnpj VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;
  SELECT COUNT(*)
  INTO total
  FROM produto
  WHERE cnpj_farmacia = p_cnpj;
 
  RETURN total;
END$$
 
DELIMITER ;
 
--executando a função acima
SELECT qtd_produtos_farmacia('12345678000199')
 

--função de soma
DELIMITER $$
 
DROP FUNCTION IF EXISTS qtd_produtos_farmacia $$
 
CREATE FUNCTION qtd_produtos_farmacia(p_cnpj VARCHAR(14))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
 
    SELECT SUM(quantproduto)
    INTO total
    FROM produto
    WHERE cnpj_farmacia = p_cnpj;
 
    RETURN total;
END$$
 
DELIMITER ;

--testando a funçao acima
SELECT qtd_produtos_farmacia('12345678000199') AS total_em_estoque;

--trigger: impedir quantidade negativa (BEFORE INSERT)
DELIMITER $$

CREATE TRIGGER trg_before_insert_produto
BEFORE INSERT ON produto
FOR EACH ROW
BEGIN
    IF NEW.quantproduto < 0 THEN
        SET NEW.quantproduto = 0;
        END IF;
END$$

DELIMITER ;

--tentando inserir um valor negativo
INSERT INTO produto (quantproduto, valorproduto, cnpj_farmacia)
VALUES (-10, 20.00, '12345678000199');

--testando o código acima
UPDATE produto
SET valorproduto = -25.00
WHERE codproduto = 1;

--view farmácia + produto
CREATE VIEW vw_farmacia_produto AS
SELECT
    f.nomefarmacia,
    f.cidade,
    p.codproduto,
    p.quantproduto,
    p.valorproduto
FROM farmacia f
INNER JOIN produto p
ON f.cnpj = p.cnpj_farmacia;

--testando o código acima
SELECT * FROM vw_farmacia_produto;

--view: farmácia = farmacêutico
CREATE VIEW vw_farmaceutico_farmacia AS
SELECT
    fa.nomefarmacia,
    fa.cidade,
    fm.nomefarmaceutico
FROM farmacia fa
INNER JOIN farmaceutico fm
ON fa.cnpj = fm.cnpj_farmacia;

--testando o código acima
CREATE VIEW vw_produtos_caros AS
SELECT *
FROM produto
WHERE valorproduto > 30;

