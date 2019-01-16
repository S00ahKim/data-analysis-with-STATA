clear
set more off
br

cd "C:\statistical-analysis-with-STATA\03_generate, replace, if, in"  
set obs 5 // 관측수(=줄의 수)를 5로 설정

* 1) generate

generate x=1 // 숫자값
gen y="y" // 문자값
g z=x // 변수
g a=ln(7) //함수1
g b=_n // 자연수생성
g c=b+1 //사칙연산
gen d=ln(c) //합수2



* 2) replace

replace x=2 // 숫자값
replace y="다른값을 넣자" // 문자값
replace z=x // 변수
replace a=ln(8) //함수
replace b=ln(x) // 함수2
replace c=c+1 //사칙연산

save example.dta,replace


* 3) if 사용

use example.dta,clear

gen e=1 if c==3 // c값이 3이면 e값이 1로 만들어라(나머지 줄은 공란(결측치)가 됨)

replace e=3 if c>=4 & c<=5 
// c값이  4보다 크거나 같고 c값이 5보다 작거나 같으면 그 줄에 속하는 e값을 3으로 바꿔라 

replace d=7 if e==.
// e값이 공란(결측치)이면 d의 값을 7로 대체하라

replace y="하하하" if c==3
// c값이  3이면 그 줄에 속하는 y의 값을 하하하로 바꾸어라

replace y="하" if c==4
// c값이  4이면 그 줄에 속하는 y의 값을 하로 바꾸어라

replace x=7 if y=="하" | y=="하하하"
// y의 값이 하 또는 하하하라면 x의 값을 7로 대체하라

replace y="하이"  if y!="하" & y!="하하하"

// y값이 하가 아니고 하하하도 아니라면 y의 값을 하이로 대체하라


* 4) in 사용

gen f=1 in 1 //1번째 줄에만 f변수의 값을 1로 되게끔 f변수 생성하기
replace a=. in 3/4 // 3~4번째줄의 변수a의 값을 공란으로 처리하기
replace c=c+1 in L //마지막째 줄의 기존의 c값에 1을 더해주기
replace c=2 in -2/L // 마지막재줄과 뒤에서 2번째 줄의 c값을 2로 대체하기
replace y="" if _n==1 | _n>=3 &_n<=4 // 1번째 줄과 3~4번쨰줄을 대상으로 y값을 공란으로 대체하기

