	 loadI 97 	=> r3 
	 i2c r3 	=> r0 
	 loadI 98 	=> r4 
	 i2c r4 	=> r1 
	 loadI 99 	=> r5 
	 i2c r5 	=> r2 
	 cwrite 	 r0
	 cwrite 	 r1
	 cwrite 	 r2
