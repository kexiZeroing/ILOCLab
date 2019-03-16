	 loadI 10 	=> r1 
	 loadI 1 	=> r0 
	 loadI 10 	=> r2 
L0:	 nop 
	 cmp_LE r0, r2 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 write 	 r0
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
