/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

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

#line 114 "util_files/project.tab.hpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_UTIL_FILES_PROJECT_TAB_HPP_INCLUDED  */
