%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

"#".*                         ;
" "                           ;
";"                           return ENDLINE;
DEFAULT_SHAPE                 yylval.str = strdup(yytext); return DEFAULTNODESHAPE;
BEGIN_GRAPH                   return BEGINGRAPH;
BEGIN_DIGRAPH                 return BEGINDIGRAPH;
NODE                          return NODE;
EDGE                          return EDGE;
END_GRAPH                     return ENDGRAPH;
"->"                          return DIRECTED;
"--"                          return NONDIRECTED;
\"([a-z]|[A-Z]|[0-9]|" ")*\"  yylval.str = strdup(yytext); return STRINGNAME;
([a-z]|[A-Z]|[0-9])+          yylval.str = strdup(yytext); return ID;
