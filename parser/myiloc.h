#include <stdio.h>

#define EMPTY 0   // default addr in ILOC
#define NOLABEL -1  // label > -1

typedef enum opcode {
    NOP=0, _ADD, _ADDI, _SUB, _SUBI, _MULT, _MULTI, _DIV, _DIVI, _LSHIFT, _LSHIFTI, _RSHIFT, _RSHIFTI,
    _AND, _ANDI, _OR, _ORI, _NOT, _LOADI, _LOAD, _LOADAI, _LOADAO, _CLOAD, _CLOADAI, _CLOADAO, _STORE, _STOREAI, _STOREAO, _CSTORE, _CSTOREAI, _CSTOREAO, _I2I, _C2C, _I2C, _C2I, _BR, _CBR, _CMP_LT, _CMP_LE, _CMP_EQ, _CMP_NE, _CMP_GT, _CMP_GE, _HALT, _READ, _CREAD, _OUTPUT, _COUTPUT, _WRITE, _CWRITE
} Opcode;

extern FILE* output;
extern int globalOffset;
extern int globalReg;
extern int globalLabel;
extern int getNextRegister();

extern int getNextLabel();

extern void emit(int labelIdx, Opcode opcode, int addr1, int addr2, int addr3);  // 3 address ILOC
