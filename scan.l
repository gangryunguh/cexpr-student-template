%{
#include "cexpr.tab.h"
%}
%%
[ \t\n]  ;
"dump"   { return DUMP; }
"reset"  { return RESET;}
[a-z]    { yylval.id = yytext[0];
           return ID;
         }
[0-9]+   { sscanf(yytext, "%d", &yylval.num);
           return NUM;
         }
.        return yytext[0];
