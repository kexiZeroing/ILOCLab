%{
#include <stdio.h>
#include <string.h>
#include "symbolTable.h"

extern int yylineno;
extern int errorCount;
#define YYINCR(n) yylineno += n

#include "myparser.tab.h"
%}

%%
"//".*                  ;
"procedure"             { return PROCEDURE; }
"int"                   { return INT; }
"char"                  { return CHAR; }
"read"                  { return READ; }
"write"                 { return WRITE; }
"=="                    { return EQ; }
">"                     { return GT; }
">="                    { return GE; }
"<"                     { return LT; }
"<="                    { return LE; }
"!="                    { return NE; }
"and"                   { return AND; }
"or"                    { return OR; }
"not"                   { return NOT; }
"if"                    { return IF; }
"then"                  { return THEN; }
"else"                  { return ELSE; }
"for"                   { return FOR; }
"to"                    { return TO; }
"by"                    { return BY; }
"while"                 { return WHILE; }
";"                     { return ';'; }
":"                     { return ':'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"="                     { return '='; }
"("                     { return '('; }
")"                     { return ')'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
"["                     { return '['; }
"]"                     { return ']'; }
","                     { return ','; }
[0-9]+                  { yylval.string = atoi(yytext); return NUMBER; }
[A-Za-z][A-Za-z0-9]*    {   yylval.string = malloc(strlen(yytext) + 1);  // need include \0
                            strcpy(yylval.string, yytext); 
                            return NAME; 
                        }
'.'                     { yylval.char_val = yytext[1]; return CHARCONST; }  // consider \n
\'\\n\'                 { yylval.char_val = 10; return CHARCONST; }  
[ \t]                   ;
[\n]                    { YYINCR(1); }
.                       { fprintf (stderr, "Unknown character %s at line %d\n", yytext, yylineno); }

%%