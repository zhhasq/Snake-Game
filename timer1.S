#include <p32xxxx.h>
.global timer1
.text
.set noreorder
.ent timer1
timer1:
sw s0,0xA00002F8	#save value of s0
nop
lw s6,0xA0000240
beq s6,0x63,switch
nop
nop
lw s0,U2RXREG
beq s0,0x63,switch
nop
beq s0,0x61,direction		#a
nop	
beq s0,0x77,direction       #w
nop
beq s0,0x64,direction       #d
nop
beq s0,0x73,direction		#s
nop
beq s0,0x72,reset
nop
beq s0,0x31,speed
nop
beq s0,0x32,speed
nop
beq s0,0x33,speed
nop
beq s0,0x34,speed
nop
beq s0,0x35,speed
nop
beq s0,0x36,speed
nop
beq s0,0x37,speed
nop
beq s0,0x38,speed
nop
beq s0,0x39,speed
nop
b stop
nop
speed:
	li k1,0x8000		#turn off timer 1
	sw k1,T1CONCLR
	addi s0,s0,-0x30
	li s1,10
	sub s0,s1,s0
	li s1,3906
	mul s1,s1,s0
	sw s1,PR1
	li s1,0x8000
	sw s1,T1CONSET
	nop
	b stop
	nop
switch:
sw zero,0xA0000240
lw s1,0xA00002FC
beq s1,0,start
nop					#game is running
sw zero,0xA00002FC
li s1,0x8000		#turn off timer 1
sw s1,T1CONCLR
nop
b stop
nop
start:				#game is stop
	li k1,0x1B
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x5B
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x32
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x4A
	bal delay
	nop
	nop
	sw k1,U2TXREG
	nop
	bal initialize
	nop
	nop
	li t0,8
	la k0,gametime
gtime:					#printf "play" on the bottom
	lb k1,0(k0)
	bal delay
	nop
	nop
	sb k1,U2TXREG
	addi k0,k0,2
	addi t0,t0,-1
	bne t0,0,gtime
	nop
	li k1,0x50
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x6C
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x61
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x79
	bal delay 
	nop
	nop
	sw k1,U2TXREG
	li k1,0x3A
	bal delay
	nop
	nop	
	sw k1,U2TXREG
	nop
	li k1,0x30
	sw k1,0xA0000320
	sw k1,0xA0000324
	sw k1,0xA000032C
	sw k1,0xA0000330
	li k1,0x6D       	#play time m
	sw k1,0xA0000328
	li k0,0x73			#play time s
	sw k0,0xA0000334
	li t0,7
	li k0,0xA0000340
	li k1,0x1B
	sh k1,0(k0)
	li k1,0x5B
	sh k1,2(k0)
	li k1,0x32
	sh k1,4(k0)
	li k1,0x3B
	sh k1,6(k0)
	li k1,0x36
	sh k1,8(k0)
	li k1,0x33
	sh k1,10(k0)
	li k1,0x48
	sh k1,12(k0)
	li k0,0xA0000340
scoreout:
	lb k1,0(k0)
	bal delay
	nop
	nop
	sb k1,U2TXREG
	addi k0,k0,2
	addi t0,t0,-1
	bne t0,0,scoreout
	nop
	li k1,0x73
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x63
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x6F
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x72
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x65
	bal delay
	nop
	nop
	sw k1,U2TXREG
	li k1,0x3A
	bal delay
	nop
	nop
	sw k1,U2TXREG
	nop
	li k1,0x0
	sw k1,0xA0000350
	sw k1,0xA0000354
	sw k1,0xA0000358
	sw k1,0xA000035C
	li k1,0x30
	bal delay
	nop
	nop
	sw k1,U2TXREG
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
li t0,9
la k0,center
centerposition:
lbu k1,0(k0)
bal delay
nop
sb k1,U2TXREG
addi t0,t0,-1
addi k0,k0,2
bne t0,0,centerposition
nop
nop
li k1,0x23
bal delay
nop
nop
sb k1,U2TXREG
li t0,6
body:
li k1,0x5E
bal delay
nop
nop
sb k1,U2TXREG
addi t0,t0,-1
bne t0,0,body
nop
nop
sw s0,0xA00002FC
li k1,12
sh k1,0xA0000404
sh k1,0xA0000408
sh k1,0xA000040C
sh k1,0xA0000410
sh k1,0xA0000414
sh k1,0xA0000418
sh k1,0xA000041C
li k1,40
sh k1,0xA0000406
li k1,46
sh k1,0xA000040A
li k1,45
sh k1,0xA000040E
li k1,44
sh k1,0xA0000412
li k1,43
sh k1,0xA0000416
li k1,42
sh k1,0xA000041A
li k1,41
sh k1,0xA000041E
li k1,0x6B
sb k1,0xA00002E0      #0xA00002E0 save the direction
li k1,0
sw k1,0xA00002E4		#0xA00002E4 save the number of dody need to increase
li k1,6
sw k1,0xA00002E8       # current number of body
li k1,0xA000041C
sw k1,0xA00002EC
nop
li s1,0x8000
sw s1,T1CONSET          	#turn on timer 1,start game
sw s1, T4CONSET				#turn on timer 4
nop
reset:
sw zero,0xA00002C4
sw zero,0xA00002C8
nop
b stop
nop
direction:
sw s0,0xA00002E0
nop
stop:
sw zero, U2RXREG		#clear U2RXREG 
sw zero, U2TXREG		#clear U2TXREG
li s1,0x0200		#clear U2RXIF
sw s1,IFS1CLR
nop
ERET
nop
.end timer1