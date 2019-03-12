#include <stdio.h>

#define EMPTY 0   // default addr in ILOC
#define NOLABEL -1  // label > -1

typedef enum opcode {
    NOP=0, ADD, ADDI, SUB, SUBI, MULT, MULTI, DIV, DIVI, LSHIFT, LSHIFTI, RSHIFT, RSHIFTI, 
    AND, ANDI, OR, ORI, NOT, LOADI, LOAD, LOADAI, LOADAO, CLOAD, CLOADAI, CLOADAO, STORE, STOREAI, STOREAO, CSTORE, CSTOREAI, CSTOREAO, I2I, C2C, I2C, C2I, BR, CBR, CMP_LT, CMP_LE, CMP_EQ, CMP_NE, CMP_GT, CMP_GE, HALT, READ, CREAD, OUTPUT, COUTPUT, WRITE, CWRITE
} Opcode;

extern FILE* outfile;

extern int getNextRegister();

extern int getNextLabel();

extern int getNextOffset(int units);

extern void emit(int labelIdx, Opcode opcode, int addr1, int addr2, int addr3);  // 3 address ILOC
