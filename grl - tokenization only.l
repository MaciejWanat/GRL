%{
#include <stdio.h>
%}

%%

"#".* ;
BEGIN_GRAPH printf("beginGraph ");
NODE printf("node ");
EDGE printf("edge ");
END_GRAPH printf("endGraph ");
"->" printf("directed ");
"--" printf("nonDirected ");
\'([a-z]|[A-Z]|[0-9]|" ")*\' printf("stringName ");
([a-z]|[A-Z]|[0-9]) printf("id ");
