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

%token BEGINGRAPH NODE EDGE ENDGRAPH DIRECTED NONDIRECTED STRINGNAME ID

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
        BEGINGRAPH
        {
                printf("graph {\n");
        }
        ;

buildNodeLabel:
        NODE ID STRINGNAME
        {
                printf("make node (with label);\n");
        }
        ;

buildNode:
        NODE ID
        {
                printf("make node (no label);\n");
        }
        ;

directedEdgeLabel:
        EDGE ID DIRECTED ID STRINGNAME
        {
                printf("Directed edge with label...;\n");
        }
        ;

directedEdge:
        EDGE ID DIRECTED ID
        {
                printf("Directed edge...;\n");
        }
        ;

nonDirectedEdgeLabel:
        EDGE ID NONDIRECTED ID STRINGNAME
        {
                printf("Non directed edge with label...;\n");
        }
        ;

nonDirectedEdge:
        EDGE ID NONDIRECTED ID
        {
                printf("Non directed edge...;\n");
        }
        ;

endGraph:
        ENDGRAPH
        {
                printf("}");
        }
        ;
