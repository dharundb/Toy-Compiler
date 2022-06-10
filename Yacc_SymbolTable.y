/* Declaration Section */

%{
#include<stdio.h>
#include<stdlib.h>

void add(char);
void insert_type();
int search(char *);
void insert_type();

struct symbolTable{
	char *id_name;
	char *data_type;
	char *type;
	int lno;
}symbol_table[50];

int count = 0;
int available;
char type[10];
extern int line_count;

%}

%token MAIN INCLUDE FOR WHILE IF ELSE ELSEIF INT CHAR FLOAT DOUBLE LONG RETURN BREAK CONTINUE DO GOTO VOID TRUE FALSE LE GE LT GT EQUAL ASSIGN UNARY ADD SUB MUL DIV STR CHARACTER FLOAT_NUM INTEGER SEPARATOR NOTEQ ID INBUILT MOD TAB COMMENTS

/* Translation Rules */
%%

program: headers datatype SEPARATOR MAIN SEPARATOR SEPARATOR SEPARATOR body SEPARATOR{
	system("clear");
	add('M');
	printf("The program inputted is syntactically correct!\n");
	printf("Continuing with symbol table creation...\n");
}
;

headers: headers headers
| INCLUDE { add('H'); }
;

datatype: INT { insert_type(); }
| FLOAT { insert_type(); }
| CHAR { insert_type(); }
| VOID { insert_type(); }
| DOUBLE { insert_type(); }
| LONG { insert_type(); }
;

body: tabs FOR { add('K'); } SEPARATOR statement SEPARATOR condition SEPARATOR statement SEPARATOR SEPARATOR body SEPARATOR
| tabs IF { add('K'); } SEPARATOR condition SEPARATOR SEPARATOR body tabs SEPARATOR else
| statement SEPARATOR
| statement separator SEPARATOR separator statement SEPARATOR
| body tabs body tabs
| tabs INBUILT { add('F'); }
| tabs RETURN { add('K'); } SEPARATOR INTEGER SEPARATOR
| tabs COMMENTS { add('X'); }
;

else: tabs ELSE { add('K'); } SEPARATOR body tabs SEPARATOR
|
;

condition: value relop value 
| TRUE { add('K'); }
| FALSE { add('K'); }
;

statement: tabs datatype separator ID { add('V'); } init
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

value: INTEGER { add('C'); }
| FLOAT_NUM { add('C'); }
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
	yyparse();
	printf("\n");
	printf("\t\t+----------------------------\n");
	printf("\t\t| SYMBOL TABLE CONSTRUCTION |\n");
	printf("\t\t----------------------------+\n\n");
	printf("_________________________________________________________________\n");
	printf("\nSYMBOL\t\tDATATYPE\t  TYPE\t\t  LINE NUMBER \n");
	printf("_________________________________________________________________\n\n");
	int i=0;
	for(i=0; i<count; i++) {
		printf("%s\t\t   %s\t\t%s\t\t%d\t\t\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].lno);
	}
	printf("\n\n");
}

int search(char *id) {
	int i;
	for(i=count-1; i>=0; i--) {
		if(strcmp(symbol_table[i].id_name, id)==0) {
			return -1;
			break;
		}
	}
	return 0;
}

void add(char c) {
  available =search(yytext);
  if(!available) {
    if(c == 'H') {
		symbol_table[count].id_name=strdup("#inc");
		symbol_table[count].data_type=strdup("-");
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Header\t");
		count++;
	}
	else if(c == 'K') {
		symbol_table[count].id_name=strdup(yytext);
		symbol_table[count].data_type=strdup("-");
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Keyword\t");
		count++;
	}
	else if(c == 'V') {
		symbol_table[count].id_name=strdup(yytext);
		symbol_table[count].data_type=strdup(type);
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Variable");
		count++;
	}
	else if(c == 'C') {
		symbol_table[count].id_name=strdup(yytext);
		symbol_table[count].data_type=strdup("-");
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Constant");
		count++;
	}
	else if(c == 'F') {
		symbol_table[count].id_name=strdup("fun()");
		symbol_table[count].data_type=strdup(type);
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Function");
		count++;
	}
	else if(c == 'M') {
		symbol_table[count].id_name=strdup("main()");
		symbol_table[count].data_type=strdup(type);
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Function");
		count++;
	}
	else if(c == 'X') {
		symbol_table[count].id_name=strdup("/* */");
		symbol_table[count].data_type=strdup("-");
		symbol_table[count].lno=line_count;
		symbol_table[count].type=strdup("Comments");
		count++;
	}
   }
}

void insert_type() {
	strcpy(type, yytext);
}

void yyerror(char *s)
{
	printf("\n\nERROR OCCURRED!\n\n");
	exit(0);
}
