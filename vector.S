#include <p32xxxx.h>
.section .vector_32,code
.set noreorder
.ent _vector_32
_vector_32:
j timer1
nop
.end _vector_32

.section .vector_4,code #timer 1
.set noreorder
.ent _vector_4
_vector_4:
j game
nop
.end _vector_4

.section .vector_12,code	#Timer 3 for global time
.set noreorder
.ent _vector_12
_vector_12:
j realtime
nop
.end _vector_12

.section .vector_16,code	#Timer 4 for gametime
.set noreorder
.ent _vector_16
_vector_16:
j playtime
nop
.end _vector_16