clear
set more off
browse

cd "C:\statistical-analysis-with-STATA\practice_collapse" //워킹디렉토리



* (1) collapse - 요약통계량을 브라우저로 제시

u reshape_응용.dta,clear

// 1) 기본방식 - 세로로 만들어주는 것이 좋아서 long으로 변경 & by option 중요 //

reshape long 제기차기 팔굽혀펴기 수학점수, i(이름 조) j(일차) // 패널 롱폼으로 바꾸기
collapse (mean) 제기차기평균=제기차기 (mean) 팔굽혀펴기평균=팔굽혀펴기 ///
         (mean) 수학점수평균=수학점수, by(조 일차) // (일차 및 조별) 평균구하기
		 
// 2) collapse 명령어를 사용 시, 좀 더 간단하게 사용 가능한 경우 - 변수명 동일//

u reshape_응용.dta,clear

reshape long 제기차기 팔굽혀펴기 수학점수, i(이름 조) j(일차) // 패널 롱폼으로 바꾸기
collapse (mean) 제기차기 팔굽혀펴기 수학점수, by(조 일차)
		 
// 3) 표로 만들기 위해서 wide 해주기..//
		 
reshape wide 제기차기 팔굽혀펴기 수학점수 ,i(일차) j(조) string // 원하는 표모양 만들기 	
export excel "표_만들기.xlsx" ,firstrow(var) replace 	 


// 4) (조 및 일차)별로 제기차기의 관측수, 평균, 표준편차, 최소값, 최대값 구해보기...//

u reshape_응용.dta,clear

reshape long 제기차기 팔굽혀펴기 수학점수, i(이름 조) j(일차) // 패널 롱폼으로 바꾸기
collapse (count) 제기차기관측수=제기차기 (mean) 제기차기평균=제기차기 ///
(sd) 제기차기표준편차=제기차기 (min) 제기차기최소=제기차기 (max) 제기차기최대=제기차기, by (조 일차)



* (2) 한 변수가 아닌 여러 변수들을 대상으로 여러 기초통계량을 구하고자 할 때 : reshape와 같이 사용하기...

u reshape_응용.dta,clear
reshape long 제기차기 팔굽혀펴기 수학점수, i(이름 조) j(일차)

* rename의 세 가지 방법 (두번째 방법으로 실습)
* rename 제기차기 v_제기차기
* rename (제기차기 팔굽혀펴기 수학점수) =_f
rename (제기차기 팔굽혀펴기 수학점수) v_=

* long -> long
reshape long v_, i(이름 일차) j(var) s

* collapse - 편의를 위해 _를 넣을 것 
collapse (count) 관측수_=v_ (mean) 평균_=v_ (sd) 표준편차_=v_ (min) 최솟값_=v_ (max) 최댓값_=v_ , by (조 일차 var)



* (3) 각 결과를 엑셀파일로 내보내기(각 시트명은 종목명으로..) - s는 string option
reshape wide *_ , i(일차 var) j(조) s
save tmp.dta, replace

local i, 수학점수
use tmp, clear
keep if var="`i'"
drop var

export excel "표.xlsx" firstrow(var) sheet("`i'", replace)
