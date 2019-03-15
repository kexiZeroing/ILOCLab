	 loadI 99 	=> r2 
	 i2c r2 	=> r0 
	 loadI 100 	=> r3 
	 i2c r3 	=> r1 
	 cwrite 	 r0
	 cwrite 	 r1
