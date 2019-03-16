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
int globalLabel = 0;
%}

/* Bison declarations */
%error-verbose

%union{
    struct SymbolEntry *entry;
	struct IfStructure *ifStructure;
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
%type <entry> Stmt Stmts Expr Exprs Reference Factor Term RelExpr Bool OrTerm AndTerm
%type <ifStructure> IFHead

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
			| IFHead THEN Stmt {
					IfStructure *ifNode = $1;
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
				}
          	| IFHead THEN WithElse {
				  	IfStructure *ifNode = $1;
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	} ELSE Stmt {
				  	IfStructure *ifNode = $1;
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	}
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
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			;
IFHead      : IF '(' Bool ')' { 
					IfStructure ifNode;
					ifNode.firstLabel = getNextLabel();
					ifNode.secondLabel = getNextLabel();
					ifNode.thirdLabel = getNextLabel();

					SymbolEntry *node = $3;

					emit(NOLABEL, _CBR, node->regNum, ifNode.firstLabel, ifNode.secondLabel);
					emit(ifNode.firstLabel, NOP, EMPTY, EMPTY, EMPTY);
					$$ = &ifNode;
				} 
			;
WithElse	: IFHead THEN WithElse ELSE WithElse 
			| Reference '=' Expr ';' {
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
			| WRITE '=' Expr ';' { yyerror("can not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("No such reserved word"); yyclearin; }
			| Reference '=' Expr error { yyerror("Missing semicolon ';' after assignment"); }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			; 
Bool      	: NOT OrTerm {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $2;
					emit(NOLABEL, _NOT, node1->regNum, tmpReg, EMPTY);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
          	| OrTerm {
					$$ = $1;
			  	}
			;
OrTerm		: OrTerm OR AndTerm {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;
					emit(NOLABEL, _OR, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| AndTerm {
					$$ = $1;
				}
			;
AndTerm   	: AndTerm AND RelExpr {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;
					emit(NOLABEL, _AND, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
          	| RelExpr {
				  $$ = $1;
			  }
			;
RelExpr 	: RelExpr LT Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_LT, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| RelExpr LE Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_LE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
			}
        	| RelExpr EQ Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_EQ, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| RelExpr NE Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_NE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| RelExpr GE Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 
					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_GE, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| RelExpr GT Expr {
					SymbolEntry *node1 = $1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = $3;
					if(node2 -> isImme) {
						int reg2 = getNextRegister();
						emit(NOLABEL, _LOADI, node2 -> regNum, reg2, EMPTY);
						node2 -> regNum = reg2;
					} 

					int tmpReg = getNextRegister();
					emit(NOLABEL, _CMP_GT, node1->regNum, node2->regNum, tmpReg);
					
					SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
					node -> regNum = tmpReg;
					$$ = node;
				}
        	| Expr {
					$$ = $1;
				}
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
