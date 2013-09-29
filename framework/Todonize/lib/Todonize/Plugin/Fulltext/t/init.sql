drop table if exists todo;

CREATE TABLE todo (
  id integer primary key auto_increment,
  title TEXT, FULLTEXT(title) WITH PARSER mecab
) ENGINE=myisam DEFAULT CHARSET=utf8;

insert into todo (title) values ("釣り"), ("aとデート"), ("bとデート"), ("cとデート"), ("デートプラン立てる"), ("池袋のデートプラン立てる");
