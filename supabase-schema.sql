-- Book Bloom : table cloud privée, une ligne JSON par compte.
create table if not exists public.book_bloom_library (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"books":[],"goal":30,"dark":false}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.book_bloom_library enable row level security;
drop policy if exists "Users can read their own library" on public.book_bloom_library;
create policy "Users can read their own library"
  on public.book_bloom_library for select to authenticated
  using (auth.uid() = user_id);
drop policy if exists "Users can insert their own library" on public.book_bloom_library;
create policy "Users can insert their own library"
  on public.book_bloom_library for insert to authenticated
  with check (auth.uid() = user_id);
drop policy if exists "Users can update their own library" on public.book_bloom_library;
create policy "Users can update their own library"
  on public.book_bloom_library for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
-- Active les événements UPDATE dans Database > Replication si nécessaire
-- pour la synchronisation temps réel.
