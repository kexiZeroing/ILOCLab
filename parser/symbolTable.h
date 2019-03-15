#include <string.h>

#define MAX_DIMENSION 3

typedef struct {
  char *name;
  int regNum;   //in reg
  int type;   // 0 for char, 1 for int
  int isArray;  // 1 for array; 0 for scalar
  int offset;   // in memory
  int dimension;
  int dim[MAX_DIMENSION][2]; // first is low index, second is high index
  int space;
} SymbolEntry;

extern void initTable();

extern SymbolEntry* lookupTable(char *name);

extern void insertToTable(char *name, int type, int regNum, int isArray, int offset, int dimension, int dim[MAX_DIMENSION][2]);

extern void printTable();
