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
	 loadI 3 	=> r17 
	 subI r17, 0 	=> r16 
	 loadI 10 	=> r15 
	 i2i r16 	=> r14 
	 multI r14, 4 	=> r14 
	 loadAI r14, 0 	=> r18 
	 write 	 r18
	 cwrite 	 r1
	 loadI 3 	=> r22 
	 subI r22, 0 	=> r21 
	 loadI 10 	=> r20 
	 i2i r21 	=> r19 
	 cloadAI r19, 40 	=> r23 
	 cwrite 	 r23
	 loadI 32 	=> r24 
	 cwrite 	 r24
	 loadI 3 	=> r28 
	 subI r28, 0 	=> r27 
	 loadI 10 	=> r26 
	 i2i r27 	=> r25 
	 multI r25, 4 	=> r25 
	 loadAI r25, 0 	=> r29 
	 addI r29, 1 	=> r30 
	 write 	 r30
