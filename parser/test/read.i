	 read 	=> r0
	 loadI 3 	=> r6 
	 subI r6, 0 	=> r5 
	 loadI 10 	=> r4 
	 i2i r5 	=> r3 
	 multI r3, 4 	=> r3 
	 read 	=> r7
	 storeAI r7 	=> r3, 0 
	 cread 	=> r1
	 loadI 3 	=> r12 
	 subI r12, 0 	=> r11 
	 loadI 10 	=> r10 
	 i2i r11 	=> r9 
	 cread 	=> r13
	 cstoreAI r13 	=> r9, 40 
	 write 	 r0
	 loadI 3 	=> r18 
	 subI r18, 0 	=> r17 
	 loadI 10 	=> r16 
	 i2i r17 	=> r15 
	 multI r15, 4 	=> r15 
	 loadAI r15, 0 	=> r19 
	 write 	 r19
	 cwrite 	 r1
	 loadI 3 	=> r25 
	 subI r25, 0 	=> r24 
	 loadI 10 	=> r23 
	 i2i r24 	=> r22 
	 cloadAI r22, 40 	=> r26 
	 cwrite 	 r26
	 loadI 32 	=> r28 
	 cwrite 	 r28
	 loadI 3 	=> r33 
	 subI r33, 0 	=> r32 
	 loadI 10 	=> r31 
	 i2i r32 	=> r30 
	 multI r30, 4 	=> r30 
	 loadAI r30, 0 	=> r34 
	 addI r34, 1 	=> r35 
	 write 	 r35
