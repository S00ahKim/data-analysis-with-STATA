clear
set more off
browse

cd "워킹디렉토리" //워킹디렉토리



* (1) outreg2 - excel

sysuse auto,clear

tab rep78 // rep78에 어떤 종류의 value가 있는지 보고자...

reg price mpg headroom if rep78==1
outreg2 using 회귀분석_기본.xls, br  excel replace 
// 엑셀로 내보낼시 br(bracket 옵션) 반드시 추가해야됨

reg price mpg headroom if rep78==2
outreg2 using 회귀분석_기본.xls, br excel append

reg price mpg headroom if rep78==3
outreg2 using 회귀분석_기본.xls, br excel append


* (2) outreg2 - word

reg price mpg headroom if rep78==4
outreg2 using 회귀분석_기본.doc,  word replace sdec(2) //표준오차 소수점2자리수..

reg price mpg headroom if rep78==5
outreg2 using 회귀분석_기본.doc,  word append sdec(4) //표준오차 소수점4자리수..


* (3) 상기 (1), (2)를 반복문으로 짜보기...(당연히 if programming이 사용되야 됨)
