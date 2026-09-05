# Frente da Panfletagem — Rio Grande do Sul

Webmap colaborativo para marcar ruas panfletadas e agendadas. Site estático (roda em qualquer hospedagem) + banco Supabase para os dados serem compartilhados por todos.

Arquivos:
- `index.html` — o aplicativo
- `config.js` — onde você cola a URL e a chave do Supabase
- `supabase.sql` — cria a tabela e as permissões no banco
- `vercel.json` — configuração mínima da Vercel

---

## Passo 1 — Banco de dados (Supabase, grátis)

1. Crie uma conta em https://supabase.com e clique em **New project**. Escolha uma senha para o banco e a região **South America (São Paulo)**. Espere ~2 min provisionar.
2. No menu lateral, abra **SQL Editor > New query**, cole todo o conteúdo de `supabase.sql` e clique em **Run**. Isso cria a tabela `panfletagens` e libera leitura/escrita pública.
3. Pegue as credenciais: clique em **Connect** (topo do painel) ou vá em **Settings > API Keys**. Copie:
   - a **Project URL** (algo como `https://abcdefgh.supabase.co`)
   - a **Publishable key** (começa com `sb_publishable_...`). Essa chave é feita para ficar pública em páginas web, então pode ir para o GitHub sem problema.
4. Abra `config.js` e cole os dois valores:
   ```js
   window.PANFLETO_CONFIG = {
     url: "https://abcdefgh.supabase.co",
     key: "sb_publishable_xxxxxxxxxxxxxxxx"
   };
   ```

> Enquanto `config.js` estiver vazio, o mapa abre em "modo local" e não salva nada — útil só para testar o visual.

## Passo 2 — GitHub

Pelo site (sem terminal):
1. Em https://github.com clique em **New repository**, dê um nome (ex.: `panfletagem-rs`), deixe **Public**, e crie.
2. Na página do repositório vazio, clique em **uploading an existing file** e arraste os arquivos desta pasta (`index.html`, `config.js`, `supabase.sql`, `vercel.json`, `README.md`). **Commit**.

Ou por terminal:
```bash
cd panfletagem-rs
git init && git add . && git commit -m "Frente da panfletagem"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/panfletagem-rs.git
git push -u origin main
```

## Passo 3 — Publicar na Vercel

1. Entre em https://vercel.com com sua conta do GitHub.
2. **Add New… > Project** e importe o repositório `panfletagem-rs`.
3. Em **Framework Preset** escolha **Other** (é site estático — não precisa de build). Deixe os campos de build vazios.
4. Clique em **Deploy**. Em ~1 min você recebe um endereço público tipo `https://panfletagem-rs.vercel.app`.

Pronto — esse link funciona no celular e no navegador, e todo mundo que abrir vê as mesmas ruas.

Sempre que você editar algo no GitHub, a Vercel republica sozinha.

---

## Como usar o app

- **Toque no mapa** na rua onde panfletou (ou toque no **+** e depois no ponto). Escolha *Já panfletei* ou *Vou panfletar* e a data.
- **Repetição:** toque no marcador da rua e use *Registrar panfletagem aqui*. Cada nova vez engorda o marcador e mostra o número de vezes — assim as ruas mais panfletadas já se destacam sozinhas no mapa.
- **Quem panfletou:** ao registrar, dá para preencher opcionalmente o nome de quem fez a panfletagem.
- **Filtros:** todas / só feitas / só agendadas. Agendadas com data vencida aparecem como *atrasada*.
- **Editar/apagar:** no marcador dá para editar cada registro (toque na data), renomear ou excluir a rua.
- Botão de **localização** pula direto para onde você está (bom no celular).

---

## Aviso importante sobre acesso aberto

Do jeito configurado, **qualquer pessoa com o link pode adicionar, editar e apagar** — inclusive apagar tudo. É o que "visível e editável por todos" exige. Se em algum momento quiser proteger:

- **Só leitura pública, escrita restrita:** troque as políticas de `insert/update/delete` para exigir usuário logado (`auth.role() = 'authenticated'`) e ative o login por e‑mail no Supabase.
- **Senha simples compartilhada:** dá para pôr uma checagem de senha no app antes de liberar a edição. Se quiser, peço para montar essa versão.

Nada aqui guarda dado pessoal — só ruas, datas e marcações.
