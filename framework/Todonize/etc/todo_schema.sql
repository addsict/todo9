create table todo (
    id integer primary key auto_increment,
    title text not null,
    is_done integer default 0
);
