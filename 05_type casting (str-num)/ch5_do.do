clear
set more off
br

cd "C:\statistical-analysis-with-STATA\05_type casting (str-num)"

* 예제데이터 만들기

set obs 100

gen x=string(_n)
gen y=string(_n+10^9,"%20.0gc")
save exData.dta,replace

* (1) 문자변수->숫자변수로 바꾸기

// 1) destring 사용방법과 real함수 사용 //

u exData.dta,clear
destring x,gen(num)
gen num2=real(x)
destring x,replace

// 2) 짜증나는 문자 제거 //

destring y,replace
replace y=subinstr(y,",","",.)
destring y,replace


* (2) 숫자변수 -> 문자변수 바꾸기

// 1) tostring 사용방법과 string함수 사용//

tostring y,gen(str_y)
gen str_y2=string(y, "%20.0gc")
tostring y, replace

// 2) 특정포맷의 string으로 바꾸기 //

replace y=string(real(y),"%20.0gc")
