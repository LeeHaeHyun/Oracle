/*****************/
파일명 :   Or03SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문)
개발자들 사이에서는 '시퀄'이라고 표현하기도 합니다.
설명: select, where 등 가장 기본적인 DQL문 사용해보기
/*****************/

-- HR 계정으로 하기
/*
SQL Developer 에서 주석 사용하기
    블럭단위주석 : 자바와 동일함. 
    라인단위주석 : -- 실행문장. 하이픈 2개를 연속으로 사용합니다.

*/

-- select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다
/*
형식) 
    selcet 컬럼1, 컬럼2, ... 혹은 * (모든것)
        from 테이블명
        where 조건1 and 조건2 or 조건3
        ordaer vy 정렬할 컬럼 asc(오름차순), desc(내림차순);
*/
-- 사원테이블에 저장된 모든 레코드를 대상으로 모든 컬럼을 조회하기
-- (쿼리문은 대소문자를 구분하지 않는다.)
select * from employees;
SELECT * FROM employees;

/*
컬럼명을 지정해서 조회하고 싶은 컬럼만 조회하기
=> 사원번호, 이름, 이메일, 부서번호만 조회하시오.
*/
select employee_id, first_name, last_name, email, department_id
    from employees; -- 하나의 쿼리문이 끝날 때 ;을 반드시 기술해야 합니다.
    
-- 테이블의 구조와 컬럼별 자료형 및 크기를 출력한다.    
-- 즉, 테이블의 스키마를 알 수 있다.
desc employees;

-- as는 생략할 수 잇습니다. 
select employee_id "사원아이디", first_name "이름", last_name "성"
    from employees where first_name = 'William';
    
/*
오라클은 기본적으로 대소문자를 구분하지 않는다. 
예약어의 경우 대소문자 구분없이 사용할 수 있다 ( 데이터는 대소문자를 구분한다)
*/
-- 데이터는 대소문자 구분한다. (중요함) select문을 표현
-- 컬럼명은 "" // 데이터는 '' 
SELECT employee_id "사원아이디", first_name "이름", last_name "성"
    FROM Employees WHERE first_name = 'William';

-- 단, 레코드인 경우 대소문자를 구분한다. 따라서 아래 SQL문을 실행하면
-- 아무런 결과도 나오지 않는다

select employee_id "사원아이디", first_name "이름", last_name "성"
    FROM EMPLOyEES WHERE first_name = 'William';

/*
where 절을 이용해서 조건에 맞는 레코드 추출하기
-> last_name이 smith인 레코드를 추출하시오
employees 테이블에서 smith인 사람만 추출
*/
select employee_id "사원ID", first_name "이름", last_name "성"
    From employees Where last_name = 'Smith';
    
/*
where절에 2개 이상의 조건이 필요할때 and 혹은 or를 사용할 수 있다.
-> last_name이 smith이면서 급여가 8000인 사원을 추출하시오
*은 모두를 뜻한다 ( 모든 컬럼 )
*/
-- 컬럼이 문자형인 경우 싱글쿼테이션으로 감싼다. 숫자인 경우 생략한다.
-- AND는 A와 B의 조건이 동시에 만족해야한다, OR는 A와 B의 조건이 하나만 만족하면 추출
select * From employees Where last_name = 'Smith' AND Salary = 8000;
-- 에러발생. 컬럼이 문자형인 경우 싱글쿼테이션이 없으면 에러가 발생한다.    
select * FROM EMPLOYEES WHERE last_name = Smith and Salary = 8000;
-- 컬럼이 숫자형일때는 생략이 기본이지만, 쓰더라도 에러가 발생하지 않는다.
select * from employees where last_name = 'Smith' and salary = '8000';

/*
비교연산자를 통한 쿼리문 작성 : 이상, 이하와 같은 조건에 >, <=와 같은 비교연산자를
사용할 수 있다. 날짜인 경우 이전, 이후와 같은 조건도 가능하다.
*/
-- 급여가 5000미만인 사원의 정보를 추출하시오 
Select * From employees where salary < 5000;
-- 입사일이 04년 01월 01일 이후인 사원정보를 추출하시오
Select * From employees where HIRE_DATE >= '04/01/01';
    
/*
in 연산자 
    : or 연산자와 같이 하나의 컬럼에 여러개의 값으로 조건을 걸고 싶을 때
    => 급여가 4200, 6400, 8000인 사원의 정보를 추출하시오
*/

-- 방법1 : or 를 사용한다. 이때 컬럼명을 반복적으로 기술해야되서 불편하다    
Select * From employees where salary = 4200 or salary = 6400 or salary = 8000;

-- 방법2 : in을 사용하면 컬럼명은 한번만 기술하면 되면 편리하다
Select * From employees where salary in (4200, 6400, 8000);
    
/*
not 연산자
    : 해당 조건이 아닌 레코드를 추출한다 
    => 부서번호가 50이 아닌 사원정보를 추출하시오 
*/
Select * From employees where department_id <> 50;
Select * From employees where not (department_id = 50);

/*
between and 연산자
    : 컬럼의 구간을 정해 검색할 때 사용한다
    => 급여가 4000~8000 사이의 사원을 추출하시오
*/
-- 방법1 
Select * From employees where salary >= 4000 and salary <= 8000;

-- 방법 2
Select * From employees where salary between 4000 and 8000;

/*
distinct
    : 컬럼에서 중복되는 레코드를 제거할 때 사용한다 
    특정 조건으로 select했을 때 하나의 컬럼에서 중복되는 값이 있는 경우
    중복값을 제거한 후 결과를 추출한다
    -> 담당업무 아이디를 중복을 제거한 후 출력하시오
*/
-- 전체 사원에 대한 담당업무명이 인출되었습니다. 
select job_id from employees ;

select distinct job_id from employees;

/*
like연산자 
    : 특정키워드를 통한 문자열을 검색할 때 사용한다
    형식) 컬럼명 like '%검색어%'
    와일드카드 사용법
        %: 모든 문자 혹은 문자열 대체한다.
        Ex) D로 시작되는 단어 : D% -> Da, Dea, Deawoo
            Z로 끝나는 단어 : %Z -> aZ, adxZ
            C가 포함된 단어 : %C% -> ACB, ABCDE, Vitamin-C
        _ : 언더바는 하나의 문자를 대체한다. 
        Ex) D로 시작하는 3글자의 단어 : D__ -> Dad, Ddd, Dxy
            A가 중간에 들어가는 3글자의 단어 : _A_ -> aAa, sAy
*/
-- First_name이 'D'로 시작하는 직원을 검색하시오
select * From employees where first_name like 'D%';
-- First_name이 3번째 문자가 a인 직원을 추출하시오
select * From employees where first_name like '__a%';
-- last_name에서 y로 끝나는 직원을 추출하시오
select * From employees where last_name like '%y';
-- 전화번호에 1344가 포함된 직원 전체를 인출하시오.
select * From employees where phone_number like '%1344%';

/*
레코드 정렬하기
 : 오름차순 정렬 : order by 컬럼명 asc (혹은 생략가능_
   내림차순 정렬 : order by 컬럼명 desc 
   
   2개 이상의 컬럼으로 정렬해야 할 경우 콤마로 구분해서 정렬한다
   단, 이 떄 먼저 입력한 컬럼으로 정렬된 상태에 2번째 컬럼이 정렬된다.
*/
/*
사원정보 테이블에서 급여가 낮은 순서에서 높은 순서로 인출되도록 정렬하시오
출력할 컬럼 : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number from employees 
    order by salary asc; --asc는 생략할 수 있다.
    
/*
부서번호를 내림차순으로 정렬한 후 해당 부서에서 낮은 급여를 받는 직원이 먼저 출력되도록 
sql문을 작성하시오
출력항목 : 사원번호, 이름, 성, 급여, 부서번호
*/
select employee_id, first_name, last_name, salary, department_id
    from employees 
    order by department_id desc, salary asc;
    
/*
is null 혹은 is not null
    : 값이 null 이거나 null이 아닌 레코드 가져오기 
    컬럼중 null값을 허용하는 경우 값을 입역하지 않으면 null 값이 되는데
    이를 대상으로 select 할 때 사용한다
*/
-- 보너스율이 없는 사원을 조회하시오
select * from employees where commission_pct is null;

-- 영업사원이면서 급여가 8000이상인 사원을 조회하시오
select * from employees where salary >= 8000
    and commission_pct is not null;
    
/*
연습문제(scott계정에서 진행합니다)
1. 덧셈 연산자를 이용해서 모든 사원에 대하여 $300의 급여인상을 계산한 후 
이름, 급여, 인상된 급여를 출력하시오
*/
select * from emp; -- 테이블 조회, AS(별칭)
select ENAME, SAL, SAL+300 AS "인상된 급여" from emp;
    
/*
2. 사원의 이름, 급여, 연봉을 수입이 많은 것부터 작은 순으로 출력하시오
연봉은 월급에 12를 곱한 후 $100을 더해서 계산하시오
*/
select ename, sal, (sal*12+100) AS "연봉" FROM emp; 
-- 정렬시 물리적으로 존재하는 컬럼명을 사용하는 게 기본이다
select ename, sal, (sal*12+100) AS "연봉" FROM emp
    order by "연봉" desc;
-- 물리적으로 존재하지 않은 컬럼이라면 계산식 그대로를 order by절에 기술한다.
/*
3. 급여가 2000이 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오
*/
select ename, sal From emp where sal > 2000 order by ename desc, sal desc;

-- 4. 사원번호가 7782인 사원의 이름과 부서번호를 출력하시오
select ename, deptno from emp
    where empno = 7782;
    
/*
5. 급여가 2000에서 3000 사이에 포함되지 않는 사원의 이름과 급여를 출력하시오
*/
select ename, sal from emp
    where not (sal between 2000 and 3000);

select ename, sal from emp
    where sal >= 2000 and sal <= 3000;

/*
6. 입사일이 81년 2월 20일부터 81년 5월 1일 사이인 사원의 이름,
담당업무, 입사일을 출력하시오
*/
select ename, job, hiredate from emp
    where (hiredate between '81/02/20' and '81/05/01');

select ename, job, hiredate from emp
    where (hiredate >= '81/02/20' and hiredate <= '81/05/01');

/*
7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을
기준(내림차순)으로 출력하시오
*/
select ename, deptno from emp
    where deptno in (20,30)
    order by ename desc;

select ename, deptno from emp
    where deptno = 20 or deptno = 30
    order by ename desc;  
    
/*
9. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인
사원의 이름, 급여, 부서번호 출력하되 이름순(오름차순)으로 출력하시오
*/
select ename, sal, deptno from emp
    where (sal between 2000 and 3000) and deptno in (20,30)
    order by ename asc;

/*
9. 1981년도에 입사한 사람의 이름과 입사일을 출력하시오
(like 연산자와, 와일드카드 사용
*/
select ename, hiredate from emp
    where hiredate like '81%';

/*
10. 관리자가 없는 사원의 이름과 담당 업무를 출력하시오
*/
select ename, job from emp 
    where mgr is null;

/*
11. 커미션을 받을 수 잇는 자격이 되는 사원의 이름, 급여, 커미션을
출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오
*/
select ename, sal, comm from emp
    where comm is not null
    order by sal desc, comm desc;
    
/*
12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오
*/
select ename from emp
    where ename like '__R%';

/*
13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시
*/
Select ename from emp
    where ename like '%A%' and ename like '%E%';

-- 아래와 같은 경우 A와 E가 포함되긴 하나 순서가 있으므로 E로 시작하고 A가 나오는
-- 이름은 검색되지 않는다. (아래와 같은 SQL문은 사용하지 않는다) 
Select ename from emp
    where ename like '%A%E%';

/*
14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 급여야 1600 950 1300이 아닌
사원의 이름, 담당업무, 급여를 출력하시오
*/
Select ename, job, sal from emp
    where job in ('CLERK','SALESMAN') and sal not in (1600, 950, 1300);

/*
15. 커미션이 500 이상인 사원의 이름과 급여 및 커미션을 출력하시오
*/
Select ename, sal, comm from emp
    where comm >= 500;


