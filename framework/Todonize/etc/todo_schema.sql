create table todo (
    id integer primary key auto_increment,
    title text not null,
    is_done integer default 0,
    is_doing integer default 0,
    updated_date timestamp,
    created_date datetime not null
);
