clear
set more off
browse

cd "C:\statistical-analysis-with-STATA\02_file read and type casting" // 워킹 디렉토리(파일을 읽고 저장하는 경로)

********************************
* import excel & save
********************************

* master sheet

import excel example.xlsx , sheet(master) clear // 파일 읽어들이기
import excel example.xlsx , sheet(master) firstrow clear // 첫째줄을 변수명을 읽게하면서 파일 읽어들이기

save master.dta,replace //저장

 

* using sheet(cellrange 사용)
 
import excel example.xlsx , sheet(using)  clear // 파일 읽어들이기
import excel example.xlsx , sheet(using) firstrow  cellrange(b2:c6) clear
// cell의 범위를 고려하여 파일을 읽기 

save using.dta,replace //저장

* Sheet3[문자변수(string variables)와 숫자변수(numeric variables)는 구분하자]

import excel example.xlsx , sheet(Sheet3) firstrow clear 
describe 

* score변수를 숫자변수(numeric variable)로 바꾸고 싶다면...

replace score="" if score=="-"
destring score,replace
describe score
save score.dta,replace //저장

********************************

********************************
* stata 파일 열기
********************************

use master.dta,clear

********************************

********************************
* import delim
********************************

* csv파일

import delim auto.csv , delim(",") clear

* |로 구분된 txt파일
import delim auto.txt , delim("|") clear

* csv파일인데 한글이 이상하게 읽혀진 경우...

import delim otherExample.csv , delim(",") clear
import delim otherExample.csv , delim(",") encoding("euc-kr") clear

********************************

