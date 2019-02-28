clear
set more off
browse

cd "워킹디렉토리" //워킹디렉토리



* (1) transpose(전치)하기

u "wide로보기.dta",clear
// 변수명 앞에 v_붙이기
 // 변수명은 id로 하여 자연수 생성하기
 
// [a ; b ; c ; d] 부분  transpose ①
  // [a ; b ; c ; d] 부분  transpose ②

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

*(4) 기형패널 원래대로 바꾸기(다른방법..)

u 기형패널.dta,clear
