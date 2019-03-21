	 loadI 1 	=> r0 
	 loadI 1 	=> r-1 
	 loadI 10 	=> r2 
L0:	 nop 
	 cmp_LE r-1, r2 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 loadI 1 	=> r0 
	 addI r-1, 1 	=> r-1 
	 br 	-> L0
L2:	 nop 
L3:	 nop 
	 cmp_EQ r0, r0 	=> r4
	 cbr r4 	-> L4, L5
L4:	 nop 
	 loadI 1 	=> r5 
	 storeAI r5 	=> r-1, 0 
	 br 	-> L3
L5:	 nop 
