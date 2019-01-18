clear
set more off
br

cd "C:\statistical-analysis-with-STATA\14_time series"

**********************************************
* 1) 제대로된 시간변수 생성하기
**********************************************

* (1) daily

// 방법1 : t라는 새로운변수 생성 //

u ex_daily.dta,clear
gen t=daily(time,"YMD")
format %td t //디폴트양식으로 시간을 바꾸기

drop time
ren t time
order time // time변수를 맨 앞으로

save ex_daily_시간변수고침.dta,replace

// 방법2 : string함수 사용 //

u ex_daily.dta,clear

replace time=string(daily(time,"YMD"),"%20.0g") 
// %20.0g은 숫자포맷 숫자가 커지면 축양형으로나와 destring이 안될 수 있어서 포맷옵션 사용함 
destring time ,replace
format %tdCCYY-NN-DD time //YYYY-MM-DD양식으로 시간을 바꾸기

save ex_daily_시간변수고침.dta,replace

* (2) monthly

// 방법1 : t라는 새로운변수 생성 //

u ex_monthly.dta,clear
gen t=monthly(time,"YM")
format %tmCCYY-NN t //YYYY-MM양식으로 시간을 바꾸기

drop time
ren t time
order time // time변수를 맨 앞으로

save ex_monthly_시간변수고침.dta,replace

// 방법2 : string함수 사용 //

u ex_monthly.dta,clear

replace time=string(monthly(time,"YM"))
destring time ,replace
format %tm time //디폴트양식으로 시간을 바꾸기

save ex_monthly_시간변수고침.dta,replace


**********************************************

**********************************************
* 2) 시간변수와 관련된 유용한 tip(daily시간변수 기준)
**********************************************

// 사전작업 //

u ex_daily_시간변수고침.dta,clear
tsset time ,d // 시계열선언, 이게 반드시 선언되야함

*  (1) tsfill(시간채우기)
 
drop if ex==. //ex가 공란이면 그 줄들을 지워라 
tsfill // 시간gap 채우기 tsset이나 xtset 선언해야됨에 유의

*  (2) 요일변수 만들기

gen day=string(dow(time)) 

local n=0 
foreach i in 일 월 화 수 목 금 토{

	replace day="`i'요일" if day=="`n'"
	local ++n

}

tab day if ex==.

* (3) lagged변수 생성
 
gen lag_x=L1.ex // 1기간 lagged변수 생성
gen lag2_x=L2.ex // 2기간 lagged변수 생성

* (4) 차분(Difference) 변수 만들기
 
gen del_ex=D1.ex
gen ddel_ex=D2.ex //2계 차분

* (5) 특정날짜범위 남기기-daily자료

// 방법1 //
u ex_daily_시간변수고침.dta,clear
keep if time>=daily("2012-03-04","YMD") //2012년 3월 4일 이후의 날짜자료들만 남기기1

// 방법2 //
u ex_daily_시간변수고침.dta,clear
keep if time>=td(04mar2012) //2012년 3월 4일 이후의 날짜자료들만 남기기2

* 6) 특정날짜범위 남기기-monthly자료

u ex_monthly_시간변수고침.dta,clear
keep if time>=tm(2012m3) //2012년 3월이후에...
**********************************************
