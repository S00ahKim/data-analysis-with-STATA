clear // 메모리에 업로드된 파일 지우기
set more off //결과가 막힘없이 쭉 나온다.
br //browse의 약자로 데이터 브라우져가 뜨게 하기

cd "C:\statistical-analysis-with-STATA\08_append and show data"  


* append


use day1.dta ,clear //파일열기
list ,ab(15) //데이터의 내용을 결과창에 보여주기 ab(15)는 팔굽혀펴기 글자가 압축되서 나오지 않게 하는 옵션

append using day2.dta // append
list ,ab(15) sepby(일차) // sepby는 일차변수의 변수값이 변할때마다 줄을 그어주라는 옵션

sort 이름  일차 // (이름,일차)의 오름차순 순으로 정렬
list ,ab(15) sepby(이름)
