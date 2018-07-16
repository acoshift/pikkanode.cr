create extension pgcrypto;

create table users (
	id uuid default gen_random_uuid(),
	username varchar not null,
	password varchar not null,
	created_at timestamp not null default now(),
	primary key (id)
);
create unique index on users (username);

create table tokens (
	id varchar,
	data bytea,
	last_active timestamp not null default now(),
	primary key (id)
);
create index on tokens (last_active);

create table pictures (
	id uuid default gen_random_uuid(),
	user_id uuid not null,
	caption varchar not null,
	created_at timestamp not null default now(),
	primary key (id),
	foreign key (user_id) references users (id)
);
create index on pictures (created_at desc);

create table comments (
	id uuid default gen_random_uuid(),
	user_id uuid not null,
	picture_id uuid not null,
	content varchar not null,
	created_at timestamp not null default now(),
	primary key (id),
	foreign key (user_id) references users (id),
	foreign key (picture_id) references pictures (id)
);
create index on comments (picture_id, created_at);
