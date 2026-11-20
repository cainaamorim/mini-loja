-- ============================================================
-- 03 · DADOS DE EXEMPLO  (opcional)
-- Rode DEPOIS do 01 (tabelas). Pode rodar uma vez só.
-- ============================================================

insert into public.clientes (nome, email) values
  ('Ana Souza',    'ana@exemplo.com'),
  ('Bruno Lima',   'bruno@exemplo.com'),
  ('Carla Mendes', 'carla@exemplo.com');

insert into public.produtos (nome, preco, estoque) values
  ('Teclado mecânico', 289.90, 15),
  ('Mouse sem fio',     99.90, 40),
  ('Monitor 24"',      799.00,  8),
  ('Headset USB',      189.50, 22),
  ('Webcam Full HD',   249.00, 12);

-- Pedido 1: Ana comprou teclado + mouse
with p as (
  insert into public.pedidos (cliente_id, status)
  select id, 'pago' from public.clientes where email = 'ana@exemplo.com'
  returning id
)
insert into public.itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
select p.id, pr.id, v.qtd, pr.preco
from p
join (values ('Teclado mecânico', 1), ('Mouse sem fio', 2)) as v(nome, qtd) on true
join public.produtos pr on pr.nome = v.nome;

-- Pedido 2: Bruno comprou monitor
with p as (
  insert into public.pedidos (cliente_id, status)
  select id, 'novo' from public.clientes where email = 'bruno@exemplo.com'
  returning id
)
insert into public.itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
select p.id, pr.id, 1, pr.preco
from p
join public.produtos pr on pr.nome = 'Monitor 24"';
