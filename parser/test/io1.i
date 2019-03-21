	 loadI 1 	=> r0 
	 loadI 3 	=> r4 
	 subI r4, 0 	=> r3 
	 loadI 10 	=> r2 
	 i2i r3 	=> r1 
	 multI r1, 4 	=> r1 
	 i2i r0 	=> r5 
	 storeAI r5 	=> r1, 0 
	 loadI 3 	=> r9 
	 subI r9, 0 	=> r8 
	 loadI 10 	=> r7 
	 i2i r8 	=> r6 
	 multI r6, 4 	=> r6 
	 loadAI r6, 0 	=> r10 
	 write 	 r10
