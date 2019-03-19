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
	struct ExprsRef *exprsRef;
	struct IfStructure *ifStructure;
	struct WhileStructure *whileStructure;
	struct ForStructure *forStructure;
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
%type <exprsRef> Exprs
%type <entry> Stmt Stmts Expr Reference Factor Term RelExpr Bool OrTerm AndTerm Bound Bounds
%type <ifStructure> IFHead IFMid
%type <whileStructure> WhileHead
%type <forStructure> ForHead

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
						// insertToTable(char *name, int type, int regNum, int isArray, int dimension, int dim[MAX_DIMENSION][2]);
						insertToTable($1, CUR_TYPE, getNextRegister(), 0, -1, dim);
					}
 				}
			| NAME '[' Bounds ']' {	
					if (lookupTable($1) != NULL){
						yyerror("variable has been already declared.\n");
					} else {
						SymbolEntry *node = $3;

						// insertToTable(char *name, int type, int regNum, int isArray, int dimension, int dim[MAX_DIMENSION][2]);
						insertToTable($1, CUR_TYPE, -1, 1, node->dimension, node->dim);
					}
				}
			;
Bounds		: Bounds ',' Bound {  
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;

					node1->dim[node1->dimension][0] = node2->dim[0][0];
					node1->dim[node1->dimension][1] = node2->dim[0][1];
					node1->dimension++;

					$$ = node1;
				}
      		| Bound {
				  $$ = $1;
			  }
      		;
Bound		: NUMBER ':' NUMBER {
					SymbolEntry *node = malloc(sizeof(SymbolEntry));
					node->dimension = 1;
					node->dim[0][0] = $1;
					node->dim[0][1] = $3;

					$$ = node;
				}
			;
Stmts		: Stmts Stmt 
	 		| Stmt 
	 		;
Stmt    : Reference '=' Expr ';' {
					SymbolEntry *node1 = $1;
					SymbolEntry *node2 = $3;
					if(node1 -> isArray == 0){
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
					}else {
							emit(NOLABEL, _STOREAI, node2->regNum, node1->regNum, node1->offset);
					}

				}
			| '{' Stmts '}'
			| IFHead THEN Stmt {
					IfStructure *ifNode = $1;
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
				}
          	| IFMid Stmt {
				  	IfStructure *ifNode = $1;
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	}
			| WhileHead '(' Bool ')' {
					WhileStructure *whileNode = $1;
					SymbolEntry *node = $3;

					// body part
					emit(NOLABEL, _CBR, node->regNum, whileNode->secondLabel, whileNode->thirdLabel);
					emit(whileNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);  
				} '{' Stmts '}' {
					// exit part
					WhileStructure *whileNode = $1;
					emit(NOLABEL, _BR, whileNode->firstLabel, EMPTY, EMPTY);
					emit(whileNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);  
				}
			|  ForHead BY Expr '{' Stmts '}' {
					ForStructure *forNode = $1;
					SymbolEntry *exprNode = $3;

					if (exprNode -> isImme) {
						emit(NOLABEL, _ADDI, forNode->regNum, exprNode->regNum, forNode->regNum);
					}else {
						emit(NOLABEL, _ADD, forNode->regNum, exprNode->regNum, forNode->regNum);
					}

					emit(NOLABEL, _BR, forNode->firstLabel, EMPTY, EMPTY);
					emit(forNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);  
				}
			| READ Reference ';'
			| WRITE Expr ';' {
					SymbolEntry *node = $2;
					if(node -> isArray){
							int baseReg = getNextRegister();
							int resReg = getNextRegister();
							emit(NOLABEL, _LOADI, node->offset, baseReg, EMPTY);
							emit(NOLABEL, _ADD, node->regNum, baseReg, node->regNum);
						  emit(NOLABEL, _LOAD, node->regNum, resReg, EMPTY);
							emit(NOLABEL, _WRITE, resReg, EMPTY, EMPTY);
					}else {
						if (node -> type == 0){
							// char
							emit(NOLABEL, _CWRITE, node->regNum, EMPTY, EMPTY);
						} else{
							// int
							emit(NOLABEL, _WRITE, node->regNum, EMPTY, EMPTY);
						}
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
ForHead		: FOR NAME '=' Expr TO Expr {
					// allocation
					ForStructure *forNode = malloc(sizeof(ForStructure));
					forNode->firstLabel = getNextLabel();
					forNode->secondLabel = getNextLabel();
					forNode->thirdLabel = getNextLabel();

					// init assign
					SymbolEntry *initNode = $4;

					SymbolEntry *nameNode = lookupTable($2);
					if (nameNode == NULL){
						yyerror("Variable has not beed declared\n");
					} 
					if (initNode -> isImme) {
						emit(NOLABEL, _LOADI, initNode->regNum, nameNode->regNum, EMPTY);
					}else {
						emit(NOLABEL, _I2I, initNode->regNum, nameNode->regNum, EMPTY);
					}
					forNode->regNum = nameNode->regNum;

					// compare
					int tmpReg1 = getNextRegister();
					SymbolEntry *resultNode = $6;

					if (resultNode -> isImme) {
						emit(NOLABEL, _LOADI, resultNode->regNum, tmpReg1, EMPTY);
					}else {
						emit(NOLABEL, _I2I, resultNode->regNum, tmpReg1, EMPTY);
					}
					emit(forNode->firstLabel, NOP, EMPTY, EMPTY, EMPTY);

					int tmpReg2 = getNextRegister();
					emit(NOLABEL, _CMP_LE, nameNode->regNum, tmpReg1, tmpReg2);
					emit(NOLABEL, _CBR, tmpReg2, forNode->secondLabel, forNode->thirdLabel);

					// loop label
					emit(forNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
					$$ = forNode;
				}
			;
IFMid		: IFHead THEN WithElse ELSE {
				  	IfStructure *ifNode = $1;
					emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);

					$$ = ifNode;
				}
IFHead      : IF '(' Bool ')' { 
					IfStructure *ifNode = malloc(sizeof(IfStructure));
					ifNode->firstLabel = getNextLabel();
					ifNode->secondLabel = getNextLabel();
					ifNode->thirdLabel = getNextLabel();

					SymbolEntry *node = $3;

					emit(NOLABEL, _CBR, node->regNum, ifNode->firstLabel, ifNode->secondLabel);
					emit(ifNode->firstLabel, NOP, EMPTY, EMPTY, EMPTY);
					$$ = ifNode;
				} 
			;
WhileHead   : WHILE  {
					WhileStructure *whileNode = malloc(sizeof(WhileStructure));
					whileNode->firstLabel = getNextLabel();
					whileNode->secondLabel = getNextLabel();
					whileNode->thirdLabel = getNextLabel();

					emit(whileNode->firstLabel, NOP, EMPTY, EMPTY, EMPTY);
					$$ = whileNode;
				}
			;
WithElse	: IFMid WithElse 
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
							SymbolEntry * node = $1;
							if(node -> isArray){
								SymbolEntry * resNode = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
								resNode -> regNum = getNextRegister();
								resNode -> type = node -> type;
								if(node -> type == 0){
									// byte
									emit(NOLABEL, _CLOADAI, node -> regNum, node -> offset, resNode -> regNum);
								} else {
									// word
									emit(NOLABEL, _LOADAI, node -> regNum, node -> offset, resNode -> regNum);
								}
								$$ = resNode;
							}else {
								$$ = $1;
							}	
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
        | NAME '[' Exprs ']' {
				  	SymbolEntry * node = lookupTable($1);
						if (node == NULL){
							yyerror("Variable has not beed declared\n");
						} else{
							SymbolEntry * offsetNode = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
							offsetNode->regNum = getNextRegister();
							SymbolEntry * accNode = (SymbolEntry*) malloc(sizeof(SymbolEntry));
							accNode->regNum = getNextRegister();
							SymbolEntry * dimOffsetNode = (SymbolEntry*) malloc(sizeof(SymbolEntry));
							dimOffsetNode->regNum = getNextRegister();

							ExprsRef *exprsNode = $3;

							int i;
							for(i = 0; i < node->dimension; i++){
								if(exprsNode->indices[i] -> isImme) {
									SymbolEntry * tmp = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
									tmp -> regNum = getNextRegister();
									emit(NOLABEL, _LOADI, exprsNode->indices[i] -> regNum, tmp->regNum, EMPTY);
									exprsNode->indices[i] = tmp;
								}
								emit(NOLABEL, _SUBI, exprsNode->indices[i]->regNum, node->dim[i][0], dimOffsetNode->regNum);

								if(i == 0){
										emit(NOLABEL, _LOADI, node->dim[0][1] - node->dim[0][0] + 1, accNode->regNum, EMPTY);
										emit(NOLABEL, _I2I, dimOffsetNode->regNum, offsetNode->regNum, EMPTY);
								} else {
									  emit(NOLABEL, _MULT, dimOffsetNode->regNum, accNode->regNum, dimOffsetNode->regNum);
										emit(NOLABEL, _ADD, dimOffsetNode->regNum, offsetNode->regNum, offsetNode->regNum);
										emit(NOLABEL, _MULTI, accNode->regNum, node->dim[i][1] - node->dim[i][0] + 1, accNode->regNum);
								}
							}
							
							if(node->type == 1){
									emit(NOLABEL, _MULTI, offsetNode->regNum, 4, offsetNode->regNum);
							}

							node->regNum = offsetNode->regNum;
							$$ = node;
						}
					}
				;
// Exprs    : Expr ',' Exprs 
Exprs     	: Exprs ',' Expr {
								ExprsRef *node = (ExprsRef*) malloc(sizeof(ExprsRef)); 
								node -> indices[node->dimension] = $3;
								node -> dimension++;

								$$ = node;
							}
          	| Expr {
								ExprsRef *node = (ExprsRef*) malloc(sizeof(ExprsRef)); 
								node -> dimension = 0;
								node -> indices[node->dimension] = $1;
								node -> dimension++;

								$$ = node;
			  		}
			;

%%                    
 /* C code */
