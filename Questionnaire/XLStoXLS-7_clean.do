****************************************
* CLEAN
****************************************
clear all
filelist, dir("$directory") pattern(*.dta)

tempfile myfiles
save "`myfiles'"
local obs=_N
forvalues i=1/`obs' {
	*set trace on
	use "`myfiles'" in `i', clear
	local d = dirname
	local f = filename
	erase "`d'\\`f'"
	tempfile save`i'
}
****************************************
* END
