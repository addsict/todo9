alter table todo engine=myisam;

alter table todo set
add fulltext(title) with parser mecab;
