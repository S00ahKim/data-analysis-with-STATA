clear
set more off
browse

cd "D:\개인\프로젝트\STATA 프로그램으로 통계분석\2장" //워킹디렉토리



* (1) 첫번째 방법

// 기업정보 //

import excel 기업패널실습파일.xlsx, firstrow sheet(기업정보) clear
sa temp기업정보.dta,replace

// 2013년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2013년) clear

ren * *2013
ren kis2013 kis
sa temp2013.dta,replace

// 2014년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2014년) clear

ren * *2014
ren kis2014 kis
sa temp2014.dta,replace


// 2015년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2015년) clear

ren * *2015
ren kis2015 kis
sa temp2015.dta,replace

// 2016년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2016년) clear

ren * *2016
ren kis2016 kis
sa temp2016.dta,replace

// 2017년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2017년) clear

ren * *2017
ren kis2017 kis
sa temp2017.dta,replace



// merge //

clear
u temp기업정보.dta,clear
merge 1:1 kis using temp2013.dta,nogen 

// reshape //

reshape long 자산총계 부채총계 자본총계, i(kis) j (year)

* (2) 두번째 방법

// 2013년 //

import excel 기업패널실습파일.xlsx, firstrow sheet(2013년) clear

gen year=2013
sa temp2013.dta,replace

// 2014년 //


import excel 기업패널실습파일.xlsx, firstrow sheet(2014년) clear

gen year=2014
sa temp2014.dta,replace


// 2015년 //


import excel 기업패널실습파일.xlsx, firstrow sheet(2015년) clear

gen year=2015
sa temp2015.dta,replace


// 2016년 //


import excel 기업패널실습파일.xlsx, firstrow sheet(2016년) clear

gen year=2016
sa temp2016.dta,replace


// 2017년 //


import excel 기업패널실습파일.xlsx, firstrow sheet(2017년) clear

gen year=2017
sa temp2017.dta,replace

// append //

clear
append using temp2013.dta temp2014.dta temp2015.dta ///
			 temp2016.dta temp2017.dta
			 
sa 기업패널.dta, replace

// import 기업정보 sheet & merge //

import excel 기업패널실습파일.xlsx, firstrow sheet(기업정보) clear
merge 1:m kis using 기업패널.dta //kis 가 unique한 data는 master쪽이다.
drop _merge

sort kis year
order kis year

duplicates in terms of kis year //중복값 여부 확인 가능

* (3) loop : 첫번째 방법


* (4) loop : 두번째 방법


clear

forvalues i=2013/2017{ //1씩 늘어나는 경우 / 사용

import excel 기업패널실습파일.xlsx, firstrow sheet(`i'년) clear

gen year=`i'
sa temp2`i'.dta,replace

}

clear //clear작업을 하지 않으면 2017년도가 두 번 붙음

forvalues i=2013/2017{

append using temp2`i'.dta


}

sa 기업패널.dta,replace
u 기업패널.dta,clear

import excel 기업패널실습파일.xlsx, firstrow sheet(기업정보) clear
merge 1:m kis using 기업패널.dta //kis 가 unique한 data는 master쪽이다.
drop _merge

sort kis year
order kis year







