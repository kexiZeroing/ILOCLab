	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 cmp_LT r0, r1 	=> r4
	 cbr r4 	-> L0, L1
L0:	 nop 
	 loadI 1 	=> r5 
	 cmp_EQ r0, r5 	=> r6
	 cbr r6 	-> L3, L4
L3:	 nop 
	 write 	 r0
	 br 	-> L5
L4:	 nop 
	 loadI 11 	=> r3 
	 write 	 r3
	 br 	-> L5
L5:	 nop 
	 br 	-> L2
L1:	 nop 
	 write 	 r2
	 br 	-> L2
L2:	 nop 
