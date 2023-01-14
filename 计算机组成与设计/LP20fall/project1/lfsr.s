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
	addi	21	0	15	reg[21] <- 31
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
