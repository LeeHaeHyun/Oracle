/*****************
파일명 :  Or18SubProgram.sql
서브프로그램
설명: 저장 프로시져, 함수 그리고 프로시져의 일종인 트리거를
학습합니다.
/*****************/
-- HR 계정
/*
서브프로그램(Sub Program)
    - PL/SQL에서는 프로시져와 함수라는 두자리 유형의 서브프로그램이 있다.
    - Select를 포함해서 다른 DML문을 이용하여 프로그래밍적인 요소를 통해
      사용 가능하다.
    - 트리거는 프로시져의 일종으로 특정 테이블의 레코드의 변화가 있을경우
    자동으로 실행된다.
    - 함수는 쿼리문의 일부분으로 사용하기 위해 생성한다. 즉 외부 프로그램에서
    호출하는 경우는 거의 없다.
    - 프로시저는 외부 프로그램에서 호출하기 위해 생성한다. 따라서 JAVA, JSP등에서
    간단한 호출로 복잡한 쿼리를 실행할 수 있다.
*/

/*
1. 저장 프로시져(Stored Procedure)
    - 프로시져는 return문이 없는 대신 out 파라미터를 통해 값을 반환
    - 보안성을 높일 수 있고, 네트워크의 부하를 줄일 수 있다.
    형식] create [or replace] procedure 프로시저명
        [(매개변수 in 자료형)], 매개변수 out 자료형)]
        is [변수선언]
        begin
            실행문장;
        end;
    * 파라미터 설정시 자료형만 명시하고, 크기는 명시하지 않는다.. 
*/
-- 예제1] 100번 사원의 급여를 가져와서 select하여 출력하는 프로시저 생성

-- 만약 첫 실행이라면 최초로 한번 실행해야만 결과를 화면에 출력할 수 있다.
set serveroutput on;

create procedure pcd_emp_salary
is
    /*
    PL/SQL은 declare에서 변수를 선언하지만 프로시져나
    함수는 is절에서 변수를 생성한다. 만약 변수가 필요없다면 생략할 수 있다.
    사원 테이블의 급여 칼럼을 참조하는 참조변수로 생성한다.
    */
    v_salary employees.salary%type;
begin
    -- 100번 사원의 급여를 into를 이용해서 변수에 할당한다.
    select salary into v_salary
    from employees
    where employee_id = 100;
    
    dbms_output.put_line('사원번호100의 급여는:'|| v_salary ||'입니다');
end;
/

select * from user_source where name like upper('%pcd_emp_salary%');
execute pcd_emp_salary;

--예제2] IN파라미터 사용하여 프로시저 생성
/*
시나리오] 사원의 이름을 매개변수로 받아서 사원테이블에서 레코드를 조회한후
해당사원의 급여를 출력하는 프로시저를 생성 후 실행하시오.
해당 문제는 in파라미터를 받은후 처리한다.
사원이름(first_name) : Bruce, Neena
*/
-- 프로시져 생성시 in파라미터를 설정한다. 
-- 사원테이블의 사원명 컬럼을 참조하는 참조변수로 생성한다.
create procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    /*
    변수는 is 절에 선언하고 필요없는 경우 선언하지 않을 수도 있다.
    */
    valSalary number(10);
begin
    /*인파라미터로 전달된 사원명을 조건으로 급여를 구한 후
    변수에 할당합니다. 하나의 결과가 출력되므로 into를 select절에서
    사용할 수 있다.*/
    select salary into valSalary
    from employees where first_name = param_name;
    
    -- 이름과 같이 급여를 출력합니다.
    dbms_output.put_line(param_name||'의 급여는 '|| valSalary ||'입니다');
end;
/
-- 사원의 이름을 파라미터로 전달하여 프로시져를 호출한다.
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');

-- 예제3] OUT파라미터 사용하여 프로시저 생성
/*
시나리오] 위 문제와 동일하게 사원명을 매개변수로 전달받아서 급여를 조회하는
프로시저를 생성하시오. 단, 급여는 out파라미터를 사용하여 반환후 출력하시오
*/
/*
두가지 형식의 파라미터를 정의한다. 일반변수, 참조변수
각각 사용했다. 파라미터의 용도에 따라 in,out을 각각
명시한다. 파라미터를 정의할때는 크기는 기술하지 않는다.
*/
create or replace procedure pcd_out_param_salary
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )
is
    /*
    select한 결과를 out 파라미터에 저장한 것이므로
    별도의 변수가 필요하지 않아 is절을 비워둔다.
    이와같이 변수선언 생략할 수가 있다.
    */
begin
    /*
    in 파라미터는 where절의 조건으로 사용하고
    select한 결과는 into절에서 out파라미터에 저장한다.
    */
    select salary into param_salary
    from employees where first_name = param_name;
end;
/
-- 호스트 환경에서 바인드 변수를 선언한다.
-- var 또는 variable 둘다 사용할 수 있다.
var v_salary varchar2(30);
/*
프로시져 호출시 각각의 파라미터를 전달한다.
특히 바인드 변수는 :를 붙여야한다.
Out 파라미터인 param_salary에 저장된 값이 v_salary로 전달된다.
*/
execute pcd_out_param_salary('Matthew', :v_salary);
-- 프로시져 실행 후 out파라미터를 통해 전달된 값을 출력한다.
print v_salary;

/*
시나리오] 
사원번호와 급여를 매개변수로 전달받아 해당사원의 급여를 수정하고, 
실제 수정된 행의 갯수를 반환받아서 출력하는 프로시저를 작성하시오
*/
-- 실습을 위해 employees테이블을 레코드까지 복사한다.
create table zcopy_employees
as
    select * from employees;
-- 복사 되었는지 확인한다. 
select * from zcopy_employees;

-- in 파라미터는 사원번호와 급여를 전달한다.
-- out 파라미터는 적용된 행의 갯수를 반환한다.
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is
    -- 추가적인 변수 선언이 필요없으므로 생략한다.
begin
    -- 실제 업데이트를 처리하는 쿼리문으로 in 파라미터를 통해
    -- 값을 설정한다.
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;  
    /*
    SQL%notfound : 쿼리 실행 후 적용된 행이 없을 경우
    true를 반환한다. Found는 반대의 경우를 반환한다.
    SQL%rowCount : 쿼리 실행 후 실제 적용된 행의 갯수를 반환한다.
    */
    if SQL%notfound then
        dbms_output.put_line(p_empid ||'은(는) 없는 사원입니다.');
    else
        dbms_output.put_line(SQL%rowcount ||'명의 자료가 수정되씸');
        
        -- 실제 적용된 행의 갯수를 반환하여 out파라미터에 저장한다.
        rCount := sql%rowcount;
    end if;
    
    /*
    행의 변화가 있는 쿼리를 실행할 경우 반드시 commit해야 실제 테이블에
    적용되어 oracle 외부에서 확인할 수 있다
    */
    commit;
end;
/
-- 프로시져 실행을 위해 바인드 변수 생성
variable r_count number;
-- 100번 사원의 이름과 급여를 확인한다. : Steven 24000
select first_name, salary from zcopy_employees where employee_id=100;
-- 프로시저 실행, 바인드 변수에는 반드시 :을 붙여야 한다
execute pcd_update_salary(100,30000, :r_count);
-- update가 적용된 행의 개수 확인
print r_count;
-- 업데이트된 내용을 확인한다 : Steven 30000
select first_name, salary from zcopy_employees where employee_id=100;
-----------------------------------------------------------------
/*
2. 함수
    - 사용자가 PL/SQL문을 사용해서 오라클에서 제공하는
    내장함수와 같은 기능을 정의한 것이다.
    - 함수는 In파라미터만 사용할 수 있고, 반드시 반환된 값의 자료형을
    명시 해야 한다.
    - 프로시져는 여러개의 결과값을 얻어올 수 있지만, 함수는 반드시
    하나의 값을 반환해야 한다.
*/

/*
시나리오] 
2개의 정수를 전달받아서 두 정수사이의 모든수를 더해서 결과를 반환하는 함수를 정의하시오.
실행예) 2, 7 -> 2+3+4+5+6+7 = ??
*/
-- 함수는 in파라미터만 있으므로 in은 주로 생략한다.
create or replace function calSumBetween (
    num1 in number,
    num2 number
)
return 
    -- 함수는 반드시 반환값이 있으므로 반환 타입을 명시해야 한다.(필수)
    number
is
    -- 반환값으로 사용할 변수 선언 ( 선택 : 필요없다면 생략 가능하다)
    sumNum number;
begin
    sumNum := 0;
    -- for 루프문으로 숫자 사이의 합의 계산한 후 반환한다
    for i in num1 .. num2 loop
        -- 증가하는 변수 i를 sumNum에 누적해서 더해준다.
        sumNum := sumNum + i;
    end loop;
    -- 결과값을 반환한다.
    return sumNum;
end;
/
-- 실행방법1 : 쿼리문의 일부로 사용한다.
select calSumbetween(1,10) from dual;

-- 실행방법2 : 바인드변수를 통한 실행명령으로 주로 디버깅용으로 사용한다.
var hapText varchar2(30);

execute : hapText := calSumBetween(1,100);
print hapText;

-- 데이터 사전에서 확인하기
select * from user_source where name=upper( 'calSumBetween');

/*
퀴즈] 주민번호를 전달받아 성별을 판단하는 함수를 정의하시오
990909-1000000 -> 남자 '반환'
990919-2000000 -> 여자 '반환'
단, 2000년 이후 출생자는 3이 남자, 4가 여자임
함수명: findGender()
*/
select substr('990909-1000000', 8, 1) from dual;
select substr('990919-2000000', 8, 1) from dual;

-- 해당 함수는 주민번호를 문자형태로 받아서 성별을 판단한다
-- 함수(funtion)은 in파라미터만 있으므로 in은 생략하는 것이 좋다.
create or replace function findGender (juminNum varchar2)
-- 함수는 반드시 반환타입을 명시해야 합니다.
-- 성별 판단후 '남자' 혹은 '여자'를 반환하므로 문자형으로 선언한다.
return varchar2 
is 
    -- 주민번호에서 성별에 해당하는 문자를 저장할 변수
    genderTxt varchar2(1);
    -- 성별을 저장한 후 반환할 변수
    returnVal varchar2(10);
begin 
    -- 방법1
    -- 쿼리에서 실행된 결과를 into를 통해 변수에 저장한다.
    select substr(juminNum, 8, 1) into genderTxt from dual;
    
    -- 방법2 : substr()을 직접 사용
    -- genderTxt := substr(juMinNum, 8, 1);
    
    if genderTxt = '1' then
        returnVal := '남자';
    elsif genderTxt = '2' then
        returnVal := '여자';   
    elsif genderTxt = '3' then
        returnVal := '남자';
    elsif genderTxt = '4' then
        returnVal := '여자'; 
    else
        returnVal := '오류';
    end if;
    -- 함수는 반드시 반환값을 가진다.
    return returnVal;
end; 
/
select findGender('990909-1000000') from dual;
select findGender('990919-2000000') from dual;
select findGender('990909-3000000') from dual;
select findGender('990909-4000000') from dual;
select findGender('990909-5000000') from dual;

/*
시나리오] 사원의 이름(first_name)을 매개변수로 전달받아서
    부서명(department_name)을 반환하는 함수를 작성하시오
    함수명 : func_depatName
*/
-- 1단계 : Nancy의 부서명을 출력하기 위한 inner join문 작성
select
    first_name, last_name, department_id, department_name
 from employees inner join departments using(department_id)
 where first_name='Nancy';
 
-- 2단계 : 함수 작성
create or replace function func_depatName(
    -- 사원의 이름을 받기 위한 파라미터 설정
    param_name varchar2)
    return
        -- 부서명을 반환하므로 문자형으로 설정한다.
        varchar2
    is
        -- 부서테이블의 부서명을 참조하는 참조변수로 선언
        return_deptname departments.department_name%type;
begin
    -- 쿼리문을 실행한 후 결과값을 변수에 저장한다.
    select
        department_name into return_deptname
    from employees inner join departments using(department_id)
    where first_name = param_name;
    
    -- 결과 반환
    return return_deptname;
end;
/
select func_depatName('Nancy') from dual; -- Finance 반환
select func_depatName('Diana') from dual;

/*
3. 트리거(Trigger)
    : 자동으로 실행되는 프로시저로 직접 실행은 불가능하다.
    주로 테이블에 입력된 레코드의 변화가 있을때 자동으로 실행한다.
*/
-- 트리거 실습을 위해 HR계정에서 아래 테이블을 복사한다.
-- 테이블의 레코드까지 모두 복사한다.
create table trigger_dept_original
as
select * from departments;
-- 테이블의 스키마(구조)만 복사한다. where절에 거짓의 조건을 주면
-- 레코드는 select 되지 않는다.
create table trigger_dept_backup
as
select * from departments where 1=0;

/*예제1] trig_dept_backup
시나리오] 테이블에 새로운 데이터가 입력되면 해당 데이터를 백업테이블에 저장하는
트리거를 작성해보자.
*/
create trigger trig_dept_backup
    after -- 타이밍 : after => 이벤트 발생후, before => 이벤트 발생전
    INSERT -- 이벤트 : insert/update/delete와 같은 쿼리 실행시 발생된다.
    on trigger_dept_original -- 트리거를 적용할 테이블명
    for each row
    /*
        행 단위 트리거 정의한다. 즉 하나의 행이 변화할때마다 트리거가
        수행된다. 만약 문장(테이블)단위 트리거로 정의하고 싶다면
        해당 문장을 제거하면 된다. 이때는 쿼리를 한번 실행할때 트리거도
        단 한번만 실행된다.
    */
begin
    -- insert 이벤트가 발생되면 true를 반환하여 if문이 실행된다.
    if Inserting then
        dbms_output.put_line('insert 트리거 발생됨');
        
        /*
        새로운 레코드가 입력되었으므로 임시 테이블 :new에 저장되고
        해당 레코드를 통해 backup 테이블에 입력할 수 있다.
        이와 같이 임시테이블은 행단위 트리거에서만 사용할 수 있다.
        */
        insert into trigger_dept_backup
        values (
            : new.department_id,
            : new.department_name,
            : new.manager_id,
            : new.location_id
        );
        end if;
    end;
    /
set serveroutput on;
insert into trigger_dept_original values (101, '개발팀', 10, 100);
select * from trigger_dept_original;
select * from trigger_dept_backup;

/*
예제2] trig_dept_delete
시나리오] 원본테이블에서 레코드가 삭제되면 백업테이블의 레코드도 같이
삭제되는 트리거를 작성해보자.
*/
create or replace trigger trig_dept_delete
    /*
    trigger_dept_original에서 레코드를 삭제한 후
    행단위로 해당 트리거를 실행한다.
    */
    after
    delete
    on trigger_dept_original
    for each row
begin
    dbms_output.put_line('delete 트리거 발생됨');
    /*
    레코드가 삭제된 이후에 이벤트가 발생되어 트리거가 호출되므로
    :old 임시테이블을 사용한다.
    */
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/
-- 아래와 같이 레코드를 삭제하면 트리거가 자동호출된다.
delete from trigger_dept_original where department_id=101;

select * from trigger_dept_original;
select * from trigger_dept_backup;

-- 예제3] trigger_update_test
/*
For each row 옵션에 따른 트리거 실행횟수 테스트

생성1 : 오리지날 테이블에 업데이트 이후 행단위로 발생되는
트리거 생성
*/
create or replace trigger trigger_update_test
    after update
    on trigger_dept_original
    for each row
begin
    /*
    업데이트 이벤트가 감지되면 backup 테이블에 레코드를 입력한다.
    */
    if updating then
        insert into trigger_dept_backup
        values (
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id
        );
    end if;
end;
/
-- 5개의 레코드가 인출되는 것을 확인한다.
select * from trigger_dept_original where
    department_id>=10 and department_id<=50;
    
-- 업데이트 실행(5개의 레코드가 업데이트되므로, 
-- 백업 테이블에도 5개가 입력된다. 행단위 트리거는
-- 적용된 행의 갯수만큼 실행된다.)    
update trigger_dept_original set department_name='5개업데이트'
    where department_id>=10 and department_id<=50;
select * from trigger_dept_original;
select * from trigger_dept_backup;

/*
생성2 : 오리지널 테이블에 업데이트 이후 테이블(문장) 단위로
발생되는 트리거 생성
*/
create or replace trigger trigger_update_test2
    after update
    on trigger_dept_original
   /* for each row      */
   /*
   오리지널 테이블의 레코드를 업데이트 한 후 테이블단위로
   트리거가 실행되므로 적용된 갯수에 상관없이 무조건 한번만
   트리거가 실행된다.
   */
begin
    /*
    업데이트 이벤트가 감지되면 backup 테이블에 레코드를 입력한다.
    */
    if updating then
        dbms_output.put_line ('update 트리거 발생됨');
        insert into trigger_dept_backup
        values (
            /* 테이블(문장) 단이 트리거에서는 임시 테이블 사용할 수 없다. 
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id */
            999, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),99,99
        );
    end if;
end;
/
-- 업데이트 실행(5개의 레코드가 업데이트되므로,   
update trigger_dept_original set department_name='5개업데이트2'
    where department_id>=10 and department_id<=50;
select * from trigger_dept_original;
select * from trigger_dept_backup;

-- 트리거 삭제하기
drop trigger trigger_update_test;
drop trigger trigger_update_test2;

