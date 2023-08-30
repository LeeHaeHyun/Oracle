/*****************/
파일명 :  Or05TypeConvert.sql
숫자(수학) 관련 함수
설명: 숫자 데이터를 처리하기 위한 숫자 관련 함수를 알아보자.
    테이블 생성시 number 타입으로 선언된 컬럼에 저장된 데이터를 
    대상으로 한다.
/*****************/

-- HR 계정
/*
sysdate : 현재 날짜와 시간을 초단위로 반환해준다, 주로 게시판이나
    회원가입에서 새로운 게시물이 있을때 입력한 날짜를 표현하기 위해
    사용한다.
*/
select sysdate from dual;

/*
날짜 포맷 : 오라클은 대소문자를 구분하지 않으므로, 서식 문자 역시 구분하지
    않는다. 따라서 mm과 MM은 동일한 결과를 출력한다
*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'YY/MM/DD') from dual;

-- 현재 날짜를 "오늘은 0000년 00월 00일 입니다."와 같은 형태로 출력하시오.
select to_char(sysdate, '오늘은 yyyy년 mm월 dd일 입니다.') "과연될까?"
    from daul; -- 에러 발썡, 날짜 형식이 부적합합니다.

/*
-(하이픈), /(슬러쉬) 외의 문자는 인식하지 못하므로 서식문자를 제외한 
나머지 문자열을 "(더블쿼테이션)으로 묶어주어야 한다. 서식문자를 감싸는게
아님에 주의해야 한다.
*/

select to_char(sysdate, '"오늘은 "yyyy"년"mm"월"dd"일 입니다."') "이제된당."
    from dual;

-- 요일이나 년도를 표현하는 서식 문자들
select 
    to_char(Sysdate, 'day') "요일(화요일)",
    to_char(Sysdate, 'dy') "요일(화요일)",
    to_char(Sysdate, 'mon') "월(4월)",
    to_char(Sysdate, 'mm') "월(04)",
    to_char(Sysdate, 'month') "월",
    to_char(Sysdate, 'yy') "두자리 년도",
    to_char(Sysdate, 'dd') "일을 숫자로 표현",
    to_char(Sysdate, 'ddd') "1년중 몇번째일"
 from dual;
 
/*
시나리오] 사원 테이블에서 사원의 입사일을 다음과 같이 출력할 수 있도록
    서식을 지정하여 쿼리문을 작성하시오
    출력] 0000년 00월 00일 0요일 
*/
select first_name, last_name, hire_date,
    to_char(hire_date, 'yyyy"년 "mm"월 "dd"일 " dy"요일"') "입사일"
from employees
    order by hire_date;
    
/*
시간 포맷: 현재시간을 00:00:00 형태로 표시하기 
    또는 날짜와 시간을 동시에 표현할 수도 있다.
*/
select 
    to_char(sysdate, 'HH:MI:SS'),
    to_char(sysdate, 'hh:mi:ss'),
    to_char(sysdate, 'hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "현재시간"
 from dual;
 
/*
숫자 포맷
    0 : 숫자의 자리수를 나타내며 자리수가 맞지 않는 경우 0으로 자리를 채운다.
    9 : 0과 동일하지만 자리수가 맞지 않는 경우 공백으로 채운다.]
trim은 공백을 지운다.
*/
select 
    to_char(123, '0000'),
    to_char(123, '9999'), trim(to_char(123, '9999'))
 from dual;