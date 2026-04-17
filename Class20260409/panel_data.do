bcuse gpa3, clear
xtset id term 

local y trmgpa 
local x season spring sat hsperc female black white frstsem tothrs crsgpa 
foreach var in `x' {
	gen D_`var' = D.`var' 
}


* POLS
reg `y' `x'
* FD
reg `y' D_season D_spring D_sat D_hsperc D_female D_black D_white D_frstsem ///
 D_tothrs D_crsgpa 
* FE
xtreg `y' `x', fe