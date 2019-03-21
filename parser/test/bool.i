	 loadI 1 	=> r0 
	 loadI 0 	=> r1 
	 or r1, r1 	=> r3 
	 cbr r3 	-> L0, L1
L0:	 nop 
	 write 	 r0
	 br 	-> L2
L1:	 nop 
	 write 	 r1
	 br 	-> L2
L2:	 nop 
	 or r0, r1 	=> r4 
	 cbr r4 	-> L3, L4
L3:	 nop 
	 write 	 r0
	 br 	-> L5
L4:	 nop 
	 write 	 r1
	 br 	-> L5
L5:	 nop 
	 or r1, r0 	=> r5 
	 cbr r5 	-> L6, L7
L6:	 nop 
	 write 	 r0
	 br 	-> L8
L7:	 nop 
	 write 	 r1
	 br 	-> L8
L8:	 nop 
	 or r0, r0 	=> r6 
	 cbr r6 	-> L9, L10
L9:	 nop 
	 write 	 r0
	 br 	-> L11
L10:	 nop 
	 write 	 r1
	 br 	-> L11
L11:	 nop 
	 and r1, r1 	=> r7 
	 cbr r7 	-> L12, L13
L12:	 nop 
	 write 	 r0
	 br 	-> L14
L13:	 nop 
	 write 	 r1
	 br 	-> L14
L14:	 nop 
	 and r0, r1 	=> r8 
	 cbr r8 	-> L15, L16
L15:	 nop 
	 write 	 r0
	 br 	-> L17
L16:	 nop 
	 write 	 r1
	 br 	-> L17
L17:	 nop 
	 and r1, r0 	=> r9 
	 cbr r9 	-> L18, L19
L18:	 nop 
	 write 	 r0
	 br 	-> L20
L19:	 nop 
	 write 	 r1
	 br 	-> L20
L20:	 nop 
	 and r0, r0 	=> r10 
	 cbr r10 	-> L21, L22
L21:	 nop 
	 write 	 r0
	 br 	-> L23
L22:	 nop 
	 write 	 r1
	 br 	-> L23
L23:	 nop 
	 not r1 	=> r11 
	 cbr r11 	-> L24, L25
L24:	 nop 
	 write 	 r0
	 br 	-> L26
L25:	 nop 
	 write 	 r1
	 br 	-> L26
L26:	 nop 
	 not r0 	=> r12 
	 cbr r12 	-> L27, L28
L27:	 nop 
	 write 	 r1
	 br 	-> L29
L28:	 nop 
	 write 	 r0
	 br 	-> L29
L29:	 nop 
