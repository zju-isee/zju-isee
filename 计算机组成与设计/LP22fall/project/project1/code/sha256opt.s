	.file	"new_sha256.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	2
	.type	k, @object
	.size	k, 256
k:
	.word	1116352408
	.word	1899447441
	.word	-1245643825
	.word	-373957723
	.word	961987163
	.word	1508970993
	.word	-1841331548
	.word	-1424204075
	.word	-670586216
	.word	310598401
	.word	607225278
	.word	1426881987
	.word	1925078388
	.word	-2132889090
	.word	-1680079193
	.word	-1046744716
	.word	-459576895
	.word	-272742522
	.word	264347078
	.word	604807628
	.word	770255983
	.word	1249150122
	.word	1555081692
	.word	1996064986
	.word	-1740746414
	.word	-1473132947
	.word	-1341970488
	.word	-1084653625
	.word	-958395405
	.word	-710438585
	.word	113926993
	.word	338241895
	.word	666307205
	.word	773529912
	.word	1294757372
	.word	1396182291
	.word	1695183700
	.word	1986661051
	.word	-2117940946
	.word	-1838011259
	.word	-1564481375
	.word	-1474664885
	.word	-1035236496
	.word	-949202525
	.word	-778901479
	.word	-694614492
	.word	-200395387
	.word	275423344
	.word	430227734
	.word	506948616
	.word	659060556
	.word	883997877
	.word	958139571
	.word	1322822218
	.word	1537002063
	.word	1747873779
	.word	1955562222
	.word	2024104815
	.word	-2067236844
	.word	-1933114872
	.word	-1866530822
	.word	-1538233109
	.word	-1090935817
	.word	-965641998
	.text
	.align	1
	.globl	sha256_transform
	.type	sha256_transform, @function
sha256_transform:
	addi	sp,sp,-336
	sw	s0,332(sp)
	addi	s0,sp,336
	sw	a0,-324(s0)
	sw	a1,-328(s0)
	sw	zero,-52(s0)
	sw	zero,-56(s0)
	j	.L2
.L3:
	lw	a4,-328(s0)
	lw	a5,-56(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	slli	a4,a5,24
	lw	a5,-56(s0)
	addi	a5,a5,1
	lw	a3,-328(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	slli	a5,a5,16
	or	a4,a4,a5
	lw	a5,-56(s0)
	addi	a5,a5,2
	lw	a3,-328(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	slli	a5,a5,8
	or	a5,a4,a5
	lw	a4,-56(s0)
	addi	a4,a4,3
	lw	a3,-328(s0)
	add	a4,a3,a4
	lbu	a4,0(a4)
	or	a5,a5,a4
	mv	a4,a5
	lw	a5,-52(s0)
	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	sw	a4,-304(a5)
	lw	a5,-52(s0)
	addi	a5,a5,1
	sw	a5,-52(s0)
	lw	a5,-56(s0)
	addi	a5,a5,4
	sw	a5,-56(s0)
.L2:
	lw	a4,-52(s0)
	li	a5,15
	bleu	a4,a5,.L3
	j	.L4
.L5:
	lw	a5,-52(s0)
	addi	a5,a5,-2
	slli	a5,a5,2
	addi	a4,s0,-16
	add	a5,a4,a5
	lw	a5,-304(a5)	
#	slli	a3,a5,13
#	srli	a4,a5,19
#	or	a4,a4,a3
	addi a3,x0,13
	.insn r 0x33,1,2,a4,a5,a3
#	lw	a5,-52(s0)
#	addi	a5,a5,-2
#	slli	a5,a5,2
#	addi	a3,s0,-16
#	add	a5,a3,a5
#	lw	a5,-304(a5)
#	# a5 didn't change, no need to read again
#	slli	a3,a5,15
#	srli	a5,a5,17
#	or	a5,a5,a3

# 	# to preserve a5, use other registers
##	addi a3,x0,15
##	.insn r 0x33,1,2,a5,a5,a3
##	xor	a4,a4,a5
	addi a3,x0,15
	.insn r 0x33,1,2,a2,a5,a3
	xor	a4,a4,a2
#	# a5 didn't change, no need to read again

#	lw	a5,-52(s0)
#	addi	a5,a5,-2
#	slli	a5,a5,2
#	addi	a3,s0,-16
#	add	a5,a3,a5
#	lw	a5,-304(a5)

# 	# to preserve a5, use other registers
#	srli	a5,a5,10
#	xor	a4,a4,a5
	srli	a2,a5,10
	xor	a4,a4,a2

#   a5 value changed
	lw	a5,-52(s0)
	addi	a5,a5,-7
	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	lw	a5,-304(a5)
	add	a3,a4,a5
	lw	a5,-52(s0)
	addi	a5,a5,-15
	slli	a5,a5,2
	addi	a4,s0,-16
	add	a5,a4,a5
	lw	a5,-304(a5)

#	!!! preserve a5 from now
#	srli	a2,a5,7
#	slli	a4,a5,25
#	or	a4,a4,a2
	addi a2,x0,25
	.insn r 0x33,1,2,a4,a5,a2
#	lw	a5,-52(s0)
#	addi	a5,a5,-15
#	slli	a5,a5,2
#	addi	a2,s0,-16
#	add	a5,a2,a5
#	lw	a5,-304(a5)
#	# don't need to read a5 again

#	slli	a2,a5,14
#	srli	a5,a5,18
#	or	a5,a5,a2
##	addi a2,x0,14
##	.insn r 0x33,1,2,a5,a5,a2
##	xor	a4,a4,a5
	addi a2,x0,14
	.insn r 0x33,1,2,a2,a5,a2
	xor	a4,a4,a2
#	lw	a5,-52(s0)
#	addi	a5,a5,-15
#	slli	a5,a5,2
#	addi	a2,s0,-16
#	add	a5,a2,a5
#	lw	a5,-304(a5)
	srli	a5,a5,3
	xor	a5,a4,a5
	add	a4,a3,a5
	lw	a5,-52(s0)
	addi	a5,a5,-16
	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	lw	a5,-304(a5)
	add	a4,a4,a5
	lw	a5,-52(s0)
	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	sw	a4,-304(a5)
	lw	a5,-52(s0)
	addi	a5,a5,1
	sw	a5,-52(s0)
.L4:
	lw	a4,-52(s0)
	li	a5,63
	bleu	a4,a5,.L5
	lw	a5,-324(s0)
	lw	a4,80(a5)
	sw	a4,-20(s0)
#	lw	a5,-324(s0)
	lw	a4,84(a5)
	sw	a4,-24(s0)
#	lw	a5,-324(s0)
	lw	a4,88(a5)
	sw	a4,-28(s0)
#	lw	a5,-324(s0)
	lw	a4,92(a5)
	sw	a4,-32(s0)
#	lw	a5,-324(s0)
	lw	a4,96(a5)
	sw	a4,-36(s0)
#	lw	a5,-324(s0)
	lw	a4,100(a5)
	sw	a4,-40(s0)
#	lw	a5,-324(s0)
	lw	a4,104(a5)
	sw	a4,-44(s0)
#	lw	a5,-324(s0)
	lw	a4,108(a5)
	sw	a4,-48(s0)
	sw	zero,-52(s0)
	j	.L6
.L7:
#EP1
	lw	a5,-36(s0)
#	slli	a3,a5,7
#	srli	a4,a5,25
#	or	a4,a4,a3
	addi a3,x0,7
	.insn r 0x33,1,2,a4,a5,a3
#	a5 didn't change
#	lw	a5,-36(s0)
#	srli	a3,a5,11
#	slli	a5,a5,21
#	or	a5,a5,a3
	addi a3,x0,21
	.insn r 0x33,1,2,a2,a5,a3
	xor	a4,a4,a2
#	lw	a5,-36(s0)
#	srli	a3,a5,6
#	slli	a5,a5,26
#	or	a5,a5,a3
	addi a3,x0,26
	.insn r 0x33,1,2,a2,a5,a3
	xor	a4,a4,a2
	lw	a2,-48(s0)
	add	a4,a4,a2
#	lw	a3,-36(s0)
	lw	a3,-40(s0)
	and	a3,a3,a5
#	lw	a5,-36(s0)
#	not	a2,a5
#	lw	a5,-44(s0)
#	and	a5,a2,a5
#   This is simpilify for notand
#	lw	a2,-36(s0)
#	lw	a5,-44(s0)
#	.insn r 0x33,4,2,a5,a2,a5

#	-36(s0) is used for many times
#	lw	a2,-36(s0)
	lw	a2,-44(s0)
	.insn r 0x33,4,2,a5,a5,a2
	xor	a5,a3,a5
	add	a4,a4,a5
	lui	a5,%hi(k)
	addi	a3,a5,%lo(k)
	lw	a5,-52(s0)

	slli	a5,a5,2
	add	a3,a3,a5

#	.insn r 0x33,5,2,a3,a5,a3

	lw	a3,0(a3)
	add	a4,a4,a3
#	lw	a5,-52(s0)
#	slli	a5,a5,2
	addi	a3,s0,-16
	add	a5,a3,a5
	lw	a5,-304(a5)
	add	a5,a4,a5
	sw	a5,-60(s0)
	lw	a5,-20(s0)
#	EP0
#	srli	a3,a5,2
#	slli	a4,a5,30
#	or	a4,a4,a3
	addi a3,x0,30
	.insn r 0x33,1,2,a4,a5,a3
	lw	a5,-20(s0)
#	srli	a3,a5,13
#	slli	a5,a5,19
#	or	a5,a5,a3
	addi a3,x0,19
	.insn r 0x33,1,2,a5,a5,a3
	xor	a4,a4,a5
	lw	a5,-20(s0)
#	slli	a3,a5,10
#	srli	a5,a5,22
#	or	a5,a5,a3
	addi a3,x0,10
	.insn r 0x33,1,2,a5,a5,a3
	xor	a4,a4,a5
#	reuse a5 for -24(s0); a2 for -28(s0)
#	lw	a3,-24(s0)
#	lw	a5,-28(s0)
	lw	a5,-24(s0)
	lw	a2,-28(s0)
	xor	a3,a2,a5
	lw	a1,-20(s0)
	and	a3,a3,a1
#	lw	a2,-24(s0)
#	lw	a5,-28(s0)
	and	a1,a2,a5
#	xor	a1,a3,a1
#	add	a1,a4,a1
	.insn r 0x33,5,2,a1,a3,a4
	
	sw	a1,-64(s0)
	lw	a4,-44(s0)
	sw	a4,-48(s0)
	lw	a4,-40(s0)
	sw	a4,-44(s0)
	lw	a4,-36(s0)
	sw	a4,-40(s0)
	lw	a4,-32(s0)
	lw	a3,-60(s0)
	add	a3,a4,a3
	sw	a3,-36(s0)
#	lw	a5,-28(s0)
	sw	a2,-32(s0)
#	lw	a5,-24(s0)
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	sw	a5,-24(s0)
	lw	a4,-60(s0)
#	lw	a5,-64(s0)
	add	a5,a4,a1
	sw	a5,-20(s0)
	lw	a5,-52(s0)
	addi	a5,a5,1
	sw	a5,-52(s0)
.L6:
	lw	a4,-52(s0)
	li	a5,63
	bleu	a4,a5,.L7
	lw	a5,-324(s0)
	lw	a4,80(a5)
	lw	a3,-20(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,80(a5)
#	lw	a5,-324(s0)
	lw	a4,84(a5)
	lw	a3,-24(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,84(a5)
#	lw	a5,-324(s0)
	lw	a4,88(a5)
	lw	a3,-28(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,88(a5)
#	lw	a5,-324(s0)
	lw	a4,92(a5)
	lw	a3,-32(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,92(a5)
#	lw	a5,-324(s0)
	lw	a4,96(a5)
	lw	a3,-36(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,96(a5)
#	lw	a5,-324(s0)
	lw	a4,100(a5)
	lw	a3,-40(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,100(a5)
#	lw	a5,-324(s0)
	lw	a4,104(a5)
	lw	a3,-44(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,104(a5)
#	lw	a5,-324(s0)
	lw	a4,108(a5)
	lw	a3,-48(s0)
	add	a4,a4,a3
#	lw	a5,-324(s0)
	sw	a4,108(a5)
#	nop
	lw	s0,332(sp)
	addi	sp,sp,336
	jr	ra
	.size	sha256_transform, .-sha256_transform
	.align	1
	.globl	sha256_init
	.type	sha256_init, @function
sha256_init:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	sw	zero,64(a5)
	lw	a5,-20(s0)
#	li	a3,0
#	li	a4,0
#	sw	a3,72(a5)
#	sw	a4,76(a5)
	sw	x0,72(a5)
	sw	x0,76(a5)
	lw	a5,-20(s0)
	li	a4,1779032064
	addi	a4,a4,1639
	sw	a4,80(a5)
	lw	a5,-20(s0)
	li	a4,-1150832640
	addi	a4,a4,-379
	sw	a4,84(a5)
	lw	a5,-20(s0)
	li	a4,1013903360
	addi	a4,a4,882
	sw	a4,88(a5)
	lw	a5,-20(s0)
#	li	a4,-1521487872
#	addi	a4,a4,1338
	li 	a4,-1521486534
#	don't decrease
	sw	a4,92(a5)
	lw	a5,-20(s0)
	li	a4,1359892480
	addi	a4,a4,639
	sw	a4,96(a5)
	lw	a5,-20(s0)
	li	a4,-1694142464
	addi	a4,a4,-1908
	sw	a4,100(a5)
	lw	a5,-20(s0)
	li	a4,528736256
	addi	a4,a4,-1621
	sw	a4,104(a5)
	lw	a5,-20(s0)
	li	a4,1541459968
	addi	a4,a4,-743
	sw	a4,108(a5)
#	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	sha256_init, .-sha256_init
	.align	1
	.globl	sha256_update
	.type	sha256_update, @function
sha256_update:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	sw	zero,-20(s0)
	j	.L10
.L12:
	lw	a4,-40(s0)
	lw	a5,-20(s0)
	add	a4,a4,a5
	lw	a5,-36(s0)
	lw	a5,64(a5)
	lbu	a4,0(a4)
	lw	a3,-36(s0)
	add	a5,a3,a5
	sb	a4,0(a5)
	lw	a5,-36(s0)
	lw	a5,64(a5)
	addi	a4,a5,1
	lw	a5,-36(s0)
	sw	a4,64(a5)
	lw	a5,-36(s0)
	lw	a4,64(a5)
	li	a5,64
	bne	a4,a5,.L11
	lw	a5,-36(s0)
	mv	a1,a5
	lw	a0,-36(s0)
	call	sha256_transform
	lw	a5,-36(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	li	a0,512
	li	a1,0
	add	a2,a4,a0
	mv	a6,a2
	sltu	a6,a6,a4
	add	a3,a5,a1
	add	a5,a6,a3
	mv	a3,a5
	mv	a4,a2
	mv	a5,a3
	lw	a3,-36(s0)
	sw	a4,72(a3)
	sw	a5,76(a3)
	lw	a5,-36(s0)
	sw	zero,64(a5)
.L11:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L10:
	lw	a4,-20(s0)
	lw	a5,-44(s0)
	bltu	a4,a5,.L12
	nop
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	sha256_update, .-sha256_update
	.align	1
	.globl	sha256_final
	.type	sha256_final, @function
sha256_final:
	addi	sp,sp,-96
	sw	ra,92(sp)
	sw	s0,88(sp)
	sw	s2,84(sp)
	sw	s3,80(sp)
	sw	s4,76(sp)
	sw	s5,72(sp)
	sw	s6,68(sp)
	sw	s7,64(sp)
	sw	s8,60(sp)
	sw	s9,56(sp)
	sw	s10,52(sp)
	sw	s11,48(sp)
	addi	s0,sp,96
	sw	a0,-68(s0)
	sw	a1,-72(s0)
	lw	a5,-68(s0)
	lw	a5,64(a5)
	sw	a5,-52(s0)
	lw	a5,-68(s0)
	lw	a4,64(a5)
	li	a5,55
	bgtu	a4,a5,.L14
	lw	a5,-52(s0)
	addi	a4,a5,1
	sw	a4,-52(s0)
	lw	a4,-68(s0)
	add	a5,a4,a5
	li	a4,-128
	sb	a4,0(a5)
	j	.L15
.L16:
	lw	a5,-52(s0)
	addi	a4,a5,1
	sw	a4,-52(s0)
	lw	a4,-68(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
.L15:
	lw	a4,-52(s0)
	li	a5,55
	bleu	a4,a5,.L16
	j	.L17
.L14:
	lw	a5,-52(s0)
	addi	a4,a5,1
	sw	a4,-52(s0)
	lw	a4,-68(s0)
	add	a5,a4,a5
	li	a4,-128
	sb	a4,0(a5)
	j	.L18
.L19:
	lw	a5,-52(s0)
	addi	a4,a5,1
	sw	a4,-52(s0)
	lw	a4,-68(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
.L18:
	lw	a4,-52(s0)
	li	a5,63
	bleu	a4,a5,.L19
	lw	a5,-68(s0)
	mv	a1,a5
	lw	a0,-68(s0)
	call	sha256_transform
	lw	a5,-68(s0)
	li	a2,56
	li	a1,0
	mv	a0,a5
	call	memset
.L17:
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	lw	a3,-68(s0)
	lw	a3,64(a3)
	slli	a3,a3,3
	mv	s8,a3
	li	s9,0
	add	a2,a4,s8
	mv	a1,a2
	sltu	a1,a1,a4
	add	a3,a5,s9
	add	a5,a1,a3
	mv	a3,a5
	mv	a4,a2
	mv	a5,a3
	lw	a3,-68(s0)
	sw	a4,72(a3)
	sw	a5,76(a3)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	andi	a4,a4,0xff
	lw	a5,-68(s0)
	sb	a4,63(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	slli	a3,a5,24
	srli	s6,a4,8
	or	s6,a3,s6
	srli	s7,a5,8
	andi	a4,s6,0xff
	lw	a5,-68(s0)
	sb	a4,62(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	slli	a3,a5,16
	srli	s4,a4,16
	or	s4,a3,s4
	srli	s5,a5,16
	andi	a4,s4,0xff
	lw	a5,-68(s0)
	sb	a4,61(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	slli	a3,a5,8
	srli	s2,a4,24
	or	s2,a3,s2
	srli	s3,a5,24
	andi	a4,s2,0xff
	lw	a5,-68(s0)
	sb	a4,60(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	srli	a5,a5,0
	sw	a5,-80(s0)
	sw	zero,-76(s0)
	lbu	a4,-80(s0)
	lw	a5,-68(s0)
	sb	a4,59(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	srli	a5,a5,8
	sw	a5,-88(s0)
	sw	zero,-84(s0)
	lbu	a4,-88(s0)
	lw	a5,-68(s0)
	sb	a4,58(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	srli	a5,a5,16
	sw	a5,-96(s0)
	sw	zero,-92(s0)
	lbu	a4,-96(s0)
	lw	a5,-68(s0)
	sb	a4,57(a5)
	lw	a5,-68(s0)
	lw	a4,72(a5)
	lw	a5,76(a5)
	srli	s10,a5,24
	li	s11,0
	andi	a4,s10,0xff
	lw	a5,-68(s0)
	sb	a4,56(a5)
	lw	a5,-68(s0)
	mv	a1,a5
	lw	a0,-68(s0)
	call	sha256_transform
	sw	zero,-52(s0)
	j	.L20
.L21:
#	this is the reverse part
#	lw	a5,-68(s0)
	lw	a2,-68(s0)
#	lw	a4,80(a5)    use a2 to save the constant offset
	lw	a4,80(a2)
#	li	a3,3		 use a0 as constant 3
	li	a0,3
#	lw	a5,-52(s0)   use a1 to save the constant value -52(s0)
	lw	a1,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
#	lw	a4,-72(s0)   use a3 to save the constant value -72(s0)
	lw	a3,-72(s0)
##	addi	a5,a5,0
#	lw	a5,-52(s0)
	.insn r 0x33,3,2,a4,a4,a1
	add	a5,a3,a1
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,84(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,4
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,88(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,8
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,92(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
#	lw	a5,-52(s0)
	.insn r 0x33,3,2,a4,a4,a1
	addi	a5,a1,12
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,96(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,16
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,100(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,20
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,104(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,24
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-68(s0)
	lw	a4,108(a2)
#	li	a3,3
#	lw	a5,-52(s0)
##	sub	a5,a0,a1
##	slli	a5,a5,3
##	srl	a4,a4,a5
	.insn r 0x33,3,2,a4,a4,a1
#	lw	a5,-52(s0)
	addi	a5,a1,28
#	lw	a4,-72(s0)
	add	a5,a3,a5
##	andi	a4,a4,0xff
	sb	a4,0(a5)
#	lw	a5,-52(s0)
	addi	a5,a1,1
	sw	a5,-52(s0)
.L20:
	lw	a4,-52(s0)
	li	a5,3
	bleu	a4,a5,.L21
	nop
	nop
	lw	ra,92(sp)
	lw	s0,88(sp)
	lw	s2,84(sp)
	lw	s3,80(sp)
	lw	s4,76(sp)
	lw	s5,72(sp)
	lw	s6,68(sp)
	lw	s7,64(sp)
	lw	s8,60(sp)
	lw	s9,56(sp)
	lw	s10,52(sp)
	lw	s11,48(sp)
	addi	sp,sp,96
	jr	ra
	.size	sha256_final, .-sha256_final
	.section	.rodata
	.align	2
.LC0:
	.string	"Please input string: "
	.align	2
.LC1:
	.string	"%s"
	.align	2
.LC2:
	.string	"hash hex: "
	.align	2
.LC3:
	.string	"%02x"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-432
	sw	ra,428(sp)
	sw	s0,424(sp)
	addi	s0,sp,432
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	addi	a5,s0,-276
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	addi	a5,s0,-424
	mv	a0,a5
	call	sha256_init
	addi	a5,s0,-276
	mv	a0,a5
	call	strlen
	mv	a3,a0
	addi	a4,s0,-276
	addi	a5,s0,-424
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	sha256_update
	addi	a4,s0,-308
	addi	a5,s0,-424
	mv	a1,a4
	mv	a0,a5
	call	sha256_final
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	sw	zero,-20(s0)
	j	.L23
.L24:
	lw	a5,-20(s0)
	addi	a4,s0,-16
	add	a5,a4,a5
	lbu	a5,-292(a5)
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L23:
	lw	a4,-20(s0)
	li	a5,31
	ble	a4,a5,.L24
	li	a0,10
	call	putchar
	li	a5,0
	mv	a0,a5
	lw	ra,428(sp)
	lw	s0,424(sp)
	addi	sp,sp,432
	jr	ra
	.size	main, .-main
	.ident	"GCC: (GNU) 9.2.0"
