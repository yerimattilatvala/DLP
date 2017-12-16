%option yylineno
%{
#include <stdlib.h>
#include "p3.tab.h"

%}
numero [0-9]
cadena \"[^"]+\"
tecla [^ \n\t]
variable [A-Za-z0-9]+
int "-"?{numero}+
double {int}"."{numero}+
operacion [+"-"*/]{1}
%%
"return" {return RETURN;};
"Llamar" {return LLAMADAFUNCION;};
{operacion} {yylval.valStr =strdup(yytext); return OPERACION;};
{int}|{double} {yylval.valStr =strdup(yytext); return DIGITO;};
"=" {return ASIGNACION;};
"->" {return FINPARAMETROS;};
"Funcion" {return FUNCION;};
"Al pulsar" {return HOTKEY;};
"Abrir" {return ABRIR;};
"Mensaje" {return MENSAJE;};
"fin" {return FIN;};
"("{variable}")" {yylval.valStr = strdup(yytext); return VAR;};
"*"{variable}"*" {yylval.valStr = strdup(yytext); return GLOBAL;};
{cadena} {yylval.valStr = strdup(yytext); return CADENA;};
{tecla} {yylval.valStr = strdup(yytext); return TECLA;};
.;

%%


