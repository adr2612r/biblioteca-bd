-- 1) Livros com categoria e autores
SELECT 
    l.titulo,
    c.nome AS categoria,
    GROUP_CONCAT(a.nome SEPARATOR ', ') AS autores
FROM Livro l
LEFT JOIN Categoria c ON l.id_categoria = c.id_categoria
LEFT JOIN LivroAutor la ON l.id_livro = la.id_livro
LEFT JOIN Autor a ON la.id_autor = a.id_autor
GROUP BY l.id_livro, c.nome;

-- 2) Exemplares disponíveis
SELECT 
    e.id_exemplar,
    l.titulo,
    e.codigo_exemplar,
    e.estado
FROM Exemplar e
JOIN Livro l ON e.id_livro = l.id_livro
WHERE e.disponivel = TRUE;

-- 3) Empréstimos em aberto com usuário e livro
SELECT 
    u.nome AS usuario,
    l.titulo,
    e.data_emprestimo,
    e.data_prevista_devolucao
FROM Emprestimo e
JOIN Usuario u ON e.id_usuario = u.id_usuario
JOIN Exemplar ex ON e.id_exemplar = ex.id_exemplar
JOIN Livro l ON ex.id_livro = l.id_livro
WHERE e.status = 'EM ABERTO';

-- 4) Quantidade de livros por categoria
SELECT 
    c.nome AS categoria,
    COUNT(l.id_livro) AS total_livros
FROM Categoria c
LEFT JOIN Livro l ON c.id_categoria = l.id_categoria
GROUP BY c.nome;

-- 5) Usuários com mais de 1 empréstimo
SELECT 
    u.nome,
    COUNT(e.id_emprestimo) AS total_emprestimos
FROM Usuario u
JOIN Emprestimo e ON u.id_usuario = e.id_usuario
GROUP BY u.id_usuario
HAVING COUNT(e.id_emprestimo) > 1;

-- 6) Empréstimos ordenados pelos mais urgentes a devolver
SELECT 
    l.titulo,
    u.nome AS usuario,
    e.data_prevista_devolucao
FROM Emprestimo e
JOIN Exemplar ex ON e.id_exemplar = ex.id_exemplar
JOIN Livro l ON ex.id_livro = l.id_livro
JOIN Usuario u ON e.id_usuario = u.id_usuario
WHERE e.status = 'EM ABERTO'
ORDER BY e.data_prevista_devolucao ASC;
