SELECT pf.*, p.*
FROM PessoaFisica pf
JOIN Pessoa p ON pf.idPessoa = p.idPessoa;

SELECT pj.*, p.*
FROM PessoaJuridica pj
JOIN Pessoa p ON pj.idPessoa = p.idPessoa;

SELECT 
  m.idMovimentacao,
  pr.nome AS nomeProduto,
  p.nome AS nomeFornecedor,
  m.quantidade,
  m.valorUnitario,
  m.quantidade * m.valorUnitario AS valorTotal
FROM Movimentacao m
JOIN Produto pr ON m.idProduto = pr.idProduto
JOIN Pessoa p ON m.idPessoa = p.idPessoa
WHERE m.tipo = 'E';

SELECT 
  m.idMovimentacao,
  pr.nome AS nomeProduto,
  p.nome AS nomeComprador,
  m.quantidade,
  m.valorUnitario,
  m.quantidade * m.valorUnitario AS valorTotal
FROM Movimentacao m
JOIN Produto pr ON m.idProduto = pr.idProduto
JOIN Pessoa p ON m.idPessoa = p.idPessoa
WHERE m.tipo = 'S';

SELECT 
  m.idProduto,
  pr.nome AS nomeProduto,
  SUM(m.quantidade * m.valorUnitario) AS valorTotalEntrada
FROM Movimentacao m
JOIN Produto pr ON m.idProduto = pr.idProduto
WHERE m.tipo = 'E'
GROUP BY m.idProduto, pr.nome;

SELECT 
  m.idProduto,
  pr.nome AS nomeProduto,
  SUM(m.quantidade * m.valorUnitario) AS valorTotalSaida
FROM Movimentacao m
JOIN Produto pr ON m.idProduto = pr.idProduto
WHERE m.tipo = 'S'
GROUP BY m.idProduto, pr.nome;

SELECT u.*
FROM Usuario u
WHERE u.idUsuario NOT IN (
  SELECT DISTINCT idUsuario
  FROM Movimentacao
  WHERE tipo = 'E'
);

SELECT 
  u.idUsuario,
  SUM(m.quantidade * m.valorUnitario) AS totalEntrada
FROM Movimentacao m
JOIN Usuario u ON m.idUsuario = u.idUsuario
WHERE m.tipo = 'E'
GROUP BY u.idUsuario;

SELECT 
  u.idUsuario,
  SUM(m.quantidade * m.valorUnitario) AS totalSaida
FROM Movimentacao m
JOIN Usuario u ON m.idUsuario = u.idUsuario
WHERE m.tipo = 'S'
GROUP BY u.idUsuario;

SELECT 
  m.idProduto,
  pr.nome AS nomeProduto,
  CAST(SUM(m.quantidade * m.valorUnitario) AS FLOAT) / NULLIF(SUM(m.quantidade), 0) AS mediaPonderada
FROM Movimentacao m
JOIN Produto pr ON m.idProduto = pr.idProduto
WHERE m.tipo = 'S'
GROUP BY m.idProduto, pr.nome;