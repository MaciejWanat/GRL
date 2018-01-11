%{
    #include <stdio.h>
    #include <string.h>

    char* defaultNodeShapeStart = "";
    char* defaultNodeStyleStart = "";
    char* defaultNodeShape = "";
    char* defaultNodeStyle = "";

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
              printf("\t%s [%s%s%s%s];", $2, defaultNodeStyleStart, defaultNodeStyle, defaultNodeShapeStart, defaultNodeShape);
        }
        | NODE ID STRINGNAME ENDLINE
        {
              printf("\t%s [label=%s%s%s%s%s];", $2, $3, defaultNodeShapeStart, defaultNodeShape, defaultNodeStyleStart, defaultNodeStyle);
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
              defaultNodeShapeStart = " shape=";
              defaultNodeShape = $2;
        }
        ;

defaultNodeStyle:
        DEFAULTNODESTYLE STRINGNAME ENDLINE
        {
              defaultNodeStyleStart = " style=";
              defaultNodeStyle = $2;
        }
        ;
