	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 loadI 1 	=> r3 
	 loadI 0 	=> r4 
	 cmp_LT r0, r1 	=> r5
	 cbr r5 	-> L0, L1
L0:	 nop 
	 write 	 r3
	 br 	-> L2
L1:	 nop 
	 write 	 r4
	 br 	-> L2
L2:	 nop 
	 cmp_GT r1, r2 	=> r8
	 cbr r8 	-> L3, L4
L3:	 nop 
	 write 	 r3
L4:	 nop 
	 cmp_LE r1, r2 	=> r10
	 cbr r10 	-> L6, L7
L6:	 nop 
	 write 	 r4
L7:	 nop 
	 cmp_LT r1, r2 	=> r12
	 cbr r12 	-> L9, L10
L9:	 nop 
	 loadI 0 	=> r13 
	 cmp_EQ r0, r13 	=> r14
	 cbr r14 	-> L12, L13
L12:	 nop 
	 write 	 r3
	 br 	-> L14
L13:	 nop 
	 write 	 r4
	 br 	-> L14
L14:	 nop 
L10:	 nop 
