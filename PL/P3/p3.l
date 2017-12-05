%option yylineno
%{
#include <stdlib.h>
#include "p3.tab.h"

%}

cadena \"[^"]+\"
tecla [^ \n\t]
variable [A-Za-z]{2,}

%%
"->" {return FINPARAMETROS;};
"Funcion" {return FUNCION;};
"Al pulsar" {return HOTKEY;};
"Abrir" {return ABRIR;};
"Mensaje" {return MENSAJE;};
"fin" {return FIN;};
{variable} {yylval.valStr = strdup(yytext); return VAR;};
{cadena} {yylval.valStr = strdup(yytext); return CADENA;};
{tecla} {yylval.valStr = strdup(yytext); return TECLA;};
.;

%%


