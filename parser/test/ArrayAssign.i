	 loadI 0 	=> r0 
	 loadI 9 	=> r1 
L0:	 nop 
	 cmp_LE r0, r1 	=> r2
	 cbr r2 	-> L1, L2
L1:	 nop 
	 subI r0, 0 	=> r5 
	 loadI 11 	=> r4 
	 i2i r5 	=> r3 
	 multI r3, 4 	=> r3 
	 storeAI r0 	=> r3, 0 
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
	 loadI 0 	=> r0 
	 loadI 9 	=> r6 
L3:	 nop 
	 cmp_LE r0, r6 	=> r7
	 cbr r7 	-> L4, L5
L4:	 nop 
	 subI r0, 0 	=> r10 
	 loadI 11 	=> r9 
	 i2i r10 	=> r8 
	 multI r8, 4 	=> r8 
	 loadAI r8, 0 	=> r11 
	 write 	 r11
	 addI r0, 1 	=> r0 
	 br 	-> L3
L5:	 nop 
