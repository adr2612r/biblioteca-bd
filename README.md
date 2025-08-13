# 📚 Sistema de Gerenciamento de Biblioteca

## 📌 Tema do Projeto
Banco de dados relacional para um **Sistema de Empréstimos de Biblioteca**.

## 📝 Descrição do Problema Modelado
Uma biblioteca precisa organizar acervo, usuários e controlar empréstimos. O modelo inclui:
- Catálogo de livros e categorias;
- Autores e a relação N:N entre livros e autores;
- Exemplares físicos (cópias) e sua disponibilidade;
- Usuários e empréstimos com datas e status.

## 🏗️ Entidades e Relacionamentos
- **Categoria (1:N) Livro**
- **Livro (N:N) Autor** via `LivroAutor`
- **Livro (1:N) Exemplar`
- **Exemplar (1:N) Emprestimo**
- **Usuario (1:N) Emprestimo**

## 🗂 Estrutura do Repositório
```
biblioteca-bd/
├─ DER.dbml
├─ modelagem.sql
├─ consultas.sql
└─ README.md
```

## 🧩 DER (dbdiagram)
O arquivo `DER.dbml` contém o diagrama em DBML. Para visualizar:
1. Acesse https://dbdiagram.io
2. Clique em **+ New Diagram**
3. Cole o conteúdo de `DER.dbml`
4. Exporte **PNG/PDF** para incluir no repositório (opcional).

## ▶️ Como aplicar no MySQL (Workbench/phpMyAdmin)
1. **Crie o schema e as tabelas + dados**:
   - Abra o MySQL Workbench (ou phpMyAdmin).
   - Abra o arquivo `modelagem.sql` e **execute** tudo.
   - Isso criará o banco `biblioteca`, as tabelas e populará com dados de exemplo.
2. **Teste consultas**:
   - Abra `consultas.sql` e execute as 6 consultas de exemplo.
3. **Verifique a consistência**:
   - `SELECT * FROM Emprestimo;`
   - `SELECT * FROM Exemplar;` (os exemplares dos empréstimos em aberto devem estar `disponivel = 0`).

> Usando outro SGBD? Ajustes rápidos:
> - PostgreSQL: troque `AUTO_INCREMENT` por `GENERATED ALWAYS AS IDENTITY` e `GROUP_CONCAT` por `STRING_AGG(a.nome, ', ')`.
> - SQLite: use `INTEGER PRIMARY KEY` e substitua `GROUP_CONCAT` removendo `SEPARATOR`.

## 🧪 Dados de exemplo incluídos
- 5 categorias, 5 livros, 5 autores e seus vínculos, 6 exemplares, 3 usuários e 3 empréstimos (2 em aberto, 1 devolvido).

## 📎 Referências internas
- DER (DBML): `DER.dbml`
- Criação + Inserts: `modelagem.sql`
- Consultas: `consultas.sql`
