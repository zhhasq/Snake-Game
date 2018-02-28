#include <p32xxxx.h>
.global game
.text
.set noreorder 
.ent game 
game:
nop
lw t7,0xA00002C4
beq t7,0,food
nop
b begin
nop
food:
	lw t7,0xA00002FC
	beq t7,0,begin
	nop
	lw t7,TMR2
	li t8,22
	divu t7,t8
	MFHI t9
	SLTIu s7,t9,0x4
	nop
	beq s7,1,food
	nop
	nop
	sh t9,0xA00002C4
	nop
	food2:
	lw t7,TMR2
	li t8,78
	divu t7,t8
	MFHI t9
	SLTIu s7,t9,0x4
	nop
	nop
	beq s7,1,food2
	nop
	sh t9,0xA00002C6
	nop
	lw t0,0xA00002E8
	li k0,0xA0000408
	repeat:
	lw k1,0(k0)
	lw t7,0xA00002C4
	beq t7,k1,food
	nop
	addi k0,k0,4
	addi t0,t0,-1
	bne t0,0,repeat 
	nop
	food3:
	lw t7,TMR2
	li t8,10
	divu t7,t8
	MFHI t9
	sltiu s7,t9,2
	beq s7,1,food3
	nop
	sw t9,0xA00002C8
	li s3,0xA00002CC
	li s5,0x1B
	sh s5,0(s3)
	li s5,0x5B
	sh s5,2(s3)
	lhu s5,0xA00002C4
	li s6,10
	divu s5,s6
	MFlo s4
	beq s4,0,goon
	nop
	addi s4,s4,0x30
	sh s4,4(s3)
	addi s3,s3,2
	nop
	goon:
	mfhi s4
	addi s4,s4,0x30
	sh s4,4(s3)
	li s5,0x3B
	sh s5,6(s3)
	lhu s5,0xA00002C6
	li s6,10
	div s5,s6
	MFlo s4
	beq s4,0,goon2
	nop
	addi s4,s4,0x30
	sh s4,8(s3)
	addi s3,s3,2
	nop
	goon2:
	mfhi s4
	addi s4,s4,0x30
	sh s4,8(s3)
	li s5,0x48
	sh s5,10(s3)
	lw s5,0xA00002C8
	addi s5,s5,0x30
	sh s5,12(s3)
	li s5,0x21
	sh s5,14(s3)
	nop
	li s3,0xA00002CC
	showfood:
	lb s5,0(s3)
	beq s5,0x21,begin
	nop
	sw ra,0xA00002C0
	bal delay
	nop
	nop
	lw ra,0xA00002C0
	sb s5,U2TXREG
	addi s3,s3,2
	b showfood
	nop
	nop
begin:	
li k0,0xA0000400
	lhu t3,0x04(k0)       #get old head row positon of snake in t3
	sh t3,0(k0)			#save old head row position
	lhu t4,0x06(k0)			#get old head column postion of snake in t4
	sh t4,0x02(k0)			#save old head column position 
	li k1,0x1B
	li a0,0xA00003A0
	sh k1,0(a0)
	li k1,0x5B
	sh k1,2(a0)
	li t2,10
	div t3,t2
	MFLo t5
	beq t5,0,next
 	nop
	addi t5,t5,0x30
	sh t5,4(a0)
	addi a0,a0,2
next:
	MFHI t6
	addi t6,t6,0x30
	sh t6,4(a0)
	li k1,0x3B
	sh k1,6(a0)
	div t4,t2
	MFLo t5
	beq t5,0,next2
	nop
	addi t5,t5,0x30
	sh t5,8(a0)
	addi a0,a0,2
next2:
	MFHI t6
	addi t6,t6,0x30
	sh t6,8(a0)
	li k1,0x48
	sh k1,10(a0)
	li k1,0x5E
	sh k1,12(a0)
nop
	lw t2,0xA00002E0      #direction key is kept in 0xA00002E0
	beq t2,0x61, left     #key is k go left
	nop
	beq t2,0x73, down
	nop
	beq t2,0x77, up
	nop
	beq t2,0x64, right
left:
	lhu t4,6(k0)
	addi t4,t4,-1      #move left 
	beq t4,3,dead     #ckeck if head meet with leat board 
	nop
	sh t4,0x06(k0)		#save new head cloumn
	lw a2,0xA00002C4
	lw a3,0xA0000404
	bne a3,a2,fresh
	nop
	lw k1,0xA00002C8
	sw k1,0xA00002E4
	sw zero,0xA00002C8
	sw zero,0xA00002C4
	b fresh
	nop
down:
	lhu t3,4(k0)
	addi t3,t3,1
	beq t3,22,dead
	nop
	sh t3,0x04(k0)
	lw a2,0xA00002C4
	lw a3,0xA0000404
	bne a3,a2,fresh
	nop
	lw k1,0xA00002C8
	sw k1,0xA00002E4
	sw zero,0xA00002C8
	sw zero,0xA00002C4
	b fresh
	nop
up:
	lhu t3,4(k0)
	addi t3,t3,-1
	beq t3,3,dead
	nop
	sh t3,0x04(k0)
	lw a2,0xA00002C4
	lw a3,0xA0000404
	bne a3,a2,fresh
	nop
	lw k1,0xA00002C8
	sw k1,0xA00002E4
	sw zero,0xA00002C8
	sw zero,0xA00002C4
	b fresh
	nop
right:
	lhu t4,6(k0)
	addi t4,t4,1      #move left 
	beq t4,78,dead     #ckeck if head meet with leat board 
	nop
	sh t4,0x06(k0)		#save new head cloumn
	lw a2,0xA00002C4
	lw a3,0xA0000404
	bne a3,a2,fresh
	nop
	lw k1,0xA00002C8
	sw k1,0xA00002E4
	sw zero,0xA00002C8
	sw zero,0xA00002C4
	b fresh
	nop

fresh:
	bal ifdead
	nop
	nop
	li k1,0x1B
	sh k1,14(a0)
	li k1,0x5B
	sh k1,16(a0)
	li t2,10
	lhu t3,4(k0)
	div t3,t2
	MFLo t5
	beq t5,0,next3
 	nop
	addi t5,t5,0x30
	sh t5,18(a0)
	addi a0,a0,2
next3:
	MFHI t6
	addi t6,t6,0x30
	sh t6,18(a0)
	li k1,0x3B
	sh k1,20(a0)
	lhu t4,6(k0)
	div t4,t2
	MFLo t5
	beq t5,0,next4
	nop
	addi t5,t5,0x30
	sh t5,22(a0)
	addi a0,a0,2		
	nop
next4:
	MFHI t6
	addi t6,t6,0x30
	sh t6,22(a0)
	li k1,0x48
	sh k1,24(a0)
	li k1,0x23
	sh k1,26(a0)
	nop

ifincrease:
lw a1,0xA00002E4			#the number of body need increase
bne a1,0,increase 
nop
lhu t3,8(k0)				#no increase
	li t2,10
	li k1,0x1B
	sh k1,28(a0)
	li k1,0x5B
	sh k1,30(a0)
	div t3,t2
	MFLo t5
	beq t5,0,next5
 	nop
	addi t5,t5,0x30
	sh t5,32(a0)
	addi a0,a0,2
next5:
	MFHI t6
	addi t6,t6,0x30
	sh t6,32(a0)
	li k1,0x3B
	sh k1,34(a0)
lhu t4,10(k0)
	div t4,t2
	MFLo t5
	beq t5,0,next6
	nop
	addi t5,t5,0x30
	sh t5,36(a0)
	addi a0,a0,2
next6:
	MFHI t6
	addi t6,t6,0x30
	sh t6,36(a0)
	li k1,0x48
	sh k1,38(a0)
	li k1,0x20
	sh k1,40(a0)
	li k1,0x21
	sh k1,42(a0)
	nop
# refresh the coordinate
lw t0,0xA00002E8
addi t0,t0,-1
li k0,0xA0000400
coordinate:
lw k1,12(k0)
sw k1,8(k0)
addi k0,k0,4
addi t0,t0,-1
bne t0,0,coordinate
nop
addi k0,k0,8
sw k0,0xA00002EC
li k0,0xA0000400
lw k1,0(k0)
lw k0,0xA00002EC
sw k1,0(k0)
nop
b update
nop
increase:
addi a1,a1,-1
sw a1,0xA00002E4
li k1,0x21
sh k1,28(a0)
li k0,0xA0000400
lw k1,0(k0)
lw k0,0xA00002EC		#0xA00002EC save the address of fist body(the last bock in memory)
addi k0,k0,4
sw k0,0xA00002EC
sw k1,0(k0)
lw k1,0xA00002E8
addi k1,k1,1
sw k1,0xA00002E8
nop
	#move cursor after score:
	li s3,0xA0000340		
	li s4,0x00390036
	sw s4,8(s3)
	li t0,7
newscore:
	lb s4,0(s3)
	bal delay
	nop
	nop
	sb s4,U2TXREG
	addi s3,s3,2
	addi t0,t0,-1
	bne t0,0,newscore
	nop
	lw s4,0xA00002E8
	addi s4,s4,-6
	sltiu s5,s4,10
	beq s5,1,dig1
	nop
	sltiu s5,s4,100
	beq s5,1,dig2
	nop
	sltiu s5,s4,1000
	beq s5,1,dig3
	nop	
	dig3:
	div s4,100
	mflo s5
	addi s5,s5,0x30
	sw s5,U2TXREG
	nop
	mfhi s4
	dig2:
	div s4,10
	mflo s5
	addi s5,s5,0x30	
	nop
	sw s5,U2TXREG
	mfhi s4
	dig1:
	addi s4,s4,0x30

	nop	
	sw s4,U2TXREG
	nop

update:
	li a0,0xA00003A0
sent:
	lb k1,0(a0)
	nop	
	bal delay
	nop
	nop
	nop
	beq k1,0x21,stop
	nop
	sb k1,U2TXREG
	addi a0,a0,2
	nop
	b sent
	nop
stop:
	li k1,0x0010
	sw k1,IFS0CLR
	ERET
dead:
	li k1,0x0010
	sw k1,IFS0CLR
	li k1,0x8000		#turn off timer 1
	sw k1,T1CONCLR
	sw k1,T4CONCLR
	sw zero,0xA00002FC
	ERET
nop
.end game
