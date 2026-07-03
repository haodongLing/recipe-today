create table if not exists public.recipes (
  id uuid primary key,
  name text not null,
  category text not null check (category in ('vegetable', 'meat', 'soup')),
  ingredients text not null,
  steps text not null,
  image_steps jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.recipes
add column if not exists image_steps jsonb not null default '[]'::jsonb;

alter table public.recipes enable row level security;

drop policy if exists "Anyone can read recipes" on public.recipes;
create policy "Anyone can read recipes"
on public.recipes
for select
to anon
using (true);

drop policy if exists "Anyone can add recipes" on public.recipes;
create policy "Anyone can add recipes"
on public.recipes
for insert
to anon
with check (true);

drop policy if exists "Anyone can update recipes" on public.recipes;
create policy "Anyone can update recipes"
on public.recipes
for update
to anon
using (true)
with check (true);

drop policy if exists "Anyone can delete recipes" on public.recipes;
create policy "Anyone can delete recipes"
on public.recipes
for delete
to anon
using (true);
