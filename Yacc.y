/* Declaration Section */

%{
#include<stdio.h>
#include<stdlib.h>
int flag = 0;
%}

%token MAIN INCLUDE FOR WHILE IF ELSE ELSEIF INT CHAR FLOAT DOUBLE LONG RETURN BREAK CONTINUE DO GOTO VOID TRUE FALSE LE GE LT GT EQUAL ASSIGN UNARY ADD SUB MUL DIV STR CHARACTER FLOAT_NUM INTEGER SEPARATOR NOTEQ ID INBUILT MOD TAB COMMENTS

/* Translation Rules */
%%

program: headers datatype SEPARATOR MAIN SEPARATOR SEPARATOR SEPARATOR body SEPARATOR{
	system("clear");
	printf("Program is syntactically correct!\n\n");
}
;

headers: headers headers
| INCLUDE
;

datatype: INT 
| FLOAT 
| CHAR
| VOID
| DOUBLE
| LONG
;

body: tabs FOR SEPARATOR statement SEPARATOR condition SEPARATOR statement SEPARATOR SEPARATOR body SEPARATOR 
| tabs IF SEPARATOR condition SEPARATOR SEPARATOR body tabs SEPARATOR else
| statement SEPARATOR
| statement separator SEPARATOR separator statement SEPARATOR
| body tabs body tabs
| tabs INBUILT
| tabs RETURN SEPARATOR INTEGER SEPARATOR
| tabs COMMENTS
;

else: tabs ELSE SEPARATOR body tabs SEPARATOR
|
;

condition: value relop value 
| TRUE 
| FALSE
;

statement: tabs datatype separator ID init
| tabs datatype separator ID 
| tabs ID init
| tabs ID ASSIGN expression
| tabs ID relop expression
| tabs ID relop ID
| tabs ID UNARY 
| tabs UNARY ID
;

init: ASSIGN separator value
| 
;

expression: expression arithmetic expression
| expression MOD expression
| value
;

arithmetic: ADD 
| SUB
| MUL
| DIV
;

relop: LT
| GT
| LE
| GE
| EQUAL
| NOTEQ
;

value: INTEGER
| FLOAT_NUM
| CHARACTER
| ID
;

separator: SEPARATOR
| 
;

tabs: tabs tabs
| TAB
| 
;

%%

#include "lex.yy.c"

//driver code
int main()
{
	while(yyparse());
	if(flag == 0){
		// Entered number is valid
	}
}

void yyerror(char *s)
{
	printf("\n\nERROR OCCURRED!\n\n");
	exit(0);
	flag = 1;
}
