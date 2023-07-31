%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    extern int yylex(void);
    extern char yytext;
    extern int yylval;
    extern int linea;
    void yyerror(char *s);
%}

%token SELECT FROM WHERE GROUP BY HAVING PC ID COM

%start sql

%%

sql:
    SELECT statement PC '\n'{
      printf("!Consulta exitosa!\n");
      exit(0);
    } 
;

statement:
           columns FROM tables WHERE condition GROUP BY fields HAVING condition 
          | columns FROM tables WHERE condition GROUP BY fields
          | columns FROM tables WHERE condition 
          | columns FROM tables 
          ;

columns:  data | '*'
          ;

data:      field
          | field ',' columns
;

fields:    field
          | field ',' fields
          ;

tables:    table
          | table ',' tables
          ;

field:     ID 
          ;

table:     ID
          ;

condition: ID '=' ID 
          | ID '=' COM ID COM
          ;
%%

int main(int argc, char** argv) {
  char* query = "SELECT * FROM tabla1 WHERE campo1 = 'valor';";
  printf("Escriba su consulta SQL:\n");
  yyparse();
  return 0;
}