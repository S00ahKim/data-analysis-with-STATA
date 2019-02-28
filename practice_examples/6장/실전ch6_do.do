clear
set more off
br

cd "워킹디렉토리" // 워킹디렉토리(파일을 읽고 저장하는 경로) 지정,양쪽 큰따옴표 안에 입력하세요


* (0) import excel

import excel 나의할일.xlsx ,clear
ren *,lower // 모든 변수명 소문자로 만들기..

* (1) 나의할일 변수만들기

gen 나의할일=a if subinstr(a,"□","",.)!=a // □가 있는 부분들을 따로 추려내기(새로운 변수를 만드는 방식) 
replace 나의할일=나의할일[_n-1] if 나의할일=="" //빈칸을 위의 것으로 채우기
drop if a==나의할일 // a변수값과 나의할일 변수값이 같은 row들 지우기
replace 나의할일=strtrim(subinstr(나의할일,"□","",.)) // □빼고 양옆의 띄어쓰기 없애기..


* (2) 항목 및 해당 값 분리

split a ,p(: ○) //:와 ○를 터트리면서 a변수 쪼개기  
drop a1 a //필요없는 변수 지우기
replace a2=strtrim(a2) // 양 옆 띄어쓰기 없애기
keep if a2=="목적" | a2=="내용" | a2=="비고" //a2값이 목적, 내용, 비고인 줄들만 남기기
replace a3=strtrim(a3) // 양 옆 띄어쓰기 없애기

* (3) 나의할일 순서 맞게 넘버링

gen nn=_n // 자연수생성하기, 순서유지용도
sort 나의할일 nn
by 나의할일 : gen no=1 if _n==1 // 나의할일마다 각 첫쨰줄(_n==1)을 대상으로  no==1생성하기
so nn // 다시 원자료 순서대로 정렬 
replace no=sum(no==1) // 1첫째줄에서 n번째줄까지 1또는0의 값(no==1이 참이면 1, 아니면 0임)을 더하기
drop nn // 제역할을 다한 nn 지우기

* (4) reshape wide

reshape wide a3 ,i(no 나의할일) j(a2) s 
// 각 obs가 나의할일 a2로 구분(identified)되나 no를 해주면 원자료의 나의할일 순서대로 깔끔하게 wide됨
ren a3* *
order no 나의할일 목적 내용 비고
