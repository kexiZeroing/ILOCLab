	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 multI r0, 10 	=> r3 
	 i2i r0 	=> r2 
	 i2i r3 	=> r4 
L0:	 nop 
	 cmp_LE r2, r4 	=> r5
	 cbr r5 	-> L1, L2
L1:	 nop 
	 addI r0, 1 	=> r6 
	 i2i r6 	=> r0 
	 multI r1, 2 	=> r7 
	 add r7, r0 	=> r8 
	 i2i r8 	=> r1 
	 addI r2, 1 	=> r2 
	 br 	-> L0
L2:	 nop 
	 write 	 r0
	 write 	 r1
