	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 cmp_LT r0, r1 	=> r3
	 cbr r3 	-> L0, L1
L0:	 nop 
	 loadI 0 	=> r4 
	 cmp_EQ r0, r4 	=> r5
	 cbr r5 	-> L3, L4
L3:	 nop 
	 write 	 r0
	 write 	 r1
	 br 	-> L5
L4:	 nop 
	 write 	 r2
	 br 	-> L5
L5:	 nop 
