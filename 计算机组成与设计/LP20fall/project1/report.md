<div align='center'><b><font size='48'>Project 1</font></b></div>

## 1 Assembler

#### 1.1 设计思路

汇编器的作用是将汇编指令编码成机器码。根据RISC-V指令格式，将opcode，rd，funct3，rs1，rs2，funct7等字段内容移位后通过```|``` 操作符拼接在一起形成完整的32位指令。下表为指令格式：

<table>
   <tr>
       <th align="center">name</th>
       <th align="center">format type</th>
       <th colspan="6" align="center">instruction format</th>
    </tr>
    <tr>
        <td>beq</td>
        <td>SB-type</td>
        <td>imm[12|10:5]</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>000</td>
        <td>imm[4:1|11]</td>
        <td>1100011</td>
    </tr>
        <tr>
        <td>lw</td>
        <td>I-type</td>
        <td colspan="2" align="center">imm[11:0]</td>
        <td>rs1</td>
        <td>010</td>
        <td>rd</td>
        <td>0000011</td>
    </tr>
        <tr>
        <td>sw</td>
        <td>S-type</td>
        <td>imm[11:5]</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>010</td>
        <td>imm[4:0]</td>
        <td>0100011</td>
    </tr>
        <tr>
        <td>addi</td>
        <td>I-type</td>
        <td colspan="2" align="center">imm[11:0]</td>
        <td>rs1</td>
        <td>000</td>
        <td>rd</td>
        <td>0010011</td>
    </tr>
        <tr>
        <td>add</td>
        <td>R-type</td>
        <td>0000000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>000</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
        <tr>
        <td>sub</td>
        <td>R-type</td>
        <td>0100000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>000</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
        <tr>
        <td>sll</td>
        <td>R-type</td>
        <td>0000000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>001</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
        <tr>
        <td>srl</td>
        <td>R-type</td>
        <td>0000000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>101</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
            <tr>
        <td>or</td>
        <td>R-type</td>
        <td>0000000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>110</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
            <tr>
        <td>and</td>
        <td>R-type</td>
        <td>0000000</td>
        <td>rs2</td>
        <td>rs1</td>
        <td>111</td>
        <td>rd</td>
        <td>0110011</td>
    </tr>
</table>



**几条特殊指令设计：**

- **lw/sw：** 立即数字段值可以是label或者十进制整数。
  - label：立即数字段值为label对应的地址，此时rs1应为0号寄存器。例如指令```lw	21	0	op1``` ，此时```op1``` 对应的地址为0x1c，则在编码时imm[11:0] = 0x1c，21号寄存器的值为地址0x1c存放的数字。
  - 十进制整数值：立即数字段即为该十进制整数，此时rs1不为0。例如指令```lw	21	22	4``` ，此时imm[11:0] = 4，该指令等同于RISC-V指令```lw x21, 4(x22)``` 。
- **beq：** 立即数字段值可以是labe或者十进制整数，该指令为PC相对寻址。
  - label：立即数字段值 = label对应的地址 - 当前PC值。
  - 十进制整数值：立即数字段值即为该十进制整数值。
- **.fill：** 该指令是指在label对应的地址处填入相应的数字，对应的指令值即为数字值。例如指令```op3 .fill 20``` ，指令地址为0x24，则该地址存放的指令值为00000014，即20的16进制表示。
- **halt：** 程序结束标志



#### 1.2 代码实现

##### 对asm.c文件的解释

- ```argv[1]``` 对应输入的汇编代码文件即```.s```文件，```argv[2]``` 对应输出文件，两个命令行参数缺一不可。
- 通过调用```readAndParse``` 函数，可以将汇编代码解析为对应的label、opcode、arg0、arg1、arg2，变量均为char*类型，该函数删除了汇编代码中的空白字符和注释。对R-type指令，arg0为rd，arg1为rs1，arg2为rs2，通过```atoi``` 函数可以将字符串转换为整数。



##### R-type(以and为例)

```C
if (!strcmp(opcode, "and")) {
	num = (AND_FUNC7 << FUNCT7_SHIFT) | (atoi(arg2) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | AND_FUNC3<<FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | REG_REG_OP;
}
```

将add指令对应的funct7字段左移25位，rs2左移20位，rs1左移15位，funct3左移12位，rd左移7位，opcode不动，然后通过或运算得到最后的指令机器码。



##### I-type(addi)

```C
if (!strcmp(opcode, "addi")) {
	num = ((atoi(arg2) & (ADDI_IMM_MASK)) << ADDI_IMM_SHIFT) | (atoi(arg1) << RS1_SHIFT) | ADDI_FUNC3<<FUNCT3_SHIFT | (atoi(arg0) << RD_SHIFT) | ADDI_OP;
}
```

addi指令为I-type，只有高12为与R-type不同，由于高12位位数有限，需要通过0xFFF的掩码取出```atoi(arg2)``` 中的低12位，其它位无效。



##### S-type(sw)

```C
if (!strcmp(opcode, "sw")) {
    if (isNumber(arg2)) {
        immediateValue = atoi(arg2);
    }
    else {
        immediateValue = get_label_address(arg2);
    }
    num = (((immediateValue >> 5) & FUNC7_MASK)<<FUNCT7_SHIFT) | (atoi(arg0) << RS2_SHIFT) | (atoi(arg1) << RS1_SHIFT) | SW_FUNC3<<FUNCT3_SHIFT | ((immediateValue & REG_MASK)<<RD_SHIFT) | SW_OP;
}
```

sw指令存在分支，先通过```isNumber``` 函数判断arg2是否为十进制整数，若为整数，则立即数即为该十进制整数，若为标签，则需要通过```get_label_address``` 函数得到标签地址，立即数为标签地址。对立即数的操作，同样需要掩码将立即数分为高7位与低5位，然后移位至正确的位置。

lw指令与sw指令虽然类型不同，但是设计原理相同，只是立即数掩码与移位操作略有不同，不再赘述。



##### SB-type(beq)

```C
if (!strcmp(opcode, "beq")) {
    if (isNumber(arg2)) {
        immediateValue = atoi(arg2);
    }
    else {
        immediateValue = get_label_address(arg2)-address;
    }
    num = ((immediateValue>>12) & 0x1)<<31 | ((immediateValue>>5) & 0x3F)<<25 | (atoi(arg1) << RS2_SHIFT) | (atoi(arg0) << RS1_SHIFT) | BEQ_FUNC3<<FUNCT3_SHIFT | ((immediateValue>>1) & 0xF)<<8 | ((immediateValue>>11) & 0x1)<<7 | BEQ_OP;
}
```

beq指令存在分支，先通过```isNumber``` 函数判断是否为十进制整数，若为整数，则立即数即为该十进制整数，若为标签，则需要通过```get_label_address``` 函数得到标签地址，立即数为标签地址 - 当前PC值，因为该指令为相对寻址，非绝对寻址。



## 2 Simulator

#### 2.1 设计思路

仿真器的作用是运行程序，模拟cpu的IF、ID、EXE、MEM、WB操作。因此需要将机器码根据指令格式译码。仿真器在运行每一条指令的时候设计到对寄存器和内存的操作，```printState``` 函数可以将每条指令运行时寄存器和内存的状态记录下来。该程序其实是机器码运行的可视化。



#### 2.2 代码实现

##### 解码

**该部分需要完成的任务：**

- 将字节为单位的地址转换为字为单位的地址。
- 从机器码中用移位和掩码操作取出对应的opcode、rd、func3、rs1、rs2、func7。
- pc+4
- 如果操作码对应指令为addi、lw、sw、beq，则需要译出立即数字段。
  - 需要处理好立即数为负的情况，C语言中算术右移可以实现符号位扩充

**代码如下：**

```C
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
```



##### 执行

**该部分需要完成的任务：**

- 根据指令类型，改变寄存器和内存地址的值。
- 对beq指令，条件成立还需要修改下一条pc的值。

**代码如下：**

**R-type(以and为例)**

```C
if ((opcode==REG_REG_OP) && (func3==AND_FUNC3)) {
	state->reg[rd] = state->reg[rs1] & state->reg[rs2];
}
```

由于R-type操作码相同，需要根据func3字段判断类型。



**lw**

```C
if (opcode == LW_OP) {
    state->reg[rd] = state->mem[(state->reg[rs1] + immField)>>2];			
}
```

若rs1=0 ，则立即数为标签地址，需要去对应内存地址取出相应的数字，放入rd寄存器；否则需要通过rs1中存放的地址加上立即数偏移得到内存地址。由于该程序内存地址以字为单位，因此需要移位操作得到正确地址值。



**sw**

```C
if (opcode == SW_OP) {
    state->mem[(state->reg[rs1] + immField)>>2] = state->reg[rs2];
}
```

原理同lw



**beq**

```C
if (opcode == BEQ_OP) {
    if (state->reg[rs1] == state->reg[rs2]) {
    	state->pc = (word_pc << 2) + immField;
    }
}
```

由于beq指令立即数不管是label还是整数，在编码时字段值都是pc的相对偏移量，因此译码时只要跳转条件成立，即可将pc值加上对应的偏移量。由于在译码阶段已经将pc加4了，因此需要从word_pc中取出正确的pc值，再加上对应的偏移量。



## 3 Test

#### 3.1 样例

**源码(simple.s)：**

```asm
	lw	21	0	op1	reg[21] <- op1
	lw	22	0	op2	reg[22] <- op2
	lw	23	0	op3	reg[23] <- op3
	add	24	21	22	reg[24] <- reg[21] + reg[22]
	sub	25	24	23	reg[25] <- reg[24] - reg[23]
	sw	25	0	answer	reg[25] -> answer
done	halt
op1	.fill	50			
op2	.fill	30
op3	.fill	20
answer	.fill	0
```



**asm结果(simple.out)：**

```
01c02a83
02002b03
02402b83
016a8c33
417c0cb3
03902423
0000003f
00000032
0000001e
00000014
00000000
```



**sim结果(simple_sim.out)：**

```
machine halted
total of 7 instructions executed
state after cycle 6:
	pc=28
	memory:
		mem[0] 0x1c02a83	(29371011)
		mem[1] 0x2002b03	(33565443)
		mem[2] 0x2402b83	(37759875)
		mem[3] 0x16a8c33	(23759923)
		mem[4] 0x417c0cb3	(1098648755)
		mem[5] 0x3902423	(59778083)
		mem[6] 0x3f	(63)
		mem[7] 0x32	(50)
		mem[8] 0x1e	(30)
		mem[9] 0x14	(20)
		mem[10] 0x3c	(60)
	registers:
		reg[0] 0x0	(0)
		reg[1] 0x0	(0)
		reg[2] 0x0	(0)
		reg[3] 0x0	(0)
		reg[4] 0x0	(0)
		reg[5] 0x0	(0)
		reg[6] 0x0	(0)
		reg[7] 0x0	(0)
		reg[8] 0x0	(0)
		reg[9] 0x0	(0)
		reg[10] 0x0	(0)
		reg[11] 0x0	(0)
		reg[12] 0x0	(0)
		reg[13] 0x0	(0)
		reg[14] 0x0	(0)
		reg[15] 0x0	(0)
		reg[16] 0x0	(0)
		reg[17] 0x0	(0)
		reg[18] 0x0	(0)
		reg[19] 0x0	(0)
		reg[20] 0x0	(0)
		reg[21] 0x32	(50)
		reg[22] 0x1e	(30)
		reg[23] 0x14	(20)
		reg[24] 0x50	(80)
		reg[25] 0x3c	(60)
		reg[26] 0x0	(0)
		reg[27] 0x0	(0)
		reg[28] 0x0	(0)
		reg[29] 0x0	(0)
		reg[30] 0x0	(0)
		reg[31] 0x0	(0)
```

样例运行正确



#### 3.2 用上所有指令的测试

**源码(test.s)：**

```assembly
	lw	15	0	num	reg[15] = sum
	addi	16	0	1	reg[16] = 1
	sll	15	15	16	reg[15] << 1
	add	17	0	15	reg[17] = reg[15]
loop	beq	15	0	end	if(reg[15] == 0) go to end
	srl	15	15	16	reg[15] >> 1
	add	17	17	15	reg[17] += reg[15]
	beq	0	0	loop	go to loop
end	sw	17	0	sum	sum = reg[17]
moreTest	addi	18	17	-5	reg[18] = reg[17]-5
	addi	19	0	32	reg[19] = 32
	sub	20	19	18	reg[20] = reg[19]-reg[18]
	sw	18	19	4	mem[reg[19]+4] = reg[18]
	sw	20	19	-4	mem[reg[19]-4] = reg[20]
	lw	21	19	4	reg[21] = mem[reg[19]-4]
	lw	22	19	-4	reg[22] = mem[.reg[19]-4]
done	halt
num	.fill	32
sum	.fill	0
```

说明：

该程序计算输入num乘2后不断右移的和。moreTest部分仅为了测试其它指令（没有实际意义）。

- 输入num
- num左移1位，即乘2
- loop中不断将num左移，新数字叠加到sum中，值到num为0，loop中测试了beq后跳和前跳
- 例子中num=32，num×2=64，sum=64+32+16+8+4+2+1=127
- moreTest中测试了lw和sw的rs1不为0以及立即数为负的情况，也测试了addi立即数为负数的情况



**asm结果(test.out)：**

```
04402783
00100813
010797b3
00f008b3
00078863
0107d7b3
00f888b3
fe000ae3
05102423
ffb88913
02000993
41298a33
0129a223
ff49ae23
0049aa83
ffc9ab03
0000003f
00000020
00000000
```



**sim结果(test_sim.out)：**

```
machine halted
total of 42 instructions executed
state after cycle 41:
	pc=68
	memory:
		mem[0] 0x4402783	(71313283)
		mem[1] 0x100813	(1050643)
		mem[2] 0x10797b3	(17274803)
		mem[3] 0xf008b3	(15730867)
		mem[4] 0x78863	(493667)
		mem[5] 0x107d7b3	(17291187)
		mem[6] 0xf888b3	(16287923)
		mem[7] 0xffffffa6	(-90)
		mem[8] 0x5102423	(84943907)
		mem[9] 0x7a	(122)
		mem[10] 0x2000993	(33556883)
		mem[11] 0x41298a33	(1093241395)
		mem[12] 0x129a223	(19505699)
		mem[13] 0xff49ae23	(-11948509)
		mem[14] 0x49aa83	(4827779)
		mem[15] 0xffc9ab03	(-3560701)
		mem[16] 0x3f	(63)
		mem[17] 0x20	(32)
		mem[18] 0x7f	(127)
	registers:
		reg[0] 0x0	(0)
		reg[1] 0x0	(0)
		reg[2] 0x0	(0)
		reg[3] 0x0	(0)
		reg[4] 0x0	(0)
		reg[5] 0x0	(0)
		reg[6] 0x0	(0)
		reg[7] 0x0	(0)
		reg[8] 0x0	(0)
		reg[9] 0x0	(0)
		reg[10] 0x0	(0)
		reg[11] 0x0	(0)
		reg[12] 0x0	(0)
		reg[13] 0x0	(0)
		reg[14] 0x0	(0)
		reg[15] 0x0	(0)
		reg[16] 0x1	(1)
		reg[17] 0x7f	(127)
		reg[18] 0x7a	(122)
		reg[19] 0x20	(32)
		reg[20] 0xffffffa6	(-90)
		reg[21] 0x7a	(122)
		reg[22] 0xffffffa6	(-90)
		reg[23] 0x0	(0)
		reg[24] 0x0	(0)
		reg[25] 0x0	(0)
		reg[26] 0x0	(0)
		reg[27] 0x0	(0)
		reg[28] 0x0	(0)
		reg[29] 0x0	(0)
		reg[30] 0x0	(0)
		reg[31] 0x0	(0)
```

分析：

- reg[17]=sum=127                                   正确
- reg[18]=reg[17]-5=122                           正确
- reg[19]=32                                               正确
- reg[20]=reg[19]-reg[18]=32-122=-90  正确
- mem[18]=127                                         正确
- 此外lw和sw操作均正确
- 结果正确



#### 3.3 一个复杂的学号尾数编码程序

**背景**：学号尾数为4位，我用学号尾数做了一个编码程序。利用了线性移位反馈寄存器的思想，首先将学号尾数认为是一个16bit的数，将第0，2，3，5位的值取出来做异或运算，将该结果放到第15位，然后将右边的数右移1位，得到伪随机数。根据异或的结果，值为1则新数字为伪随机数与原数字之差，结果为0则新数字为伪随机数与原数字之和。该程序也用上了所有指令。

**源码（lfsr.s）：**

```asm
	addi	15	0	1	reg[15] <- 1
	addi	16	0	2	reg[16] <- 2
	addi	17	0	3	reg[17] <- 3
	addi	18	0	5	reg[18] <- 5
main	lw	19	0	num	reg[20] <- num
getbit0	and	20	19	15	reg[20] <- reg[19] & reg[15]
	srl	21	19	16	reg[21] <- reg[19] << reg[16]
getbit2	and	22	21	15	reg[22] <- reg[21] & reg[15]
	add	20	20	22	reg[20] <- reg[20] + reg[22]
	srl	21	19	17	reg[21] <- reg[19] << reg[17]
getbit3	and	22	21	15	reg[22] <- reg[21] & reg[15]
	add	20	20	22	reg[20] <- reg[20] + reg[22]
	srl	21	19	18	reg[21] <- reg[19] << reg[18]
getbit5	and	22	21	15	reg[22] <- reg[21] & reg[15]
	add	20	20	22	reg[20] <- reg[20] + reg[22]	
xorResult	and	20	20	15	reg[20] <- reg[20] & reg[15]
	add	23	0	20	reg[23] <- reg[20]
	addi	21	0	15	reg[21] <- 15
	sll	23	23	21	reg[23] <- reg[23] << reg[21]
	srl	22	19	15	reg[22] <- reg[19] >> reg[15]
lfsrResult	or	22	22	23	reg[22] <- reg[22] | reg[23]	
	beq	20	15	isOne	if(reg[20] == reg[15]) go to isOne
	add	25	22	19	reg[25] <- reg[22] + reg[19]
	beq	0	0	end	go to end
isOne	sub	25	22	19	reg[25] <- reg[22] - reg[19]
end	sw	25	0	newNum	reg[25] -> newNum
done	halt
num	.fill	1279
newNum	.fill	0
```



RISC-V形式：

```assembly
main:
	addi x15 x0 1
	addi x16 x0 2
	addi x17 x0 3
	addi x18 x0 5
    addi x19 x0 1279      #指令替换，即lw	19	0	num	reg[20] <- num
getbit0:
	and	x20	x19 x15       #取出第0位
	srl	x21	x19	x16       #num >> 2
getbit2:
	and	x22	x21	x15       #取出第2位，即(num >> 2) & 1
	add	x20	x20	x22       #为异或做准备，奇数个1异或结果为1的原理
	srl	x21	x19	x17       #num >> 3
getbit3:
	and	x22	x21	x15       #取出第3位，即(num >> 3) & 1
	add	x20	x20	x22
	srl	x21	x19	x18       #num >> 5
getbit5:
	and	x22	x21	x15       #取出第5位，即(num >> 5) & 1
	add	x20	x20	x22
xorResult:
	and	x20	x20	x15       #取出add结果的第0位，为1则说明奇数个1，异或结果为1
	add	x23	x0	x20       #保存异或结果
	addi x21 x0 15
    sll x23 x23 x21       #异或结果<<15
    srl x22 x19 x15       #num >> 1
lfsrResult:
	or x22 x22 x23        #(异或结果<<31) | (num >> 1)
    beq x20 x15 isOne     #分支
    add x25 x22 x19       #newNum = 伪随机数 - num
    beq x0 x0 end
isOne:
	sub x25 x22 x19       #newNum = 伪随机数 + num
end:
```



**asm结果(lfsr.out)：**

```
00100793
00200813
00300893
00500913
06c02983
00f9fa33
0109dab3
00fafb33
016a0a33
0119dab3
00fafb33
016a0a33
0129dab3
00fafb33
016a0a33
00fa7a33
01400bb3
00f00a93
015b9bb3
00f9db33
017b6b33
00fa0663
013b0cb3
00000463
413b0cb3
07902823
0000003f
000004ff
00000000
```



**sim结果(lfsr_sim.out)：**

```
machine halted
total of 26 instructions executed
state after cycle 25:
	pc=108
	memory:
		mem[0] 0x100793	(1050515)
		mem[1] 0x200813	(2099219)
		mem[2] 0x300893	(3147923)
		mem[3] 0x500913	(5245203)
		mem[4] 0x6c02983	(113256835)
		mem[5] 0xf9fa33	(16382515)
		mem[6] 0x109dab3	(17423027)
		mem[7] 0xfafb33	(16448307)
		mem[8] 0x16a0a33	(23726643)
		mem[9] 0x119dab3	(18471603)
		mem[10] 0xfafb33	(16448307)
		mem[11] 0x16a0a33	(23726643)
		mem[12] 0x129dab3	(19520179)
		mem[13] 0xfafb33	(16448307)
		mem[14] 0x16a0a33	(23726643)
		mem[15] 0xfa7a33	(16415283)
		mem[16] 0x1400bb3	(20974515)
		mem[17] 0xf00a93	(15731347)
		mem[18] 0x15b9bb3	(22780851)
		mem[19] 0xf9db33	(16374579)
		mem[20] 0x17b6b33	(24865587)
		mem[21] 0xfa0663	(16385635)
		mem[22] 0x13b0cb3	(20647091)
		mem[23] 0x463	(1123)
		mem[24] 0x413b0cb3	(1094388915)
		mem[25] 0x7902823	(126887971)
		mem[26] 0x3f	(63)
		mem[27] 0x4ff	(1279)
		mem[28] 0x77e	(1918)
	registers:
		reg[0] 0x0	(0)
		reg[1] 0x0	(0)
		reg[2] 0x0	(0)
		reg[3] 0x0	(0)
		reg[4] 0x0	(0)
		reg[5] 0x0	(0)
		reg[6] 0x0	(0)
		reg[7] 0x0	(0)
		reg[8] 0x0	(0)
		reg[9] 0x0	(0)
		reg[10] 0x0	(0)
		reg[11] 0x0	(0)
		reg[12] 0x0	(0)
		reg[13] 0x0	(0)
		reg[14] 0x0	(0)
		reg[15] 0x1	(1)
		reg[16] 0x2	(2)
		reg[17] 0x3	(3)
		reg[18] 0x5	(5)
		reg[19] 0x4ff	(1279)
		reg[20] 0x0	(0)
		reg[21] 0xf	(15)
		reg[22] 0x27f	(639)
		reg[23] 0x0	(0)
		reg[24] 0x0	(0)
		reg[25] 0x77e	(1918)
		reg[26] 0x0	(0)
		reg[27] 0x0	(0)
		reg[28] 0x0	(0)
		reg[29] 0x0	(0)
		reg[30] 0x0	(0)
		reg[31] 0x0	(0)
```

由于1279 二进制表示为 0100 1111 1111，第0，2，3，5位异或结果为0，故新数字为0000 0010 0111 1111（639），与1279之和为1918结果正确。

