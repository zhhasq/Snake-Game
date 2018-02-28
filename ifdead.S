#include <p32xxxx.h>
.global ifdead
.text
.set noreorder 
.ent ifdead
ifdead:
lw t0,0xA00002E8
lw a2,0xA0000404
li s5,0xA0000408
nextbody:
lw a3,0(s5)
beq a2,a3,dead
nop
addi t0,t0,-1
addi s5,s5,4
bne t0,0,nextbody
nop
nop
jr ra
nop
dead:
	li k1,0x0010
	sw k1,IFS0CLR
	li k1,0x8000		#turn off timer 1
	sw k1,T1CONCLR
	sw k1,T4CONCLR
	sw zero,0xA00002FC
	
nop
jr ra
nop
.end ifdead
