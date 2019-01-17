clear
set more off
browse


cd "C:\statistical-analysis-with-STATA\09_merge, join"  

****************************
* merge (1:1)
****************************

* import 

import excel merge.xlsx, sheet(master) firstrow clear //import master sheet
save 마스터.dta,replace

import excel merge.xlsx, sheet(using) firstrow clear //import using sheet
save 유징.dta,replace

* merge

u 마스터.dta,clear
merge m:m 이름 using 유징.dta // 이름을 기준으로 merge하기 , 1:1대신 m:m 써도 됨

****************************



***************************
* merge(m:1)
***************************

* 마스터자료 살펴보기

u 마스터_m_on_1.dta,clear //master파일 로드하기
list ,sepby(이름)

* 유징자료 살펴보기

u 유징_m_on_1.dta,clear
list ,sep(0)

* 마스터자료 열고 합치기

u 마스터_m_on_1.dta,clear //master파일 로드하기
merge m:1 문항 using 유징_m_on_1.dta ,nogen 
          // 문항을 기준으로 merge하기, nogen은 _merge 변수 생성안해줌, m:1대신 m:m 써도됨
sort 이름 문항 // (이름 및 문항)으로 오름차순 정렬		  
		  
****************************



***************************
* merge(1:m)  
***************************

u 마스터_m_on_1.dta,clear //master파일 로드하기
merge 1:1 문항 using 유징_m_on_1.dta ,nogen 
          // 문항을 기준으로 merge하기, nogen은 _merge 변수 생성안해줌, m:1대신 m:m 써도됨
sort 이름 문항 // (이름 및 문항)으로 오름차순 정렬

****************************



********************************
* 각종 join들
********************************


*--------------------------
* inner join(matched만 남기기)
*-------------------------
 
u 마스터.dta,clear // 자료 열기
merge 1:1 이름 using 유징.dta // 이름을 기준으로 merge
keep if _merge==3 // key variable이 매치 된 것만 남기기
drop _merge // _merge 변수 없애기
 
 
* 다른 방법
 
u 마스터.dta,clear  // 자료 열기
merge 1:1 이름 using 유징.dta , keep(match) nogen
 // merge 할 때 key variable이 matched된건만 남기고(keep(match)) _merge 생성 안하기(nogen)

*-------------------------
 
 
*--------------------------
* outer join(그냥 merge)
*--------------------------
 
u 마스터.dta,clear // 자료 열기
merge 1:1 이름 using 유징.dta // 이름을 기준으로 merge
drop _merge // _merge 변수 없애기
 
* 다른 방법
 
u 마스터.dta,clear // 자료 열기 
merge 1:1 이름 using 유징.dta,  nogen 
 // merge 할 때  _merge 생성 안하기(nogen)
 
 
*--------------------------
 
 
 
 
*--------------------------
* left outer join
* (master only, matched남기기)
*--------------------------
 
u 마스터.dta,clear // 자료 열기
merge 1:1 이름 using 유징.dta // cust_id를 기준으로 merge
keep if _merge==1 | _merge==3 // key variable이 매치 된 것(3)과 master only(1)만 남기기
drop _merge // _merge 변수 없애기
 
* 다른 방법
 
u 마스터.dta,clear // 자료 열기
merge 1:1 이름 using 유징.dta , keep(master match) nogen
 /* key variable이 매치 된 것(3)과 master only(1)만 남기고(keep(master match))
    merge 할 때  _merge 생성 안하기(nogen)
*/
 
 
*--------------------------
 
 
 
 
*--------------------------
* right outer join
*(using only, matched남기기)
*--------------------------
 
u 마스터.dta,clear  // 자료 열기
merge 1:1 이름 using 유징.dta // cust_id를 기준으로 merge
keep if _merge==2 | _merge==3 // key variable이 매치 된 것(3)과 using only(2)만 남기기
drop _merge // _merge 변수 없애기

 
* 다른 방법
 
u 마스터.dta,clear //자료열기 
merge 1:1 이름 using 유징.dta, keep(using match) nogen
/* key variable이 매치 된 것(3)과 using only(2)만 남기고(keep(using match))
    merge 할 때  _merge 생성 안하기(nogen)
*/

 
*--------------------------


*********************************	  
