clear
set more off
browse

cd "C:\statistical-analysis-with-STATA\10_reshape"

* 1) 자료 예시
* 횡단면자료 예시
u panelEx.dta,clear
keep if day==1 // 1은 그저 예시임 
*drop day


* 시계열자료
u panelEx.dta,clear
keep if 이름=="김아무개" // 김아무개는 그저 예시임 다른 이름 입력해도 됨




* 2) reshape wide & reshape long
* 패널 long->wide로 바꾸기
u panelEx.dta,clear
reshape wide 달린거리 칼로리소모량, i(이름) j(day)


* 패널 wide->long으로 바꾸기
reshape long 달린거리 칼로리소모량, i(이름) j(day)

* 또다른 long->wide로 바꾸기

u panelEx.dta,clear
ren (달린거리 칼로리소모량) (달린거리_ 칼로리소모량_)

reshape wide 달린거리_ 칼로리소모량_, i(day) j(이름) string 
// j()안에 문자변수를 입력할 경우, 반드시 string 옵션(s만 입력해도됨)을 써야됨!

reshape long 달린거리_ 칼로리소모량_, i(day) j(이름) string 
// 이경우 이름이라는 새로운 변수명이 나오게되며 문자변수가 생성되기에 string 옵션을 반드시 써줘야됨




* 3) wide 폼으로 바라보기~!

u "showWide.dta",clear
ren * v_* // 변수명 앞에 v_붙이기
gen id=_n // 변수명은 id로 하여 자연수 생성하기

duplicates list id // id 중복값 확인
reshape long v_,i(id) j(time) string // v_뒤의 것들은 숫자가 아니기에 string 옵션 넣어야 됨

* 4) transpose(전치)하기

u "showWide.dta",clear
ren * v_* // 변수명 앞에 v_붙이기
gen id=_n // 변수명은 id로 하여 자연수 생성하기
 
reshape long v_,i(id) j(time) string // [a ; b ; c ; d] 부분  transpose ①
reshape wide v_,i(time) j(id)  // [a ; b ; c ; d] 부분  transpose ②

* 5) 기형패널 만들기..

u panelEx.dta,clear
 
ren 달린거리 v_달린거리
ren 칼로리소모량 v_칼로리소모량
reshape long v_ ,i(이름 day) j(var) string // 롱폼을 와이드 폼으로 바라보아 새로운 롱폼으로 만들기
reshape wide v_ ,i(이름 var) j(day) // 기형패널 만들기
ren v_* d* // 앞자리가 v로 시작되는 모든변수들을 day로 시작하게끔 바꾸기..
