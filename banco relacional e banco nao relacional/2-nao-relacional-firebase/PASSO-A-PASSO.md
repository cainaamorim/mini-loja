# Firebase / Firestore (não relacional) — cola rápida

1. **Projeto:** console.firebase.google.com → *Create a project*.
2. **App Web:** na visão geral, ícone **`</>`** → *Register app* → copie o bloco `firebaseConfig`.
3. Abra `index.html` → aba **Conexão** → cole → **Conectar**.
4. **Banco:** *Firestore Database* → **Create database** → edição **Standard** → região → modo teste *ou* produção.
5. **Regras:** aba **Rules** → cole o conteúdo de `firestore.rules` (botão *Copiar* no front) → **Publish**.
6. No front: **Testar escrita** → **Inserir dados de exemplo**.

**Se algo falhar**
| Mensagem no front | Causa | Solução |
|---|---|---|
| Não consegui falar com o Firestore | banco não criado, projectId errado ou sem internet | passo 4; conferir o `projectId` |
| As regras do Firestore estão bloqueando | banco em modo produção sem as regras | passo 5 |
| Dados recusados (invalid-argument / permission-denied ao gravar) | os dados violam as regras (ex.: preço negativo) | é o comportamento esperado da demo |
