-- Leaders in Benefits Quarterly Governance Platform
-- Tables for date voting, topic suggestions, and network nominations

create table if not exists q1_votes (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),

  -- For date voting
  name text,
  name_key text unique,
  selected_dates text[],

  -- For topic voting
  topic text,

  -- For nominations (anonymous)
  nominee text,

  -- Category to organize vote type
  category text not null check (category in ('dates', 'topics', 'nominations')),

  constraint name_key_unique_per_category unique(name_key, category) deferrable initially deferred
);

-- Enable RLS
alter table q1_votes enable row level security;

-- Public can read all votes
create policy "anon_read_votes" on q1_votes
  for select using (true);

-- Public can insert votes (only dates require unique name_key to replace previous response)
create policy "anon_insert_votes" on q1_votes
  for insert with check (true);

-- Public can update their own date votes (by name_key)
create policy "anon_update_own_dates" on q1_votes
  for update using (category = 'dates' and name_key is not null)
  with check (category = 'dates' and name_key is not null);

-- Indexes for performance
create index idx_q1_votes_category on q1_votes(category);
create index idx_q1_votes_name_key on q1_votes(name_key) where category = 'dates';
create index idx_q1_votes_created_at on q1_votes(created_at desc);

-- Create equivalent tables for other quarters (copy the table structure for Q2, Q3, Q4)
-- Q2 (January)
create table if not exists q2_votes (like q1_votes including all);
alter table q2_votes enable row level security;
create policy "anon_read_q2" on q2_votes for select using (true);
create policy "anon_insert_q2" on q2_votes for insert with check (true);
create policy "anon_update_q2" on q2_votes for update using (category = 'dates' and name_key is not null) with check (category = 'dates' and name_key is not null);
create index idx_q2_votes_category on q2_votes(category);
create index idx_q2_votes_name_key on q2_votes(name_key) where category = 'dates';

-- Q3 (May)
create table if not exists q3_votes (like q1_votes including all);
alter table q3_votes enable row level security;
create policy "anon_read_q3" on q3_votes for select using (true);
create policy "anon_insert_q3" on q3_votes for insert with check (true);
create policy "anon_update_q3" on q3_votes for update using (category = 'dates' and name_key is not null) with check (category = 'dates' and name_key is not null);
create index idx_q3_votes_category on q3_votes(category);
create index idx_q3_votes_name_key on q3_votes(name_key) where category = 'dates';

-- Q4 (September)
create table if not exists q4_votes (like q1_votes including all);
alter table q4_votes enable row level security;
create policy "anon_read_q4" on q4_votes for select using (true);
create policy "anon_insert_q4" on q4_votes for insert with check (true);
create policy "anon_update_q4" on q4_votes for update using (category = 'dates' and name_key is not null) with check (category = 'dates' and name_key is not null);
create index idx_q4_votes_category on q4_votes(category);
create index idx_q4_votes_name_key on q4_votes(name_key) where category = 'dates';
