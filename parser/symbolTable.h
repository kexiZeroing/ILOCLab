#include <string.h>

#define MAX_DIMENSION 4

typedef struct {
  char *name;
  int regNum;    //in reg (value for immediate, offset for array access)
  int type;      // 0 for char, 1 for int
  int isArray;   // 1 for array; 0 for scalar
  int offset;    // in memory (array start address)
  int dimension;   // array's dimension
  int dim[MAX_DIMENSION][2];  // bound for each dimension
  int space;      // total space for array, calculate when insert to table 
  int isImme;    // 1 for immediate value
} SymbolEntry;

typedef struct {
  char *name;
  int dimension;
  SymbolEntry * indices[MAX_DIMENSION];   // index for each dimension
} ExprsRef;

extern void initTable();

extern SymbolEntry* lookupTable(char *name);

extern void insertToTable(char *name, int type, int regNum, int isArray, int dimension, int dim[MAX_DIMENSION][2]);

extern void printTable();
