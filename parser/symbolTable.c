#include <stdlib.h>
#include <string.h>
#include "symbolTable.h"

#define HASH_TABLE_SIZE 499  // max prime in 1-500

static SymbolEntry **HashTable;  // look up will return an address

static int getHash(char* name) {
    int hashValue = 1;

    for (int i=0; i < strlen(name); i++) {
    hashValue = (hashValue * name[i]) % HASH_TABLE_SIZE;
    }

    return hashValue;
}

void initTable() {
    // array of address (pointer to symbol table entry)
    HashTable = (SymbolEntry **) malloc(sizeof(SymbolEntry*) * HASH_TABLE_SIZE);  

    for (int i=0; i < HASH_TABLE_SIZE; i++) {
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

void insertToTable(char* name, Type type, int index, int isArray) {
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
    HashTable[curIndex] -> index = index; 
    HashTable[curIndex] -> isArray = isArray;
}

void printTable() {
    printf("\n ----------- Symbol Table -----------\n");

    for(int i=0; i < HASH_TABLE_SIZE; i++){
        // scalar
        if(HashTable[i] != NULL && HashTable[i] -> isArray == 0) {
            printf("Scalar: %s has type %s with offset %d\n", HashTable[i]->name, printType(HashTable[i]->type), HashTable[i]->index); 
        }
        // array
        if(HashTable[i] != NULL && HashTable[i] -> isArray == 1) {
            printf("Array: %s has element of type %s with offset %d\n", HashTable[i]->name, printType(HashTable[i]->type), HashTable[i]->index); 
        }
    }
    printf("\n --------------------------------\n\n");
}

static char* printType(Type type){
    switch (type) { 
        case TYPE_INT: 
            return "integer";	
        case TYPE_CHAR: 
            return "char"; 
        default: 
            printf("some error in type \n");
        }
}
