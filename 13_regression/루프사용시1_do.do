clear
set more off
br

***********************************
* import excel
***********************************

* 기업정보

import excel 기업패널실습파일.xlsx, firstrow sheet(기업정보) clear
sa 기업패널.dta,replace

* 2013년도 ~ 2017년도

forvalues i=2013/2017{

	import excel 기업패널실습파일.xlsx, firstrow sheet(`i'년) clear
	ren * *`i'
	ren kis`i' kis
	merge 1:1 kis using 기업패널.dta ,nogen
	sa 기업패널.dta,replace
	
}	

* reshape wide -> long

reshape long 자산총계 부채총계 자본총계 ,i(kis stock name) j(year)
order 자산총계 부채총계 자본총계 ,last

sa 기업패널.dta,replace


***********************************
