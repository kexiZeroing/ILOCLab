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
	 storeAI r7 	=> r4, 0 
	 addI r1, 1 	=> r1 
	 br 	-> L0
L2:	 nop 
	 loadI 0 	=> r1 
	 loadI 9 	=> r8 
L3:	 nop 
	 cmp_LE r1, r8 	=> r9
	 cbr r9 	-> L4, L5
L4:	 nop 
	 subI r1, 0 	=> r12 
	 loadI 11 	=> r11 
	 i2i r12 	=> r10 
	 multI r10, 4 	=> r10 
	 loadAI r10, 0 	=> r13 
	 add r0, r13 	=> r14 
	 i2i r14 	=> r0 
	 addI r1, 1 	=> r1 
	 br 	-> L3
L5:	 nop 
	 write 	 r0
