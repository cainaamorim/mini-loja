-- ============================================================
-- 00 · LIMPAR TUDO  (use para repetir a demonstração do zero)
-- Apaga as 4 tabelas do projeto de demonstração.
-- ============================================================
drop table if exists public.itens_pedido cascade;
drop table if exists public.pedidos      cascade;
drop table if exists public.produtos     cascade;
drop table if exists public.clientes     cascade;

notify pgrst, 'reload schema';
