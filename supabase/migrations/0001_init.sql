create table if not exists contacts (
  id bigint primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  fname text not null,
  lname text not null,
  company text,
  phone text,
  email text,
  status text not null default 'active',
  ctype text,
  lead_stage text,
  lead_type text,
  source text,
  follow_up text,
  notes jsonb not null default '[]',
  date text
);

create table if not exists deals (
  id bigint primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  company text,
  value numeric not null default 0,
  prob int not null default 50,
  stage text not null default 'ליד',
  status text not null default 'open',
  close text,
  closed_date text,
  notes jsonb not null default '[]',
  created text
);

create table if not exists tasks (
  id bigint primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  priority text not null default 'medium',
  due text,
  related text,
  done boolean not null default false
);

alter table contacts enable row level security;
alter table deals enable row level security;
alter table tasks enable row level security;

create policy "user owns row" on contacts for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "user owns row" on deals for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "user owns row" on tasks for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists contacts_user_id_idx on contacts(user_id);
create index if not exists deals_user_id_idx on deals(user_id);
create index if not exists tasks_user_id_idx on tasks(user_id);
