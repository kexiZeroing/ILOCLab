/* C declarations */
%{
#include <stdio.h>
#include "symbolTable.h"
#include "myiloc.h"
extern int yylineno;
extern int errorCount;

int CUR_TYPE; // 0 for char, 1 for int
int globalOffset = 0;
int globalReg = 0;
%}

/* Bison declarations */
%error-verbose

%union{
    struct SymbolEntry *entry;
    int int_val;
    char* string;
    char char_val;
}

%start Procedure
%token PROCEDURE
%token INT
%token CHAR
%token WRITE
%token READ
%token AND
%token OR
%token NOT
%token IF
%token ELSE
%token THEN
%token FOR
%token TO
%token BY
%token WHILE
%token LT
%token LE
%token EQ
%token NE
%token GT
%token GE
%token <string> NAME
%token <int_val> NUMBER
%token <char_val> CHARCONST

%type <int_val> Type
%type <entry> Stmt Stmts Expr Exprs Reference Factor Term

/* productions and actions */
%%
Procedure   : PROCEDURE NAME '{' Decls Stmts '}'
			| PROCEDURE NAME '{' Decls Stmts { yyerror("Missing procedure closing curly brace '}'"); }
			| PROCEDURE NAME '{' Decls Stmts '}' '}' { yyerror("unexpected '}', redundant closing curly brace found"); yyclearin; }
			;
Decls 		: Decls Decl ';' 
	 		| Decl ';' 
			| Decls Decl { yyerror("Missing semicolon after declaration"); }
			| Decl  { yyerror("Missing semicolon after declaration"); }
			| Decls Decl ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; }
			| Decl ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; }
	 		;
Decl		: Type SpecList
			;
Type		: INT { CUR_TYPE = 1; }
			| CHAR { CUR_TYPE = 0; }
			;
SpecList	: SpecList ',' Spec
			| Spec 
			;
Spec		: NAME { 
					if (lookupTable($1) != NULL){
						yyerror("variable has been already declared.\n");
					} else {
						int dim[MAX_DIMENSION][2];
						// insertToTable(char *name, int type, int regNum, int isArray, int offset, int dimension, int dim[MAX_DIMENSION][2]);
						insertToTable($1, CUR_TYPE, getNextRegister(), 0, -1, -1, dim);
					}
 				}
			| NAME '[' Bounds ']' 
			;
Bounds		: Bounds ',' Bound 
      		| Bound 
      		;
Bound		: NUMBER ':' NUMBER 
			;
Stmts		: Stmts Stmt 
	 		| Stmt 
	 		;
Stmt      	: Reference '=' Expr ';' {
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;
					if (node1 -> type == 0){
						// char
						emit(NOLABEL, _I2C, node2->regNum, node1->regNum, EMPTY);
					} else{
						// int
						if (node2 -> isImme) {
							emit(NOLABEL, _LOADI, node2->regNum, node1->regNum, EMPTY);
						}else {
							emit(NOLABEL, _I2I, node2->regNum, node1->regNum, EMPTY);
						}
					}
				}
			| '{' Stmts '}'
			| IF '(' Bool ')' THEN Stmt 
          	| IF '(' Bool ')' THEN WithElse ELSE Stmt 
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';' {
					SymbolEntry *node = $2;
					if (node -> type == 0){
						// char
						emit(NOLABEL, _CWRITE, node->regNum, EMPTY, EMPTY);
					} else{
						// int
						emit(NOLABEL, _WRITE, node->regNum, EMPTY, EMPTY);
					}
				}
			| '{' '}' { yyerror("Empty statement list is not allowed"); yyclearin; }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); yyclearin; }
			| Reference '+' '=' Expr ';' { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; } 
			| Reference '=' Expr ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			}
			| WRITE '=' Expr ';' { yyerror("unexpected EQUALS, expecting CHARCONST or '(' or NAME or NUMBER, could not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("unexpected NAME. No such reserved word"); yyclearin; }
			| IF '(' Bool ')' error  { yyerror("Missing keyword THEN"); /* just forget keyword then, do not need to throw away token */ }
			| IF '(' Bool ')' THEN '{' Stmts error { yyerror("Missing closing curly brace '}'"); }
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			;
WithElse	: IF '(' Bool ')' THEN WithElse ELSE WithElse
			| Reference '=' Expr ';' 
			| '{' Stmts '}'
			| WHILE '(' Bool ')' '{' Stmts '}' 
			| FOR NAME '=' Expr TO Expr BY Expr '{' Stmts '}' 
			| READ Reference ';'
			| WRITE Expr ';'
			| '{' '}' { yyerror("Empty statement list is not allowed"); yyclearin; }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); yyclearin; }
			| Reference '+' '=' Expr ';' { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; } 
			| Reference '=' Expr ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			}
			| WRITE '=' Expr ';' { yyerror("can not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("No such reserved word"); yyclearin; }
			| IF '(' Bool ')' error  { yyerror("Missing keyword THEN"); /* just forget keyword then, do not need to throw away token */ }
			| IF '(' Bool ')' THEN '{' Stmts error { yyerror("Missing closing curly brace '}'"); }
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			; 
Bool      	: NOT OrTerm
          	| OrTerm
			;
OrTerm		: OrTerm OR AndTerm
        	| AndTerm
			;
AndTerm   	: AndTerm AND RelExpr
          	| RelExpr
			;
RelExpr 	: RelExpr LT Expr
        	| RelExpr LE Expr
        	| RelExpr EQ Expr
        	| RelExpr NE Expr
        	| RelExpr GE Expr
        	| RelExpr GT Expr
        	| Expr
			| RelExpr '=' Expr { yyerror("Forgot an equal '=' in RelExprssion"); }
			;
Expr		: Expr '+' Term {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;

					// differentiate by immediate value or register
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum + node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						emit(NOLABEL, _ADDI, node2->regNum, node1->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _ADDI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _ADD, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
			| Expr '-' Term  {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;
					
					// 'a-1' use subI; '1-a' use sub (loadI first)
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum - node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
						node -> regNum = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, node->regNum, EMPTY);
						emit(NOLABEL, _SUB, node->regNum, node2->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _SUBI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _SUB, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
			| Term {
					$$ = $1;
				}
			;
Term		: Term '*' Factor {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;

					// same as add
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum * node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						emit(NOLABEL, _MULTI, node2->regNum, node1->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _MULTI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _MULT, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
			| Term '/' Factor {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;

					// same as sub
					if(node1 -> isImme && node2 -> isImme) {
						emit(NOLABEL, _LOADI, node1 -> regNum / node2 -> regNum, tmpReg, EMPTY);
					} else if(node1 -> isImme) {
						SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
						node -> regNum = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, node->regNum, EMPTY);
						emit(NOLABEL, _DIV, node->regNum, node2->regNum, tmpReg);
					} else if(node2 -> isImme) {
						emit(NOLABEL, _DIVI, node1->regNum, node2->regNum, tmpReg);
					} else {
						emit(NOLABEL, _DIV, node1->regNum, node2->regNum, tmpReg);
					}
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
			| Factor {
					$$ = $1;
				}
			;
Factor		: '(' Expr ')' 
         	| Reference {
					$$ = $1;
				}
	  		| NUMBER {
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> isImme = 1;
					node -> regNum = $1;   // pseudo node
					$$ = node;
				} 
	  		| CHARCONST {
				  	int tmpReg = getNextRegister();
					emit(NOLABEL, _LOADI, $1, tmpReg, EMPTY);
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
			  	}
	  		; 
Reference 	: NAME {
					SymbolEntry * node = lookupTable($1);
					if (node == NULL){
						yyerror("Variable has not beed declared\n");
					} else{
						$$ = node;
					}
				}
          	| NAME '[' Exprs ']'
			;
Exprs     	: Expr ',' Exprs 
          	| Expr
			;

%%                    
 /* C code */
