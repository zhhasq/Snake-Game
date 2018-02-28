#include <p32xxxx.h>
.global delay
.text
.set noreorder
.ent delay
delay:
li t1,1800
again:
addi t1,t1,-1
bne t1,0,again
nop
nop
jr ra
nop
.end delay
