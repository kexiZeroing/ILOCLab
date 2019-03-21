	 loadI 1 	=> r0 
	 loadI 0 	=> r1 
	 cbr r2 	-> L0, L1
L0:	 nop 
	 write 	 r0
	 br 	-> L2
L1:	 nop 
	 write 	 r1
	 br 	-> L2
L2:	 nop 
	 cbr r2 	-> L3, L4
L3:	 nop 
	 write 	 r0
	 br 	-> L5
L4:	 nop 
	 write 	 r1
	 br 	-> L5
L5:	 nop 
	 write 	 r2
	 write 	 r2
