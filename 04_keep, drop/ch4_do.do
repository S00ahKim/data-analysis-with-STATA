clear
set more off
br

cd "C:\statistical-analysis-with-STATA\04_keep, drop"  


* 1) 예제파일 읽어들이기

import excel example.xlsx,firstrow clear
save ex.dta,replace

* 2) keep 

// a라는 변수만 남기고 싶을 경우 //

keep a //a라는 변수"만" 남겨라

// a b라는 변수만 남기고 싶을 경우 //

u ex.dta,clear
keep a b //a와 b라는 변수"만" 남겨라

* 3) drop

// a라는 변수만 없애고 싶을 때 //

u ex.dta,clear
drop a //a라는 변수"만" 없애라

// a b라는 변수만 없애고 싶을 경우 //

u ex.dta,clear
drop a b //a와 b라는 변수"만" 없애라

* 4) 특정 줄을 남기거나 없앨 때 - if나 in 사용

// id_code가 001인 줄을 남기고 싶을 경우 //

u ex.dta,clear
keep if id_code=="001" //id_code=="001"인 줄"만" 남겨라

u ex.dta,clear
drop if year>=2000 //year의 값이 2000이상인 줄"만" 없애라
list id_code year a b c ,sepby(id_code) 
/* 현재 stata에 있는 데이터의 id_code year a b c 변수의 값들을 보여주기
id_code의 값이 바뀔떄마다 줄을 그어주면서(sepby옵션) */

* 5) 그 외 (시스템 변수 _N과 와일드카드* 활용)

u ex.dta,clear
keep if _n==_N // 관측수(_n)가 맨마지막번째 줄의 숫자(_N)인 줄이면 그 줄"만" 남겨라

u ex.dta,clear
gen obs=_N
keep i* // 뒷자리가 무엇으로 끝나든 간에 i로 시작되는 모든 변수만 남겨라
