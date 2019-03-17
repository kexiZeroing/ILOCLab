	 loadI 0 	=> r0 
	 loadI 9 	=> r1 
L0:	 nop 
	 cmp_LE r0, r1 	=> r2
	 cbr r2 	-> L1, L2
L1:	 nop 
	 i2c r0 	=> r0 
	 addI r0, 1 	=> r0 
	 br 	-> L0
L2:	 nop 
	 loadI 0 	=> r0 
	 loadI 9 	=> r3 
L3:	 nop 
	 cmp_LE r0, r3 	=> r4
	 cbr r4 	-> L4, L5
L4:	 nop 
	 cwrite 	 r0
	 addI r0, 1 	=> r0 
	 br 	-> L3
L5:	 nop 
