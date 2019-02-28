clear
set more off
browse

cd "워킹디렉토리" //워킹디렉토리


* (0) 시간이 1기간만 있었다면(예시 time==9)..

// 빈칸채우기 //

u 예제.dta,clear
replace time=time[_n-1] if missing(time)
sa 예제_시간채움.dta,replace

// sum함수 //

gen sum=sum(score)


* (1) 시간이 1기간만 있었다면(예시 time==9)..

u 예제_시간채움.dta,clear

keep if time==9 //시간 하나만 남기기
egen rank=group(score) // score의 오름차순 순서대로 번호가 매겨짐
su rank //최대값이 저장된 r(max)를 활용하기 위해 su 사용함
replace rank=r(max)+1-rank

* (2) 시간이 여러 개일경우

u 예제_시간채움.dta,clear

*1)

 //시간이 오름차순이면서, 점수는 내림차순

*2)

 // 일단 시간마다 자연수를 매기기(결측치는 제외하면서)

*3)


/* 매 시간마다(by time), 어느 a번째줄의 score값이 (a-1)째 줄의 score값과 같으면(당연히 missing아님)
   a번째줄의 rank의 값을 (a-1)번째 줄의 rank값으로 대체하라!
*/

*4)



*5)




* (3) 이번엔 매 시간마다 오름차순 순으로 공동순위를 고려해가며 rank를 매겨보세요~
