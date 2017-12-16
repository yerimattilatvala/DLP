/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_P3_TAB_H_INCLUDED
# define YY_YY_P3_TAB_H_INCLUDED
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
    ABRIR = 258,
    FIN = 259,
    MENSAJE = 260,
    HOTKEY = 261,
    FUNCION = 262,
    FINPARAMETROS = 263,
    ASIGNACION = 264,
    RETURN = 265,
    LLAMADAFUNCION = 266,
    TECLA = 267,
    CADENA = 268,
    VAR = 269,
    OPERACION = 270,
    DIGITO = 271,
    GLOBAL = 272
  };
#endif
/* Tokens.  */
#define ABRIR 258
#define FIN 259
#define MENSAJE 260
#define HOTKEY 261
#define FUNCION 262
#define FINPARAMETROS 263
#define ASIGNACION 264
#define RETURN 265
#define LLAMADAFUNCION 266
#define TECLA 267
#define CADENA 268
#define VAR 269
#define OPERACION 270
#define DIGITO 271
#define GLOBAL 272

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 29 "p3.y" /* yacc.c:1909  */

	int valInt;
	float valFloat;
	char * valStr;

#line 94 "p3.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_P3_TAB_H_INCLUDED  */
