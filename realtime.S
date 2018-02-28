#include <p32xxxx.h>
.global realtime
.text
.set noreorder
.ent realtime
realtime:
	sw k0,0xA00002F0
	sw k1,0xA00002F4
	li k0,0xA0000300
	lw k1,16(k0)
	addi k1,k1,1
	beq k1,0x3A,CC
	nop
	sw k1,16(k0)
	b refresh
	nop
CC:
	li k1,0x30
	sw k1,16(k0)
	lw k1,12(k0)
	addi k1,k1,1
	beq k1,0x36,BB
	nop
	sw k1,12(k0)
	b refresh
	nop
BB:
	li k1,0x30
	sw k1,12(k0)
	lw k1,4(k0)
	addi k1,k1,1
	sw k1,4(k0)
	lw k1,0(k0)
	beq k1,0x32,AA
	nop
	lw k1,4(k0)
	beq k1,0x3A,BBB
	nop
	b refresh
	nop
BBB: 
	li k1,0x30
	sw k1,4(k0)           
	lw k1,0(k0)
	addi k1,k1,1
	sw k1,0(k0)
	b refresh
	nop
AA:
	lw k1,4(k0)
	beq k1,0x34,new
	nop
	b refresh
	nop
new:
	li k1,0x30
	sw k1,0(k0)
	sw k1,4(k0)
	b refresh
	nop
	nop
refresh :
	la k0,line3
	li t0,8
	change4:
	lb k1,0(k0)
	nop
	nop
	bal delay
	nop
	nop
	nop
	sb k1,U2TXREG
	nop	
	addi t0,t0,-1
	nop	
	addi k0,k0,2
	bne t0,0,change4
	nop
	li t0,5
	li k0,0xA0000300
	nop
	sent:
	lw k1,0(k0)
	nop	
	bal delay
	nop
	nop
	nop
	sw k1,U2TXREG
	addi k0,k0,4
	addi t0,t0,-1
	bne t0,0,sent
	nop
	nop
	li k1,0x1000
	sw k1,IFS0CLR
	nop
	lw k0,0xA00002F0
	lw k1,0xA00002F4
nop
ERET
nop
.end realtime
