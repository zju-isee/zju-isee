#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAXLINELENGTH		1000
#define MAXNUMLABELS		10000
#define MAXLABELLENGTH		10
#define VALUE_32K					32768

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

//opcode 段的取值
#define BEQ_OP			0x63
#define LW_OP				0x3
#define SW_OP				0x23
#define ADDI_OP			0x13
#define REG_REG_OP	0x33
#define HALT_OP			0x3F

//func7段
#define ADD_FUNC7	0x0
#define SUB_FUNC7		0x20
#define SLL_FUNC7		0x0
#define SRL_FUNC7		0x0
#define OR_FUNC7		0x0
#define AND_FUNC7	0x0
//funct3
#define BEQ_FUNC3		0x0
#define LW_FUNC3		0x2
#define SW_FUNC3		0x2
#define ADDI_FUNC3	0x0
#define ADD_FUNC3	0x0
#define SUB_FUNC3		0x0
#define SLL_FUNC3		0x1
#define SRL_FUNC3		0x5
#define OR_FUNC3		0x6
#define AND_FUNC3	0x7

char * readAndParse(FILE *, char *, char **, char **, char **, char **, char **);
int isNumber(char *);

char Labels[MAXNUMLABELS][MAXLABELLENGTH];
int Addresses[MAXNUMLABELS];
int NumValidLabels = 0;

int get_label_address(char *s)
//char *s;
{
	int i;

	for (i = 0; i < NumValidLabels; i++) {
		if (strlen(Labels[i]) == 0) {
			return -1;
		}
		if (strcmp(Labels[i], s) == 0) {
			return Addresses[i];
		}
	}
	return -1;
}

int main(int argc, char *argv[])
{
	char *inFileString, *outFileString;
	FILE *inFilePtr, *outFilePtr;
	int address;
	char *label, *opcode, *arg0, *arg1, *arg2;
	char *statusString;
	char lineString[MAXLINELENGTH + 1];
	int i;
	int num;
	int immediateValue;

	if (argc != 3) {
		printf("error: usage: %s <assembly-code-file> <machine-code-file> \n",
			argv[0]);
		exit(1);
	}

	inFileString = argv[1];
	outFileString = argv[2];

	inFilePtr = fopen(inFileString, "r");
	if (inFilePtr == NULL) {
		printf("error in opening %s\n", inFileString);
		exit(1);
	}
	outFilePtr = fopen(outFileString, "w");
	if (outFilePtr == NULL) {
		printf("error in opening %s\n", outFileString);
		exit(1);
	}

	/* PASS ONE -- map symbols to addresses */

	/* assume address start at 0 */
	address = 0;

	while (readAndParse(inFilePtr, lineString, &label, &opcode, &arg0,
		&arg1, &arg2) != NULL) {

		if (label != NULL) {
			/* look for duplicate label */
			if ((i = get_label_address(label)) < 0) {
				/* label not found -- a good sign */
				/* but first -- make sure we don't overrun buffer */
				if (NumValidLabels >= MAXNUMLABELS) {
					/* we will exceed the size of the array */
					printf("error: too many labels (label=%s)\n", label);
					exit(1);
				}
				strcpy(Labels[NumValidLabels], label);
				Addresses[NumValidLabels] = address;
				NumValidLabels++;
			}
			else {
				/* duplicate label -- terminate */
				printf("error: duplicate label %s \n", label);
				exit(1);
			}
		}

		address += 4;
	}

	/* PASS TWO -- print machine code, with symbols filled in as addresses */

	rewind(inFilePtr);
	address = 0;

	while (readAndParse(inFilePtr, lineString, &label, &opcode, &arg0, &arg1, &arg2) != NULL) {

		if ((strcmp(opcode, "halt") && strcmp(opcode, ".fill") && arg2 == NULL) ||
			(!strcmp(opcode, ".fill") && arg0 == NULL)) {
			printf("error at address %hd: not enough arguments\n", address);
			exit(1);
		}

		if (!strcmp(opcode, "add")) {
			num = (ADD_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | ADD_FUNC3<<FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
  /* STUDENT CODE START HERE. */		
		else if (!strcmp(opcode, "sub")) {
			num = (SUB_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | SUB_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
		else if (!strcmp(opcode, "sll")) {
			num = (SLL_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | SLL_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
		else if (!strcmp(opcode, "srl")) {
			num = (SRL_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | SRL_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
		else if (!strcmp(opcode, "or")) {
			num = (OR_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | OR_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
		else if (!strcmp(opcode, "and")) {
			num = (AND_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | AND_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
		}
		else if (!strcmp(opcode, "addi")) {
			num = (((atoi(arg2)) & ADDI_IMM_MASK) << ADDI_IMM_SHIFT) | (atoi(arg1) << RS1_SHIFT) | ADDI_FUNC3 << FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | ADDI_OP;
		}
		else if (!strcmp(opcode, "lw")) {
			if (!isNumber(arg2))
			{
				num=(((get_label_address(arg2))&LW_IMM_MASK) << LW_IMM_SHIFT) | (atoi(arg1) << RS1_SHIFT) | (LW_FUNC3 << FUNCT3_SHIFT) | (atoi(arg0) << RD_SHIFT) | LW_OP;
			}
			else
			{
				num = (((atoi(arg2)) & LW_IMM_MASK) << LW_IMM_SHIFT) | (atoi(arg1) << RS1_SHIFT) | (LW_FUNC3 << FUNCT3_SHIFT) | (atoi(arg0) << RD_SHIFT) | LW_OP;
			}
		}
		else if (!strcmp(opcode, "sw")) {
			if (!isNumber(arg2))
			{
				num = ((((get_label_address(arg2)) >> 5) & FUNC7_MASK) << FUNCT7_SHIFT) | (atoi(arg0) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | (SW_FUNC3 << FUNCT3_SHIFT) | (((get_label_address(arg2)) & REG_MASK) << RD_SHIFT) | SW_OP;
			}
			
			else
			{
				num = ((((atoi(arg2)) >> 5) & FUNC7_MASK) << FUNCT7_SHIFT) | (atoi(arg0) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | (SW_FUNC3 << FUNCT3_SHIFT) | (((atoi(arg2)) & REG_MASK) << RD_SHIFT) | SW_OP;
			}
		}
		else if (!strcmp(opcode, "beq")) {
			if (!isNumber(arg2))
			{
				num = ((((get_label_address(arg2)) >> 12) & 0x1) << (FUNCT7_SHIFT + 6)) | ((((get_label_address(arg2)) >> 5) & 0x3F) << (FUNCT7_SHIFT )) | (atoi(arg1) << RS2_SHIFT) | (atoi(arg0) << RS1_SHIFT) | (BEQ_FUNC3 << FUNCT3_SHIFT) | ((((get_label_address(arg2)) >> 1) & 0xF) << (RD_SHIFT + 1)) | ((((get_label_address(arg2)) >> 11) & 0x1) << (RD_SHIFT)) | BEQ_OP;
				// address = address + get_label_address(arg2);
				
			}
			else
			{
				num = ((((atoi(arg2)) >> 12) & 0x1) << (FUNCT7_SHIFT + 6)) | (((atoi(arg2) >> 5) & 0x3F) << (FUNCT7_SHIFT)) | (atoi(arg1) << RS2_SHIFT) | (atoi(arg0) << RS1_SHIFT) | (BEQ_FUNC3 << FUNCT3_SHIFT) | ((((atoi(arg2)) >> 1) & 0xF) << (RD_SHIFT + 1)) | ((((atoi(arg2)) >> 11) & 0x1) << (RD_SHIFT)) | BEQ_OP;
				// address = address + atoi(arg2);
				
			}
			// address = address - 4;
		}

  /* STUDENT CODE END. */
		else if (!strcmp(opcode, "halt")) {
			num = HALT_OP;
		}
		else if (!strcmp(opcode, ".fill")) {
			if (!isNumber(arg0)) {
				num = get_label_address(arg0);
			}
			else {
				num = atoi(arg0);
			}
		}
		else {
			printf("error: unrecognized opcode %s at address %d\n",
				opcode, address);
			exit(1);
		}

		fprintf(outFilePtr, "%08x\n", num);

		address += 4;

	}
}

char *readAndParse(FILE *inFilePtr, char *lineString, char **labelPtr,
	char **opcodePtr, char **arg0Ptr, char **arg1Ptr,
	char **arg2Ptr)
{
	char *statusString;

	statusString = fgets(lineString, MAXLINELENGTH, inFilePtr);
	if (statusString != NULL) {
		if (lineString[0] == '\t') {
			*labelPtr = NULL;
			*opcodePtr = strtok(lineString, "\t\n");
		}
		else {
			*labelPtr = strtok(lineString, "\t\n");
			*opcodePtr = strtok(NULL, "\t\n");
		}
		*arg0Ptr = strtok(NULL, "\t\n");
		*arg1Ptr = strtok(NULL, "\t\n");
		*arg2Ptr = strtok(NULL, "\t\n");
	}
	return(statusString);
}

int
isNumber(char *string)
{
	/* return 1 if string is a number */
	int i;
	return((sscanf(string, "%d", &i)) == 1);
}
