%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

"#".*                             ;
" "                               ;
";"                               return ENDLINE;
DEFAULT_SHAPE                     yylval.str = strdup(yytext); return DEFAULTNODESHAPE;
DEFAULT_STYLE                     yylval.str = strdup(yytext); return DEFAULTNODESTYLE;
BEGIN_GRAPH                       return BEGINGRAPH;
BEGIN_DIGRAPH                     return BEGINDIGRAPH;
NODE                              return NODE;
EDGE                              return EDGE;
END_GRAPH                         return ENDGRAPH;
"->"                              return DIRECTED;
"--"                              return NONDIRECTED;
STYLE=                            return STYLE;
SHAPE=                            return SHAPE;
\"([a-z]|[A-Z]|[0-9]|" "|\n)*\"   yylval.str = strdup(yytext); return STRINGNAME;
([a-z]|[A-Z]|[0-9])+              yylval.str = strdup(yytext); return ID;
