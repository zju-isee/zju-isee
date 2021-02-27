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
