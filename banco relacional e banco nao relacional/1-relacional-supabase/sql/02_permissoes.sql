-- ============================================================
-- 02 · PERMISSÕES  (GRANT + RLS)
--
-- Duas camadas controlam o acesso pela API do navegador:
--   1) GRANT  -> o papel (anon) pode tocar na tabela?
--   2) RLS    -> quais LINHAS ele pode ver/alterar? (policies)
--
-- ⚠ SOMENTE PARA DEMONSTRAÇÃO: libera tudo para qualquer visitante
--   (papel "anon"). Em produção, use Supabase Auth e policies
--   do tipo  using (auth.uid() = user_id).
-- ============================================================

-- 1) GRANT (projetos novos não expõem tabelas automaticamente)
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete
  on public.clientes, public.produtos, public.pedidos, public.itens_pedido
  to anon, authenticated;
grant usage, select on all sequences in schema public to anon, authenticated;

-- 2) RLS ligado + uma policy "liberada geral" por tabela
alter table public.clientes     enable row level security;
alter table public.produtos     enable row level security;
alter table public.pedidos      enable row level security;
alter table public.itens_pedido enable row level security;

drop policy if exists "demo: acesso total" on public.clientes;
drop policy if exists "demo: acesso total" on public.produtos;
drop policy if exists "demo: acesso total" on public.pedidos;
drop policy if exists "demo: acesso total" on public.itens_pedido;

create policy "demo: acesso total" on public.clientes
  for all to anon, authenticated using (true) with check (true);
create policy "demo: acesso total" on public.produtos
  for all to anon, authenticated using (true) with check (true);
create policy "demo: acesso total" on public.pedidos
  for all to anon, authenticated using (true) with check (true);
create policy "demo: acesso total" on public.itens_pedido
  for all to anon, authenticated using (true) with check (true);

notify pgrst, 'reload schema';