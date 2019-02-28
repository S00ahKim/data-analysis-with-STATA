clear
set more off
br

*cd "워킹디렉토리" //파일을 읽고 저장하는 위치인 워킹디렉토리 설정 
 
****************************************
* (1) 자료보기 
****************************************

// master 자료 // 
 
u adverse_event.dta,clear // 마스터자료로 활용할 데이터
list ,sepby(putnum date) //자료를 putnum마다 줄그으며(sepby(putnum)) 보기

duplicates list putnum date // (putnum date) 중복값 체크

// using 자료 //
 
u concomitant_medication.dta // 유징자료로 활용할 데이터
list ,sepby(putnum date) //자료를 putnum마다 줄그으며(sepby(putnum)) 보기

duplicates list putnum date // (putnum date) 중복값 체크
 
 
****************************************
 
*************************************************
* (2) merge m:m ; 의도한 merge가 아님ㅠㅠ
*************************************************
 
u adverse_event.dta,clear
merge m:m putnum date  using concomitant_medication.dta 
 
list ,sepby(putnum date)
 
************************************************
 
*************************************************
* (3) joinby; 우리가 의도한 merge
*************************************************
 
* 1) inner merge
 
u adverse_event.dta,clear
joinby putnum date using concomitant_medication.dta 
list ,sepby(putnum date)
 
* 2) outer merge
 
u adverse_event.dta,clear
joinby putnum date using concomitant_medication.dta , unmatched(both)
list ,sepby(putnum date)
 
*************************************************

*************************************************
* (4) joinby 활용: 각 시간마다 자기 자신을 제외한 값의 차이 구하기
*************************************************

* 0) 자료구조 및 시간의 갯수 알아보기..

 
u 예제.dta,clear
duplicates list id t //(id t)별로 중복값 체크
bys t :gen count=_N
su count
 

 
* 1) joinby하기위해 id와 size변수명 바꾸기
 
u 예제.dta,clear
 

 
* 2) joinby하기
 
order  //변수 위치 순서 조절(그림참조)
 
sort t id
list ,sepby(t) //t마다 보아 잘 합쳐졌는지 확인하기
 
* 3) 시간마다 구하고자하는 index구하기
 

 
*************************************************
