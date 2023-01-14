// #include "pch.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define NUMREGS 32 /* number of machine registers */
#define MAXLINELENGTH 1000
#define MEMSIZE 0x7fff	/* maximum number of memory words */

#define FUNCT7_SHIFT		25
#define RS2_SHIFT				20
#define RS1_SHIFT				15
#define FUNCT3_SHIFT		12
#define RD_SHIFT					7
#define LW_IMM_SHIFT		20
#define ADDI_IMM_SHIFT	20

#define OP_MASK					0x7F
#define REG_MASK				0x1F
#define FUNC3_MASK			0x7
#define FUNC7_MASK			0x7F
#define LW_IMM_MASK		0xFFF
#define ADDI_IMM_MASK	0xFFF

#define BEQ_OP			0x63
#define LW_OP				0x03
#define SW_OP				0x23
#define ADDI_OP			0x13
#define REG_REG_OP  0x33
#define HALT_OP			0x3F

//func7段
#define ADD_FUNC7	0x0
#define SUB_FUNC7		0x20
#define SLL_FUNC7		0x0
#define SRL_FUNC7		0x0
#define OR_FUNC7		0x0
#define AND_FUNC7	0x0
//funct3
#define BEQ_FUNCT3	0x0
#define LW_FUNCT3		0x2
#define SW_FUNCT3	0x2
#define ADDI_FUNCT3 0x0
#define ADD_FUNC3	0x0
#define SUB_FUNC3		0x0
#define SLL_FUNC3		0x01
#define SRL_FUNC3		0x05
#define OR_FUNC3		0x06
#define AND_FUNC3	0x07


typedef struct stateStruct {
	int pc;
	int mem[MEMSIZE];
	int reg[NUMREGS];
	int numMemory;
} stateType, *Pstate;

void printState(Pstate);
void run(Pstate);

int Instructions = 0;

/************************************************************/
int main(int argc, char **argv)
{
	int i;
	char line[MAXLINELENGTH];
	stateType state;
	FILE *filePtr;

	if (argc != 2) {
		printf("error: usage: %s <machine-code file>\n", argv[0]);
		exit(1);
	}

	/* initialize memories and registers */
	for (i = 0; i < MEMSIZE; i++) {
		state.mem[i] = 0;
	}
	for (i = 0; i < NUMREGS; i++) {
		state.reg[i] = 0;
	}

	state.pc = 0;

	/* read machine-code file into instruction/data memory (starting at
	   address 0) */
	filePtr = fopen(argv[1], "r");
	if (filePtr == NULL) {
		printf("error: can't open file %s\n", argv[1]);
		perror("fopen");
		exit(1);
	}

	for (state.numMemory = 0; fgets(line, MAXLINELENGTH, filePtr) != NULL; state.numMemory++) {
		if (sscanf(line, "%x", &(state.mem[state.numMemory])) != 1) {
			printf("error in reading address %hd\n", state.numMemory);
			exit(1);
		}
		printf("memory[%d]=%08x\n", state.numMemory,state.mem[state.numMemory]);
		fflush(stdout);
	}

	printf("\n");

	run(&state);

	printState(&state);
}
/************************************************************/

/************************************************************/
void run(Pstate state)
{
	int i;
	int rs2, rs1, rd, immField, func7,func3;
	int opcode;
	int word_pc;
	int imm;

	for (; 1; Instructions++) { /* infinite loop, exits when it executes halt */

		/* decode the instruction */
		word_pc = state->pc >> 2;
		opcode = (state->mem[word_pc] ) & OP_MASK;
  /* STUDENT CODE START HERE. */	
		rd = (state->mem[word_pc] >> RD_SHIFT) & REG_MASK;
		func3 = (state->mem[word_pc] >> FUNCT3_SHIFT) & FUNC3_MASK;
		rs1 = (state->mem[word_pc] >> RS1_SHIFT) & REG_MASK;
		rs2 = (state->mem[word_pc] >> RS2_SHIFT) & REG_MASK;
		func7 = (state->mem[word_pc] >> FUNCT7_SHIFT) & FUNC7_MASK;
		state->pc += 4;
		if (opcode == ADDI_OP) {
			immField = state->mem[word_pc] >> ADDI_IMM_SHIFT;
		}
		else if (opcode == LW_OP) {
			immField = state->mem[word_pc] >> LW_IMM_SHIFT;
		}
		else if (opcode == SW_OP) {
			immField = ((state->mem[word_pc] >> 20) & 0xFFFFFFE0) | ((state->mem[word_pc] >> RD_SHIFT) & REG_MASK);
		}
		else if (opcode == BEQ_OP) {
			immField = ((state->mem[word_pc]>>19) & 0xFFFFF000) | ((state->mem[word_pc] & 0x80)<<4 | ((state->mem[word_pc]>>20) & 0x7E0) | ((state->mem[word_pc]>>8) & 0xF)<<1);
		}
		// printf("%d %d %d %d %d %x %x %x\n", rd, rs1, rs2, immField, imm, func3, func7, opcode);
  /* STUDENT CODE END. */		

		/* execute the instruction */
		if (opcode == ADDI_OP) {
			state->reg[rd] = state->reg[rs1] + immField;
		}
  /* STUDENT CODE START HERE. */	
		else if ((opcode==REG_REG_OP) && (func3==AND_FUNC3)) {
			state->reg[rd] = state->reg[rs1] & state->reg[rs2];
		}
		else if ((opcode==REG_REG_OP) && (func3==OR_FUNC3)) {
			state->reg[rd] = state->reg[rs1] | state->reg[rs2];
		}
		else if ((opcode==REG_REG_OP) && (func3==SRL_FUNC3)) {
			state->reg[rd] = state->reg[rs1] >> state->reg[rs2];
		}
		else if ((opcode==REG_REG_OP) && (func3==SLL_FUNC3)) {
			state->reg[rd] = state->reg[rs1] << state->reg[rs2];
		}
		else if ((opcode==REG_REG_OP) && (func7==SUB_FUNC7)) {
			state->reg[rd] = state->reg[rs1] - state->reg[rs2];
		}
		else if ((opcode==REG_REG_OP) && (func3==ADD_FUNC3)) {
			state->reg[rd] = state->reg[rs1] + state->reg[rs2];
		}
		else if (opcode == LW_OP) {
			state->reg[rd] = state->mem[(state->reg[rs1] + immField)>>2];			
		}
		else if (opcode == SW_OP) {
			state->mem[(state->reg[rs1] + immField)>>2] = state->reg[rs2];
		}
		else if (opcode == BEQ_OP) {
			if (state->reg[rs1] == state->reg[rs2]) {
				state->pc = (word_pc << 2) + immField;
			}
		}	
  /* STUDENT CODE END. */		
		else if (opcode == HALT_OP) {
			printf("machine halted\n");
			printf("total of %d instructions executed\n", Instructions + 1);
			printState(state);
			exit(0);
		}
		else {
			printf("error: illegal opcode %x\n", opcode);
			exit(1);
		}

		state->reg[0] = 0;

		printState(state);
	}
}
/************************************************************/

/************************************************************/
void
printState(Pstate state)
{
	short i;
	printf("state after cycle %d:\n", Instructions);
	printf("\tpc=%d\n", state->pc);
	printf("\tmemory:\n");
	for (i = 0; i < state->numMemory; i++) {
		printf("\t\tmem[%d] 0x%x\t(%d)\n", i, state->mem[i], state->mem[i]);
	}
	printf("\tregisters:\n");
	for (i = 0; i < NUMREGS; i++) {
		printf("\t\treg[%d] 0x%x\t(%d)\n", i, state->reg[i], state->reg[i]);
	}
	printf("\n");
	fflush(stdout);
}
/************************************************************/
