	 loadI 0 	=> r0 
	 loadI 9 	=> r1 
L0:	 nop 
	 cmp_LE r0, r1 	=> r2
	 cbr r2 	-> L1, L2
L1:	 nop 
	 subI r0, 0 	=> r4 
	 i2i r4 	=> r3 
	 multI r3, 4 	=> r3 
	 i2i r0 	=> r6 
	 storeAI r6 	=> r3, 0 
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
	 loadI 0 	=> r0 
	 loadI 9 	=> r7 
L3:	 nop 
	 cmp_LE r0, r7 	=> r8
	 cbr r8 	-> L4, L5
L4:	 nop 
	 subI r0, 0 	=> r10 
	 i2i r10 	=> r9 
	 multI r9, 4 	=> r9 
	 loadAI r9, 0 	=> r12 
	 write 	 r12
	 addI r0, 1 	=> r0 
	 br 	-> L3
L5:	 nop 
