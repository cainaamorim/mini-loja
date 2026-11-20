-- ============================================================
-- 99 · CONSULTAS PARA MOSTRAR NO BRIEFING (SQL Editor)
-- Mostram o "superpoder" do modelo relacional: JOIN + agregação.
-- ============================================================

-- Total de cada pedido, com o nome do cliente (3 tabelas juntas)
select p.id            as pedido,
       c.nome          as cliente,
       p.status,
       sum(i.quantidade * i.preco_unitario) as total
from public.pedidos p
join public.clientes     c on c.id = p.cliente_id
join public.itens_pedido i on i.pedido_id = p.id
group by p.id, c.nome, p.status
order by p.id;

-- Produtos mais vendidos
select pr.nome, sum(i.quantidade) as unidades
from public.itens_pedido i
join public.produtos pr on pr.id = i.produto_id
group by pr.nome
order by unidades desc;

-- Teste de integridade (deve FALHAR por causa da chave estrangeira):
-- delete from public.clientes where email = 'ana@exemplo.com';
