-- ============================================================
-- 01 · TABELAS  (modelo relacional: Mini-Loja)
--
--   clientes 1 ──< pedidos 1 ──< itens_pedido >── 1 produtos
--
-- Cole no  SQL Editor  do Supabase e clique em RUN.
-- ============================================================

create table if not exists public.clientes (
  id        bigint generated always as identity primary key,
  nome      text        not null,
  email     text        not null unique,          -- UNIQUE: não repete e-mail
  criado_em timestamptz not null default now()
);

create table if not exists public.produtos (
  id      bigint generated always as identity primary key,
  nome    text           not null,
  preco   numeric(10,2)  not null check (preco >= 0),   -- CHECK: sem preço negativo
  estoque integer        not null default 0 check (estoque >= 0)
);

create table if not exists public.pedidos (
  id         bigint generated always as identity primary key,
  cliente_id bigint not null
             references public.clientes(id) on delete restrict,  -- FK: não apaga cliente com pedido
  status     text   not null default 'novo'
             check (status in ('novo','pago','enviado','cancelado')),
  criado_em  timestamptz not null default now()
);

create table if not exists public.itens_pedido (
  id             bigint generated always as identity primary key,
  pedido_id      bigint        not null
                 references public.pedidos(id)  on delete cascade,   -- apagou o pedido, apaga os itens
  produto_id     bigint        not null
                 references public.produtos(id) on delete restrict,  -- não apaga produto já vendido
  quantidade     integer       not null check (quantidade > 0),
  preco_unitario numeric(10,2) not null check (preco_unitario >= 0)
);

-- Índices nas chaves estrangeiras (boa prática para JOINs rápidos)
create index if not exists idx_pedidos_cliente on public.pedidos(cliente_id);
create index if not exists idx_itens_pedido    on public.itens_pedido(pedido_id);
create index if not exists idx_itens_produto   on public.itens_pedido(produto_id);

-- Avisa a API do Supabase (PostgREST) que o schema mudou
notify pgrst, 'reload schema';
