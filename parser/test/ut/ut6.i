	 loadI 1 	=> r0 
	 loadI 1 	=> r1 
	 loadI 10 	=> r2 
L0:	 nop 
	 cmp_LE r1, r2 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 addI r0, 1 	=> r4 
	 i2i r4 	=> r0 
	 addI r1, 1 	=> r1 
	 br 	-> L0
L2:	 nop 
	 write 	 r0
