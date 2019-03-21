	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 loadI 1 	=> r3 
	 loadI 0 	=> r4 
	 cmp_LE r0, r1 	=> r5
	 cbr r5 	-> L0, L1
L0:	 nop 
	 write 	 r3
	 br 	-> L2
L1:	 nop 
	 write 	 r4
	 br 	-> L2
L2:	 nop 
