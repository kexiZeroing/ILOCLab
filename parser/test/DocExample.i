	 read 	=> r1
	 loadI 10000 	=> r5 
	 cmp_GT r1, r5 	=> r6
	 cbr r6 	-> L0, L1
L0:	 nop 
	 loadI 0 	=> r1 
L1:	 nop 
	 loadI 100 	=> r7 
	 cwrite 	 r7
	 loadI 97 	=> r9 
	 cwrite 	 r9
	 loadI 116 	=> r11 
	 cwrite 	 r11
	 loadI 97 	=> r13 
	 cwrite 	 r13
	 loadI 32 	=> r15 
	 cwrite 	 r15
	 subI r1, 1 	=> r17 
	 loadI 0 	=> r0 
	 i2i r17 	=> r18 
L3:	 nop 
	 cmp_LE r0, r18 	=> r19
	 cbr r19 	-> L4, L5
L4:	 nop 
	 subI r0, 0 	=> r21 
	 i2i r21 	=> r20 
	 multI r20, 4 	=> r20 
	 read 	=> r23
	 storeAI r23 	=> r20, 0 
	 addI r0, 1 	=> r0 
	 br 	-> L3
L5:	 nop 
	 loadI 1 	=> r2 
L6:	 nop 
	 loadI 1 	=> r24 
	 cmp_EQ r2, r24 	=> r25
	 cbr r25 	-> L7, L8
L7:	 nop 
	 loadI 0 	=> r2 
	 subI r1, 2 	=> r26 
	 loadI 0 	=> r0 
	 i2i r26 	=> r27 
L9:	 nop 
	 cmp_LE r0, r27 	=> r28
	 cbr r28 	-> L10, L11
L10:	 nop 
	 subI r0, 0 	=> r30 
	 i2i r30 	=> r29 
	 multI r29, 4 	=> r29 
	 loadAI r29, 0 	=> r32 
	 addI r0, 1 	=> r33 
	 subI r33, 0 	=> r35 
	 i2i r35 	=> r34 
	 multI r34, 4 	=> r34 
	 loadAI r34, 0 	=> r37 
	 cmp_GT r32, r37 	=> r38
	 cbr r38 	-> L12, L13
L12:	 nop 
	 loadI 1 	=> r2 
	 subI r0, 0 	=> r40 
	 i2i r40 	=> r39 
	 multI r39, 4 	=> r39 
	 loadAI r39, 0 	=> r42 
	 i2i r42 	=> r3 
	 subI r0, 0 	=> r44 
	 i2i r44 	=> r43 
	 multI r43, 4 	=> r43 
	 addI r0, 1 	=> r46 
	 subI r46, 0 	=> r48 
	 i2i r48 	=> r47 
	 multI r47, 4 	=> r47 
	 loadAI r47, 0 	=> r50 
	 i2i r50 	=> r51 
	 storeAI r51 	=> r43, 0 
	 addI r0, 1 	=> r52 
	 subI r52, 0 	=> r54 
	 i2i r54 	=> r53 
	 multI r53, 4 	=> r53 
	 i2i r3 	=> r56 
	 storeAI r56 	=> r53, 0 
L13:	 nop 
	 addI r0, 1 	=> r0 
	 br 	-> L9
L11:	 nop 
	 br 	-> L6
L8:	 nop 
	 subI r1, 1 	=> r57 
	 loadI 0 	=> r0 
	 i2i r57 	=> r58 
L15:	 nop 
	 cmp_LE r0, r58 	=> r59
	 cbr r59 	-> L16, L17
L16:	 nop 
	 subI r0, 0 	=> r61 
	 i2i r61 	=> r60 
	 multI r60, 4 	=> r60 
	 loadAI r60, 0 	=> r63 
	 write 	 r63
	 addI r0, 1 	=> r0 
	 br 	-> L15
L17:	 nop 
