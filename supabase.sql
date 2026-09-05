-- ============================================================
--  Banco da Frente da Panfletagem — Rio Grande do Sul
--  Cole tudo isto no Supabase: painel > SQL Editor > New query > Run
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists public.panfletagens (
  id          uuid primary key default gen_random_uuid(),
  ponto_id    text not null,                  -- agrupa os registros de uma mesma rua/ponto
  rua         text not null default 'Rua sem nome',
  lat         double precision not null,
  lng         double precision not null,
  tipo        text not null check (tipo in ('panfletada','agendada')),
  data        date,
  created_at  timestamptz not null default now()
);

create index if not exists panfletagens_ponto_idx on public.panfletagens (ponto_id);

alter table public.panfletagens enable row level security;

-- Ferramenta colaborativa e ABERTA: qualquer visitante lê e escreve.
-- (Ver o README para uma versão com senha, se quiser restringir.)
drop policy if exists "leitura publica"     on public.panfletagens;
drop policy if exists "insercao publica"    on public.panfletagens;
drop policy if exists "atualizacao publica" on public.panfletagens;
drop policy if exists "exclusao publica"    on public.panfletagens;

create policy "leitura publica"     on public.panfletagens for select using (true);
create policy "insercao publica"    on public.panfletagens for insert with check (true);
create policy "atualizacao publica" on public.panfletagens for update using (true) with check (true);
create policy "exclusao publica"    on public.panfletagens for delete using (true);
