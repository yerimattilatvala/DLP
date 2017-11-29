%option yylineno
%{
#include <stdlib.h>
#include "p3.tab.h"

%}

cadena \"[^"]+\"
tecla [^ \n\t]

%%
"Al pulsar" {return HOTKEY;};
"Abrir" {return ABRIR;};
"Mensaje" {return MENSAJE;};
"fin" {return FIN;};
{cadena} {yylval.valStr = strdup(yytext); return CADENA;};
{tecla} {yylval.valStr = strdup(yytext); return TECLA;};
.;

%%


