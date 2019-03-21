	 loadI 1 	=> r0 
	 loadI 10 	=> r1 
L0:	 nop 
	 cmp_LT r0, r1 	=> r3
	 cbr r3 	-> L1, L2
L1:	 nop 
	 loadI 10 	=> r4 
	 cwrite 	 r4
	 write 	 r0
	 loadI 32 	=> r7 
	 cwrite 	 r7
	 loadI 9 	=> r2 
L3:	 nop 
	 loadI 1 	=> r9 
	 cmp_GE r2, r9 	=> r10
	 cbr r10 	-> L4, L5
L4:	 nop 
	 write 	 r2
	 subI r2, 1 	=> r12 
	 i2i r12 	=> r2 
	 br 	-> L3
L5:	 nop 
	 addI r0, 1 	=> r13 
	 i2i r13 	=> r0 
	 br 	-> L0
L2:	 nop 
