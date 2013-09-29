create table todo (
  id integer primary key auto_increment,
  todo varchar(128) not null,
  updated_at timestamp,
  created_at datetime not null
) engine=innodb default charset=utf8;

delimiter //
create trigger `todo_table_insert_trigger`
before insert on `todo`
for each row
begin
    if new.created_at = '0000-00-00 00:00:00' then
        set new.created_at = now();
    end if;
end;//
delimiter ;
