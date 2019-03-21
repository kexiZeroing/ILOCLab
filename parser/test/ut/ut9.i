	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 loadI 1 	=> r3 
	 loadI 0 	=> r4 
	 cmp_LT r1, r2 	=> r5
	 cbr r5 	-> L0, L1
L0:	 nop 
	 loadI 0 	=> r6 
	 cmp_EQ r0, r6 	=> r7
	 cbr r7 	-> L3, L4
L3:	 nop 
	 write 	 r3
	 br 	-> L5
L4:	 nop 
	 write 	 r4
	 br 	-> L5
L5:	 nop 
L1:	 nop 
