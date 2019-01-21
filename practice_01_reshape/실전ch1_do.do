clear
set more off
browse

cd "C:\statistical-analysis-with-STATA\practice_01_reshape" //워킹디렉토리



* (1) transpose(전치)하기

u "wide로보기.dta",clear
ren * v_* // 변수명 앞에 v_붙이기
gen id=_n // 변수명은 id로 하여 자연수 생성하기
 
reshape long v_ , i(id) j(time) s // [a ; b ; c ; d] 부분  transpose ①
reshape wide v_ , i(time) j(id) // [a ; b ; c ; d] 부분  transpose ②
drop time

* (2) 기형패널 만들기..

u 패널예시.dta,clear
 
ren 달린거리 v_달린거리
ren 칼로리소모량 v_칼로리소모량
reshape long v_ ,i(이름 day) j(var) string // 롱폼을 와이드 폼으로 바라보아 새로운 롱폼으로 만들기
reshape wide v_ ,i(이름 var) j(day) // 기형패널 만들기
ren v_* d* // 앞자리가 v로 시작되는 모든변수들을 day로 시작하게끔 바꾸기..

sa 기형패널,replace

*(3) 기형패널 원래대로 바꾸기(reshape 써서)

u 기형패널.dta,clear

ren d* v_*
reshape long v_ , i(이름 var) j(day) 
reshape wide v_ , i(이름 day) j(var) s
ren v_* *


*(4) 기형패널 원래대로 바꾸기(다른방법..)

u 기형패널.dta, clear
levelsof var , local(jongmok)

foreach i of local jongmok{

u 기형패널.dta,clear

keep if var=="`i'"
drop var

reshape long d, i(이름) j(day) 

ren d `i'

sa `i'_using.dta, replace
}

//변수명은 남기고 값은 없는 상태
keep 이름 day
keep in 1 
drop in 1

foreach i of local jongmok {

merge 1:1 이름 day using `i'_using
drop _merge
}



