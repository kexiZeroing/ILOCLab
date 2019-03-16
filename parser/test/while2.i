	 loadI 1 	=> r0 
	 loadI 10 	=> r1 
L0:	 nop 
	 cmp_LT r0, r1 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 loadI 10 	=> r4 
	 cwrite 	 r4
	 write 	 r0
	 loadI 32 	=> r5 
	 cwrite 	 r5
	 loadI 9 	=> r2 
L3:	 nop 
	 loadI 1 	=> r6 
	 cmp_GE r2, r6 	=> r7
	 cbr r7 	-> L4, L5
L4:	 nop 
	 write 	 r2
	 subI r2, 1 	=> r8 
	 i2i r8 	=> r2 
	 br 	-> L3
L5:	 nop 
	 addI r0, 1 	=> r9 
	 i2i r9 	=> r0 
	 br 	-> L0
L2:	 nop 
