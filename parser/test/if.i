	 loadI 1 	=> r0 
	 loadI 2 	=> r1 
	 loadI 3 	=> r2 
	 cmp_EQ r0, r0 	=> r3
	 cbr r3 	-> L0, L1
L0:	 nop 
	 write 	 r0
L1:	 nop 
	 cmp_EQ r0, r1 	=> r4
	 cbr r4 	-> L3, L4
L3:	 nop 
	 write 	 r1
	 br 	-> L5
L4:	 nop 
	 write 	 r0
	 br 	-> L5
L5:	 nop 
	 add r0, r0 	=> r5 
	 cmp_EQ r5, r1 	=> r6
	 cbr r6 	-> L6, L7
L6:	 nop 
	 write 	 r0
	 br 	-> L8
L7:	 nop 
	 write 	 r1
	 br 	-> L8
L8:	 nop 
	 cmp_LT r0, r1 	=> r7
	 cbr r7 	-> L9, L10
L9:	 nop 
	 loadI 0 	=> r8 
	 cmp_EQ r0, r8 	=> r9
	 cbr r9 	-> L12, L13
L12:	 nop 
	 write 	 r0
	 br 	-> L14
L13:	 nop 
	 write 	 r1
	 br 	-> L14
L14:	 nop 
L13:	 nop 
	 cmp_LT r1, r0 	=> r10
	 cbr r10 	-> L15, L16
L15:	 nop 
	 loadI 0 	=> r11 
	 cmp_EQ r0, r11 	=> r12
	 cbr r12 	-> L18, L19
L18:	 nop 
	 write 	 r0
	 br 	-> L20
L19:	 nop 
	 write 	 r1
	 br 	-> L20
L20:	 nop 
L19:	 nop 
