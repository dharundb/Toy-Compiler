/*Declaration part*/
%{
int line_count = 0;
%}

/*Translation rules*/
%%
#.* {
	/* Header */
	return INCLUDE;
	//printf("\nHeader files\t\t: %s",yytext);
}

\/\/.*|\/"*"(.*|\n)*"*"\/ {
	/* Both Multi line and single line Comments are detected */
	//printf("\nComment lines\t\t: %s",yytext);
	return COMMENTS;
}

"main" 	{ return MAIN; }
"for" 		{ return FOR; }
"while" 	{ return WHILE; }
"if"		{ return IF; }
"else"		{ return ELSE; }
"else if" 	{ return ELSEIF; }
"int" 		{ return INT; }
"float" 	{ return FLOAT; }
"char" 	{ return CHAR; }
"double" 	{ return DOUBLE; }
"long" 	{ return LONG; }
"return" 	{ return RETURN; }
"break" 	{ return BREAK; }
"continue" 	{ return CONTINUE; }
"do" 		{ return DO; }
"goto" 	{ return GOTO; }
"void" 	{ return VOID; }
"true" 	{ return TRUE; }
"false" 	{ return FALSE; }
"<=" 		{ return LE; }
">=" 		{ return GE; }
"<"		{ return LT; }
">"		{ return GT; }
"==" 		{ return EQUAL; }
"=" 		{ return ASSIGN; }
"!="		{ return NOTEQ; }
"++" 		{ return UNARY; }
"--" 		{ return UNARY; }
"+" 		{ return ADD; }
"-" 		{ return SUB; }
"*" 		{ return MUL; }
"/" 		{ return DIV; }
"%" 		{ return MOD; }
[\t] 		{ return TAB; }

[a-zA-Z][a-zA-Z0-9_]*\((.|\\n)*\); {
	return INBUILT;
}

["].*["] 	{ return STR; }
['].['] 	{ return CHARACTER; }

[+-]?[0-9]*"."[0-9]+ 	{ return FLOAT_NUM; }
[+-]?[0-9]+		{ return INTEGER; }

[a-zA-Z_][a-zA-Z0-9_]*	{
	/* Variables or identifiers */ 
	return ID;
}

[(){}|, ;] {
	/* Separators */
	return SEPARATOR;
}

[\n] {
	/* To count lines */
	line_count++;
}

. {
	return *yytext;
	/* Any other are considered not to be tokens */
	//printf("\nOther\t\t: %s",yytext);
}
%%

int yywrap(){}

/*
int main(int argc, char **argv)
{
	FILE *fp;
	char filename[50] = "b2d.c";
	fp = fopen(filename,"r");
	yyin = fp;
	yylex();
	//printf("\n\nNo. of lines \t\t\t: %d",line_count+1);
	return 0;
}
*/