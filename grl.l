%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

"#".*                         ;
BEGIN_GRAPH                   return BEGINGRAPH;
NODE                          return NODE;
EDGE                          return EDGE;
END_GRAPH                     return ENDGRAPH;
"->"                          return DIRECTED;
"--"                          return NONDIRECTED;
\'([a-z]|[A-Z]|[0-9]|" ")*\'  return STRINGNAME;
([a-z]|[A-Z]|[0-9])           return ID;
