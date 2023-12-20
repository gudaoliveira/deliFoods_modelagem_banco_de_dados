-- Quais os produtos mais vendidos
SELECT
    pr.id_produto,
    pr.nome AS nome_produto,
	pr.preco_unitario,
    pr.id_restaurante,
    r.nome AS nome_restaurante,
    SUM(dp.quantidade) AS total_pedidos,
	SUM(dp.quantidade * pr.preco_unitario) AS valor_total
FROM
    delifoods.detalhes_pedidos dp
JOIN 
    delifoods.produtos pr ON dp.id_produto = pr.id_produto
JOIN 
    delifoods.pedidos p ON dp.id_pedido = p.id_pedido
JOIN 
    delifoods.restaurante r ON pr.id_restaurante = r.id_restaurante
WHERE p.status = 'Confirmado'
GROUP BY
    pr.id_produto,
    pr.nome,
	pr.preco_unitario,
    pr.id_restaurante,
    r.nome
ORDER BY
    total_pedidos DESC

-- Quanto os restaurantes deixaram de ganhar por conta de cancelamento
SELECT
	r.nome,
	SUM(dp.quantidade * pr.preco_unitario) AS renda_total
FROM
    delifoods.detalhes_pedidos dp
JOIN 
    delifoods.produtos pr ON dp.id_produto = pr.id_produto
JOIN 
    delifoods.pedidos p ON dp.id_pedido = p.id_pedido
JOIN 
    delifoods.restaurante r ON pr.id_restaurante = r.id_restaurante
WHERE p.status = 'Cancelado'
GROUP BY
    r.nome
ORDER BY renda_total DESC

-- Restaurantes com os maiores faturamentos
SELECT
	r.nome,
	SUM(dp.quantidade * pr.preco_unitario) AS renda_total
FROM
    delifoods.detalhes_pedidos dp
JOIN 
    delifoods.produtos pr ON dp.id_produto = pr.id_produto
JOIN 
    delifoods.pedidos p ON dp.id_pedido = p.id_pedido
JOIN 
    delifoods.restaurante r ON pr.id_restaurante = r.id_restaurante
WHERE p.status = 'Confirmado'
GROUP BY
    r.nome
ORDER BY renda_total DESC

-- Ticket Médio dos restaurantes
SELECT
    r.id_restaurante,
    r.nome,
    ROUND(SUM(dp.quantidade * pr.preco_unitario)/SUM(dp.quantidade),2) AS ticket_medio
FROM delifoods.detalhes_pedidos dp
JOIN 
    delifoods.pedidos p ON dp.id_pedido = p.id_pedido
JOIN 
    delifoods.restaurante r ON p.id_restaurante = r.id_restaurante
JOIN 
    delifoods.produtos pr ON dp.id_produto = pr.id_produto
WHERE p.status = 'Confirmado'
GROUP BY
    r.id_restaurante,
    r.nome
ORDER BY ticket_medio DESC

-- 5 Clientes com a maior quantidade de pedidos da plataforma
SELECT 
	cl.nome,
	p.id_cliente,
	COUNT(p.id_cliente) AS cliente_pedidos
FROM
	delifoods.clientes cl
JOIN
    delifoods.pedidos p ON cl.id_cliente = p.id_cliente
GROUP BY cl.nome, p.id_cliente
ORDER BY id_cliente
LIMIT 5
