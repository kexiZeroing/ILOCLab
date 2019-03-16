	 loadI 10 	=> r2 
	 loadI 1 	=> r0 
	 i2i r2 	=> r3 
L0:	 nop 
	 cmp_LE r0, r3 	=> r4
	 cbr r4 	-> L1, L2
L1:	 nop 
	 write 	 r0
	 loadI 1 	=> r1 
	 i2i r2 	=> r5 
L3:	 nop 
	 cmp_LE r1, r5 	=> r6
	 cbr r6 	-> L4, L5
L4:	 nop 
	 write 	 r1
	 addI r1, 1 	=> r1 
	 br 	-> L3
L5:	 nop 
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
