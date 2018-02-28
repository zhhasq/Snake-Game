#include <p32xxxx.h>
.global initialize
.text
.set noreorder 
.ent initialize
initialize:
	sw ra,0xA00002C0
	nop
	sw zero,0xA00002FC
	li k0,0x00008B00		#initialize U2ART
	sw k0,U2MODE
	nop
	li k0,0x00001400
	sw k0,U2STA
	nop
	li k0,0x00000020
	sw k0,U2BRG
	nop
	sw zero,TRISB  #set PORTB as output 	
	sw zero,ODCB
	sw zero,PORTB

	sw zero,TRISE  #set PORTE as output 	
	sw zero,ODCE
	sw zero,PORTE

	li t0,326
	la k0,LR
	nop
	column:
	lb k1,0(k0)
	bal delay
	nop
	nop
	nop
	sb k1,U2TXREG
	addi t0,t0,-1
	addi k0,k0,2
	bne t0,0,column
	nop
	nop
	li t0,7
	la k0,line1
	change:
	lb k1,0(k0)
	bal delay
	nop
	nop
	nop
	sb k1,U2TXREG
	addi t0,t0,-1
	addi k0,k0,2
	bne t0,0,change
	nop
	nop
	li t0,75
	li k1,0x00000058
	row:
	nop
	bal delay
	nop
	nop
	sw k1,U2TXREG
	addi t0,t0,-1
	bne t0,0,row
	nop
	li t0,7
	la k0,line2
	change2:
	lb k1,0(k0)
	bal delay	
	nop
	nop
	sw k1,U2TXREG
	addi t0,t0,-1
	addi k0,k0,2
	bne t0,0,change2
	nop
	nop
	li t0,75
	li k1,0x00000058
	row2:
	nop
	bal delay
	nop
	nop
	sw k1,U2TXREG
	addi t0,t0,-1
	bne t0,0,row2
	nop
	nop
	la k0,line3
	li t0,8
	change3:
	lb k1,0(k0)
	bal delay
	nop
	nop
	sb k1,U2TXREG
	addi t0,t0,-1
	addi k0,k0,2
	bne t0,0,change3
	nop
	nop
	li t0,5
	li s0,0xA0000300	
	lw ra,0xA00002C0
	jr ra
	
.end initialize