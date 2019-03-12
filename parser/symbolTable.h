#include <string.h>

typedef enum type {TYPE_INT=0, TYPE_CHAR=1} Type;

typedef struct {
  char *name;
  int index;
  Type type;
  int isArray;  // 1 for array; 0 for scalar
} SymbolEntry;

extern void InitSymbolTable();

extern SymbolEntry* lookup(char *name);

extern void insert(char *name, Type type, int index);

extern void PrintSymbolTable();
