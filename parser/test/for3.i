	 loadI 10 	=> r2 
	 loadI 1 	=> r1 
	 i2i r2 	=> r3 
L0:	 nop 
	 cmp_LE r1, r3 	=> r4
	 cbr r4 	-> L1, L2
L1:	 nop 
	 write 	 r1
	 addI r1, 1 	=> r1 
	 br 	-> L0
L2:	 nop 
