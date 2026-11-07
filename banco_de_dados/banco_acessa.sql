CREATE DATABASE recife_acessivel;
USE recife_acessivel;

CREATE TABLE login (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL
) CHARSET=utf8mb4;
 
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_cliente ENUM('cliente físico','cliente jurídico') NOT NULL,
    tipo_acessibilidade ENUM('cadeirante','neurodivergente','autismo','idoso','nenhum'),
    id_login INT NOT NULL UNIQUE,
    FOREIGN KEY (id_login) REFERENCES login(id_login)
) CHARSET=utf8mb4;
 
CREATE TABLE fisica (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(11) NOT NULL,
    idade INT NOT NULL,
    data_nasc DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
) CHARSET=utf8mb4;
 
CREATE TABLE juridico (
    id_cliente INT PRIMARY KEY,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(100) NOT NULL,
    telefone VARCHAR(11) NOT NULL,
    data_fund DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
) CHARSET=utf8mb4;
 
CREATE TABLE informacao (
    id_informacao INT AUTO_INCREMENT PRIMARY KEY,
    nivel_acessi ENUM('baixa','média','alta'),
    rampas ENUM('possui','não possui'),
    banheiro ENUM('acessivel','não acessivel')
) CHARSET=utf8mb4;
 

CREATE TABLE local (
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    hr_funcionamento VARCHAR(50) NOT NULL,
    id_informacao INT NOT NULL UNIQUE,
    FOREIGN KEY (id_informacao) REFERENCES informacao(id_informacao)
) CHARSET=utf8mb4;
 
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    id_local INT NOT NULL UNIQUE,
    FOREIGN KEY (id_local) REFERENCES local(id_local)
) CHARSET=utf8mb4;
 
CREATE TABLE avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    comentario TEXT,
    id_cliente INT NOT NULL,
    id_local INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_local) REFERENCES local(id_local)
) CHARSET=utf8mb4;
 
CREATE TABLE midia (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    tipo_arquivo ENUM('foto','vídeo') NOT NULL,
    nome_arquivo VARCHAR(250) NOT NULL,
    conteudo_bin LONGBLOB NOT NULL,
    id_avaliacao INT NOT NULL,
    FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao)
) CHARSET=utf8mb4;
 
CREATE TABLE motorista (
    id_motorista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    cnh VARCHAR(9) NOT NULL UNIQUE
) CHARSET=utf8mb4;
 
CREATE TABLE guia_turistico (
    id_guia INT AUTO_INCREMENT PRIMARY KEY,
    nome_guia VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    num_cadastur VARCHAR(11) NOT NULL UNIQUE,
    valid_credencial DATE NOT NULL
) CHARSET=utf8mb4;
 
CREATE TABLE onibus (
    id_onibus INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(7) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL
) CHARSET=utf8mb4;
 
CREATE TABLE terminal (
    id_terminal INT AUTO_INCREMENT PRIMARY KEY,
    nome_terminal VARCHAR(100) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL
) CHARSET=utf8mb4;
 
CREATE TABLE viagem (
    id_viagem INT AUTO_INCREMENT PRIMARY KEY,
    date_time DATETIME NOT NULL,
    id_local INT NOT NULL,
    id_motorista INT NOT NULL,
    id_onibus INT NOT NULL,
    id_guia INT NOT NULL,
    id_terminal INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES local(id_local),
    FOREIGN KEY (id_motorista) REFERENCES motorista(id_motorista),
    FOREIGN KEY (id_onibus) REFERENCES onibus(id_onibus),
    FOREIGN KEY (id_guia) REFERENCES guia_turistico(id_guia),
    FOREIGN KEY (id_terminal) REFERENCES terminal(id_terminal)
) CHARSET=utf8mb4;
 
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    assento INT NOT NULL,
    data_hora DATETIME NOT NULL,
    pagamento ENUM('confirmado','análise'),
    id_cliente INT NOT NULL,
    id_viagem INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem)
) CHARSET=utf8mb4;
 
INSERT INTO login (email, senha) VALUES
('ana.silva@email.com',       'hash_senha_001'),
('bruno.costa@email.com',     'hash_senha_002'),
('carla.souza@email.com',     'hash_senha_003'),
('diego.lima@email.com',      'hash_senha_004'),
('elisa.melo@email.com',      'hash_senha_005'),
('fabio.araujo@email.com',    'hash_senha_006'),
('contato@turismoverde.com',  'hash_senha_007'),
('contato@viajaplus.com',     'hash_senha_008'),
('contato@recifetur.com',     'hash_senha_009'),
('contato@acessotur.com',     'hash_senha_010');
 
INSERT INTO cliente (nome, tipo_cliente, tipo_acessibilidade, id_login) VALUES
('Ana Silva',      'cliente físico',   'cadeirante',      1),
('Bruno Costa',    'cliente físico',   'autismo',         2),
('Carla Souza',    'cliente físico',   'idoso',           3),
('Diego Lima',     'cliente físico',   'neurodivergente', 4),
('Elisa Melo',     'cliente físico',   'nenhum',          5),
('Fabio Araujo',   'cliente físico',   'cadeirante',      6),
('Turismo Verde',  'cliente jurídico', 'nenhum',          7),
('Viaja Plus',     'cliente jurídico', 'nenhum',          8),
('Recife Tur',     'cliente jurídico', 'nenhum',          9),
('Acesso Tur',     'cliente jurídico', 'nenhum',          10);
 
INSERT INTO fisica (id_cliente, cpf, telefone, idade, data_nasc) VALUES
(1, '111.111.111-11', '81987650001', 34, '1992-03-14'),
(2, '222.222.222-22', '81987650002', 22, '2004-07-21'),
(3, '333.333.333-33', '81987650003', 68, '1958-11-02'),
(4, '444.444.444-44', '81987650004', 29, '1997-01-30'),
(5, '555.555.555-55', '81987650005', 41, '1985-09-08'),
(6, '666.666.666-66', '81987650006', 52, '1974-05-19');
 
INSERT INTO juridico (id_cliente, cnpj, razao_social, telefone, data_fund) VALUES
(7,  '11111111000111', 'Turismo Verde LTDA',          '8132250001', '2010-02-15'),
(8,  '22222222000122', 'Viaja Plus Agência ME',       '8132250002', '2015-06-30'),
(9,  '33333333000133', 'Recife Tur Eventos LTDA',     '8132250003', '2008-10-10'),
(10, '44444444000144', 'Acesso Tur Inclusivo EIRELI', '8132250004', '2019-04-22');
 
INSERT INTO informacao (nivel_acessi, rampas, banheiro) VALUES
('alta',  'possui',     'acessivel'),
('média', 'possui',     'acessivel'),
('baixa', 'não possui', 'não acessivel'),
('alta',  'possui',     'acessivel'),
('média', 'possui',     'não acessivel'),
('baixa', 'não possui', 'acessivel'),
('alta',  'possui',     'acessivel'),
('média', 'não possui', 'acessivel');
 
INSERT INTO local (nome, descricao, hr_funcionamento, id_informacao) VALUES
('Sinagoga Kahal Zur Israel', 'Ponto turístico histórico no Recife Antigo.', '08:00 - 18:00', 1),
('Cais do Apolo',             'Ponto turístico às margens do rio.',          '09:00 - 17:00', 2),
('Ponto turístico 3',         'Descrição a preencher.',                      '07:00 - 16:00', 3),
('Praia de Boa Viagem',       'Orla e calçadão de Boa Viagem.',              '08:30 - 19:00', 4),
('Ponto turístico 5',         'Descrição a preencher.',                      '10:00 - 22:00', 5),
('Marco Zero',                'Praça central do Recife Antigo.',             '06:00 - 18:00', 6),
('Ponto turístico 7',         'Descrição a preencher.',                      '09:00 - 20:00', 7),
('Ponto turístico 8',         'Descrição a preencher.',                      '08:00 - 17:30', 8);
 
INSERT INTO endereco (logradouro, numero, bairro, cidade, estado, cep, latitude, longitude, id_local) VALUES
('Rua do Bom Jesus',    183,  'Recife Antigo', 'Recife', 'Pernambuco', '50030170', -8.0631, -34.8711, 1),
('Av. Cais do Apolo',   925,  'Recife Antigo', 'Recife', 'Pernambuco', '50030230', -8.0624, -34.8720, 2),
('Rua da Aurora',       457,  'Boa Vista',     'Recife', 'Pernambuco', '50050000', -8.0560, -34.8800, 3),
('Av. Boa Viagem',      3000, 'Boa Viagem',    'Recife', 'Pernambuco', '51020001', -8.1190, -34.8990, 4),
('Rua do Sol',          120,  'Santo Antônio', 'Recife', 'Pernambuco', '50010120', -8.0650, -34.8765, 5),
('Praça do Marco Zero', 1,    'Recife Antigo', 'Recife', 'Pernambuco', '50030000', -8.0629, -34.8712, 6),
('Av. Rui Barbosa',     1596, 'Graças',        'Recife', 'Pernambuco', '52011040', -8.0520, -34.8915, 7),
('Rua Benfica',         700,  'Madalena',      'Recife', 'Pernambuco', '50720001', -8.0480, -34.9030, 8);
 
INSERT INTO avaliacao (comentario, id_cliente, id_local) VALUES
('Local com rampas ótimas e banheiro adaptado.',          1, 1),
('Ambiente calmo, bom para pessoas com autismo.',         2, 2),
('Faltou rampa na entrada, difícil para idosos.',         3, 3),
('Equipe muito atenciosa e preparada.',                   4, 4),
('Banheiro não é acessível, precisa melhorar.',           5, 5),
('Praça ampla e fácil de circular com cadeira de rodas.', 6, 6),
('Excelente estrutura para grupos.',                      7, 7),
('Boa acessibilidade, mas poderia ter mais sinalização.', 8, 8);
 
INSERT INTO midia (tipo_arquivo, nome_arquivo, conteudo_bin, id_avaliacao) VALUES
('foto',  'rampa_bomjesus.jpg',    UNHEX('FFD8FFE000104A464946'),     1),
('foto',  'sala_calma.jpg',        UNHEX('FFD8FFE000104A464947'),     2),
('foto',  'entrada_sem_rampa.jpg', UNHEX('FFD8FFE000104A464948'),     3),
('vídeo', 'tour_boaviagem.mp4',    UNHEX('000000186674797069736F6D'), 4),
('foto',  'banheiro_comum.jpg',    UNHEX('FFD8FFE000104A464949'),     5),
('vídeo', 'marco_zero.mp4',        UNHEX('000000186674797069736F6E'), 6);
 
INSERT INTO motorista (nome, cpf, cnh) VALUES
('Carlos Pereira', '777.777.777-77', '123456789'),
('Roberto Alves',  '888.888.888-88', '234567890'),
('Fernando Dias',  '999.999.999-99', '345678901'),
('Antonio Gomes',  '101.010.101-01', '456789012'),
('Sergio Nunes',   '202.020.202-02', '567890123');
 
INSERT INTO guia_turistico (nome_guia, cpf, num_cadastur, valid_credencial) VALUES
('Marcos Oliveira', '303.030.303-03', '12345678901', '2027-12-31'),
('Juliana Ramos',   '404.040.404-04', '23456789012', '2027-06-30'),
('Paulo Henrique',  '505.050.505-05', '34567890123', '2026-12-31'),
('Renata Barbosa',  '606.060.606-06', '45678901234', '2028-03-15'),
('Thiago Mendes',   '707.070.707-07', '56789012345', '2027-09-01');
 
INSERT INTO onibus (placa, modelo) VALUES
('ABC1D23', 'Marcopolo Paradiso G8'),
('DEF4G56', 'Mercedes-Benz O500 Acessível'),
('HIJ7K89', 'Volvo B270F Piso Baixo'),
('LMN0P12', 'Scania K310 Adaptado'),
('QRS3T45', 'Iveco Urbanuss Plataforma');
 
INSERT INTO terminal (nome_terminal, rua, numero, bairro) VALUES
('Terminal Integrado do Cabo',    'Av. Presidente Kennedy', '100', 'Cabo'),
('Terminal Joana Bezerra',        'Av. Sul',                '250', 'Joana Bezerra'),
('Terminal Integrado Boa Viagem', 'Av. Boa Viagem',         '500', 'Boa Viagem'),
('Terminal Recife Antigo',        'Rua do Bom Jesus',       '10',  'Recife Antigo'),
('Terminal Barro',                'Av. General San Martin', '800', 'Barro');
 
INSERT INTO viagem (date_time, id_local, id_motorista, id_onibus, id_guia, id_terminal) VALUES
('2026-11-10 09:00:00', 1, 1, 1, 1, 1),
('2026-11-12 14:00:00', 2, 2, 2, 2, 2),
('2026-11-15 08:30:00', 3, 3, 3, 3, 3),
('2026-11-18 10:00:00', 4, 4, 4, 4, 4),
('2026-11-20 15:00:00', 5, 5, 5, 5, 5),
('2026-11-22 08:00:00', 6, 2, 2, 2, 2),
('2026-11-25 09:30:00', 7, 3, 3, 3, 3);
 
INSERT INTO reserva (assento, data_hora, pagamento, id_cliente, id_viagem) VALUES
(2,  '2026-11-01 09:00:00', 'confirmado', 1, 1),
(1,  '2026-11-01 10:30:00', 'confirmado', 2, 1),
(3,  '2026-11-03 14:00:00', 'análise',    3, 2),
(1,  '2026-11-05 08:30:00', 'confirmado', 4, 3),
(2,  '2026-11-08 10:00:00', 'análise',    5, 4),
(1,  '2026-11-10 15:00:00', 'confirmado', 6, 5),
(20, '2026-11-12 08:00:00', 'confirmado', 7, 6),
(15, '2026-11-15 09:30:00', 'confirmado', 8, 7);
 
--colocando em prática antes que o sr veja, mas pode olhar os commits kkk

SELECT c.nome, r.pagamento 
FROM cliente c
INNER JOIN reserva r
  ON c.id_cliente = r.id_cliente;

  SELECT * FROM cliente c  

  INNER JOIN avaliacao a
    ON c.id_cliente = a.id_cliente

  INNER JOIN midia m 
    ON a.id_avaliacao = m.id_avaliacao;
 
