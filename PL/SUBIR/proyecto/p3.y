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
int fatal_error = 0;
%}
%error-verbose
%union{
	int valInt;
	float valFloat;
	char * valStr;
}
%token ABRIR FIN MENSAJE HOTKEY FUNCION FINPARAMETROS ASIGNACION RETURN LLAMADAFUNCION HOTSTRING REMAP
%token <valStr> TECLA
%token <valStr> CADENA
%token <valStr> VAR OPERACION DIGITO GLOBAL
%start S
%%

/**ERRORES PUEDES VENIR DE UNA LINEA POSTERIOR SI EL USUARIO SE OLVIDA DE CERRA ALGO CON FIN**/

S : e | comando e ;

e : e x | x;

x : hotkey | hotstring | remap | funcion | llamarFun | print_asignacion valor 

;

print_asignacion : VAR ASIGNACION
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s=",aux);
		insertarVar(pos,variables,aux);
		pos++;
	}
	|VAR error
	{
		printf("Línea %d: Asignación no válida\n",yylineno);
		fatal_error = 0;
	}
;

valor : DIGITO
	{
		fprintf(f,"%s",$1);
	}
	|CADENA
	{
		fprintf(f,"%s\n",$1);
	}
	|error
	{
		printf("Línea %d: Valor de asignación no válido\n",yylineno);
		fatal_error = 0;
	}
;
/*********************************** HOTSTRING *************************************************/

hotstring : HOTSTRING TECLA CADENA FIN
	{
		char aux[100] = "";
		strncpy(aux,$3+1,strlen($3)-2);
		fprintf(f,"::%s::%s\n",$2,aux);
	}
	|HOTSTRING error CADENA FIN
	{
		printf("Línea %d: Tecla no válida en la hotstring\n",yylineno);
		fatal_error = 0;
	}
	|HOTSTRING TECLA error FIN
	{
		printf("Línea %d: Cadena no válida en la hotstring\n",yylineno);
		fatal_error = 0;
	}
	|HOTSTRING FIN
	{
		printf("Línea %d: Teclas no válida en la hotstring\n",yylineno);
	}
	|HOTSTRING TECLA CADENA error
	{
		printf("Línea %d: Las hotstrings acaban en \"fin\"\n",yylineno);
		fatal_error = 0;
	}
	|HOTSTRING
	{
		printf("Línea %d: Las hotstrings necesitan TECLA, CADENA y fin de parámetros\n",yylineno);
	}
;
/*********************************** REMAP *****************************************************/

remap : REMAP TECLA TECLA FIN
	{
		fprintf(f,"%s::%s\n",$2,$3);
	}
	|REMAP TECLA error FIN
	{
		printf("Línea %d: Tecla no válida en el intercambio\n",yylineno);
		fatal_error = 0;
	}
	|REMAP FIN
	{
		printf("Línea %d: Teclas no válida en el intercambio\n",yylineno);
	}
	|REMAP TECLA TECLA error
	{
		printf("Línea %d: Los intercambios acaban en \"fin\"\n",yylineno);
		fatal_error = 0;
	}
	|REMAP
	{
		printf("Línea %d: Los Intercambios necesitan TECLA, CADENA y fin de parámetros\n",yylineno);
	}
	
;
/*********************************** HOTKEY *************************************************/

hotkey : HOTKEY tecla_print_aux comando FIN 
	{
		fprintf(f,"return\n");
	}
	|HOTKEY error comando FIN
	{
		printf("Línea %d: Tecla no válida en Al pulsar\n",yylineno);
		fatal_error = 0;
	}
	|HOTKEY tecla_print_aux error FIN
	{
		printf("Línea %d: Al pulsar sin comandos\n",yylineno);
		fatal_error = 0;
	}
	|HOTKEY FIN
	{
		printf("Línea %d: Faltan parámetros en Al pulsar\n",yylineno);
	}
	|HOTKEY TECLA CADENA error
	{
		printf("Línea %d: Al pulsar acaba con \"fin\"\n",yylineno);
		fatal_error = 0;
	}
	|HOTKEY
	{
		printf("Línea %d: Al pulsar necesita una TECLA y comandos\n",yylineno);
	}
;
/********************************** COMANDOS ************************************************/

comando : comando accion | accion;

accion : ABRIR CADENA /*Falta caso de que no venga abrir ni cadena -> posiblemente conflictivo*/
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
	|ABRIR error
	{
		printf("Línea %d: Abrir necesita una CADENA como parámetro\n",yylineno);
		fatal_error = 0;
	}
	|MENSAJE error
	{
		printf("Línea %d: MENSAJE necesita una CADENA como parámetro\n",yylineno);
		fatal_error = 0;
	}
	
;

/********************************** FUNCION *************************************************/

funcion : funcion_print_aux cuerpoFuncion FIN
	{
		fprintf(f,"}\n");
		//printf("%s NOMBREFUN\n",nombreFun);
		//printf("%d NPARAM\n",nParam);
		insertarFun(listaFunciones,posFuncion);
		posFuncion++;
	}
	|funcion_print_aux cuerpoFuncion error
	{
		printf("Línea %d: Falta el \"fin\" de la función\n",yylineno);
		fatal_error = 0;
	}

;

funcion_print_aux : FUNCION print_cadena parametro 
	{
		fprintf(f,")\n{\n");
	}
	|FUNCION error parametro
	{
		printf("Línea %d: Falta el nombre de la función\n",yylineno);
		fatal_error = 0;	
	}
;

cuerpoFuncion : comando | print_return 
	| error
	{
		printf("Línea %d: La función no tiene ningún comando\n",yylineno);
		fatal_error = 0;
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
			error = 0;
			printf("Línea %d: Parámetro no declarado\n",yylineno);
		}
		memset(nombreVar, 0, strlen(nombreVar));		
	}
	|RETURN error OPERACION VAR 
	{
		printf("Línea %d: Variable no válida en return\n",yylineno);
		fatal_error = 0;
	}
	|RETURN VAR error VAR 
	{
		printf("Línea %d: Operación no válida en return\n",yylineno);
		fatal_error = 0;
	}
	|RETURN VAR OPERACION error 
	{
		printf("Línea %d: Variable no válida en return\n",yylineno);
		fatal_error = 0;
	}
;
/********************************** FUNCION-LLAMADA******************************************/

llamarFun: LLAMADAFUNCION print_cadena parametro FIN 
	{
		fprintf(f,")\n");
		int i,n;
		i = existeFun(listaFunciones);
		if (i == 0) {
			error =i;
			printf("Línea %d: Función no definida\n",yylineno);
		}else{
			n = devolverNumParam(listaFunciones);
			error = (n==nParam);
			if (!error)
				printf("Línea %d: Número de parámetro en llamada incorrecto\n",yylineno);
		}
		nParam = 0;
	}
	|LLAMADAFUNCION error parametro FIN 
	{
		printf("Línea %d: Falta el nombre de la función en la llamada\n",yylineno);
		fatal_error = 0;
	}
	|LLAMADAFUNCION print_cadena parametro error 
	{
		printf("Línea %d: Falta \"fin\" al final de la llamada de la función\n",yylineno);
		fatal_error = 0;
	}
;
/********************************** PARAMETROS **********************************************/

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
			printf("Línea %d: Parámetro no declarado\n",yylineno);
		}
	}
	
;

tecla_print_aux : TECLA
	{
		fprintf(f,"%s::\n",$1);
	}
;
/********************************** AUXILIARES **********************************************/

print_cadena : CADENA 
	{
		char aux[100] = "";
		strncpy(aux,$1+1,strlen($1)-2);
		fprintf(f,"%s(",aux);
		funcion.nombre = $1;
		strncpy(nombreFun,$1,strlen($1)); 
	}
;

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
	printf("\n");
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
	if (fatal_error){/* Por si algo no cuadra con la gramática*/
		printf("Línea %d: Construcción no válida, falta idetificador de instrucción inicial o la instrucción no está permitida en este contexto.\n",yylineno);
	}
	if (error == 0){
		borrado = remove(file);
		if(borrado == 0) {
		      	printf("Error: File deleted successfully\n");
	   	} else {
		      	printf("SUCCESS\n");
	   	}
	}
	printf("\n");
	return 0;
}
void yyerror (char const *message) {
	fatal_error = 1;
	error = 0;
	//fprintf (stderr, "Línea %d: %s \n",yylineno, message);
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