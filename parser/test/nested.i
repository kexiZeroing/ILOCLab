	 loadI 0 	=> r4 
	 loadI 2 	=> r3 
	 loadI 1 	=> r0 
	 loadI 100 	=> r5 
L0:	 nop 
	 cmp_LE r0, r5 	=> r6
	 cbr r6 	-> L1, L2
L1:	 nop 
	 loadI 1 	=> r1 
	 loadI 100 	=> r7 
L3:	 nop 
	 cmp_LE r1, r7 	=> r8
	 cbr r8 	-> L4, L5
L4:	 nop 
	 loadI 1 	=> r2 
	 loadI 13 	=> r9 
L6:	 nop 
	 cmp_LE r2, r9 	=> r10
	 cbr r10 	-> L7, L8
L7:	 nop 
	 loadI 2 	=> r11 
	 cmp_EQ r3, r11 	=> r12
	 cbr r12 	-> L9, L10
L9:	 nop 
	 addI r4, 1 	=> r13 
	 i2i r13 	=> r4 
L10:	 nop 
	 loadI 2 	=> r14 
	 cmp_EQ r3, r14 	=> r15
	 cbr r15 	-> L12, L13
L12:	 nop 
	 loadI 0 	=> r3 
L13:	 nop 
	 addI r3, 1 	=> r16 
	 i2i r16 	=> r3 
	 addI r2, 1 	=> r2 
	 br 	-> L6
L8:	 nop 
	 addI r1, 1 	=> r1 
	 br 	-> L3
L5:	 nop 
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
	 write 	 r4
