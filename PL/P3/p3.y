%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern int yylineno;
FILE *f;
int yylex();
void yyerror (char const *);
/**********************************/
struct funcion
{
	int nParam;
	char *nombre;
};
struct funcion listaFunciones[128]; //listaFunciones
struct funcion funcion;
int posFuncion = 0; 
char nombreFun[128]; // variable global para guardar nombre de la funcion
int nParam = 0;  // variable global para guaradr el numero de parametros de funcion
void insertarFun(struct funcion *lista,int pos);
int existeFun(struct funcion *lista);
int devolverNumParam(struct funcion *lista);
/***********************************/
typedef char letras[128];
letras variables[128];
int pos = 0;
char nombreVar[128];
void insertarVar(int pos, letras lista[],char*varible);
int existeVar(char*variable,letras lista[]);
/***********************************/
int error = 1;
%}
%error-verbose
%union{
	int valInt;
	float valFloat;
	char * valStr;
}
%token ABRIR FIN MENSAJE HOTKEY FUNCION FINPARAMETROS ASIGNACION RETURN LLAMADAFUNCION
%token <valStr> TECLA
%token <valStr> CADENA
%token <valStr> VAR OPERACION DIGITO GLOBAL
%start S
%%
S : e | comando e ;

e : e x | x;

x : hotkey | hotstring | remap | funcion | llamarFun
	| print_asignacion CADENA
	{
		fprintf(f,"%s\n",$2);
	}
	| print_asignacion print_digito
	{
		fprintf(f,"\n");
	}
;

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
		funcion.nombre = $1;
		strncpy(nombreFun,$1,strlen($1)); 
	}
;

funcion_print_aux : FUNCION print_cadena parametro 
	{
		fprintf(f,")\n{\n");
	}
;
funcion : funcion_print_aux cuerpoFuncion FIN
	{
		fprintf(f,"}\n");
		//printf("%s NOMBREFUN\n",nombreFun);
		//printf("%d NPARAM\n",nParam);
		insertarFun(listaFunciones,posFuncion);
		posFuncion++;
	}
;

print_asignacion : VAR ASIGNACION
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s=",aux);
		insertarVar(pos,variables,aux);
		pos++;
	}
;

print_digito : DIGITO
	{
		fprintf(f,"%s",$1);
	}
;


llamarFun: LLAMADAFUNCION print_cadena parametro FIN 
	{
		fprintf(f,")\n");
		int i,n;
		i = existeFun(listaFunciones);
		if (i == 0) {
			error =i;
		}else{
			n = devolverNumParam(listaFunciones);
			error = (n==nParam);
		}
		nParam = 0;
	}
;
cuerpoFuncion : comando | print_return;
comando : comando accion | accion;

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
;

print_return : RETURN VAR OPERACION VAR 
	{
		char aux[100] = "";
		strncpy(aux,$2+1,strlen($2)-2);
		char aux2[100] = "";
		strncpy(aux2,$4+1,strlen($4)-2);
		fprintf(f,"	return %s %s %s \n",aux,$3,aux2);
		char aux3[100]="";
		strcat(aux3, aux);
		strcat(aux3, aux2);
		if ((strcmp(nombreVar,aux3))!=0){
			error =0;
		}
		memset(nombreVar, 0, strlen(nombreVar));		
	}
;

print_var: VAR
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s",aux);
		strcat(nombreVar, aux);
	}
	|GLOBAL 
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s",aux);
		int i;
		i = existeVar(aux,variables);
		if (i == 0){
			error = i;
		}
	}
;

parametro :  
	{
	}
	| parametro print_var
	{
		fprintf(f,", ");
		nParam++;
	}
	| parametro print_var FINPARAMETROS 
	{
		nParam++;
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
	
	char file[] = "file.ahk";
	int borrado = 1;
	f = fopen(file, "w");
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
	if (error == 0){ borrado = remove(file); }
	if(borrado == 0) {
      printf("File deleted successfully");
   } else {
      printf("Error: unable to delete the file");
   }
	return 0;
}
void yyerror (char const *message) {fprintf (stderr, "%s \n", message);
}
void insertarVar(int pos, letras lista[],char*variable) 
{
	strcpy(lista[pos],variable);
};
int existeVar(char*variable,letras lista[]) 
{
	int i;
	for (i = 0;i < pos;i++){
		if ((strcmp(variable,lista[i]))==0){
			return 1;
		}
	}
	return 0;
};

void insertarFun(struct funcion *lista,int pos)
{
	funcion.nParam = nParam;
	lista[pos] = funcion;
	nParam = 0;
	memset(nombreFun, 0, strlen(nombreFun));
};

int existeFun(struct funcion *lista)
{
	int i,output = 0;
	for(i=0;i<posFuncion;i++){
		if((strcmp(nombreFun,lista[i].nombre))==0) {
		output = 1;
		break;}
	}
	return output;
};

int devolverNumParam(struct funcion *lista)
{
	int i,output = -1;
	for(i=0;i<posFuncion;i++){
		if((strcmp(nombreFun,lista[i].nombre))==0) {
		output = lista[i].nParam;
		break;}
	}
	memset(nombreFun, 0, strlen(nombreFun));
	return output;
};