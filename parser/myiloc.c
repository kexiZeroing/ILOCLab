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
        case NOP: 
            fprintf(outfile, "%s\t nop \n", label);
            break;
        case ADD:
            fprintf(outfile, "%s\t add r%d, r%d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
        case ADDI:
            fprintf(outfile, "%s\t addI r%d, %d \t=> r%d \n", label, addr1, addr2, addr3);
            break;
    }

  
}