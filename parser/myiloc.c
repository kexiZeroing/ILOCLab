#include <stdio.h>
#include <stdlib.h>
#include "myiloc.h"

static nextRegister = 0; 
static nextLabel = 0;
static nextOffset = 0;

int getNextRegister(){
    return nextRegister++;
}

int getNextLabel(){
    return nextLabel++;
}

int getNextOffset(int units){ 
    int tmp = nextOffset;
    nextOffset += units * 4;
    return tmp;
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
        case ADD:
            fprintf(output, "%s\t add r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case ADDI:
            fprintf(output, "%s\t addI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case SUB:
            fprintf(output, "%s\t sub r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case SUBI:
            fprintf(output, "%s\t subI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case MULT:
            fprintf(output, "%s\t mult r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case MULTI:
            fprintf(output, "%s\t multI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case DIV:
            fprintf(output, "%s\t div r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case DIVI:
            fprintf(output, "%s\t divI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;

        case LSHIFT:
            fprintf(output, "%s\t lshift r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case LSHIFTI:
            fprintf(output, "%s\t lshiftI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case RSHIFT:
            fprintf(output, "%s\t rshift r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case RSHIFTI:
            fprintf(output, "%s\t rshiftI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;

        case AND:
            fprintf(output, "%s\t and r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case ANDI:
            fprintf(output, "%s\t andI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case OR:
            fprintf(output, "%s\t or r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case ORI:
            fprintf(output, "%s\t orI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case NOT:
            fprintf(output, "%s\t not r%d \t=> r%d \n", label, addr1, addr2);
            break;

        // Data-Movement Operations
        case LOAD: 
            fprintf(output, "%s\t load r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case LOADI: 
            fprintf(output, "%s\t loadI %d \t=> r%d \n", label, addr1, addr2);
            break;
        case LOADAI: 
            fprintf(output, "%s\t loadAI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case LOADAO: 
            fprintf(output, "%s\t loadAO r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case CLOAD: 
            fprintf(output, "%s\t cload r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case CLOADAI: 
            fprintf(output, "%s\t cloadAI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case CLOADAO: 
            fprintf(output, "%s\t cloadAO r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        
        case STORE: 
            fprintf(output, "%s\t store r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case STOREAI: 
            fprintf(output, "%s\t storeAI r%d \t=> r%d, %d \n", label, addr1, addr2, addr3);
            break;
        case STOREAO: 
            fprintf(output, "%s\t storeAO r%d \t=> r%d, r%d \n", label, addr1, addr2, addr3);
            break;
        case CSTORE: 
            fprintf(output, "%s\t cstore r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case CSTOREAI: 
            fprintf(output, "%s\t cstoreAI r%d \t=> r%d, %d \n", label, addr1, addr2, addr3);
            break;
        case CSTOREAO: 
            fprintf(output, "%s\t cstoreAO r%d \t=> r%d, r%d \n", label, addr1, addr2, addr3);
            break;

        case I2I: 
            fprintf(output, "%s\t i2i r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case C2C: 
            fprintf(output, "%s\t c2c r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case I2C: 
            fprintf(output, "%s\t i2c r%d \t=> r%d \n", label, addr1, addr2);
            break;
        case C2I: 
            fprintf(output, "%s\t c2i r%d \t=> r%d \n", label, addr1, addr2);
            break;

        // Control-Flow Operations
        case BR: 
            fprintf(output, "%s\t br \t-> L%d\n", label, addr1);
            break;
        case CBR: 
            fprintf(output, "%s\t cbr r%d \t-> L%d, L%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_LT: 
            fprintf(output, "%s\t cmp_LT r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_LE: 
            fprintf(output, "%s\t cmp_LE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_GT: 
            fprintf(output, "%s\t cmp_GT r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_GE: 
            fprintf(output, "%s\t cmp_GE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_EQ: 
            fprintf(output, "%s\t cmp_EQ r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case CMP_NE: 
            fprintf(output, "%s\t cmp_NE r%d, r%d \t=> r%d\n", label, addr1, addr2, addr3);
            break;
        case HALT: 
            fprintf(output, "%s\t halt \n", label);
            break;

        // Input and Output Operations
        case READ: 
            fprintf(output, "%s\t read \t=> r%d\n", label, addr1);
            break;
        case CREAD: 
            fprintf(output, "%s\t cread \t=> r%d\n", label, addr1);
            break;
        case OUTPUT: 
            fprintf(output, "%s\t output \t %d\n", label, addr1);
            break;
        case COUTPUT: 
            fprintf(output, "%s\t coutput \t %d\n", label, addr1);
            break;
        case WRITE: 
            fprintf(output, "%s\t write \t r%d\n", label, addr1);
            break;
        case CWRITE: 
            fprintf(output, "%s\t cwrite \t r%d\n", label, addr1);
            break;

        // maybe never run here
        default:
            printf("Error: Illegal ILOC Code");
    }

}