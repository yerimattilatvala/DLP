%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern int yylineno;
FILE *f;
int yylex();
void yyerror (char const *);
typedef char letras[128];
letras variables[128];
int pos = 0;
void insertar(int pos, letras lista[],char*varible);
int existe(char*variable,letras lista[]);
%}
%error-verbose
%union{
	int valInt;
	float valFloat;
	char * valStr;
}
%token ABRIR FIN MENSAJE HOTKEY FUNCION FINPARAMETROS ASIGNACION
%token <valStr> TECLA
%token <valStr> CADENA
%token <valStr> VAR OPERACION DIGITO
%start S
%%
S : e | comando e;

e : e x | x;

x : hotkey | hotstring | remap | funcion;

hotkey : HOTKEY tecla_print_aux comando FIN 
	{
		fprintf(f,"return\n");
	}
;

tecla_print_aux : TECLA //Para evitar tener que guardar las cadenas
	{
		fprintf(f,"%s::\n",$1);
	}
;

print_cadena : CADENA 
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s(",aux);
	}
;
funcion_print_aux : FUNCION print_cadena parametro 
	{
		fprintf(f,")\n{\n");
	}
;
funcion : funcion_print_aux comando FIN
	{
		fprintf(f,"}\n");
	}
;
comando : comando accion | accion;

print_asignacion : CADENA ASIGNACION
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s=",aux);
		insertar(pos,variables,$1);
		pos++;
	}
;

print_digito : DIGITO
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s",aux);
	}
;

accion : ABRIR CADENA 
	{
		char aux[100] = "";
		strncpy(aux,$2+1,strlen($2)-2);
		fprintf(f,"Run %s\n",aux);
	}

	| MENSAJE CADENA 
	{
		char aux[100] = "";
		strncpy(aux,$2+1,strlen($2)-2);
		fprintf(f,"MsgBox, %s\n",aux);
	}
	| print_asignacion CADENA
	{
		fprintf(f,"%s/n",$2);
	}
	| print_asignacion print_digito
	{
		fprintf(f,"/n");
	}
;

parametro :  
	{
	}
	| parametro VAR
	{
		fprintf(f,"%s, ",$2);
	}
	| parametro VAR FINPARAMETROS 
	{
		fprintf(f,"%s",$2);
	}
	
;
hotstring : TECLA CADENA FIN
	{
		char aux[100] = "";
		strncpy(aux,$2+1,strlen($2)-2);
		fprintf(f,"::%s::%s\n",$1,aux);
	};

remap : TECLA TECLA FIN
	{
		fprintf(f,"%s::%s\n",$1,$2);
	};

%%


int main(int argc, char *argv[]) {
extern FILE *yyin;
	
	f = fopen("file.ahk", "w");
	if (f == NULL)
	{
	    printf("Error opening file!\n");
	    exit(1);
	}

	switch (argc) {
		case 1:	yyin=stdin;
			yyparse();
			break;
		case 2: yyin = fopen(argv[1], "r");
			if (yyin == NULL) {
				printf("ERROR: No se ha podido abrir el fichero.\n");
			}
			else {
				yyparse();
				fclose(yyin);
			}
			break;
		default: printf("ERROR: Demasiados argumentos.\nSintaxis: %s [fichero_entrada]\n\n", argv[0]);
	}
	
	fclose(f);
	return 0;
}
void yyerror (char const *message) {fprintf (stderr, "%s %d\n", message,yylineno);
}
void insertar (int pos, letras lista[],char*variable) 
{
	strcpy(lista[pos],variable);
};
int existe (char*variable,letras lista[]) 
{
	int i;
	for (i = 0;i < pos;i++){
		if (strcmp(variable,lista[i])){
			return 1;
		}
	}
	return 0;
};