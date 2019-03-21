	 read 	=> r0
	 loadI 2 	=> r1 
	 loadI 2 	=> r6 
	 subI r6, 0 	=> r4 
	 i2i r4 	=> r3 
	 multI r3, 4 	=> r3 
	 read 	=> r7
	 storeAI r7 	=> r3, 0 
	 write 	 r0
	 write 	 r1
	 loadI 2 	=> r13 
	 subI r13, 0 	=> r11 
	 i2i r11 	=> r10 
	 multI r10, 4 	=> r10 
	 loadAI r10, 0 	=> r14 
	 write 	 r14
	 loadI 4 	=> r16 
	 write 	 r16
