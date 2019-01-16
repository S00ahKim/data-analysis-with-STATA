clear
set more off
br


sysuse auto.dta,clear


* 1) describe

describe
des make price // des까지만쳐도 알아들음
d ,replace clear //변수에 대한 설명을 데이터브라우져에 표시하게 해주는 명령어
// help describe를 치면 d에만 밑줄이 쳐져 있는데, 이는 d만쳐도 describe명령어로 알아듣는다는 의미

* 2) summarize

sysuse auto.dta,clear

summarize 
su price mpg //su까치만 쳐도 알아들음
su price mpg,d // 원래는 detail다치는게 정석이지만 d까지만쳐도 알아들음
su price if foreign==0

*3) tabulate

tabulate foreign
tab headroom // tab까지만쳐도 됨
tab foreign headroom // foreign, headroom에 대한 결합테이블 보여주기
tab foreign if headroom<=3 // if 사용가능 


* 4) count

count // observation의 수(=row의 수) 세기
cou if price<=5000

* 5) list

list
l price mpg in 1/5 //price와 mpg의 데이터를 1~5째줄까지 보여주기 
l price mpg if mpg<20 in 1/20 ,sep(2) //두줄마다 선 긋기, if in 둘다 사용가능
l weight headroom in 1/10 ,sepby(headroom) //headroom의 값이 달라질때 마다 선긋기


* 6) label variable

label variable price 가격
la var mpg "마일리지,mpg" // , / *등과 같은 특수문자를 넣을땐 양옆에 큰따옴표 사용해줘야 됨

* 7) rename

rename price pprice

des m*
ren m* hey_* //뒤가 무엇으로 끝나든 간에 맨첫번째 시작이 m으로 시작되는 모든 변수를 대상으로 hey_로 시작하게끔 바꾸기
des hey_*


des *_*
ren *_* *hi* // 앞과 뒤가 무엇이든 간에 중간이 _인 모든변수를 대상으로 _를 hi로 바꾸기
des *hi*


des *t
ren *t * // 앞이 무엇으로 시작되든 간에 변수명 맨 끝이 t로 끝나는 모든변수를 대상으로 t를 떼어내기
des *


des *
ren * v_* // 모든 변수들을 대상으로 변수명이 v_로 시작하게끔 바꾸기
des v_*


