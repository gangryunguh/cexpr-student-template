/*
 * This file defines a yacc grammar for C expressions.
 */
%{
#include <stdio.h>
#define NUMVAR 26
int i;                   // counter variable
int id[NUMVAR];          // integer variables used in the calculator
int defined=1;           // indicates if the calculation is defined
int id_defined[NUMVAR];  // indicates if each variable has a defined value

int yylex();
void yyerror(char *);
%}

%union	{
	char id;
	int num;
	int *addr;
	}


%%
commands:
	|	commands command
	;

%%
int main()
{
   /* invoke calculator */
   if (yyparse())
      printf("\nInvalid expression.\n");
   else
      printf("\nCalculator off.\n");
}

void yyerror(char *s)
{
   fprintf(stderr, "%s\n", s);
}
