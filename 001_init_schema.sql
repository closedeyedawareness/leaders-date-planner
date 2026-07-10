-- Leaders in Benefits Quarterly Governance Platform
-- Tables for date voting, topic suggestions with for/against voting, and network nominations with against voting
-- Safe to re-run: tables use IF NOT EXISTS, policies are dropped and recreated, indexes use IF NOT EXISTS.

-- Q1 VOTES (date voting only)
create table if not exists q1_votes (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  name text,
  name_key text unique,
  selected_dates text[],
  category text default 'dates'
);

-- Q1 TOPICS (topic suggestions + for/against votes)
create table if not exists q1_topics (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  topic text not null,
  submitted_by text
);

-- Q1 TOPIC VOTES (track for/against votes on each topic)
create table if not exists q1_topic_votes (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  topic_id bigint not null references q1_topics(id) on delete cascade,
  vote_for boolean not null,
  voter_key text,
  constraint unique_topic_voter unique(topic_id, voter_key)
);

-- Q1 NOMINATIONS (anonymous nominations)
create table if not exists q1_nominations (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  nominee text not null
);

-- Q1 NOMINATION VOTES (anonymous against votes on nominations)
create table if not exists q1_nomination_votes (
  id bigserial primary key,
  created_at timestamp with time zone default now(),
  nomination_id bigint not null references q1_nominations(id) on delete cascade,
  voter_key text,
  constraint unique_nomination_voter unique(nomination_id, voter_key)
);

-- Enable RLS on all tables
alter table q1_votes enable row level security;
alter table q1_topics enable row level security;
alter table q1_topic_votes enable row level security;
alter table q1_nominations enable row level security;
alter table q1_nomination_votes enable row level security;

-- RLS Policies (drop-then-create so this script is safe to re-run)
drop policy if exists "anon_read_q1_votes" on q1_votes;
create policy "anon_read_q1_votes" on q1_votes for select using (true);
drop policy if exists "anon_insert_q1_votes" on q1_votes;
create policy "anon_insert_q1_votes" on q1_votes for insert with check (true);
drop policy if exists "anon_update_q1_votes" on q1_votes;
create policy "anon_update_q1_votes" on q1_votes for update using (name_key is not null) with check (name_key is not null);

drop policy if exists "anon_read_q1_topics" on q1_topics;
create policy "anon_read_q1_topics" on q1_topics for select using (true);
drop policy if exists "anon_insert_q1_topics" on q1_topics;
create policy "anon_insert_q1_topics" on q1_topics for insert with check (true);

drop policy if exists "anon_read_q1_topic_votes" on q1_topic_votes;
create policy "anon_read_q1_topic_votes" on q1_topic_votes for select using (true);
drop policy if exists "anon_insert_q1_topic_votes" on q1_topic_votes;
create policy "anon_insert_q1_topic_votes" on q1_topic_votes for insert with check (true);

drop policy if exists "anon_read_q1_nominations" on q1_nominations;
create policy "anon_read_q1_nominations" on q1_nominations for select using (true);
drop policy if exists "anon_insert_q1_nominations" on q1_nominations;
create policy "anon_insert_q1_nominations" on q1_nominations for insert with check (true);

drop policy if exists "anon_read_q1_nomination_votes" on q1_nomination_votes;
create policy "anon_read_q1_nomination_votes" on q1_nomination_votes for select using (true);
drop policy if exists "anon_insert_q1_nomination_votes" on q1_nomination_votes;
create policy "anon_insert_q1_nomination_votes" on q1_nomination_votes for insert with check (true);

-- Indexes
create index if not exists idx_q1_topic_votes_topic_id on q1_topic_votes(topic_id);
create index if not exists idx_q1_topic_votes_vote_for on q1_topic_votes(vote_for);
create index if not exists idx_q1_nomination_votes_nomination_id on q1_nomination_votes(nomination_id);

-- REPEAT FOR Q2, Q3, Q4
-- Q2 (January)
create table if not exists q2_votes (like q1_votes including all);
create table if not exists q2_topics (like q1_topics including all);
create table if not exists q2_topic_votes (like q1_topic_votes including all);
create table if not exists q2_nominations (like q1_nominations including all);
create table if not exists q2_nomination_votes (like q1_nomination_votes including all);
alter table q2_votes enable row level security;
alter table q2_topics enable row level security;
alter table q2_topic_votes enable row level security;
alter table q2_nominations enable row level security;
alter table q2_nomination_votes enable row level security;

drop policy if exists "anon_read_q2_votes" on q2_votes;
create policy "anon_read_q2_votes" on q2_votes for select using (true);
drop policy if exists "anon_insert_q2_votes" on q2_votes;
create policy "anon_insert_q2_votes" on q2_votes for insert with check (true);
drop policy if exists "anon_update_q2_votes" on q2_votes;
create policy "anon_update_q2_votes" on q2_votes for update using (name_key is not null) with check (name_key is not null);

drop policy if exists "anon_read_q2_topics" on q2_topics;
create policy "anon_read_q2_topics" on q2_topics for select using (true);
drop policy if exists "anon_insert_q2_topics" on q2_topics;
create policy "anon_insert_q2_topics" on q2_topics for insert with check (true);

drop policy if exists "anon_read_q2_topic_votes" on q2_topic_votes;
create policy "anon_read_q2_topic_votes" on q2_topic_votes for select using (true);
drop policy if exists "anon_insert_q2_topic_votes" on q2_topic_votes;
create policy "anon_insert_q2_topic_votes" on q2_topic_votes for insert with check (true);

drop policy if exists "anon_read_q2_nominations" on q2_nominations;
create policy "anon_read_q2_nominations" on q2_nominations for select using (true);
drop policy if exists "anon_insert_q2_nominations" on q2_nominations;
create policy "anon_insert_q2_nominations" on q2_nominations for insert with check (true);

drop policy if exists "anon_read_q2_nomination_votes" on q2_nomination_votes;
create policy "anon_read_q2_nomination_votes" on q2_nomination_votes for select using (true);
drop policy if exists "anon_insert_q2_nomination_votes" on q2_nomination_votes;
create policy "anon_insert_q2_nomination_votes" on q2_nomination_votes for insert with check (true);

create index if not exists idx_q2_topic_votes_topic_id on q2_topic_votes(topic_id);
create index if not exists idx_q2_topic_votes_vote_for on q2_topic_votes(vote_for);
create index if not exists idx_q2_nomination_votes_nomination_id on q2_nomination_votes(nomination_id);

-- Q3 (May)
create table if not exists q3_votes (like q1_votes including all);
create table if not exists q3_topics (like q1_topics including all);
create table if not exists q3_topic_votes (like q1_topic_votes including all);
create table if not exists q3_nominations (like q1_nominations including all);
create table if not exists q3_nomination_votes (like q1_nomination_votes including all);
alter table q3_votes enable row level security;
alter table q3_topics enable row level security;
alter table q3_topic_votes enable row level security;
alter table q3_nominations enable row level security;
alter table q3_nomination_votes enable row level security;

drop policy if exists "anon_read_q3_votes" on q3_votes;
create policy "anon_read_q3_votes" on q3_votes for select using (true);
drop policy if exists "anon_insert_q3_votes" on q3_votes;
create policy "anon_insert_q3_votes" on q3_votes for insert with check (true);
drop policy if exists "anon_update_q3_votes" on q3_votes;
create policy "anon_update_q3_votes" on q3_votes for update using (name_key is not null) with check (name_key is not null);

drop policy if exists "anon_read_q3_topics" on q3_topics;
create policy "anon_read_q3_topics" on q3_topics for select using (true);
drop policy if exists "anon_insert_q3_topics" on q3_topics;
create policy "anon_insert_q3_topics" on q3_topics for insert with check (true);

drop policy if exists "anon_read_q3_topic_votes" on q3_topic_votes;
create policy "anon_read_q3_topic_votes" on q3_topic_votes for select using (true);
drop policy if exists "anon_insert_q3_topic_votes" on q3_topic_votes;
create policy "anon_insert_q3_topic_votes" on q3_topic_votes for insert with check (true);

drop policy if exists "anon_read_q3_nominations" on q3_nominations;
create policy "anon_read_q3_nominations" on q3_nominations for select using (true);
drop policy if exists "anon_insert_q3_nominations" on q3_nominations;
create policy "anon_insert_q3_nominations" on q3_nominations for insert with check (true);

drop policy if exists "anon_read_q3_nomination_votes" on q3_nomination_votes;
create policy "anon_read_q3_nomination_votes" on q3_nomination_votes for select using (true);
drop policy if exists "anon_insert_q3_nomination_votes" on q3_nomination_votes;
create policy "anon_insert_q3_nomination_votes" on q3_nomination_votes for insert with check (true);

create index if not exists idx_q3_topic_votes_topic_id on q3_topic_votes(topic_id);
create index if not exists idx_q3_topic_votes_vote_for on q3_topic_votes(vote_for);
create index if not exists idx_q3_nomination_votes_nomination_id on q3_nomination_votes(nomination_id);

-- Q4 (September)
create table if not exists q4_votes (like q1_votes including all);
create table if not exists q4_topics (like q1_topics including all);
create table if not exists q4_topic_votes (like q1_topic_votes including all);
create table if not exists q4_nominations (like q1_nominations including all);
create table if not exists q4_nomination_votes (like q1_nomination_votes including all);
alter table q4_votes enable row level security;
alter table q4_topics enable row level security;
alter table q4_topic_votes enable row level security;
alter table q4_nominations enable row level security;
alter table q4_nomination_votes enable row level security;

drop policy if exists "anon_read_q4_votes" on q4_votes;
create policy "anon_read_q4_votes" on q4_votes for select using (true);
drop policy if exists "anon_insert_q4_votes" on q4_votes;
create policy "anon_insert_q4_votes" on q4_votes for insert with check (true);
drop policy if exists "anon_update_q4_votes" on q4_votes;
create policy "anon_update_q4_votes" on q4_votes for update using (name_key is not null) with check (name_key is not null);

drop policy if exists "anon_read_q4_topics" on q4_topics;
create policy "anon_read_q4_topics" on q4_topics for select using (true);
drop policy if exists "anon_insert_q4_topics" on q4_topics;
create policy "anon_insert_q4_topics" on q4_topics for insert with check (true);

drop policy if exists "anon_read_q4_topic_votes" on q4_topic_votes;
create policy "anon_read_q4_topic_votes" on q4_topic_votes for select using (true);
drop policy if exists "anon_insert_q4_topic_votes" on q4_topic_votes;
create policy "anon_insert_q4_topic_votes" on q4_topic_votes for insert with check (true);

drop policy if exists "anon_read_q4_nominations" on q4_nominations;
create policy "anon_read_q4_nominations" on q4_nominations for select using (true);
drop policy if exists "anon_insert_q4_nominations" on q4_nominations;
create policy "anon_insert_q4_nominations" on q4_nominations for insert with check (true);

drop policy if exists "anon_read_q4_nomination_votes" on q4_nomination_votes;
create policy "anon_read_q4_nomination_votes" on q4_nomination_votes for select using (true);
drop policy if exists "anon_insert_q4_nomination_votes" on q4_nomination_votes;
create policy "anon_insert_q4_nomination_votes" on q4_nomination_votes for insert with check (true);

create index if not exists idx_q4_topic_votes_topic_id on q4_topic_votes(topic_id);
create index if not exists idx_q4_topic_votes_vote_for on q4_topic_votes(vote_for);
create index if not exists idx_q4_nomination_votes_nomination_id on q4_nomination_votes(nomination_id);

-- Reload PostgREST schema cache so the API picks up newly created tables immediately
notify pgrst, 'reload schema';
