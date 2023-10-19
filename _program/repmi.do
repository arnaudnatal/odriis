/*
Raccourcir les replace missing
*/

program define repmi
	version 15.1
	args arg1
	replace `arg1'="" if `arg1'=="."	
end
