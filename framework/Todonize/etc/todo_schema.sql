create table todo (
    id integer primary key auto_increment,
    title varchar(1024) not null,
    is_done integer default 0
);
