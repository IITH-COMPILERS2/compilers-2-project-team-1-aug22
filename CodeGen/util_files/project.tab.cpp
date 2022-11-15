/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "project.y"

	#include "../Semantics.hpp"
	#include "../AST.hpp"
    void yyerror(string s);
    int yylex();
    int yywrap();
	class Start *root = NULL;

#line 79 "util_files/project.tab.cpp"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_UTIL_FILES_PROJECT_TAB_HPP_INCLUDED
# define YY_YY_UTIL_FILES_PROJECT_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    STRING_LITERAL = 259,
    FRAC_CONST = 260,
    DOUBLE_CONST = 261,
    INT_CONST = 262,
    ARROW = 263,
    LE_OP = 264,
    GE_OP = 265,
    EQ_OP = 266,
    NE_OP = 267,
    POW_OP = 268,
    AND_OP = 269,
    OR_OP = 270,
    MUL_ASSIGN = 271,
    ADD_ASSIGN = 272,
    FUN_ST = 273,
    FUN_EN = 274,
    STRING = 275,
    INT = 276,
    LONG = 277,
    BOOL = 278,
    FRAC = 279,
    DOUBLE = 280,
    VOID = 281,
    EOL = 282,
    TRUE = 283,
    FALSE = 284,
    INPUT = 285,
    OUTPUT = 286,
    IF = 287,
    ELSE = 288,
    LOOP = 289,
    CONTINUE = 290,
    BREAK = 291,
    EXIT = 292,
    POINT = 293,
    LINE = 294,
    CONIC = 295,
    LINE_PAIR = 296,
    CIRCLE = 297,
    PARABOLA = 298,
    ELLIPSE = 299,
    HYPERBOLA = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "project.y"

	struct nd_info {
		struct var_name {
			char name[1000];
			struct node* nd;
			char type[1000];
		} sem_nd;
		class Node* cg_nd;
	} obj;

#line 188 "util_files/project.tab.cpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_UTIL_FILES_PROJECT_TAB_HPP_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

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
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
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
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
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
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   423

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  59
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  52
/* YYNRULES -- Number of rules.  */
#define YYNRULES  127
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  198

#define YYUNDEFTOK  2
#define YYMAXUTOK   300


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    49,     2,     2,     2,    56,     2,     2,
      57,    58,    54,    47,    51,    48,     2,    55,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    50,     2,
      52,    46,    53,     2,     2,     2,     2,     2,     2,     2,
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
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    53,    53,    53,    61,    71,    72,    78,    86,    86,
      86,    93,    94,    98,    99,   103,   109,   119,   120,   121,
     122,   123,   124,   125,   126,   127,   128,   129,   130,   131,
     132,   133,   137,   138,   142,   143,   147,   165,   166,   170,
     171,   175,   176,   191,   192,   193,   197,   201,   202,   215,
     216,   229,   230,   240,   253,   254,   264,   274,   284,   297,
     298,   309,   322,   323,   333,   343,   356,   357,   361,   362,
     366,   367,   368,   372,   373,   374,   378,   388,   389,   390,
     391,   392,   396,   397,   401,   402,   406,   407,   408,   409,
     410,   411,   412,   421,   422,   426,   427,   431,   432,   436,
     437,   442,   446,   447,   451,   455,   455,   460,   460,   463,
     464,   465,   466,   470,   470,   471,   471,   475,   479,   483,
     487,   491,   492,   493,   497,   498,   507,   507
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IDENTIFIER", "STRING_LITERAL",
  "FRAC_CONST", "DOUBLE_CONST", "INT_CONST", "ARROW", "LE_OP", "GE_OP",
  "EQ_OP", "NE_OP", "POW_OP", "AND_OP", "OR_OP", "MUL_ASSIGN",
  "ADD_ASSIGN", "FUN_ST", "FUN_EN", "STRING", "INT", "LONG", "BOOL",
  "FRAC", "DOUBLE", "VOID", "EOL", "TRUE", "FALSE", "INPUT", "OUTPUT",
  "IF", "ELSE", "LOOP", "CONTINUE", "BREAK", "EXIT", "POINT", "LINE",
  "CONIC", "LINE_PAIR", "CIRCLE", "PARABOLA", "ELLIPSE", "HYPERBOLA",
  "'='", "'+'", "'-'", "'!'", "':'", "','", "'<'", "'>'", "'*'", "'/'",
  "'%'", "'('", "')'", "$accept", "translation_unit", "$@1",
  "external_declaration", "function_definition", "$@2", "$@3", "error_fun",
  "parameter_list", "parameters", "type_specifier", "in_out_specifier",
  "compound_statement", "temp_fun", "expression_statement", "expression",
  "assignment_expression", "assignment_operator", "conditional_expression",
  "logical_or_expression", "logical_and_expression", "equality_expression",
  "relational_expression", "additive_expression",
  "multiplicative_expression", "cast_expression", "unary_expression",
  "unary_operator", "postfix_expression", "primary_expression",
  "argument_expression_list", "statement_list", "statement", "declaration",
  "mulendoflines", "init_declarator_list", "init_declarator",
  "initializer_list", "declarator", "direct_declarator", "$@4", "$@5",
  "identifier_list", "$@6", "$@7", "initializer", "selection_statement",
  "iteration_statement", "jump_statement", "exit", "in_out_statement",
  "$@8", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,    61,    43,    45,    33,
      58,    44,    60,    62,    42,    47,    37,    40,    41
};
# endif

#define YYPACT_NINF (-141)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-12)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
    -141,   325,   378,  -141,  -141,  -141,  -141,  -141,  -141,  -141,
    -141,  -141,  -141,  -141,  -141,  -141,  -141,  -141,  -141,  -141,
    -141,  -141,  -141,   266,  -141,   -16,  -141,     5,  -141,   317,
    -141,   274,    -8,  -141,   -19,   -11,  -141,   214,    61,  -141,
      16,  -141,    -7,  -141,   317,    34,    34,     4,    39,    91,
     370,  -141,  -141,  -141,  -141,  -141,  -141,  -141,  -141,  -141,
    -141,  -141,   223,  -141,  -141,    82,    85,    73,     0,    45,
      47,  -141,    -4,    34,    53,  -141,  -141,    64,  -141,  -141,
    -141,    58,   -33,   214,  -141,  -141,   214,    59,   -28,  -141,
      34,    34,    34,    34,    34,    34,    34,    34,    34,    34,
      34,    34,    34,  -141,  -141,  -141,    34,  -141,  -141,    29,
      34,  -141,  -141,   117,  -141,   118,  -141,    34,    34,  -141,
      85,    73,     0,     0,    45,    45,    45,    45,    47,    47,
    -141,  -141,  -141,  -141,  -141,  -141,    21,  -141,  -141,  -141,
      95,  -141,  -141,    34,  -141,  -141,   105,  -141,   106,  -141,
    -141,   176,  -141,  -141,  -141,    71,    72,   103,   110,    -1,
    -141,  -141,  -141,    -6,   129,  -141,  -141,  -141,  -141,  -141,
    -141,    34,    34,  -141,  -141,  -141,    34,  -141,    88,  -141,
    -141,  -141,    37,    38,    -3,    34,   112,   114,  -141,    64,
     105,   105,   116,  -141,   111,   119,   105,  -141
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     1,     8,    19,    20,    21,    18,    23,
      22,    17,    95,    24,    30,    29,    31,    28,    25,    26,
      27,     4,     6,     0,     7,     5,     3,    13,   105,     0,
     107,     0,     0,    97,    99,   104,    96,     0,     0,   106,
       0,   108,     0,    93,     0,     0,     0,     0,    14,     0,
       0,   109,    94,    98,    76,    80,    78,    79,    77,    70,
      71,    72,     0,   117,    41,    46,    47,    49,    51,    54,
      59,    62,    66,     0,    68,    73,   100,   101,   102,   113,
     112,     0,     0,     0,    15,    12,     0,     0,     0,    39,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    44,    45,    43,     0,    69,    66,     0,
       0,   114,   110,     0,   111,     0,     9,     0,     0,    81,
      48,    50,    52,    53,    57,    58,    55,    56,    60,    61,
      63,    64,    65,    42,    74,    82,     0,   103,   115,    16,
       0,    67,    40,     0,    75,   116,     0,    83,    36,    10,
      34,     0,    37,    32,    33,     0,     0,     0,     0,     0,
     126,    87,    88,     0,     0,    84,    86,    89,    90,    91,
      92,     0,     0,   121,   122,   124,     0,   123,     0,    38,
      35,    85,     0,     0,     0,     0,     0,     0,   125,   127,
       0,     0,   119,   120,     0,     0,     0,   118
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -141,  -141,  -141,   143,  -141,  -141,  -141,  -141,   115,  -141,
     -15,  -141,  -140,  -141,  -141,   -58,   -43,  -141,  -141,  -141,
      67,    84,    12,   -37,    13,     7,   -45,  -141,  -141,  -141,
    -141,  -141,    20,  -136,   135,   154,   144,     2,   160,  -141,
    -141,  -141,  -141,  -141,  -141,   -40,  -141,  -141,  -141,  -141,
    -141,  -141
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     2,    21,    22,    27,   140,    86,    38,    48,
      23,   160,   161,   151,   162,   163,    89,   106,    64,    65,
      66,    67,    68,    69,    70,    71,   108,    73,    74,    75,
     136,   164,   165,    24,    25,    32,    33,    77,    34,    35,
      39,    41,    82,   111,   145,    78,   167,   168,   169,   177,
     170,   178
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      72,    72,    63,    63,    88,    76,   149,    79,    30,    94,
      95,    36,   103,   104,    30,   166,    30,    72,   113,    43,
      52,   179,    49,   118,   188,   114,   175,    45,   166,    30,
     119,    46,    54,    55,    56,    57,    58,    54,    55,    56,
      57,    58,   105,    44,    44,   118,    47,    87,   118,   176,
     192,   193,    96,    97,    37,    37,   197,   124,   125,   126,
     127,    72,    80,   133,    72,    72,   135,    63,   115,    50,
     137,   116,   143,    72,    51,   142,    59,    60,    61,   144,
     107,    59,    60,    61,    92,    93,    62,   134,   118,   118,
      83,    62,    98,    99,    84,   186,   187,    90,    72,    91,
     147,   100,   101,   102,   122,   123,    72,   130,   131,   132,
     109,   128,   129,   182,   183,   110,   112,   117,   184,    72,
     138,   139,   146,   148,   141,   150,    72,    72,   171,   172,
     173,    72,    54,    55,    56,    57,    58,   174,   185,   190,
      72,   191,    63,   194,   195,    26,   196,   148,   180,     5,
       6,     7,     8,     9,    10,    11,   152,   120,    31,   153,
     154,   155,    81,   156,   157,   158,   159,    13,    14,    15,
      16,    17,    18,    19,    20,   121,    59,    60,    61,    54,
      55,    56,    57,    58,   181,    42,    62,   189,    53,    40,
       0,     0,     0,     0,   148,     0,     5,     6,     7,     8,
       9,    10,    11,   152,     0,     0,   153,   154,   155,     0,
     156,   157,   158,   159,    13,    14,    15,    16,    17,    18,
      19,    20,     0,    59,    60,    61,    54,    55,    56,    57,
      58,     0,     0,    62,     5,     6,     7,     8,     9,    10,
      11,     0,     0,     5,     6,     7,     8,     9,    10,    11,
       0,     0,    13,    14,    15,    16,    17,    18,    19,    20,
       0,    13,    14,    15,    16,    17,    18,    19,    20,    28,
      59,    60,    61,     0,     0,     0,     0,    28,     0,     0,
      62,     0,     0,     0,     0,     0,     5,     6,     7,     8,
       9,    10,    11,    12,     5,     6,     7,     8,     9,    10,
      11,    36,     0,     0,    13,    14,    15,    16,    17,    18,
      19,    20,    13,    14,    15,    16,    17,    18,    19,    20,
      28,     0,     0,    29,     0,     3,     0,     0,     4,     0,
       0,    29,     0,     0,     0,     0,     0,     5,     6,     7,
       8,     9,    10,    11,     0,     5,     6,     7,     8,     9,
      10,    11,    12,     0,     0,    13,    14,    15,    16,    17,
      18,    19,    20,    13,    14,    15,    16,    17,    18,    19,
      20,    85,     0,     0,    29,     0,     0,     0,     0,     0,
       0,     4,     0,     0,     0,     0,     0,     0,     0,     0,
     -11,   -11,   -11,   -11,   -11,   -11,   -11,     0,     5,     6,
       7,     8,     9,    10,    11,    12,     0,     0,   -11,   -11,
     -11,   -11,   -11,   -11,   -11,   -11,    13,    14,    15,    16,
      17,    18,    19,    20
};

static const yytype_int16 yycheck[] =
{
      45,    46,    45,    46,    62,    45,   146,     3,    23,     9,
      10,    27,    16,    17,    29,   151,    31,    62,    51,    27,
      27,    27,    37,    51,    27,    58,    27,    46,   164,    44,
      58,    50,     3,     4,     5,     6,     7,     3,     4,     5,
       6,     7,    46,    51,    51,    51,    57,    62,    51,    50,
     190,   191,    52,    53,    50,    50,   196,    94,    95,    96,
      97,   106,    58,   106,   109,   110,   109,   110,    83,     8,
     110,    86,    51,   118,    58,   118,    47,    48,    49,    58,
      73,    47,    48,    49,    11,    12,    57,    58,    51,    51,
      51,    57,    47,    48,     3,    58,    58,    15,   143,    14,
     143,    54,    55,    56,    92,    93,   151,   100,   101,   102,
      57,    98,    99,   171,   172,    51,    58,    58,   176,   164,
       3,     3,    27,    18,   117,    19,   171,   172,    57,    57,
      27,   176,     3,     4,     5,     6,     7,    27,    50,    27,
     185,    27,   185,    27,    33,     2,    27,    18,    19,    20,
      21,    22,    23,    24,    25,    26,    27,    90,    23,    30,
      31,    32,    47,    34,    35,    36,    37,    38,    39,    40,
      41,    42,    43,    44,    45,    91,    47,    48,    49,     3,
       4,     5,     6,     7,   164,    31,    57,   185,    44,    29,
      -1,    -1,    -1,    -1,    18,    -1,    20,    21,    22,    23,
      24,    25,    26,    27,    -1,    -1,    30,    31,    32,    -1,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      44,    45,    -1,    47,    48,    49,     3,     4,     5,     6,
       7,    -1,    -1,    57,    20,    21,    22,    23,    24,    25,
      26,    -1,    -1,    20,    21,    22,    23,    24,    25,    26,
      -1,    -1,    38,    39,    40,    41,    42,    43,    44,    45,
      -1,    38,    39,    40,    41,    42,    43,    44,    45,     3,
      47,    48,    49,    -1,    -1,    -1,    -1,     3,    -1,    -1,
      57,    -1,    -1,    -1,    -1,    -1,    20,    21,    22,    23,
      24,    25,    26,    27,    20,    21,    22,    23,    24,    25,
      26,    27,    -1,    -1,    38,    39,    40,    41,    42,    43,
      44,    45,    38,    39,    40,    41,    42,    43,    44,    45,
       3,    -1,    -1,    57,    -1,     0,    -1,    -1,     3,    -1,
      -1,    57,    -1,    -1,    -1,    -1,    -1,    20,    21,    22,
      23,    24,    25,    26,    -1,    20,    21,    22,    23,    24,
      25,    26,    27,    -1,    -1,    38,    39,    40,    41,    42,
      43,    44,    45,    38,    39,    40,    41,    42,    43,    44,
      45,     1,    -1,    -1,    57,    -1,    -1,    -1,    -1,    -1,
      -1,     3,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      20,    21,    22,    23,    24,    25,    26,    -1,    20,    21,
      22,    23,    24,    25,    26,    27,    -1,    -1,    38,    39,
      40,    41,    42,    43,    44,    45,    38,    39,    40,    41,
      42,    43,    44,    45
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    60,    61,     0,     3,    20,    21,    22,    23,    24,
      25,    26,    27,    38,    39,    40,    41,    42,    43,    44,
      45,    62,    63,    69,    92,    93,    62,    64,     3,    57,
      69,    93,    94,    95,    97,    98,    27,    50,    67,    99,
      97,   100,    94,    27,    51,    46,    50,    57,    68,    69,
       8,    58,    27,    95,     3,     4,     5,     6,     7,    47,
      48,    49,    57,    75,    77,    78,    79,    80,    81,    82,
      83,    84,    85,    86,    87,    88,   104,    96,   104,     3,
      58,    67,   101,    51,     3,     1,    66,    69,    74,    75,
      15,    14,    11,    12,     9,    10,    52,    53,    47,    48,
      54,    55,    56,    16,    17,    46,    76,    84,    85,    57,
      51,   102,    58,    51,    58,    69,    69,    58,    51,    58,
      79,    80,    81,    81,    82,    82,    82,    82,    83,    83,
      84,    84,    84,    75,    58,    75,    89,   104,     3,     3,
      65,    84,    75,    51,    58,   103,    27,    75,    18,    71,
      19,    72,    27,    30,    31,    32,    34,    35,    36,    37,
      70,    71,    73,    74,    90,    91,    92,   105,   106,   107,
     109,    57,    57,    27,    27,    27,    50,   108,   110,    27,
      19,    91,    74,    74,    74,    50,    58,    58,    27,    96,
      27,    27,    71,    71,    27,    33,    27,    71
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    59,    61,    60,    60,    62,    62,    62,    64,    65,
      63,    66,    66,    67,    67,    68,    68,    69,    69,    69,
      69,    69,    69,    69,    69,    69,    69,    69,    69,    69,
      69,    69,    70,    70,    71,    71,    72,    73,    73,    74,
      74,    75,    75,    76,    76,    76,    77,    78,    78,    79,
      79,    80,    80,    80,    81,    81,    81,    81,    81,    82,
      82,    82,    83,    83,    83,    83,    84,    84,    85,    85,
      86,    86,    86,    87,    87,    87,    88,    88,    88,    88,
      88,    88,    89,    89,    90,    90,    91,    91,    91,    91,
      91,    91,    91,    92,    92,    93,    93,    94,    94,    95,
      95,    95,    96,    96,    97,    99,    98,   100,    98,    98,
      98,    98,    98,   102,   101,   103,   101,   104,   105,   105,
     106,   107,   107,   107,   108,   108,   110,   109
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     2,     1,     1,     1,     0,     0,
       9,     0,     1,     0,     2,     2,     4,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     2,     4,     0,     1,     2,     1,
       3,     1,     3,     1,     1,     1,     1,     1,     3,     1,
       3,     1,     3,     3,     1,     3,     3,     3,     3,     1,
       3,     3,     1,     3,     3,     3,     1,     4,     1,     2,
       1,     1,     1,     1,     3,     4,     1,     1,     1,     1,
       1,     3,     1,     3,     1,     2,     1,     1,     1,     1,
       1,     1,     1,     3,     4,     1,     2,     1,     3,     1,
       3,     3,     1,     3,     1,     0,     2,     0,     2,     3,
       4,     4,     3,     0,     2,     0,     4,     1,    10,     6,
       6,     2,     2,     2,     1,     3,     0,     4
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

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
#ifndef YYINITDEPTH
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
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
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
static char *
yystpcpy (char *yydest, const char *yysrc)
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
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
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
            else
              goto append;

          append:
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

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
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
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
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
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 53 "project.y"
          { enter_scope(); }
#line 1568 "util_files/project.tab.cpp"
    break;

  case 3:
#line 54 "project.y"
        { 	
		(yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[0].obj).sem_nd.nd, "TRANSLATION_UNIT"); head = (yyval.obj).sem_nd.nd;
		root = new Start((yyvsp[0].obj).cg_nd);
		(yyval.obj).cg_nd = new Node;
		(yyval.obj).cg_nd->start = root;
		root->traverse();
	}
#line 1580 "util_files/project.tab.cpp"
    break;

  case 4:
#line 62 "project.y"
        { 
		(yyvsp[0].obj).sem_nd.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "TRANSLATION_UNIT"); head = (yyval.obj).sem_nd.nd;
		root = new Start((yyvsp[0].obj).cg_nd);
		(yyval.obj).cg_nd = new Node;
		(yyval.obj).cg_nd->start = root;
	}
#line 1591 "util_files/project.tab.cpp"
    break;

  case 6:
#line 73 "project.y"
        { 
		(yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[0].obj).sem_nd.nd, "EXTERNAL_DECLR"); 
		(yyval.obj).cg_nd = new Node;
		(yyval.obj).cg_nd->func_def = new Function_Def();
	}
#line 1601 "util_files/project.tab.cpp"
    break;

  case 7:
#line 79 "project.y"
        {
		(yyval.obj).cg_nd = new Node;
		(yyval.obj).cg_nd->decl = new Declaration();
	}
#line 1610 "util_files/project.tab.cpp"
    break;

  case 8:
#line 86 "project.y"
                 { function_name = yytext; is_function_now = true; }
#line 1616 "util_files/project.tab.cpp"
    break;

  case 9:
#line 86 "project.y"
                                                                                                                   { ret_type = yytext; add('F'); }
#line 1622 "util_files/project.tab.cpp"
    break;

  case 10:
#line 86 "project.y"
                                                                                                                                                                           { 
		struct node* tp = mknode((yyvsp[-6].obj).sem_nd.nd, (yyvsp[-3].obj).sem_nd.nd, "OPTIONS");
		(yyval.obj).sem_nd.nd = mknode(tp, (yyvsp[0].obj).sem_nd.nd, (yyvsp[-8].obj).sem_nd.name);
	}
#line 1631 "util_files/project.tab.cpp"
    break;

  case 13:
#line 98 "project.y"
                 {}
#line 1637 "util_files/project.tab.cpp"
    break;

  case 14:
#line 99 "project.y"
                         { (yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[0].obj).sem_nd.nd, "PARAMS_LIST"); }
#line 1643 "util_files/project.tab.cpp"
    break;

  case 15:
#line 103 "project.y"
                                    {
			struct node* tp = mknode(NULL, NULL, (yyvsp[0].obj).sem_nd.name);
			(yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, tp, "PARAMS");
			function_params.push_back((yyvsp[-1].obj).sem_nd.name);
			param_id.push_back({(yyvsp[-1].obj).sem_nd.name, (yyvsp[0].obj).sem_nd.name});
		}
#line 1654 "util_files/project.tab.cpp"
    break;

  case 16:
#line 109 "project.y"
                                                   {
			struct node* tp = mknode(NULL, NULL, (yyvsp[0].obj).sem_nd.name);
			struct node* tp2 = mknode((yyvsp[-1].obj).sem_nd.nd, tp, "VARIABLES");
			(yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, tp2, "PARAMS");
			function_params.push_back((yyvsp[-1].obj).sem_nd.name);
			param_id.push_back({(yyvsp[-1].obj).sem_nd.name, (yyvsp[0].obj).sem_nd.name});
		}
#line 1666 "util_files/project.tab.cpp"
    break;

  case 17:
#line 119 "project.y"
                        { insert_type(); }
#line 1672 "util_files/project.tab.cpp"
    break;

  case 18:
#line 120 "project.y"
                        { insert_type(); }
#line 1678 "util_files/project.tab.cpp"
    break;

  case 19:
#line 121 "project.y"
                        { insert_type(); }
#line 1684 "util_files/project.tab.cpp"
    break;

  case 20:
#line 122 "project.y"
                        { insert_type(); }
#line 1690 "util_files/project.tab.cpp"
    break;

  case 21:
#line 123 "project.y"
                        { insert_type(); }
#line 1696 "util_files/project.tab.cpp"
    break;

  case 22:
#line 124 "project.y"
                        { insert_type(); }
#line 1702 "util_files/project.tab.cpp"
    break;

  case 23:
#line 125 "project.y"
                        { insert_type(); }
#line 1708 "util_files/project.tab.cpp"
    break;

  case 24:
#line 126 "project.y"
                        { insert_type(); }
#line 1714 "util_files/project.tab.cpp"
    break;

  case 25:
#line 127 "project.y"
                        { insert_type(); }
#line 1720 "util_files/project.tab.cpp"
    break;

  case 26:
#line 128 "project.y"
                        { insert_type(); }
#line 1726 "util_files/project.tab.cpp"
    break;

  case 27:
#line 129 "project.y"
                        { insert_type(); }
#line 1732 "util_files/project.tab.cpp"
    break;

  case 28:
#line 130 "project.y"
                        { insert_type(); }
#line 1738 "util_files/project.tab.cpp"
    break;

  case 29:
#line 131 "project.y"
                        { insert_type(); }
#line 1744 "util_files/project.tab.cpp"
    break;

  case 30:
#line 132 "project.y"
                        { insert_type(); }
#line 1750 "util_files/project.tab.cpp"
    break;

  case 31:
#line 133 "project.y"
                        { insert_type(); }
#line 1756 "util_files/project.tab.cpp"
    break;

  case 32:
#line 137 "project.y"
                        { insert_type(); }
#line 1762 "util_files/project.tab.cpp"
    break;

  case 33:
#line 138 "project.y"
                        { insert_type(); }
#line 1768 "util_files/project.tab.cpp"
    break;

  case 34:
#line 142 "project.y"
                                                                                {(yyval.obj).sem_nd.nd = mknode(NULL, NULL, "COMPOUND_STATEMENT"); }
#line 1774 "util_files/project.tab.cpp"
    break;

  case 35:
#line 143 "project.y"
                                                                        {(yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[-1].obj).sem_nd.nd, "COMPOUND_STATEMENT"); exit_scope(); }
#line 1780 "util_files/project.tab.cpp"
    break;

  case 36:
#line 147 "project.y"
                  {
		if(is_function_now){
			symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[function_name]]->params = function_params;
		}
		enter_scope(); 
		if(is_function_now){
			for(auto i : param_id) {
				add_params(i.first, i.second);
			}
			symbol_table.back()->fun_ret_type = ret_type;
			function_params.clear();
			param_id.clear();
			is_function_now = false;
		}
	}
#line 1800 "util_files/project.tab.cpp"
    break;

  case 38:
#line 166 "project.y"
                                {(yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, NULL, "EXPR_ST"); }
#line 1806 "util_files/project.tab.cpp"
    break;

  case 39:
#line 170 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 1812 "util_files/project.tab.cpp"
    break;

  case 40:
#line 171 "project.y"
                                               { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 1818 "util_files/project.tab.cpp"
    break;

  case 41:
#line 175 "project.y"
                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "ASS_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 1824 "util_files/project.tab.cpp"
    break;

  case 42:
#line 176 "project.y"
                                                                     { 
			struct node* tp = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "UN_ASSGN");
			(yyval.obj).sem_nd.nd = mknode(tp, (yyvsp[0].obj).sem_nd.nd, "ASS_EXPR");
			if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
				if(/*print("1") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
					strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
				}
				else{
					strcpy((yyval.obj).sem_nd.type, "undefined");
				}
			}
		}
#line 1841 "util_files/project.tab.cpp"
    break;

  case 46:
#line 197 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "COND_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1847 "util_files/project.tab.cpp"
    break;

  case 47:
#line 201 "project.y"
                                 { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "LOGI_OR_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1853 "util_files/project.tab.cpp"
    break;

  case 48:
#line 202 "project.y"
                                                             { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "OR"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("2") && */check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1868 "util_files/project.tab.cpp"
    break;

  case 49:
#line 215 "project.y"
                              { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "LOGI_AND_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1874 "util_files/project.tab.cpp"
    break;

  case 50:
#line 216 "project.y"
                                                            { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "AND"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("3") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1889 "util_files/project.tab.cpp"
    break;

  case 51:
#line 229 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "EQ_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1895 "util_files/project.tab.cpp"
    break;

  case 52:
#line 230 "project.y"
                                                          { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "=="); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("4") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1910 "util_files/project.tab.cpp"
    break;

  case 53:
#line 240 "project.y"
                                                          { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "!="); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("5") && */check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1925 "util_files/project.tab.cpp"
    break;

  case 54:
#line 253 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "RELATIONAL_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1931 "util_files/project.tab.cpp"
    break;

  case 55:
#line 254 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "<"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("6") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1946 "util_files/project.tab.cpp"
    break;

  case 56:
#line 264 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, ">"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("7") && */check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1961 "util_files/project.tab.cpp"
    break;

  case 57:
#line 274 "project.y"
                                                          { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "<="); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("8") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1976 "util_files/project.tab.cpp"
    break;

  case 58:
#line 284 "project.y"
                                                          { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, ">="); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("9") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 1991 "util_files/project.tab.cpp"
    break;

  case 59:
#line 297 "project.y"
                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "ADDITIVE_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 1997 "util_files/project.tab.cpp"
    break;

  case 60:
#line 298 "project.y"
                                                            { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "+"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			//print(to_string(check_types($1.sem_nd.type, $3.sem_nd.type)));
			if(/*print("10") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 2013 "util_files/project.tab.cpp"
    break;

  case 61:
#line 309 "project.y"
                                                            { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "-"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("11") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 2028 "util_files/project.tab.cpp"
    break;

  case 62:
#line 322 "project.y"
                          { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "MUL_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 2034 "util_files/project.tab.cpp"
    break;

  case 63:
#line 323 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "*"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("12") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 2049 "util_files/project.tab.cpp"
    break;

  case 64:
#line 333 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "/"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("13") &&*/ check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 2064 "util_files/project.tab.cpp"
    break;

  case 65:
#line 343 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "%"); 
		if(strcmp((yyvsp[-2].obj).sem_nd.type, "undefined") !=0 && strcmp((yyvsp[0].obj).sem_nd.type, "undefined") !=0){
			if(/*print("14") && */check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); 
			}
			else{
				strcpy((yyval.obj).sem_nd.type, "undefined");
			}
		}
	}
#line 2079 "util_files/project.tab.cpp"
    break;

  case 66:
#line 356 "project.y"
                           { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "CAST_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 2085 "util_files/project.tab.cpp"
    break;

  case 67:
#line 357 "project.y"
                                                 { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "CAST_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.name); }
#line 2091 "util_files/project.tab.cpp"
    break;

  case 68:
#line 361 "project.y"
                             { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "UNARY_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 2097 "util_files/project.tab.cpp"
    break;

  case 69:
#line 362 "project.y"
                                         { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "UNARY_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 2103 "util_files/project.tab.cpp"
    break;

  case 73:
#line 372 "project.y"
                             { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "POSTFIX_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);  }
#line 2109 "util_files/project.tab.cpp"
    break;

  case 74:
#line 373 "project.y"
                                     { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, NULL, "POSTFIX_EXPR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type);  }
#line 2115 "util_files/project.tab.cpp"
    break;

  case 75:
#line 374 "project.y"
                                                              { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "POSTFIX_EXPR"); /*strcpy($$.sem_nd.type, $1.sem_nd.type);  */ }
#line 2121 "util_files/project.tab.cpp"
    break;

  case 76:
#line 378 "project.y"
                                 { check_declarations((yyvsp[0].obj).sem_nd.name); (yyval.obj).sem_nd.nd = mknode(NULL, NULL, (yyvsp[0].obj).sem_nd.name);
		if(!search((yyvsp[0].obj).sem_nd.name)){
			strcpy((yyval.obj).sem_nd.type, "undefined");
		}
		else{
			string a = symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[(yyvsp[0].obj).sem_nd.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy((yyval.obj).sem_nd.type, c); 
		}
		}
#line 2136 "util_files/project.tab.cpp"
    break;

  case 77:
#line 388 "project.y"
                                         { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, "INT_CONST"); strcpy((yyval.obj).sem_nd.type, "int"); /*print($$.sem_nd.type);*/ }
#line 2142 "util_files/project.tab.cpp"
    break;

  case 78:
#line 389 "project.y"
                                 { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, (yyvsp[0].obj).sem_nd.name); strcpy((yyval.obj).sem_nd.type, "frac"); }
#line 2148 "util_files/project.tab.cpp"
    break;

  case 79:
#line 390 "project.y"
                                 { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, "DOUBLE_CONST"); strcpy((yyval.obj).sem_nd.type, "double"); }
#line 2154 "util_files/project.tab.cpp"
    break;

  case 80:
#line 391 "project.y"
                                 { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, (yyvsp[0].obj).sem_nd.name); strcpy((yyval.obj).sem_nd.type, "string_literal"); }
#line 2160 "util_files/project.tab.cpp"
    break;

  case 81:
#line 392 "project.y"
                             { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, NULL, "PRIM_EXPR"); }
#line 2166 "util_files/project.tab.cpp"
    break;

  case 82:
#line 396 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "ARGU_EXPR_LIST"); }
#line 2172 "util_files/project.tab.cpp"
    break;

  case 83:
#line 397 "project.y"
                                                             { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "ARGU_EXPR_LIST"); }
#line 2178 "util_files/project.tab.cpp"
    break;

  case 84:
#line 401 "project.y"
                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT_LIST"); }
#line 2184 "util_files/project.tab.cpp"
    break;

  case 85:
#line 402 "project.y"
                                   { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "STAT_LIST"); }
#line 2190 "util_files/project.tab.cpp"
    break;

  case 86:
#line 406 "project.y"
                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2196 "util_files/project.tab.cpp"
    break;

  case 87:
#line 407 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2202 "util_files/project.tab.cpp"
    break;

  case 88:
#line 408 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2208 "util_files/project.tab.cpp"
    break;

  case 89:
#line 409 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2214 "util_files/project.tab.cpp"
    break;

  case 90:
#line 410 "project.y"
                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2220 "util_files/project.tab.cpp"
    break;

  case 91:
#line 411 "project.y"
                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2226 "util_files/project.tab.cpp"
    break;

  case 92:
#line 412 "project.y"
                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "STAT"); }
#line 2232 "util_files/project.tab.cpp"
    break;

  case 93:
#line 421 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "DECLR"); }
#line 2238 "util_files/project.tab.cpp"
    break;

  case 94:
#line 422 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "DECLR"); }
#line 2244 "util_files/project.tab.cpp"
    break;

  case 96:
#line 427 "project.y"
                            { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, NULL, "MUL_END_OF_LINES"); }
#line 2250 "util_files/project.tab.cpp"
    break;

  case 97:
#line 431 "project.y"
                                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "INIT_DECLR_LIST"); }
#line 2256 "util_files/project.tab.cpp"
    break;

  case 98:
#line 432 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "INIT_DECLR_LIST"); }
#line 2262 "util_files/project.tab.cpp"
    break;

  case 99:
#line 436 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "INIT_DECLR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 2268 "util_files/project.tab.cpp"
    break;

  case 100:
#line 437 "project.y"
                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "INIT_DECLR"); 
			if(/*print("14") && */check_types((yyvsp[-2].obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type) == 0){
				strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type);
			}
		}
#line 2278 "util_files/project.tab.cpp"
    break;

  case 101:
#line 442 "project.y"
                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "INIT_DECLR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[-2].obj).sem_nd.type); }
#line 2284 "util_files/project.tab.cpp"
    break;

  case 102:
#line 446 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "INIT_LIST"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);}
#line 2290 "util_files/project.tab.cpp"
    break;

  case 103:
#line 447 "project.y"
                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "INIT_LIST"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type);}
#line 2296 "util_files/project.tab.cpp"
    break;

  case 104:
#line 451 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "DECLR"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 2302 "util_files/project.tab.cpp"
    break;

  case 105:
#line 455 "project.y"
                        { add('V'); }
#line 2308 "util_files/project.tab.cpp"
    break;

  case 106:
#line 455 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, (yyvsp[-1].obj).sem_nd.name); 
			string a = symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[(yyvsp[-1].obj).sem_nd.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy((yyval.obj).sem_nd.type, c);
		}
#line 2318 "util_files/project.tab.cpp"
    break;

  case 107:
#line 460 "project.y"
                         {  add('V'); }
#line 2324 "util_files/project.tab.cpp"
    break;

  case 108:
#line 460 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, NULL, "DIRECT_DECLR"); 
			strcpy((yyval.obj).sem_nd.type, (yyvsp[-1].obj).sem_nd.name); 
		}
#line 2332 "util_files/project.tab.cpp"
    break;

  case 109:
#line 463 "project.y"
                                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-1].obj).sem_nd.nd, NULL, "DIRECT_DECLR"); }
#line 2338 "util_files/project.tab.cpp"
    break;

  case 110:
#line 464 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "DIRECT_DECLR"); }
#line 2344 "util_files/project.tab.cpp"
    break;

  case 111:
#line 465 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[-1].obj).sem_nd.nd, "DIRECT_DECLR"); }
#line 2350 "util_files/project.tab.cpp"
    break;

  case 112:
#line 466 "project.y"
                                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-2].obj).sem_nd.nd, NULL, "DIRECT_DECLR"); }
#line 2356 "util_files/project.tab.cpp"
    break;

  case 113:
#line 470 "project.y"
                        { add('V'); }
#line 2362 "util_files/project.tab.cpp"
    break;

  case 114:
#line 470 "project.y"
                                                                                { (yyval.obj).sem_nd.nd = mknode(NULL, NULL, (yyvsp[-1].obj).sem_nd.name); }
#line 2368 "util_files/project.tab.cpp"
    break;

  case 115:
#line 471 "project.y"
                                                { add('V'); }
#line 2374 "util_files/project.tab.cpp"
    break;

  case 116:
#line 471 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, NULL, "IDEN_LIST"); }
#line 2380 "util_files/project.tab.cpp"
    break;

  case 117:
#line 475 "project.y"
                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[0].obj).sem_nd.nd, NULL, "INITIALIZER"); strcpy((yyval.obj).sem_nd.type, (yyvsp[0].obj).sem_nd.type); }
#line 2386 "util_files/project.tab.cpp"
    break;

  case 118:
#line 479 "project.y"
                                                                                        { 
		struct node* tp = mknode((yyvsp[-7].obj).sem_nd.nd, (yyvsp[-4].obj).sem_nd.nd, "IF_STAT");
			(yyval.obj).sem_nd.nd = mknode(tp, (yyvsp[0].obj).sem_nd.nd, "IF_ELSE_STAT"); 
		}
#line 2395 "util_files/project.tab.cpp"
    break;

  case 119:
#line 483 "project.y"
                                                                                        { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "SELECT_STAT"); }
#line 2401 "util_files/project.tab.cpp"
    break;

  case 120:
#line 487 "project.y"
                                                                { (yyval.obj).sem_nd.nd = mknode((yyvsp[-3].obj).sem_nd.nd, (yyvsp[0].obj).sem_nd.nd, "ITER_STAT"); }
#line 2407 "util_files/project.tab.cpp"
    break;

  case 123:
#line 493 "project.y"
                    { (yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[0].obj).sem_nd.nd, "EXIT_EXPR"); }
#line 2413 "util_files/project.tab.cpp"
    break;

  case 125:
#line 498 "project.y"
                             { 
		(yyval.obj).sem_nd.nd = mknode(NULL, (yyvsp[-1].obj).sem_nd.nd, "EXIT"); 
		string a = symbol_table.back()->fun_ret_type; 
		char* c = const_cast<char*>(a.c_str());
		check_return_types((yyvsp[-1].obj).sem_nd.type, c);
	}
#line 2424 "util_files/project.tab.cpp"
    break;

  case 126:
#line 507 "project.y"
                           { add('F'); }
#line 2430 "util_files/project.tab.cpp"
    break;


#line 2434 "util_files/project.tab.cpp"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
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

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
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
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
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

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


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


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
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
  return yyresult;
}
#line 509 "project.y"


int main(int argc, char* argv[]) 
{
	yyparse();
	SymbolTableGenerator();
	SemanticErrors();
	printtree(head);
	// if(root){
	// 	cout << "hai\n";
	// 	root->traverse();
	// }
}
