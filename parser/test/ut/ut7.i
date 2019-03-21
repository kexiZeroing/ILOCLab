	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 1 	=> r2 
	 loadI 10 	=> r3 
L0:	 nop 
	 cmp_LE r2, r3 	=> r4
	 cbr r4 	-> L1, L2
L1:	 nop 
	 addI r1, 1 	=> r5 
	 addI r0, 1 	=> r6 
	 i2i r6 	=> r0 
	 add r2, r5 	=> r2 
	 br 	-> L0
L2:	 nop 
	 write 	 r0
