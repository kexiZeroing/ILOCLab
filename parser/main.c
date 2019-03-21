#include <stdio.h>
#include "symbolTable.h"
int yylineno;
int errorCount = 0;

FILE *yyin;
FILE *output;

// must have yyerror, yywrap
int yyerror (const char *s) {	
	errorCount += 1;
	fprintf(stderr, "\nLine %d has an error: %s\n", yylineno, s);
}

int yywrap (void) {return 1;}  // means end

char* getOutputName(char* str){
			int i = 0;
			while(str[i] != '.') i++;
			char * prefix = strndup(str, i);
			return strcat(prefix, ".i");
}

int main (int argc, char* argv[]) {
	int printHelp = 0;
	int printVar = 0;

	char *outputName = "";

	// ./demo -h test1.demo
	if (argc == 3) {
		char *tmpH = "-h";
		char *tmpS = "-s";
		if (strcmp(argv[1], tmpH) == 0){
			printHelp = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s\n", argv[2]);
				return 0;
			}else {
				outputName = getOutputName(argv[2]);
			}
		}else if(strcmp(argv[1], tmpS) == 0){
			printVar = 1;
			yyin = fopen(argv[2], "r");
			if (!yyin){
				printf("error, unable to open file %s\n", argv[2]);
				return 0;
			}else {
				outputName = getOutputName(argv[2]);
			}
		}else if(argv[1][0] == '-'){
			printf("no option '-%c', please use -h to check.\n", argv[1][1]);
			return 0;
		}else {
			printf("wrong parameter, please use -h to check.\n");
			return 0;
		}
	}
	// ./demo -h  or ./demo test1.demo
	else if(argc == 2) {
		char *tmpH = "-h";
		if (strcmp(argv[1], tmpH) == 0){
			printHelp = 1;
		}else if(argv[1][0] == '-'){
			printf("no option '-%c', please use -h to check.\n", argv[1][1]);
			return 0;
		}else {
			yyin = fopen(argv[1], "r");
			if(!yyin) {
				printf("error, unable to open file %s\n", argv[1]);
				return 0;
			} else {
				outputName = getOutputName(argv[1]);
			}
		}
	}

	// handle all printHelp
	if (printHelp == 1){
        printf("========== Command help start ==========\n");
        printf("./demo -h: check command line syntax\n");
        printf("./demo filename: compile target file\n");
				printf("./demo -s filename: print symbol table\n");
        printf("./demo: compile from stdin, ^D to EOF\n");
				printf("========== Command help end ==========\n");

				if(argc == 2) {
					return 0;
				}
    }
	
	output = fopen(outputName, "w");
	if (output == NULL) { 
			printf("error, unable to open output file %s \n", outputName);
			return 0;
	}

	initTable();

	yyparse();
  
	fclose(output);

	if (errorCount == 0) {
		printf("Parse succeeds!\n");  //ctrl+d if use stdin

		// print all the variables 
		if(printVar == 1){
			printTable();
		}
	} else {
		remove(outputName);   // don't generate iloc file if parse failed
		printf("Parser fails. Total number of errors: %d\n", errorCount);
	}
	return 0;
}