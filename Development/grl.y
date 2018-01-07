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
                printf("graph {\n");
        }
        ;

buildNode:
        NODE ID ENDLINE
        {
                printf("%s;\n", $2);
        }
        ;

buildNodeLabel:
        NODE ID STRINGNAME ENDLINE
        {
                printf("%s [label=\"%s\"];\n", $2, $3);
        }
        ;

directedEdgeLabel:
        EDGE ID DIRECTED ID STRINGNAME ENDLINE
        {
                printf("%s->%s [label=\"%s\"];\n", $2, $4, $5);
        }
        ;

directedEdge:
        EDGE ID DIRECTED ID ENDLINE
        {
                printf("%s->%s;\n", $2, $4);
        }
        ;

nonDirectedEdgeLabel:
        EDGE ID NONDIRECTED ID STRINGNAME ENDLINE
        {
                printf("%s--%s [label=\"%s\"];\n", $2, $4, $5);
        }
        ;

nonDirectedEdge:
        EDGE ID NONDIRECTED ID ENDLINE
        {
                printf("%s--%s;\n", $2, $4);
        }
        ;

endGraph:
        ENDGRAPH ENDLINE
        {
                printf("}");
        }
        ;
