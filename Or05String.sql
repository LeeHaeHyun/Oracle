/*****************/
파일명 :  Or05String.sql
문자열 처리함수
설명 : 문자열에 대해 대소문자를 변환하거나 문자열의 길이를
반환하는 등 문자열을 조작하는 함수 
/*****************/
-- HR 계정

/*
concat(문자열1, 문자열2) 
    : 문자열1과 문자열2를 연결해서 출력하는 함수
    사용법 1 : concat('문자열1', '문자열2)
    사용법 2 : '문자열1' || '문자열2'
*/
select concat('Good ', 'morning') as "아침 인사" from dual;
select 'Good ' || 'morning' from dual;


select 'Oracle ' ||'21C '||'Good..!!' from dual;
-- => 위 sql문을 concat()으로 변경하면 다음과 같다.(조금 불편하다)
select concat(concat('Oracle ' , '21C '), 'Good..!!') from dual;

/*
시나리오] 사원테이블에서 사원의 이름을 연결해서 아래와 같이 출력하시오
    출력내용: first+last name, 급여, 부서번호
*/
-- Step1 : 이름을 연결해서 출력하지만 띄어쓰기가 안되어 가독성이 떨어진다
select
    concat(first_name, last_name), salary, department_id
 from employees;
 
-- Step2 : 스페이스를 추가하기 위해 concat()을 하나 더 사용한다.
 select
    concat(concat(first_name,' '), last_name), salary, department_id
 from employees;
 
 -- Step3 : 2개의 함수를 사용하는 것보다 ||를 이용하면 간단히 
 -- 표현할 수 있다. 또한 컬럼명에는 as를 이용해서 별칭을 부여한다.
select first_name|| ' ' ||last_name as full_name, salary, department_id 
    from employees;
    
/*
initcap(문자열)
    : 문자열의 첫문자만 대문자로 변환하는 함수.
    단, 첫문자를 인식하는 기준은 다음과 같다.
    - 공백문자 다음에 나오는 첫문자를 대문자로 변환한다.
    - 알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫번째 문자를 
    대문자로 변환한다
*/
-- hi, hello의 첫글자를 대문자로 변경(공백 다음은 새로운 문자로 취급)
select initcap('hi hello 안녕') from dual;

-- g, b, m이 대문자로 변경(슬래쉬 다음도 새로운 문자로 취급)
select initcap('good/bad morning') from dual;

-- n, g, b가 대문자로 변경(6은 숫자라서 say는 변경되지 않는다.
-- 특수문자 다음도 새로운 문자로 취급)
select initcap('naver9say*good가bye') from dual;

/*
시나리오] 사원테이블에서 first_name이 john인 사원을 찾아서 인출하시오
*/
-- 이와 같이 쿼리하면 결과가 인출되지 않습니다. (데이터는 대소문자 구분)
select * from employees where first_name = 'john';

-- 따라서 아래와 같이 함수를 사용하거나 대문자가 포함된 이름을 사용
-- 둘다 3개의 검색 결과가 인출된다.
select * from employees where first_name = initcap('john');
select * from employees where first_name = 'John';

/*
대소문자 변경하기
lower() : 소문자로 변경한다
upper() : 대문자로 변경함
*/
select lower('GOOD'), upper('bad') from dual;

-- 위와 같이 john을 검색하기 위해 다음과 같이 활용할 수 있다.
-- 컬럼 자체를 대문자 혹은 소문자로 변경한 후 쿼리한다. 
-- first_name 차트 전체를 소문자 및 대문자로 바꾼다 그래서 검색이 됨
select * from employees where lower(first_name) = 'john';
select * from employees where upper(first_name) = 'JOHN';

/*
lpad() : rpad()
    : 문자열의 왼쪽, 오른쪽을 특정한 기호로 채울 때 사용한다.
    형식] lpad('문자열, '전체자리수', '채울문자열')
        -> 전체자리수에서 문자열의 길이만큼을 채워주는 함수
        rpad()는 오른쪽을 채워줌
*/
-- 출력결과 : good, ###good, good###, ---good(공백3개가 좌측에 출력)
select 
    'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7)
 from dual;

-- 이름 전체를 12자로 간주하여 이름을 제외한 나머지 부분을 *로 채운다. 
select rpad(first_name, 12, '*') from employees;
select rpad(first_name, 12)||rpad(last_name, 12) as fullname from employees;

/*
시나리오] 사원테이블에 first_name을 첫글자를 제외한 나머지 부분을
    *로 마스킹 처리하는 쿼리문을 작성하시오 
*/
-- substr(문자열 혹은 컬럼, 시작 인덱스, 길이) : 시작 인덱스부터 길이만큼
-- 잘라낸다.
select substr('abcdefg', 1,1) from dual;
select substr(first_name,1,1) from employees;

-- 문자열의 길이를 10으로 지정하여 남은 부분을 *로 채운다.
-- 즉, 이름을 제외한 나머지 5를 *로 채워준다.
select rpad('Ellen' , 10, '*') from dual;

-- length(문자열 혹은 컬럼명) : 해당 문자열의 길이를 반환한다.
select
    first_name, 
    rpad(substr(first_name,1,1), length(first_name), '*') "마스킹"
 from employees;

/*
trim() : 공백을 제거할때 사용한다.
    형식] trim[leading | trailing | both] 제거할 문자 from 컬럼명)
    - leading : 왼쪽에서 제거함
    - trailing : 오른쪽에서 제거함
    - both : 양쪽에서 제거함, 설정값이 없으면 both가 기본값임
    [주의1] 양쪽 끝에 문자만 제거되고, 중간에 있는 문자는 제거되지 않음
    [주의2] 문자만 제거할 수 있고 문자열은 제거할 수 없음(에러발생)
*/
select 
    '공백제거테스트' as trim1,
    trim(' 공백제거테스트 ') as trim2, -- 양쪽의 공백 제거됨
    trim('다' from '다람쥐가 나무를 탑니다') trim3, -- 양쪽에 '다' 제거 
    trim(both '다' from '다람쥐가 나무를 탑니다') trim4, -- both는 기본값
    trim(leading '다' from '다람쥐가 나무를 탑니다') trim5, -- 좌측의 '다' 제거
    trim(trailing'다' from '다람쥐가 나무를 탑니다') trim6 -- 우측의 '다' 제거
 from dual;
-- trim()은 중간의 문자는 제거할 수 없고, 양쪽 끝의 문자만 제거할 수 있다.

-- trim()은 '다람쥐' 문자열은 제거할 수 없어 에러가 발생합니다.
select 
    trim('다람쥐' from '다람쥐가 나무를 타다가 떨어졌어욤TT') "TrimError"
 from dual;

/*
ltrim(), rtrim() : Left, Right
 : 좌측 혹은 우측 문자열을 제거할 때 사용한다.
  ★ Trim은 문자열을 제거할 수 없지만, LTrim, RTim은 문자열까지 제거할 수 있다.
*/
select 
    -- 좌측 공백이 제거된다. 
    ltrim(' 좌측공백제거 ') ltrim,
    -- 이 경우 좌측에 스페이스가 포함된 문자열이므로 삭제되지 않는다.
    ltrim(' 좌측공백제거 ', '좌측') ltrim2,
    -- 여기서는 '좌측'이라는 문자열이 삭제된다.
    ltrim('좌측공백제거 ', '좌측') ltrim3,
    -- 우측에 문자열이 제거된다.
    rtrim('우측공백제거', '제거') rtrim1,
    -- 문자열 중간은 제거되지 않는다.
    rtrim('우측공백제거 ', '공백') rtrim2
 from dual;
 
 /*
 substr() : 문자열에서 시작 인덱스부터 길이만큼 잘라서 문자열을 출력한다.
    형식] substr(컬럼), 시작인덱스, 길이) 
    
    참고1] 오라클의 인덱스는 1부터 시작한다. (0부터 아님)
    참고2] '길이'에 해당하는 인자가 없으면 문자열의 끝까지를 의미한다.
    참고3] 시작 인덱스가 음수면 우측 끝부터 좌로 인덱스를 적용한다. 
 */
 select substr('good morning john', 8,4) from dual;
 select substr('good morning john', 8) from dual;
 
 /*
 replace() 문자열을 다른 문자열로 대체할 때 사용한다.
 만약 공백으로 문자열을 대치한다면, 문자열이 삭제되는 결과로 된다.
 형식] repace(문자열 or 문자열, '변경할 대상의 문자', '변경할 문자')
 
 ☆  trim(), ltrim(), rtrim() 함수기능을 가진 replace() 
 함수 하나로 대체할 수 있어 trim()에 비해 replace()가 훨씬 더 사용빈도가 높다.
 
 */
-- 문자열을 변경한다
select replace('good morning john', 'morning', 'evening') from dual;
-- 문자열을 삭제한다
select replace('good morning john', 'john', '') from dual;
-- trim은 양쪽의 공백만 제거된다.
select trim(' good morning john ') from dual;
-- replace는 좌우측뿐 아니라 중간의 공백도 제거할 수 있다.
select replace(' good morning john ', ' ', '') from dual;
 
-- 102번 사원의 레코드를 대상으로 문자열 변경을 해보자
select first_name, last_name,
    ltrim(first_name, 'L') "좌측L제거",
    rtrim(first_name, 'ex') "우측ex제거",
    replace(last_name, ' ','') "중간공백제거",
    replace(last_name, 'De', 'Dea') "이름변경"
 from employees where employee_id=102;
 
 /*
 instr() : 해당 문자열에서 특정문자가 위치한 인덱스값을 반환한다.
    형식1] instr(컬럼명, '찾을문자')
        : 문자열의 처음부터 문자를 찾는다.
    형식2] instr(컬럼명, '찾을문자' '탐색을 시작할 인덱스','몇번째 문자')
        : 탐색할 인덱스부터 문자를 찾는다. 단, 찾는 문자중 몇번째에 있는 
        문자인지 지장할 수 있다.
    * 탐색을 시작할 인덱스가 음수인 경우 우측에서 좌측으로 찾게 된다.
 */
 -- n이 발견된 첫번째 인덱스 반환
 select instr('good morning john', 'n') from dual; 
 
 -- 인덱스 1부터 탐색을 시작해서 2번째 n을 찾아서 인덱스를 반환
 select instr('good morning john', 'n', 1, 2) from dual;
 
 -- 인덱스 8부터 탐색을 시작하여 h가 발견된 첫번째 인덱스 반환 
 select instr('good morning john', 'h', 8,1) from dual;
 
 