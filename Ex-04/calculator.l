%{
#include <stdio.h>
#include <stdlib.h>
int op = 0;
float a, b;
void digi(); // Function prototype
%}

dig [0-9]+(\.[0-9]+)?

%%

{dig} { digi(); }
"+" { op=1; }
"-" { op=2; }
"*" { op=3; }
"/" { op=4; }
"^" { op=5; }
[\n] { printf("\nResult =  %.2f\n\n", a); exit(0); }

%%

void digi() {
    if(op == 0)
        a = atof(yytext);
    else {
        b = atof(yytext);
        switch(op) {
            case 1: a = a + b; break;
            case 2: a = a - b; break;
            case 3: a = a * b; break;
            case 4: a = a / b; break;
            case 5: for(int i = 1; i < b; i++) a *= a; break;
        }
        op = 0;
    }
}

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
