	 loadI 1 	=> r0 
	 loadI 10 	=> r1 
L0:	 nop 
	 cmp_LT r0, r1 	=> r2
	 cbr r2 	-> L1, L2
L1:	 nop 
	 write 	 r0
	 addI r0, 1 	=> r3 
	 i2i r3 	=> r0 
	 br 	-> L0
L2:	 nop 
