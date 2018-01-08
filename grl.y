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

%token BEGINGRAPH NODE EDGE ENDGRAPH DIRECTED NONDIRECTED ENDLINE
%token <str> STRINGNAME ID

%%

commands: /* empty */
        | commands command
        ;

command:
        startGraph
        |
        startGraphLabel
        |
        buildNode
        |
        buildNodeLabel
        |
        directedEdge
        |
        nonDirectedEdge
        |
        directedEdgeLabel
        |
        nonDirectedEdgeLabel
        |
        endGraph
        ;

startGraph:
        BEGINGRAPH ENDLINE
        {
                printf("graph {");
        }
        ;

startGraphLabel:
        BEGINGRAPH STRINGNAME ENDLINE
        {
                printf("graph %s {", $2);
        }
        ;

buildNode:
        NODE ID ENDLINE
        {
                printf("\t%s;", $2);
        }
        ;

buildNodeLabel:
        NODE ID STRINGNAME ENDLINE
        {
                printf("\t%s [label=%s];", $2, $3);
        }
        ;

directedEdgeLabel:
        EDGE ID DIRECTED ID STRINGNAME ENDLINE
        {
                printf("\t%s -> %s [label=%s];", $2, $4, $5);
        }
        ;

directedEdge:
        EDGE ID DIRECTED ID ENDLINE
        {
                printf("\t%s -> %s;", $2, $4);
        }
        ;

nonDirectedEdgeLabel:
        EDGE ID NONDIRECTED ID STRINGNAME ENDLINE
        {
                printf("\t%s -- %s [label=%s];", $2, $4, $5);
        }
        ;

nonDirectedEdge:
        EDGE ID NONDIRECTED ID ENDLINE
        {
                printf("\t%s -- %s;", $2, $4);
        }
        ;

endGraph:
        ENDGRAPH ENDLINE
        {
                printf("}");
        }
        ;
