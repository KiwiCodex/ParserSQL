sql: lex.yy.c bisonSQL.tab.c
	gcc lex.yy.c bisonSQL.tab.c -o sql
	./sql
