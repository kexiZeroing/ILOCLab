	 loadI 0 	=> r0 
	 loadI 0 	=> r1 
	 loadI 9 	=> r2 
L0:	 nop 
	 cmp_LE r1, r2 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 subI r1, 0 	=> r6 
	 loadI 11 	=> r5 
	 i2i r6 	=> r4 
	 multI r4, 4 	=> r4 
	 multI r1, 2 	=> r7 
	 i2i r7 	=> r8 
	 storeAI r8 	=> r4, 0 
	 addI r1, 1 	=> r1 
	 br 	-> L0
L2:	 nop 
	 loadI 0 	=> r1 
	 loadI 9 	=> r9 
L3:	 nop 
	 cmp_LE r1, r9 	=> r10
	 cbr r10 	-> L4, L5
L4:	 nop 
	 subI r1, 0 	=> r13 
	 loadI 11 	=> r12 
	 i2i r13 	=> r11 
	 multI r11, 4 	=> r11 
	 loadAI r11, 0 	=> r14 
	 add r0, r14 	=> r15 
	 i2i r15 	=> r0 
	 addI r1, 1 	=> r1 
	 br 	-> L3
L5:	 nop 
	 write 	 r0
