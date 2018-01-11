%{
    #include <stdio.h>
    #include <string.h>

    char* defaultNodeShape;
    char* defaultNodeStyle;

    void yyerror(const char *str)
    {
            fprintf(stderr,"error: %s\n",str);
    }

    int yywrap()
    {
          return 1;
    }

    int main()
    {
          yyparse();
          return 0;
    }

%}

%union
{
    char *str;
}

%token STYLE BEGINDIGRAPH BEGINGRAPH NODE EDGE ENDGRAPH DIRECTED NONDIRECTED ENDLINE
%token <str> STRINGNAME ID DEFAULTNODESHAPE DEFAULTNODESTYLE

%%

commands: /* empty */
        | commands command
        ;

command: startGraph
        | buildNode
        | buildEdge
        | endGraph
        | defaultNodeShape
        | defaultNodeStyle
        ;

startGraph:
        BEGINGRAPH ENDLINE { printf("graph {"); }
        | BEGINGRAPH STRINGNAME ENDLINE { printf("graph %s {", $2); }
        | BEGINDIGRAPH ENDLINE { printf("digraph {"); }
        | BEGINDIGRAPH STRINGNAME ENDLINE { printf("digraph %s {", $2); }
        ;

buildNode:
        NODE ID ENDLINE
        {
                if(!defaultNodeShape)
                  if(!defaultNodeStyle)
                    printf("\t%s;", $2);
                  else
                    printf("\t%s, [style=%s];", $2, defaultNodeStyle);
                else
                  if(!defaultNodeStyle)
                    printf("\t%s [shape=%s];", $2, defaultNodeShape);
                  else
                    printf("\t%s [shape=%s, style=%s];", $2, defaultNodeShape, defaultNodeStyle);
        }
        | NODE ID STRINGNAME ENDLINE
        {
                if(!defaultNodeShape)
                  if(!defaultNodeStyle)
                    printf("\t%s [label=%s];", $2, $3);
                  else
                    printf("\t%s, [ label=%s, style=%s,];", $2, $3, defaultNodeStyle);
                else
                  if(!defaultNodeStyle)
                    printf("\t%s [label=%s, shape=%s];", $2, $3, defaultNodeShape);
                  else
                    printf("\t%s [label=%s, shape=%s, style=%s];", $2, $3, defaultNodeShape, defaultNodeStyle);
        }
        ;

buildEdge:
        buildNonDirected
        |
        buildDirected
        ;

buildDirected:
         EDGE ID DIRECTED ID STRINGNAME ENDLINE { printf("\t%s -> %s [label=%s];", $2, $4, $5); }
        | EDGE ID DIRECTED ID ENDLINE { printf("\t%s -> %s;", $2, $4); }
        | EDGE ID DIRECTED ID STRINGNAME STYLE STRINGNAME ENDLINE { printf("\t%s -> %s [label=%s, style=%s];", $2, $4, $5, $7); }
        | EDGE ID DIRECTED ID STYLE STRINGNAME ENDLINE { printf("\t%s -> %s [style=%s];", $2, $4, $6); }

buildNonDirected:
         EDGE ID NONDIRECTED ID STRINGNAME ENDLINE { printf("\t%s -- %s [label=%s];", $2, $4, $5); }
        | EDGE ID NONDIRECTED ID ENDLINE { printf("\t%s -- %s;", $2, $4);}
        | EDGE ID NONDIRECTED ID STRINGNAME STYLE STRINGNAME ENDLINE { printf("\t%s -> %s [label=%s, style=%s];", $2, $4, $5, $7); }
        | EDGE ID NONDIRECTED ID STYLE STRINGNAME ENDLINE { printf("\t%s -> %s [style=%s];", $2, $4, $6); }

endGraph:
        ENDGRAPH ENDLINE
        {
                printf("}");
        }
        ;

defaultNodeShape:
        DEFAULTNODESHAPE STRINGNAME ENDLINE
        {
                defaultNodeShape = $2;
        }
        ;

defaultNodeStyle:
        DEFAULTNODESTYLE STRINGNAME ENDLINE
        {
                defaultNodeStyle = $2;
        }
        ;
