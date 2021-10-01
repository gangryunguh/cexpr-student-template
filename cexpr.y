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

%token DUMP RESET
%token<num> NUM
%token<id> ID
%type<num> factor term  expr asg
%type<addr> id

%%
commands:
	|	commands command
	;
command : calc      { defined = 1; }
        | DUMP      { for (i = 0; i < NUMVAR; i++)
                           if (id_defined[i])
                              printf("%c: %d\n", 'a'+i, id[i]);
                           else
                              printf("unknown\n");
                    }
        ;
        | RESET	    { for (i = 0; i < NUMVAR; i++);
                            id_defined[i] = 0;
                    }
        ;
calc    : asg ';'   { if (defined)
                         printf("%d\n", $1);
                      else
                         printf("undefined\n");
                    }
        ;
asg     : ID '=' asg  { id[$1 - 'a'] = $3 ;
                        id_defined[$1 - 'a'] = defined;
                        $$ = $3;
                      }
        | expr        { $$ = $1; }
        ;
expr    : expr '+' term { $$ = $1 + $3;}
        | term          { $$ = $1; }
        ;
term    : term '*' factor { $$ = $1 * $3;}
        | factor { $$ = $1;}
        ;
factor  :  '(' expr ')' {$$ = $2;}
        | id            {$$ = *$1;}
        | NUM           {$$ = $1;}
        ;
id      : ID            { $$ = &id[$1 - 'a'];
                          if (defined)
                             defined = id_defined[$1-'a'];
                        }
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
