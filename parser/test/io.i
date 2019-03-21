	 loadI 0 	=> r6 
	 subI r6, 0 	=> r4 
	 i2i r4 	=> r3 
	 multI r3, 4 	=> r3 
	 read 	=> r7
	 storeAI r7 	=> r3, 0 
	 loadI 0 	=> r0 
	 loadI 1 	=> r1 
	 loadI 1 	=> r11 
	 subI r11, 0 	=> r9 
	 i2i r9 	=> r8 
	 multI r8, 4 	=> r8 
	 loadI 0 	=> r15 
	 subI r15, 0 	=> r13 
	 i2i r13 	=> r12 
	 multI r12, 4 	=> r12 
	 loadAI r12, 0 	=> r16 
	 add r16, r1 	=> r17 
	 i2i r17 	=> r18 
	 storeAI r18 	=> r8, 0 
	 loadI 2 	=> r22 
	 subI r22, 0 	=> r20 
	 i2i r20 	=> r19 
	 multI r19, 4 	=> r19 
	 loadI 1 	=> r26 
	 subI r26, 0 	=> r24 
	 i2i r24 	=> r23 
	 multI r23, 4 	=> r23 
	 loadAI r23, 0 	=> r27 
	 add r27, r1 	=> r28 
	 i2i r28 	=> r29 
	 storeAI r29 	=> r19, 0 
	 loadI 3 	=> r33 
	 subI r33, 0 	=> r31 
	 i2i r31 	=> r30 
	 multI r30, 4 	=> r30 
	 loadI 2 	=> r37 
	 subI r37, 0 	=> r35 
	 i2i r35 	=> r34 
	 multI r34, 4 	=> r34 
	 loadAI r34, 0 	=> r38 
	 add r38, r1 	=> r39 
	 i2i r39 	=> r40 
	 storeAI r40 	=> r30, 0 
	 loadI 3 	=> r44 
	 subI r44, 0 	=> r42 
	 i2i r42 	=> r41 
	 multI r41, 4 	=> r41 
	 loadAI r41, 0 	=> r45 
	 i2i r45 	=> r2 
	 write 	 r2
	 loadI 0 	=> r47 
	 write 	 r47
	 write 	 r0
	 loadI 0 	=> r52 
	 subI r52, 0 	=> r50 
	 i2i r50 	=> r49 
	 multI r49, 4 	=> r49 
	 loadAI r49, 0 	=> r53 
	 write 	 r53
	 loadI 1 	=> r58 
	 subI r58, 0 	=> r56 
	 i2i r56 	=> r55 
	 multI r55, 4 	=> r55 
	 loadAI r55, 0 	=> r59 
	 write 	 r59
	 loadI 2 	=> r64 
	 subI r64, 0 	=> r62 
	 i2i r62 	=> r61 
	 multI r61, 4 	=> r61 
	 loadAI r61, 0 	=> r65 
	 write 	 r65
	 loadI 3 	=> r70 
	 subI r70, 0 	=> r68 
	 i2i r68 	=> r67 
	 multI r67, 4 	=> r67 
	 loadAI r67, 0 	=> r71 
	 write 	 r71
