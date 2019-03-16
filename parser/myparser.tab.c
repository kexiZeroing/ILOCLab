/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PROCEDURE = 258,
     INT = 259,
     CHAR = 260,
     WRITE = 261,
     READ = 262,
     AND = 263,
     OR = 264,
     NOT = 265,
     IF = 266,
     ELSE = 267,
     THEN = 268,
     FOR = 269,
     TO = 270,
     BY = 271,
     WHILE = 272,
     LT = 273,
     LE = 274,
     EQ = 275,
     NE = 276,
     GT = 277,
     GE = 278,
     NAME = 279,
     NUMBER = 280,
     CHARCONST = 281
   };
#endif
/* Tokens.  */
#define PROCEDURE 258
#define INT 259
#define CHAR 260
#define WRITE 261
#define READ 262
#define AND 263
#define OR 264
#define NOT 265
#define IF 266
#define ELSE 267
#define THEN 268
#define FOR 269
#define TO 270
#define BY 271
#define WHILE 272
#define LT 273
#define LE 274
#define EQ 275
#define NE 276
#define GT 277
#define GE 278
#define NAME 279
#define NUMBER 280
#define CHARCONST 281




/* Copy the first part of user declarations.  */
#line 2 "myparser.y"

#include <stdio.h>
#include "symbolTable.h"
#include "myiloc.h"
extern int yylineno;
extern int errorCount;

int CUR_TYPE; // 0 for char, 1 for int
int globalOffset = 0;
int globalReg = 0;
int globalLabel = 0;


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 18 "myparser.y"
{
    struct SymbolEntry *entry;
	struct IfStructure *ifStructure;
    int int_val;
    char* string;
    char char_val;
}
/* Line 193 of yacc.c.  */
#line 169 "myparser.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 182 "myparser.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   455

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  23
/* YYNRULES -- Number of rules.  */
#define YYNRULES  83
/* YYNRULES -- Number of states.  */
#define YYNSTATES  245

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   281

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      35,    36,    39,    37,    30,    38,     2,    40,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    33,    29,
       2,    34,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    31,     2,    32,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    27,     2,    28,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,    10,    16,    24,    28,    31,    34,    36,
      41,    45,    48,    50,    52,    56,    58,    60,    65,    69,
      71,    75,    78,    80,    85,    89,    93,    94,   101,   109,
     121,   125,   129,   132,   136,   142,   148,   153,   157,   162,
     165,   170,   176,   181,   185,   193,   205,   209,   213,   216,
     220,   226,   232,   237,   241,   246,   249,   252,   254,   258,
     260,   264,   266,   270,   274,   278,   282,   286,   290,   292,
     296,   300,   304,   306,   310,   314,   316,   320,   322,   324,
     326,   328,   333,   337
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      42,     0,    -1,     3,    24,    27,    43,    50,    28,    -1,
       3,    24,    27,    43,    50,    -1,     3,    24,    27,    43,
      50,    28,    28,    -1,    43,    44,    29,    -1,    44,    29,
      -1,    43,    44,    -1,    44,    -1,    43,    44,    29,    29,
      -1,    44,    29,    29,    -1,    45,    46,    -1,     4,    -1,
       5,    -1,    46,    30,    47,    -1,    47,    -1,    24,    -1,
      24,    31,    48,    32,    -1,    48,    30,    49,    -1,    49,
      -1,    25,    33,    25,    -1,    50,    51,    -1,    51,    -1,
      62,    34,    59,    29,    -1,    27,    50,    28,    -1,    53,
      13,    51,    -1,    -1,    53,    13,    54,    52,    12,    51,
      -1,    17,    35,    55,    36,    27,    50,    28,    -1,    14,
      24,    34,    59,    15,    59,    16,    59,    27,    50,    28,
      -1,     7,    62,    29,    -1,     6,    59,    29,    -1,    27,
      28,    -1,    27,    29,    28,    -1,    62,    37,    34,    59,
      29,    -1,    62,    34,    59,    29,    29,    -1,     6,    34,
      59,    29,    -1,    24,    24,    29,    -1,    62,    34,    59,
       1,    -1,     1,    29,    -1,    11,    35,    55,    36,    -1,
      53,    13,    54,    12,    54,    -1,    62,    34,    59,    29,
      -1,    27,    50,    28,    -1,    17,    35,    55,    36,    27,
      50,    28,    -1,    14,    24,    34,    59,    15,    59,    16,
      59,    27,    50,    28,    -1,     7,    62,    29,    -1,     6,
      59,    29,    -1,    27,    28,    -1,    27,    29,    28,    -1,
      62,    37,    34,    59,    29,    -1,    62,    34,    59,    29,
      29,    -1,     6,    34,    59,    29,    -1,    24,    24,    29,
      -1,    62,    34,    59,     1,    -1,     1,    29,    -1,    10,
      56,    -1,    56,    -1,    56,     9,    57,    -1,    57,    -1,
      57,     8,    58,    -1,    58,    -1,    58,    18,    59,    -1,
      58,    19,    59,    -1,    58,    20,    59,    -1,    58,    21,
      59,    -1,    58,    23,    59,    -1,    58,    22,    59,    -1,
      59,    -1,    58,    34,    59,    -1,    59,    37,    60,    -1,
      59,    38,    60,    -1,    60,    -1,    60,    39,    61,    -1,
      60,    40,    61,    -1,    61,    -1,    35,    59,    36,    -1,
      62,    -1,    25,    -1,    26,    -1,    24,    -1,    24,    31,
      63,    32,    -1,    59,    30,    63,    -1,    59,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    58,    58,    59,    60,    62,    63,    64,    65,    66,
      67,    69,    71,    72,    74,    75,    77,    86,    88,    89,
      91,    93,    94,    96,   111,   112,   116,   116,   125,   126,
     127,   128,   138,   139,   140,   141,   143,   144,   145,   146,
     148,   161,   162,   177,   178,   179,   180,   181,   191,   192,
     193,   194,   196,   197,   198,   199,   201,   210,   214,   224,
     228,   238,   242,   264,   286,   308,   330,   351,   373,   376,
     378,   397,   419,   423,   442,   464,   468,   469,   472,   478,
     486,   494,   496,   497
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "PROCEDURE", "INT", "CHAR", "WRITE",
  "READ", "AND", "OR", "NOT", "IF", "ELSE", "THEN", "FOR", "TO", "BY",
  "WHILE", "LT", "LE", "EQ", "NE", "GT", "GE", "NAME", "NUMBER",
  "CHARCONST", "'{'", "'}'", "';'", "','", "'['", "']'", "':'", "'='",
  "'('", "')'", "'+'", "'-'", "'*'", "'/'", "$accept", "Procedure",
  "Decls", "Decl", "Type", "SpecList", "Spec", "Bounds", "Bound", "Stmts",
  "Stmt", "@1", "IFHead", "WithElse", "Bool", "OrTerm", "AndTerm",
  "RelExpr", "Expr", "Term", "Factor", "Reference", "Exprs", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   123,   125,    59,
      44,    91,    93,    58,    61,    40,    41,    43,    45,    42,
      47
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    41,    42,    42,    42,    43,    43,    43,    43,    43,
      43,    44,    45,    45,    46,    46,    47,    47,    48,    48,
      49,    50,    50,    51,    51,    51,    52,    51,    51,    51,
      51,    51,    51,    51,    51,    51,    51,    51,    51,    51,
      53,    54,    54,    54,    54,    54,    54,    54,    54,    54,
      54,    54,    54,    54,    54,    54,    55,    55,    56,    56,
      57,    57,    58,    58,    58,    58,    58,    58,    58,    58,
      59,    59,    59,    60,    60,    60,    61,    61,    61,    61,
      62,    62,    63,    63
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     6,     5,     7,     3,     2,     2,     1,     4,
       3,     2,     1,     1,     3,     1,     1,     4,     3,     1,
       3,     2,     1,     4,     3,     3,     0,     6,     7,    11,
       3,     3,     2,     3,     5,     5,     4,     3,     4,     2,
       4,     5,     4,     3,     7,    11,     3,     3,     2,     3,
       5,     5,     4,     3,     4,     2,     2,     1,     3,     1,
       3,     1,     3,     3,     3,     3,     3,     3,     1,     3,
       3,     3,     1,     3,     3,     1,     3,     1,     1,     1,
       1,     4,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,    12,    13,     0,     8,
       0,     0,     0,     0,     0,     0,     0,    80,     0,     7,
       0,    22,     0,     0,     6,    16,    11,    15,    39,    80,
      78,    79,     0,     0,     0,    72,    75,    77,     0,     0,
       0,     0,     0,     0,    32,     0,     0,     5,     2,    21,
       0,     0,     0,    10,     0,     0,     0,     0,    31,     0,
       0,     0,     0,    30,     0,     0,    57,    59,    61,    68,
       0,     0,    37,    83,     0,    33,    24,     9,     4,     0,
       0,     0,     0,     0,    80,     0,    25,     0,    26,     0,
       0,     0,     0,     0,    19,    14,    36,    76,    70,    71,
      73,    74,    56,    40,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    81,    39,     0,     0,
       0,     0,     0,     0,    32,     0,     0,     0,     0,     0,
       0,    38,    23,     0,     0,     0,    17,    58,    60,    62,
      63,    64,    65,    67,    66,    69,     0,     0,    82,     0,
      31,    30,     0,     0,    37,    33,    24,     0,     0,     0,
       0,    35,    34,    20,    18,     0,     0,    36,     0,     0,
       0,    27,    38,    23,     0,     0,    28,     0,     0,     0,
       0,     0,     0,     0,    80,     0,     0,    41,     0,    35,
      34,     0,     0,     0,    55,     0,     0,     0,     0,     0,
       0,    48,     0,     0,     0,     0,     0,     0,     0,    28,
       0,    47,    46,     0,     0,    53,    49,    43,     0,     0,
       0,     0,     0,    52,     0,     0,    54,    42,     0,    29,
       0,     0,     0,    51,    50,     0,     0,     0,    29,     0,
      44,     0,     0,     0,    45
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     8,     9,    10,    26,    27,    93,    94,    20,
      21,   128,    22,    88,    65,    66,    67,    68,    69,    35,
      36,    37,    74
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -126
static const yytype_int16 yypact[] =
{
       4,    34,    33,    35,  -126,    32,  -126,  -126,   404,    95,
      54,   114,   129,    78,    92,   127,   133,    -1,    43,   147,
      98,  -126,   171,   -18,   157,   159,   174,  -126,  -126,   180,
    -126,  -126,   182,   182,    99,   142,  -126,  -126,   190,    66,
     189,    66,   201,   182,  -126,   205,   283,   208,   210,  -126,
       7,   182,   213,  -126,   219,    54,   183,    70,  -126,   182,
     182,   182,   182,  -126,   182,   212,   243,   247,   126,   172,
     182,   223,  -126,    83,   229,  -126,  -126,  -126,  -126,   240,
     154,    78,   255,   245,    57,   239,  -126,   270,  -126,   -17,
       3,   182,   254,   110,  -126,  -126,  -126,  -126,   142,   142,
    -126,  -126,   243,  -126,   182,   182,   182,   182,   182,   182,
     182,   182,   182,    -9,   271,   182,  -126,   287,   182,   220,
     276,   281,    66,   288,   304,   299,   295,     7,   316,   182,
     305,  -126,   300,   235,   315,   219,  -126,   247,   126,   172,
     172,   172,   172,   172,   172,   172,   182,   413,  -126,   248,
     329,   339,   182,   317,   340,   351,   352,   353,   413,    10,
     182,  -126,  -126,  -126,  -126,    49,   307,   364,    31,   348,
     428,  -126,   365,    -3,   266,   182,  -126,   182,   413,   358,
     167,    78,   378,   381,   143,   264,   386,  -126,   -12,   376,
     405,    26,    59,   319,  -126,   182,   360,   393,   389,    66,
     396,  -126,   398,   331,   428,   182,   399,   413,   182,   420,
     363,  -126,  -126,   182,   400,  -126,  -126,  -126,   353,    14,
     182,   343,    73,  -126,    46,   411,  -126,   412,   375,  -126,
     413,   182,   413,  -126,  -126,   355,    79,   367,   431,   182,
    -126,   134,   413,   379,  -126
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -126,  -126,  -126,   436,  -126,  -126,   391,  -126,   312,     9,
      39,  -126,   -47,  -125,   -40,   384,   345,   346,    23,   155,
     164,    -8,   335
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -56
static const yytype_int16 yytable[] =
{
      23,    71,   157,    87,   131,    38,   146,     1,    79,   -42,
      23,   172,    23,    80,    81,   226,    51,   129,    14,    52,
     130,    82,   205,    42,    83,   206,   189,    46,    59,    60,
      43,    84,   132,     4,    85,    34,     6,     7,    23,   173,
      59,    60,    89,   227,    11,   187,   177,    59,    60,    12,
      13,    59,    60,   207,    14,    56,    57,    15,     3,    49,
      16,   231,     5,    59,    60,   175,    73,    17,    59,    60,
      18,    44,    45,   120,    90,   208,    64,    23,    25,   218,
      87,   123,   153,    59,    60,    49,    59,    60,    43,    86,
      29,    30,    31,   113,   126,   239,    59,    60,    -3,    11,
     230,    33,    29,   119,    12,    13,    97,    59,    60,    14,
      59,    60,    15,   115,   133,    16,    59,    60,    23,    89,
      59,    60,    17,   186,    24,    18,    48,    39,    58,   139,
     140,   141,   142,   143,   144,   145,    59,    60,    73,    23,
     135,   149,   136,    28,   106,   107,   108,   109,   110,   111,
      23,    40,   159,    29,    30,    31,   166,   186,    23,   214,
     112,   242,   188,    32,    33,    49,    86,   200,    41,   165,
      23,    59,    60,   197,    43,   168,    47,    23,    29,    30,
      31,    61,    62,   174,    50,    23,    53,   193,   118,    33,
      54,    29,    30,    31,   203,    23,   188,   171,   191,    23,
     192,   195,    33,   196,    55,    49,    29,    30,    31,    59,
      60,    43,    96,    23,    98,    99,   221,    33,   210,    63,
      59,    60,    23,    70,    23,   100,   101,    23,   219,    23,
      72,   222,    49,    75,    23,    23,   224,    77,    78,   235,
      11,   237,    49,   228,    92,    12,    13,    91,   103,   150,
      14,   243,   104,    15,   236,   105,    16,    59,    60,   114,
      49,   116,   241,    17,   162,    11,    18,   124,   125,   117,
      12,    13,    59,    60,    49,    14,    49,   167,    15,   121,
     122,    16,    49,   127,    11,    59,    60,   134,    17,    12,
      13,    18,   201,   202,    14,   190,    11,    15,   147,   -55,
      16,    12,    13,    59,    60,   151,    14,    17,    11,    15,
      18,    76,    16,    12,    13,   152,   -48,   154,    14,    17,
      11,    15,    18,   156,    16,    12,    13,   155,   158,   161,
      14,    17,    11,    15,    18,   176,    16,    12,    13,   160,
     163,   -47,    14,    17,    11,    15,    18,   209,    16,    12,
      13,   -46,   -53,   169,    14,    17,    11,    15,    18,   217,
      16,    12,    13,   -49,   -43,   170,    14,    17,    11,    15,
      18,   229,    16,    12,    13,   178,   -52,   -54,    14,    17,
      11,    15,    18,   238,    16,    12,    13,   194,   -51,   211,
      14,    17,   223,    15,    18,   240,    16,    59,    60,   204,
      59,    60,   198,    17,   234,    11,    18,   244,     6,     7,
      12,    13,    59,    60,    11,    14,   199,   -50,    15,    12,
      13,    16,   212,   213,    14,   215,   216,    15,    17,   179,
      16,    18,   -44,   220,   180,   181,   225,    17,   232,    14,
      18,   233,   182,   -45,    19,   183,    95,   164,   102,   137,
     148,   138,   184,     0,     0,   185
};

static const yytype_int16 yycheck[] =
{
       8,    41,   127,    50,     1,    13,    15,     3,     1,    12,
      18,     1,    20,     6,     7,     1,    34,    34,    11,    37,
      37,    14,    34,    24,    17,    37,    29,    18,    37,    38,
      31,    24,    29,     0,    27,    12,     4,     5,    46,    29,
      37,    38,    50,    29,     1,   170,    15,    37,    38,     6,
       7,    37,    38,    27,    11,    32,    33,    14,    24,    20,
      17,    15,    27,    37,    38,    16,    43,    24,    37,    38,
      27,    28,    29,    81,    51,    16,    10,    85,    24,   204,
     127,    24,   122,    37,    38,    46,    37,    38,    31,    50,
      24,    25,    26,    70,    85,    16,    37,    38,     0,     1,
      27,    35,    24,    80,     6,     7,    36,    37,    38,    11,
      37,    38,    14,    30,    91,    17,    37,    38,   126,   127,
      37,    38,    24,   170,    29,    27,    28,    35,    29,   106,
     107,   108,   109,   110,   111,   112,    37,    38,   115,   147,
      30,   118,    32,    29,    18,    19,    20,    21,    22,    23,
     158,    24,   129,    24,    25,    26,   147,   204,   166,   199,
      34,    27,   170,    34,    35,   126,   127,    24,    35,   146,
     178,    37,    38,   181,    31,   152,    29,   185,    24,    25,
      26,    39,    40,   160,    13,   193,    29,   178,    34,    35,
      31,    24,    25,    26,   185,   203,   204,   158,   175,   207,
     177,    34,    35,   180,    30,   166,    24,    25,    26,    37,
      38,    31,    29,   221,    59,    60,   207,    35,   195,    29,
      37,    38,   230,    34,   232,    61,    62,   235,   205,   237,
      29,   208,   193,    28,   242,   243,   213,    29,    28,   230,
       1,   232,   203,   220,    25,     6,     7,    34,    36,    29,
      11,   242,     9,    14,   231,     8,    17,    37,    38,    36,
     221,    32,   239,    24,    29,     1,    27,    28,    29,    29,
       6,     7,    37,    38,   235,    11,   237,    29,    14,    24,
      35,    17,   243,    13,     1,    37,    38,    33,    24,     6,
       7,    27,    28,    29,    11,    29,     1,    14,    27,    12,
      17,     6,     7,    37,    38,    29,    11,    24,     1,    14,
      27,    28,    17,     6,     7,    34,    12,    29,    11,    24,
       1,    14,    27,    28,    17,     6,     7,    28,    12,    29,
      11,    24,     1,    14,    27,    28,    17,     6,     7,    34,
      25,    12,    11,    24,     1,    14,    27,    28,    17,     6,
       7,    12,    12,    36,    11,    24,     1,    14,    27,    28,
      17,     6,     7,    12,    12,    12,    11,    24,     1,    14,
      27,    28,    17,     6,     7,    27,    12,    12,    11,    24,
       1,    14,    27,    28,    17,     6,     7,    29,    12,    29,
      11,    24,    29,    14,    27,    28,    17,    37,    38,    13,
      37,    38,    24,    24,    29,     1,    27,    28,     4,     5,
       6,     7,    37,    38,     1,    11,    35,    12,    14,     6,
       7,    17,    29,    34,    11,    29,    28,    14,    24,     1,
      17,    27,    12,    34,     6,     7,    36,    24,    27,    11,
      27,    29,    14,    12,     8,    17,    55,   135,    64,   104,
     115,   105,    24,    -1,    -1,    27
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    42,    24,     0,    27,     4,     5,    43,    44,
      45,     1,     6,     7,    11,    14,    17,    24,    27,    44,
      50,    51,    53,    62,    29,    24,    46,    47,    29,    24,
      25,    26,    34,    35,    59,    60,    61,    62,    62,    35,
      24,    35,    24,    31,    28,    29,    50,    29,    28,    51,
      13,    34,    37,    29,    31,    30,    59,    59,    29,    37,
      38,    39,    40,    29,    10,    55,    56,    57,    58,    59,
      34,    55,    29,    59,    63,    28,    28,    29,    28,     1,
       6,     7,    14,    17,    24,    27,    51,    53,    54,    62,
      59,    34,    25,    48,    49,    47,    29,    36,    60,    60,
      61,    61,    56,    36,     9,     8,    18,    19,    20,    21,
      22,    23,    34,    59,    36,    30,    32,    29,    34,    59,
      62,    24,    35,    24,    28,    29,    50,    13,    52,    34,
      37,     1,    29,    59,    33,    30,    32,    57,    58,    59,
      59,    59,    59,    59,    59,    59,    15,    27,    63,    59,
      29,    29,    34,    55,    29,    28,    28,    54,    12,    59,
      34,    29,    29,    25,    49,    59,    50,    29,    59,    36,
      12,    51,     1,    29,    59,    16,    28,    15,    27,     1,
       6,     7,    14,    17,    24,    27,    53,    54,    62,    29,
      29,    59,    59,    50,    29,    34,    59,    62,    24,    35,
      24,    28,    29,    50,    13,    34,    37,    27,    16,    28,
      59,    29,    29,    34,    55,    29,    28,    28,    54,    59,
      34,    50,    59,    29,    59,    36,     1,    29,    59,    28,
      27,    15,    27,    29,    29,    50,    59,    50,    28,    16,
      28,    59,    27,    50,    28
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 3:
#line 59 "myparser.y"
    { yyerror("Missing procedure closing curly brace '}'"); ;}
    break;

  case 4:
#line 60 "myparser.y"
    { yyerror("unexpected '}', redundant closing curly brace found"); yyclearin; ;}
    break;

  case 7:
#line 64 "myparser.y"
    { yyerror("Missing semicolon after declaration"); ;}
    break;

  case 8:
#line 65 "myparser.y"
    { yyerror("Missing semicolon after declaration"); ;}
    break;

  case 9:
#line 66 "myparser.y"
    { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; ;}
    break;

  case 10:
#line 67 "myparser.y"
    { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; ;}
    break;

  case 12:
#line 71 "myparser.y"
    { CUR_TYPE = 1; ;}
    break;

  case 13:
#line 72 "myparser.y"
    { CUR_TYPE = 0; ;}
    break;

  case 16:
#line 77 "myparser.y"
    { 
					if (lookupTable((yyvsp[(1) - (1)].string)) != NULL){
						yyerror("variable has been already declared.\n");
					} else {
						int dim[MAX_DIMENSION][2];
						// insertToTable(char *name, int type, int regNum, int isArray, int offset, int dimension, int dim[MAX_DIMENSION][2]);
						insertToTable((yyvsp[(1) - (1)].string), CUR_TYPE, getNextRegister(), 0, -1, -1, dim);
					}
 				;}
    break;

  case 23:
#line 96 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (4)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (4)].entry);
					if (node1 -> type == 0){
						// char
						emit(NOLABEL, _I2C, node2->regNum, node1->regNum, EMPTY);
					} else{
						// int
						if (node2 -> isImme) {
							emit(NOLABEL, _LOADI, node2->regNum, node1->regNum, EMPTY);
						}else {
							emit(NOLABEL, _I2I, node2->regNum, node1->regNum, EMPTY);
						}
					}
				;}
    break;

  case 25:
#line 112 "myparser.y"
    {
					IfStructure *ifNode = (yyvsp[(1) - (3)].ifStructure);
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
				;}
    break;

  case 26:
#line 116 "myparser.y"
    {
				  	IfStructure *ifNode = (yyvsp[(1) - (3)].ifStructure);
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	;}
    break;

  case 27:
#line 120 "myparser.y"
    {
				  	IfStructure *ifNode = (yyvsp[(1) - (6)].ifStructure);
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	;}
    break;

  case 31:
#line 128 "myparser.y"
    {
					SymbolEntry *node = (yyvsp[(2) - (3)].entry);
					if (node -> type == 0){
						// char
						emit(NOLABEL, _CWRITE, node->regNum, EMPTY, EMPTY);
					} else{
						// int
						emit(NOLABEL, _WRITE, node->regNum, EMPTY, EMPTY);
					}
				;}
    break;

  case 32:
#line 138 "myparser.y"
    { yyerror("Empty statement list is not allowed"); yyclearin; ;}
    break;

  case 33:
#line 139 "myparser.y"
    { yyerror("Empty statement in a list is not allowed"); yyclearin; ;}
    break;

  case 34:
#line 140 "myparser.y"
    { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; ;}
    break;

  case 35:
#line 141 "myparser.y"
    { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			;}
    break;

  case 36:
#line 143 "myparser.y"
    { yyerror("unexpected EQUALS, expecting CHARCONST or '(' or NAME or NUMBER, could not make an assignment to write"); yyclearin; ;}
    break;

  case 37:
#line 144 "myparser.y"
    { yyerror("unexpected NAME. No such reserved word"); yyclearin; ;}
    break;

  case 38:
#line 145 "myparser.y"
    { yyerror("Missing semicolon ';' after assignment"); ;}
    break;

  case 39:
#line 146 "myparser.y"
    { yyerror("Do not support this statement"); yyclearin; yyerrok; ;}
    break;

  case 40:
#line 148 "myparser.y"
    { 
					IfStructure ifNode;
					ifNode.firstLabel = getNextLabel();
					ifNode.secondLabel = getNextLabel();
					ifNode.thirdLabel = getNextLabel();

					SymbolEntry *node = (yyvsp[(3) - (4)].entry);

					emit(NOLABEL, _CBR, node->regNum, ifNode.firstLabel, ifNode.secondLabel);
					emit(ifNode.firstLabel, NOP, EMPTY, EMPTY, EMPTY);
					(yyval.ifStructure) = &ifNode;
				;}
    break;

  case 42:
#line 162 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (4)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (4)].entry);
					if (node1 -> type == 0){
						// char
						emit(NOLABEL, _I2C, node2->regNum, node1->regNum, EMPTY);
					} else{
						// int
						if (node2 -> isImme) {
							emit(NOLABEL, _LOADI, node2->regNum, node1->regNum, EMPTY);
						}else {
							emit(NOLABEL, _I2I, node2->regNum, node1->regNum, EMPTY);
						}
					}
				;}
    break;

  case 47:
#line 181 "myparser.y"
    {
					SymbolEntry *node = (yyvsp[(2) - (3)].entry);
					if (node -> type == 0){
						// char
						emit(NOLABEL, _CWRITE, node->regNum, EMPTY, EMPTY);
					} else{
						// int
						emit(NOLABEL, _WRITE, node->regNum, EMPTY, EMPTY);
					}
				;}
    break;

  case 48:
#line 191 "myparser.y"
    { yyerror("Empty statement list is not allowed"); yyclearin; ;}
    break;

  case 49:
#line 192 "myparser.y"
    { yyerror("Empty statement in a list is not allowed"); yyclearin; ;}
    break;

  case 50:
#line 193 "myparser.y"
    { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; ;}
    break;

  case 51:
#line 194 "myparser.y"
    { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			;}
    break;

  case 52:
#line 196 "myparser.y"
    { yyerror("can not make an assignment to write"); yyclearin; ;}
    break;

  case 53:
#line 197 "myparser.y"
    { yyerror("No such reserved word"); yyclearin; ;}
    break;

  case 54:
#line 198 "myparser.y"
    { yyerror("Missing semicolon ';' after assignment"); ;}
    break;

  case 55:
#line 199 "myparser.y"
    { yyerror("Do not support this statement"); yyclearin; yyerrok; ;}
    break;

  case 56:
#line 201 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(2) - (2)].entry);
					emit(NOLABEL, _NOT, node1->regNum, tmpReg, EMPTY);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 57:
#line 210 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
			  	;}
    break;

  case 58:
#line 214 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					emit(NOLABEL, _OR, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 59:
#line 224 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
				;}
    break;

  case 60:
#line 228 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					emit(NOLABEL, _AND, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 61:
#line 238 "myparser.y"
    {
				  (yyval.entry) = (yyvsp[(1) - (1)].entry);
			  ;}
    break;

  case 62:
#line 242 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_LT, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 63:
#line 264 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_LE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
			;}
    break;

  case 64:
#line 286 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_EQ, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 65:
#line 308 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_NE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 66:
#line 330 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 
					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_GE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 67:
#line 351 "myparser.y"
    {
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_GT, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 68:
#line 373 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
				;}
    break;

  case 69:
#line 376 "myparser.y"
    { yyerror("Forgot an equal '=' in RelExprssion"); ;}
    break;

  case 70:
#line 378 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);

					// differentiate by immediate value or register
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum + node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						emit(NOLABEL, _ADDI, node2->regNum, node1->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _ADDI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _ADD, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 71:
#line 397 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);
					
					// 'a-1' use subI; '1-a' use sub (loadI first)
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum - node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
						node -> regNum = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, node->regNum, EMPTY);
						emit(NOLABEL, _SUB, node->regNum, node2->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _SUBI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _SUB, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 72:
#line 419 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
				;}
    break;

  case 73:
#line 423 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);

					// same as add
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum * node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						emit(NOLABEL, _MULTI, node2->regNum, node1->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _MULTI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _MULT, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 74:
#line 442 "myparser.y"
    {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (yyvsp[(1) - (3)].entry);
					SymbolEntry *node2 = (yyvsp[(3) - (3)].entry);

					// same as sub
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum / node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
						node -> regNum = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, node->regNum, EMPTY);
						emit(NOLABEL, _DIV, node->regNum, node2->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _DIVI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _DIV, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
				;}
    break;

  case 75:
#line 464 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
				;}
    break;

  case 77:
#line 469 "myparser.y"
    {
					(yyval.entry) = (yyvsp[(1) - (1)].entry);
				;}
    break;

  case 78:
#line 472 "myparser.y"
    {
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> isImme = 1;
					node -> regNum = (yyvsp[(1) - (1)].int_val);   // pseudo node
					(yyval.entry) = node;
				;}
    break;

  case 79:
#line 478 "myparser.y"
    {
				  	int tmpReg = getNextRegister();
					emit(NOLABEL, _LOADI, (yyvsp[(1) - (1)].char_val), tmpReg, EMPTY);
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					(yyval.entry) = node;
			  	;}
    break;

  case 80:
#line 486 "myparser.y"
    {
					SymbolEntry * node = lookupTable((yyvsp[(1) - (1)].string));
					if (node == NULL){
						yyerror("Variable has not beed declared\n");
					} else{
						(yyval.entry) = node;
					}
				;}
    break;


/* Line 1267 of yacc.c.  */
#line 2229 "myparser.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 500 "myparser.y"
                    
 /* C code */

