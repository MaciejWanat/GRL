#define BEGINGRAPH 257
#define NODE 258
#define EDGE 259
#define ENDGRAPH 260
#define DIRECTED 261
#define NONDIRECTED 262
#define ENDLINE 263
#define STRINGNAME 264
#define ID 265
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union
{
    char *str;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
