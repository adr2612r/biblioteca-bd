-- Criação do banco (MySQL/MariaDB)
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Tabela Autor
CREATE TABLE IF NOT EXISTS Autor (
  id_autor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

-- Tabela Categoria
CREATE TABLE IF NOT EXISTS Categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Tabela Livro
CREATE TABLE IF NOT EXISTS Livro (
  id_livro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  id_categoria INT,
  ano_publicacao INT,
  isbn VARCHAR(20),
  CONSTRAINT fk_livro_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
) ENGINE=InnoDB;

-- Tabela Exemplar
CREATE TABLE IF NOT EXISTS Exemplar (
  id_exemplar INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_livro INT NOT NULL,
  codigo_exemplar VARCHAR(50) NOT NULL,
  estado VARCHAR(50) DEFAULT 'Bom',
  disponivel BOOLEAN DEFAULT TRUE,
  CONSTRAINT fk_exemplar_livro FOREIGN KEY (id_livro) REFERENCES Livro(id_livro)
) ENGINE=InnoDB;

-- Tabela Usuario
CREATE TABLE IF NOT EXISTS Usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE,
  telefone VARCHAR(20)
) ENGINE=InnoDB;

-- Tabela Emprestimo
CREATE TABLE IF NOT EXISTS Emprestimo (
  id_emprestimo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_exemplar INT NOT NULL,
  id_usuario INT NOT NULL,
  data_emprestimo DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  data_devolucao DATE,
  status VARCHAR(30) DEFAULT 'EM ABERTO',
  CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (id_exemplar) REFERENCES Exemplar(id_exemplar),
  CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
) ENGINE=InnoDB;

-- Tabela associativa LivroAutor (N:N)
CREATE TABLE IF NOT EXISTS LivroAutor (
  id_livro INT NOT NULL,
  id_autor INT NOT NULL,
  PRIMARY KEY (id_livro, id_autor),
  CONSTRAINT fk_livroautor_livro FOREIGN KEY (id_livro) REFERENCES Livro(id_livro),
  CONSTRAINT fk_livroautor_autor FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
) ENGINE=InnoDB;

-- Índices úteis
CREATE INDEX idx_livro_titulo ON Livro(titulo);
CREATE INDEX idx_usuario_email ON Usuario(email);

-- -----------------------------
-- Inserts de exemplo coerentes
-- -----------------------------

-- Categorias
INSERT INTO Categoria (nome) VALUES
('Romance'),
('Ficção Científica'),
('Fantasia'),
('Drama'),
('História');

-- Autores
INSERT INTO Autor (nome) VALUES
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell'),
('J.K. Rowling'),
('José Saramago');

-- Livros
INSERT INTO Livro (titulo, id_categoria, ano_publicacao, isbn) VALUES
('Dom Casmurro', 1, 1899, '978851234501'),
('A Hora da Estrela', 4, 1977, '978851234502'),
('1984', 2, 1949, '978851234503'),
('Harry Potter e a Pedra Filosofal', 3, 1997, '978851234504'),
('Ensaio Sobre a Cegueira', 1, 1995, '978851234505');

-- LivroAutor (N:N)
INSERT INTO LivroAutor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Exemplares
INSERT INTO Exemplar (id_livro, codigo_exemplar, estado, disponivel) VALUES
(1, 'EX001', 'Bom', TRUE),
(1, 'EX002', 'Regular', TRUE),
(2, 'EX003', 'Bom', TRUE),
(3, 'EX004', 'Ótimo', TRUE),
(4, 'EX005', 'Novo', TRUE),
(5, 'EX006', 'Bom', TRUE);

-- Usuários
INSERT INTO Usuario (nome, email, telefone) VALUES
('Ana Souza', 'ana@email.com', '99999-1111'),
('Carlos Lima', 'carlos@email.com', '99999-2222'),
('Fernanda Dias', 'fernanda@email.com', '99999-3333');

-- Empréstimos: 2 em aberto e 1 devolvido
INSERT INTO Emprestimo (id_exemplar, id_usuario, data_emprestimo, data_prevista_devolucao, data_devolucao, status) VALUES
(4, 1, '2025-08-01', '2025-08-15', NULL, 'EM ABERTO'),
(1, 2, '2025-07-20', '2025-08-03', '2025-08-02', 'DEVOLVIDO'),
(3, 3, '2025-07-28', '2025-08-11', NULL, 'EM ABERTO');

-- Ajuste de disponibilidade dos exemplares conforme empréstimos
UPDATE Exemplar SET disponivel = FALSE WHERE id_exemplar IN (4, 3);
UPDATE Exemplar SET disponivel = TRUE WHERE id_exemplar = 1;
