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
