clear
set more off
br

cd "C:\statistical-analysis-with-STATA\07_sorting"

u example.dta,clear

* 1) sort x

sort x
list ,sepby(x)

* 2) by(반드시 sort가 선행되어야..)

by x : gen no=_n // 예시1
list ,sepby(x)

by x: su y  // 예시2


* 3) bysort

u example.dta,clear

bysort x: gen no=_n // 예시1 : x마다 자연수 생성하기
bys x: su y // 예시2 : x마다 y의 기초통계량 구하기


* 4) bysort를 바로 쓰지 말아야 하는 경우: x뿐만 아니라 y의 순서도 정렬해야 되는 경우

u example.dta,clear

sort x y
by x : gen no=_n
list ,sepby(x)

* 5) gsort : 오름차순 및 내림차순 가능

u example.dta,clear

gsort - x
list ,sepby(x)
 
gsort -x + y
list ,sepby(x)

gsort +x - y
list ,sepby(x)

* 6) sort와 by 사용용례(reshape)

u example.dta,clear

sort x y
by x : gen no=_n

reshape wide y ,i(x) j(no)
egen num=concat(y*) ,p(, "")
keep x num
