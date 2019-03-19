#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbolTable.h"

#define HASH_TABLE_SIZE 499  // max prime in 1-500
extern int globalOffset;   // start addr in memory (just for array)

static SymbolEntry **HashTable;  // look up will return an address

static int getHash(char* name) {
    int hashValue = 1;
    int i;

    for (i=0; i < strlen(name); i++) {
        hashValue = (hashValue * name[i]) % HASH_TABLE_SIZE;
    }

    return hashValue;
}

void initTable() {
    // array of address (pointer to symbol table entry)
    HashTable = (SymbolEntry **) malloc(sizeof(SymbolEntry*) * HASH_TABLE_SIZE);  
    int i;

    for (i=0; i < HASH_TABLE_SIZE; i++) {
        HashTable[i] = NULL;
    }
}

SymbolEntry* lookupTable(char* name) {
    int visitedNum = 0;  
    int curIndex = getHash(name);

    while (HashTable[curIndex] != NULL && visitedNum < HASH_TABLE_SIZE) {
        // find the entry
        if (!strcmp(HashTable[curIndex]->name, name)) {
            return HashTable[curIndex];
        }
        // otherwise continue
        curIndex = (curIndex + 1) % HASH_TABLE_SIZE; 
        visitedNum++;
    }

    return NULL;
}

void insertToTable(char *name, int type, int regNum, int isArray, int dimension, int dim[MAX_DIMENSION][2]) {
    int visitedNum = 0;  
    int curIndex = getHash(name);
 
    while (HashTable[curIndex] != NULL && visitedNum < HASH_TABLE_SIZE) {
        // find the entry
        if (!strcmp(HashTable[curIndex]->name, name)) {
            printf("Error: %s has already in symbol table.\n", name);
            return;
        }
        curIndex = (curIndex + 1) % HASH_TABLE_SIZE; 
        visitedNum++;
    }

    // no space for new name
    if (visitedNum == HASH_TABLE_SIZE) {
        printf("Error: No space in symbol table \n");
        return;
    }

    // malloc entry's memory
    HashTable[curIndex] = (SymbolEntry*) malloc(sizeof(SymbolEntry)); 
    // copy the string src to dst (including
    HashTable[curIndex] -> name = (char *) malloc(strlen(name) + 1); 
    strcpy(HashTable[curIndex]->name, name);

    HashTable[curIndex] -> type = type; 
    HashTable[curIndex] -> regNum = regNum; 
    HashTable[curIndex] -> isArray = isArray;
    
    // array
    if (isArray){
        HashTable[curIndex] -> dimension = dimension;

        // int array must word aligned
        while (globalOffset % 4 != 0) {
            globalOffset++;
        }
        HashTable[curIndex] -> offset = globalOffset;
        int i;
        int wid;
        int space;
        for (i = 0; i < dimension; i++) {
            HashTable[curIndex] -> dim[i][0] = dim[i][0];
            HashTable[curIndex] -> dim[i][1] = dim[i][1];
            
            if (i == 0){
                space = dim[i][1] - dim[i][0] + 1;
            } else {
                space = space * (dim[i][1] - dim[i][0] + 1);  //[0:3, 1:3, 1:3] -> 4 * 3 * 3  
            }
        }
        wid = (type == 0) ? 1 : 4;  // char: 1, int: 4
        space = space * wid;
        HashTable[curIndex] -> space = space;

        globalOffset += space;  // for next array start position in memory
    } else{
        // scalar
        HashTable[curIndex] -> regNum = regNum;
    }
}

char* printType(int type){
    switch (type) { 
        case 0: 
            return "CHAR";	
        case 1: 
            return "INT"; 
        default: 
            printf("some error in type \n");
            return "";
        }
}

void printTable() {
    printf("\n ----------- Symbol Table -----------\n");
    int i;
    for(i=0; i < HASH_TABLE_SIZE; i++){
        if(HashTable[i] != NULL) {
            // print array
            if(HashTable[i] -> isArray) {
                printf("\nName:%s, Type:%s, Address:%d, dimensions:%d, dim:", HashTable[i]->name, printType(HashTable[i]->type), HashTable[i]->offset, HashTable[i]->dimension); 
                // [1:4,0:3]
                printf("[");
                int j;
        
                // print each dimension
                for(j=0; j<HashTable[i]->dimension; j++){
                    printf("%d:%d", HashTable[i]->dim[j][0], HashTable[i]->dim[j][1]);
                    if(j != HashTable[i]->dimension-1){
                        printf(", ");
                    }
                }
                printf("]\n");
            } 
        }
    }
    printf("\n");
    for(i=0; i < HASH_TABLE_SIZE; i++){ 
        if(HashTable[i] != NULL) {
             // print single variable
            if(!HashTable[i] -> isArray) {
                printf("\nName:%s, Type:%s, Address:r%d, dimensions:/\n", HashTable[i]->name, printType(HashTable[i]->type), HashTable[i]->regNum); 
            }
        }
    }
    printf("\n --------------------------------\n");
}

