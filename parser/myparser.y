/* C declarations */
%{
#include <stdio.h>
#include "symbolTable.h"
#include "myiloc.h"
extern int yylineno;
extern int errorCount;

int CUR_TYPE;  // 0 for char, 1 for int
int globalOffset = 0;
int globalReg = 0;
int globalLabel = 0;
%}

/* Bison declarations */
%error-verbose

// type for non-terminal structure
%union{
  struct SymbolEntry *entry;
	struct ExprsRef *exprsRef;
	struct IfStructure *ifStructure;
	struct WhileStructure *whileStructure;
	struct ForStructure *forStructure;
	char* string;
	int int_val;
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

%type <entry> Stmt Stmts Expr Reference Factor Term RelExpr Bool OrTerm AndTerm Bound Bounds WithElse NonIf
%type <ifStructure> IFHead IFMid
%type <whileStructure> WhileHead
%type <forStructure> ForHead
%type <exprsRef> Exprs

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
					// error for duplicate variable name
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
						SymbolEntry *node = (SymbolEntry*)$3;
						// node->dim has the information about the bound of array
						// if a is array, use a = 1 will get r-1. So report error when reference array as a scalar
						insertToTable($1, CUR_TYPE, -1, 1, node->dimension, node->dim); 
					}
				}
			;
Bounds		: Bounds ',' Bound {  
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;

					// accumulate dimension
					// Bounds has already reduced for 1 dimension, add the next dimension from Bound info
					// dim's first index just same as current $1's dimension
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
					// define the node that would be delivered up
					SymbolEntry *node = malloc(sizeof(SymbolEntry));
					node->dimension = 1;

					// know the below and upper bound of one dimension here
					node->dim[0][0] = $1;
					node->dim[0][1] = $3;

					$$ = node;
				}
			;
Stmts		: Stmts Stmt 
	 		| Stmt 
	 		;
Stmt    : IFHead THEN Stmt {
					IfStructure *ifNode = (IfStructure*)$1;
					emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
				}
      | IFMid Stmt {
						IfStructure *ifNode = (IfStructure*)$1;
						emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
						emit(ifNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	}
			| NonIf
			| '{' '}' { yyerror("Empty statement list is not allowed"); yyclearin; }
			| '{' ';' '}' { yyerror("Empty statement in a list is not allowed"); yyclearin; }
			| Reference '+' '=' Expr ';' { yyerror("Do not support '+=', only use '=' in assignment"); yyclearin; } 
			| Reference '=' Expr ';' ';' { yyerror("Unexpected semicolon. Empty statement is not allowed"); yyclearin; 
			}
			| WRITE '=' Expr ';' { yyerror("unexpected EQUALS, expecting CHARCONST or '(' or NAME or NUMBER, could not make an assignment to write"); yyclearin; }
			| NAME NAME ';' { yyerror("unexpected NAME. No such reserved word"); yyclearin; }
			| error ';'  { yyerror("Do not support this statement"); yyclearin; yyerrok; }
			;
NonIf    : Reference '=' Expr ';' {
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;

					// error if b = 1 if b is array  -> already checked in reference

					// if Expr is an array, it has been loaded in Factor
					// if Reference is an array, use the regNum as offset in StoreAI
					// store in memory
					if(node1 -> isArray == 1) {
							int tmpReg = getNextRegister();
							// immediate value need to be loaded first
							if (node2 -> isImme) {
									emit(NOLABEL, _LOADI, node2->regNum, tmpReg, EMPTY);
							}else{
									emit(NOLABEL, _I2I, node2->regNum, tmpReg, EMPTY);
							} 

							// type CHAR use cstore
							if(node1 -> type == 0){
									emit(NOLABEL, _CSTOREAI, tmpReg, node1->regNum, node1->offset);
							} else {
									emit(NOLABEL, _STOREAI, tmpReg, node1->regNum, node1->offset);
							}
					}
					// store in register
					else {
						if (node1 -> type == 0){
								emit(NOLABEL, _I2C, node2->regNum, node1->regNum, EMPTY);
						} else{
								if (node2 -> isImme) {
									emit(NOLABEL, _LOADI, node2->regNum, node1->regNum, EMPTY);
								}else {
									emit(NOLABEL, _I2I, node2->regNum, node1->regNum, EMPTY);
								}
						}
					}
				}
				| WhileHead '(' Bool ')' {
							WhileStructure *whileNode = (WhileStructure*)$1;
							SymbolEntry *node = $3;

							// body part
							emit(NOLABEL, _CBR, node->regNum, whileNode->secondLabel, whileNode->thirdLabel);
							emit(whileNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);  
						} '{' Stmts '}' {
							// exit part
							WhileStructure *whileNode = (WhileStructure*)$1;
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
			| READ Reference ';' {
					SymbolEntry *refNode = (SymbolEntry*)$2;

					SymbolEntry *resNode = malloc(sizeof(SymbolEntry));
					resNode->regNum = getNextRegister();
		
					if(refNode -> isArray == 0){
						if(refNode->type == 0){
							emit(NOLABEL, _CREAD, refNode->regNum, EMPTY, EMPTY);
						}else {
							emit(NOLABEL, _READ, refNode->regNum, EMPTY, EMPTY);
						}

					// array need be stored
					}else {
						if(refNode->type == 0){
							emit(NOLABEL, _CREAD, resNode->regNum, EMPTY, EMPTY);
							emit(NOLABEL, _CSTOREAI, resNode->regNum, refNode->regNum, refNode->offset);
						}else {
							emit(NOLABEL, _READ, resNode->regNum, EMPTY, EMPTY);
							emit(NOLABEL, _STOREAI, resNode->regNum, refNode->regNum, refNode->offset);
						}
					}					
				}
			| WRITE Expr ';' {
					SymbolEntry *node = (SymbolEntry*)$2;
					int tmpReg = getNextRegister();

					if(node -> isImme){
							emit(NOLABEL, _LOADI, node->regNum, tmpReg, EMPTY);
					} else {
							tmpReg = node->regNum;
					}

					// CHAR is cwrite; INT is write
					if (node -> type == 0){
						emit(NOLABEL, _CWRITE, tmpReg, EMPTY, EMPTY);
					} else{
						emit(NOLABEL, _WRITE, tmpReg, EMPTY, EMPTY);
					}
				}
			| '{' Stmts '}'
			;
ForHead		: FOR NAME '=' Expr TO Expr {
					// allocation
					ForStructure *forNode = malloc(sizeof(ForStructure));
					forNode->firstLabel = getNextLabel();
					forNode->secondLabel = getNextLabel();
					forNode->thirdLabel = getNextLabel();

					// init assign
					SymbolEntry *initNode = (SymbolEntry*)$4;

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
					SymbolEntry *resultNode = (SymbolEntry*)$6;

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
IFMid		: IFHead THEN WithElse ELSE {
				  	IfStructure *ifNode = $1;
						emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
						emit(ifNode->secondLabel, NOP, EMPTY, EMPTY, EMPTY);
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
WithElse	: IFMid WithElse{
							IfStructure *ifNode = (IfStructure*)$1;
							emit(NOLABEL, _BR, ifNode->thirdLabel, EMPTY, EMPTY);
							emit(ifNode->thirdLabel, NOP, EMPTY, EMPTY, EMPTY);
			  	}
			| NonIf
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
					SymbolEntry *node1 = (SymbolEntry*)$2;
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
							SymbolEntry *node1 = (SymbolEntry*)$1;
							SymbolEntry *node2 = (SymbolEntry*)$3;
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
								SymbolEntry *node1 = (SymbolEntry*)$1;
								SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					if(node1 -> isImme) {
						int reg1 = getNextRegister();
						emit(NOLABEL, _LOADI, node1 -> regNum, reg1, EMPTY);
						node1 -> regNum = reg1;
					} 
				
					SymbolEntry *node2 = (SymbolEntry*)$3;
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
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;

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
					node -> type = node1 -> type;
					$$ = node;
				}
			| Expr '-' Term  {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;
					
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
					node -> type = node1 -> type;
					$$ = node;
				}
			| Term {
					$$ = $1;
				}
			;
Term		: Term '*' Factor {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;

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
					node -> type = node1 -> type;
					$$ = node;
				}
			| Term '/' Factor {
					int tmpReg = getNextRegister();
					SymbolEntry *node1 = (SymbolEntry*)$1;
					SymbolEntry *node2 = (SymbolEntry*)$3;

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
					node -> type = node1 -> type;
					$$ = node;
				}
			| Factor {
					$$ = $1;
				}
			;
Factor		: '(' Expr ')'
         	| Reference {
							SymbolEntry * node = (SymbolEntry *) $1;

							// if ref is an array, need to load its offset (in regNum) first. 
							// otherwise is a single variable, just deliver up the node
							if(node -> isArray == 1){
									SymbolEntry * resNode = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
									resNode -> regNum = getNextRegister();
									resNode -> type = node -> type;
									resNode -> name = node -> name;
									resNode -> isArray = node -> isArray;

									// get real offset by adding base and offset
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
						node -> type = 1;
						node -> regNum = $1;  // just use regNum to represent value if immediate is true
						$$ = node;
				} 
	  		| CHARCONST {
						SymbolEntry * node = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
						node -> regNum = getNextRegister();
						node -> type = 0;
						emit(NOLABEL, _LOADI, $1, node -> regNum, EMPTY);
						$$ = node;
			  	}
	  		; 
Reference 	: NAME {
					SymbolEntry * node = lookupTable($1);
					// use before declaration
					if (node == NULL){
						yyerror("Variable has not beed declared.\n");
					} else if (node -> isArray == 1){
						// need to check array or scalar, cannot use array without specifying subscript or use scalar with the subscript
						// then deliver the information up
						yyerror("Cannot use the varaible array referenced as a scalar.\n");
					} else {
						$$ = node;
					}
				}
        | NAME '[' Exprs ']' {
				  	SymbolEntry * node = lookupTable($1);
						ExprsRef *exprsNode = (ExprsRef *)$3;

						if (node == NULL){
								yyerror("Variable has not beed declared.\n");
						} else if(node -> isArray == 0){
							  // cannot be single varaible
								yyerror("Cannot use the scalar varaible with subscript.\n");
						} else if(node -> dimension != exprsNode -> dimension){
								yyerror("Using varaible array's dimension is not same as the declaration.\n");
						}	else {
							// need to compute the real offset of the reference (spread in one dimension)

							// the node need to be delivered up
							SymbolEntry * offsetNode = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
							offsetNode->regNum = getNextRegister();

							int oneDimOffsetReg = getNextRegister();
							int accDimReg = getNextRegister();

							// compute the offset by column major order
							// [2,a] -> (a-low2) * dim1 + (2-low1)
							// [2,a,3] -> [(3-low3) * dim2 + (a-low2)]* dim1 + (2-low1) -> (3-low3) * dim2 * dim1 + (a-low2) * dim1 + (2-low1)
							int i;
							for(i = 0; i < node->dimension; i++){
								// subscript is an immediate value, need loadI first
								if(exprsNode->indices[i] -> isImme) {
									SymbolEntry * tmp = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
									tmp -> regNum = getNextRegister();
									emit(NOLABEL, _LOADI, exprsNode->indices[i]->regNum, tmp->regNum, EMPTY);
									exprsNode->indices[i] = tmp;
								}
								// offset for each dimension
								emit(NOLABEL, _SUBI, exprsNode->indices[i]->regNum, node->dim[i][0], oneDimOffsetReg);

								if(i == 0){
									  if(node->dimension > 1) {
											emit(NOLABEL, _LOADI, node->dim[0][1] - node->dim[0][0] + 1, accDimReg, EMPTY);
										}
										emit(NOLABEL, _I2I, oneDimOffsetReg, offsetNode->regNum, EMPTY);
								} else {
									  emit(NOLABEL, _MULT, oneDimOffsetReg, accDimReg, oneDimOffsetReg);
										emit(NOLABEL, _ADD, oneDimOffsetReg, offsetNode->regNum, offsetNode->regNum);
										if(i != node->dimension-1){
											emit(NOLABEL, _MULTI, accDimReg, node->dim[i][1] - node->dim[i][0] + 1, accDimReg);
										}
								}
							}
							
							// for type INT
							if(node->type == 1){
								emit(NOLABEL, _MULTI, offsetNode->regNum, 4, offsetNode->regNum);
							}

							// store all the info from $1 to offsetNode (hold computed offset information) 
							offsetNode->type = node->type;
							offsetNode->name = node->name;
							offsetNode->isArray = node->isArray;
							offsetNode->offset = node->offset;
							offsetNode->dimension = node->dimension;

							int j;
							for(j=0; j<node->dimension; j++) {
								offsetNode->dim[j][0] = node->dim[j][0];
								offsetNode->dim[j][1] = node->dim[j][1];
							}
							offsetNode->space = node->space;

							$$ = offsetNode;
						}
					}
				;
// Exprs    : Expr ',' Exprs 
Exprs     	: Exprs ',' Expr {
								// same method in processing Bounds
								ExprsRef *node = (ExprsRef*)$1;
								node -> indices[node->dimension] = $3;
								node -> dimension++;

								$$ = node;
							}
          	| Expr {
								ExprsRef *node = (ExprsRef*) malloc(sizeof(ExprsRef)); 
								node -> indices[0] = $1;
								node -> dimension = 1;

								$$ = node;
			  		}
			;

%%                    
 /* C code */
