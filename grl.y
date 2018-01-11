%{
    #include <stdio.h>
    #include <string.h>

    void yyerror(const char *str)
    {
            fprintf(stderr,"error: %s\n",str);
    }

    int yywrap()
    {
            return 1;
    }

    main()
    {
          yyparse();
    }

%}

%union
{
    char *str;
}

%token BEGINDIGRAPH BEGINGRAPH NODE EDGE ENDGRAPH DIRECTED NONDIRECTED ENDLINE
%token <str> STRINGNAME ID

%%

commands: /* empty */
        | commands command
        ;

command: startGraph
        | buildNode
        | buildEdge
        | endGraph
        ;

startGraph:
        BEGINGRAPH ENDLINE { printf("graph {"); }
        | BEGINGRAPH STRINGNAME ENDLINE { printf("graph %s {", $2); }
        | BEGINDIGRAPH ENDLINE { printf("digraph {"); }
        | BEGINDIGRAPH STRINGNAME ENDLINE { printf("digraph %s {", $2); }
        ;

buildNode:
        NODE ID ENDLINE { printf("\t%s;", $2); }
        | NODE ID STRINGNAME ENDLINE { printf("\t%s [label=%s];", $2, $3); }
        ;

buildEdge:
        EDGE ID DIRECTED ID STRINGNAME ENDLINE { printf("\t%s -> %s [label=%s];", $2, $4, $5); }
        | EDGE ID DIRECTED ID ENDLINE { printf("\t%s -> %s;", $2, $4); }
        | EDGE ID DIRECTED ID ENDLINE { printf("\t%s -> %s;", $2, $4); }
        | EDGE ID NONDIRECTED ID STRINGNAME ENDLINE { printf("\t%s -- %s [label=%s];", $2, $4, $5); }
        | EDGE ID NONDIRECTED ID ENDLINE { printf("\t%s -- %s;", $2, $4);}
        ;

endGraph:
        ENDGRAPH ENDLINE
        {
                printf("}");
        }
        ;
