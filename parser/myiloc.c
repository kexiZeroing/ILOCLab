#include <stdio.h>
#include <stdlib.h>
#include "myiloc.h"

int getNextRegister(){
    return globalReg++;
}

int getNextLabel(){
    return globalLabel++;
}

void emit(int labelIdx, Opcode opcode, int addr1, int addr2, int addr3){
    char *label = "";

    // has label
    if (labelIdx > NOLABEL) {
        label = (char *) malloc(60);
        sprintf(label, "L%d:", labelIdx);  // copy string
    }

    // out put ILOC
    switch (opcode) { 
        // Computational Operations
        case NOP: 
            fprintf(output, "%s\t nop \n", label);
            break;
        case _ADD:
            fprintf(output, "%s\t add r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _ADDI:
            fprintf(output, "%s\t addI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _SUB:
            fprintf(output, "%s\t sub r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _SUBI:
            fprintf(output, "%s\t subI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _MULT:
            fprintf(output, "%s\t mult r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _MULTI:
            fprintf(output, "%s\t multI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _DIV:
            fprintf(output, "%s\t div r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _DIVI:
            fprintf(output, "%s\t divI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;

        case _LSHIFT:
            fprintf(output, "%s\t lshift r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _LSHIFTI:
            fprintf(output, "%s\t lshiftI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _RSHIFT:
            fprintf(output, "%s\t rshift r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _RSHIFTI:
            fprintf(output, "%s\t rshiftI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;

        case _AND:
            fprintf(output, "%s\t and r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _ANDI:
            fprintf(output, "%s\t andI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _OR:
            fprintf(output, "%s\t or r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _ORI:
            fprintf(output, "%s\t orI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _NOT:
            fprintf(output, "%s\t not r%d \t=> r%d \n", label, addr1, addr2);
            break;

        // Data-Movement Operations
        case _LOAD: 
            fprintf(output, "%s\t load r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _LOADI: 
            fprintf(output, "%s\t loadI %d \t=> r%d \n", label, addr1, addr2);
            break;
        case _LOADAI: 
            fprintf(output, "%s\t loadAI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _LOADAO: 
            fprintf(output, "%s\t loadAO r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _CLOAD: 
            fprintf(output, "%s\t cload r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _CLOADAI: 
            fprintf(output, "%s\t cloadAI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case _CLOADAO: 
            fprintf(output, "%s\t cloadAO r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        
        case _STORE: 
            fprintf(output, "%s\t store r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _STOREAI: 
            fprintf(output, "%s\t storeAI r%d \t=> r%d, %d \n", label, addr1, addr2, addr3);
            break;
        case _STOREAO: 
            fprintf(output, "%s\t storeAO r%d \t=> r%d, r%d \n", label, addr1, addr2, addr3);
            break;
        case _CSTORE: 
            fprintf(output, "%s\t cstore r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _CSTOREAI: 
            fprintf(output, "%s\t cstoreAI r%d \t=> r%d, %d \n", label, addr1, addr2, addr3);
            break;
        case _CSTOREAO: 
            fprintf(output, "%s\t cstoreAO r%d \t=> r%d, r%d \n", label, addr1, addr2, addr3);
            break;

        case _I2I: 
            fprintf(output, "%s\t i2i r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _C2C: 
            fprintf(output, "%s\t c2c r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _I2C: 
            fprintf(output, "%s\t i2c r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case _C2I: 
            fprintf(output, "%s\t c2i r%d \t=> r%d \n", label, addr1, addr2);
            break;

        // Control-Flow Operations
        case _BR: 
            fprintf(output, "%s\t br \t-> L%d\n", label, addr1);
            break;
        case _CBR: 
            fprintf(output, "%s\t cbr r%d \t-> L%d, L%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_LT: 
            fprintf(output, "%s\t cmp_LT r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_LE: 
            fprintf(output, "%s\t cmp_LE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_GT: 
            fprintf(output, "%s\t cmp_GT r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_GE: 
            fprintf(output, "%s\t cmp_GE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_EQ: 
            fprintf(output, "%s\t cmp_EQ r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _CMP_NE: 
            fprintf(output, "%s\t cmp_NE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case _HALT: 
            fprintf(output, "%s\t halt \n", label);
            break;

        // Input and Output Operations
        case _READ: 
            fprintf(output, "%s\t read \t=> r%d\n", label, addr1);
            break;
        case _CREAD: 
            fprintf(output, "%s\t cread \t=> r%d\n", label, addr1);
            break;
        case _OUTPUT: 
            fprintf(output, "%s\t output \t %d\n", label, addr1);
            break;
        case _COUTPUT: 
            fprintf(output, "%s\t coutput \t %d\n", label, addr1);
            break;
        case _WRITE: 
            fprintf(output, "%s\t write \t r%d\n", label, addr1);
            break;
        case _CWRITE: 
            fprintf(output, "%s\t cwrite \t r%d\n", label, addr1);
            break;

        // maybe never run here
        default:
            printf("Error: Illegal ILOC Code");
    }

}