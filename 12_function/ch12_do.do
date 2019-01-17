clear
set more off
br

/************************************
  intro: c(pwd)와 subinstr함수 사용하여
  11장에 있는 do파일 실행시키기
*************************************/

cd "C:\statistical-analysis-with-STATA\12_function" // 워킹디렉토리
ma drop _all // 글로벌매크로 다 날리기.
glo source=subinstr("`c(pwd)'","12_function","11_macro",.) // ch11의 do파일이 있는 디렉토리설정

/*	c(pwd)는 화면에 creturn list를 커맨드창에 쳐서 참고, 
	바로밑의 별표와 /부분까지 드래그해서 실행
	pwd는 print working directory를 의미함.
*/

do "$source/ch11_do.do" //c11에 있는 do파일 작동시키기.. 

*************************************


/************************************
 2) forvalues(consecutive 한 숫자에 대하여)
*************************************/

// 단순 1씩 증가하는 숫자에 대하여//

forvalues i=-1/7{

	di `i'

}

// 단순 2씩 증가하는 숫자에 대하여//

forv i=-1(2)7{

	di `i'

}

// 간단 사용예시//

forv i=1/100{

	gen x`i'=`i'
	di "숫자 `i'"

}
drop x*


**************************************

/************************************
 3) foreach
*************************************/

// loop over not-consecutive numbers//

foreach i of numlist 1 5 9 100{

	di `i'

}

// 문자에 대하여.. //

foreach i in 가 나 다{

	di "`i'"

}

// 로컬 매크로에 대하여 //

local a 가 나 다
foreach i of local a{

	di "`i'"

}

loc a 가 나 다
foreach i in `a'{

	di "`i'"

}

// 글로벌 매크로에 대하여 //

global a 가 나 다
foreach i of global a{

	di "`i'"

}

foreach i in $a{

	di "`i'"

}
ma drop a // 글로벌 a 지우기

// 변수리스트에 대하여... //

foreach i of varlist v*{

	di "`i'"

}

// 기본명령어에 숨어있는 매크로 사용하기..//
des ,varl 
local var `r(varlist)'
foreach i in `var'{

	di "`i'"

}

save example.dta,replace

// levelsof와의 콜라보 //

use example.dta,clear
levelsof year,local(year)
global year `year'
foreach i in `year'{

	u example.dta,clear
	keep if year==`i'
	save temp_`i'.dta,replace

}
clear
foreach i in $year{

	append using temp_`i'.dta

}
**************************************

/************************************
 4) while
*************************************/

local n=1
while `n'<=3{

	di `n'
	local ++n // `n'이 1씩증가

}

local n=-1
while `n'>=-3{

	di `n'
	local --n // `n'이 1씩감소

}


**************************************

/************************************
 5) 이중루프(nested loop, 예시: 19단)
*************************************/
clear 

local n=19 //구구단 숫자설정

set obs `n'

forvalues i=1/`n'{

	gen 구구단`i'=.
	forvalues j=1/`n'{

		replace 구구단`i'=`i'*`j' in `j'

	}
	
}

**************************************

/************************************
 6) 조건문(if programming)
*************************************/
clear 
set more off

local n=19 //구구단 숫자설정

set obs `n'

forvalues i=1/`n'{

	gen 구구단`i'=""
	forvalues j=1/`n'{
	
		if `j'==2{
	
			replace 구구단`i'="홍진호" in `j'
		
		}
		
		else{

			replace 구구단`i'=string(`i'*`j') in `j'
		}
		
	}
	
}

**************************************

