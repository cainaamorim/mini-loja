# Supabase (relacional) — cola rápida

1. **Projeto:** supabase.com/dashboard → *New project* (nome, senha do banco, região São Paulo).
2. **Chaves:** botão **Connect** (topo) ou **Settings → API Keys** → copie *Project URL* e *Publishable key* (`sb_publishable_...`; a `anon` antiga também funciona, mas vai ser descontinuada).
3. Abra `index.html` → aba **Conexão** → cole → **Conectar**.
4. **SQL Editor → New query**, rode **na ordem** (ou use os botões *Copiar* do front):
   - `sql/01_tabelas.sql` — cria as 4 tabelas
   - `sql/02_permissoes.sql` — GRANT + RLS (demo aberta)
   - `sql/03_dados_exemplo.sql` — opcional
5. No front: **Rodar diagnóstico** / **Testar escrita** até tudo ficar ✔.

Extras: `sql/99_consultas_para_mostrar.sql` (JOIN e agregações) · `sql/00_limpar_tudo.sql` (recomeçar).

**Se algo falhar**
| Mensagem no front | Causa | Solução |
|---|---|---|
| Chave inválida | chave de outro projeto / digitada errada | copiar de novo em Connect |
| Tabela não encontrada | falta o 01 | rodar `01_tabelas.sql` |
| Permissão negada | falta o 02 | rodar `02_permissoes.sql` |
| Relacionamento não encontrado | cache da API | rodar `notify pgrst, 'reload schema';` |