%option yylineno
%option noyywrap

%{
    #include <stdio.h>
    #include <string.h>
    #include "bisonSQL.tab.h"
    
    void yyerror(char *msg){
      printf("\nConsulta no se encuentra en el formato indicado! %d: %s.\n", yylineno, msg);
      exit(1);
      }
%}

%x COMMENT

%%

"--"[^\n]*\n          { /* ignorar comentarios */ }
"/*"                  { BEGIN(COMMENT); }
"*/"                  { BEGIN(INITIAL); }
"SELECT"              { return SELECT; }
"FROM"                { return FROM; }
"WHERE"               { return WHERE; }
"GROUP"               { return GROUP; }
"BY"                  { return BY;}
"HAVING"              { return HAVING; }
";"                   { return PC;} 
["]                   { return COM;}
[*]                   { return *yytext;}
[,]                   { return *yytext;}
[a-zA-Z0-9][a-zA-Z0-9_]* { return ID; }
\n                    {return *yytext;}
[ \t]+                { /* ignorar espacios en blanco */ }
<COMMENT>.|\n         { /* ignorar comentarios */ }
.                     { return *yytext;}
%%
