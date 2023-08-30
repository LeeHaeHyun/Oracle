select * from emp;
select * from test1;
drop TABLE test1;

create table test3 (
    id varchar2(10),
    password varchar2(10)
);
insert into test3 values ('이순신', '0000');
commit;

-- 왠만하면 이걸로 수정한다 -
CREATE TABLE dept (dno number(2),
                    dnam varchar2(14),
                    loc varchar2(13),
                    birth Date);
drop table dept;                    
                    
-- 거의 쓰지 않는다             
ALTER TABLE dept
    MODIFY dnam varchar2(30);

ALTER TABLE dept
    ADD (birth Date) ; 
    
    ----
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK', SYSDATE);

UPDATE DEPT SET dnam = '홍보부' Where dno = 10;

DELETE DEPT WHERE dno = 10; -- 테이블 안에 있는 데이터

select * from dept;
    ----
    
drop table 회원DB;
drop table user_info;
create table 대여DB
    (rent_id varchar2(20) primary key,
    book_number varchar2(30) not null,
    member_id varchar2(30) not null,
    rent_date date not null,
    return_date date not null);
    
select * from 회원DB;

create sequence num increment by 1 start with 1 maxvalue 99999 cycle;

create table 회원DB
    (별명_ID varchar2(40) primary key, -- 10자리
    비밀번호_PW varchar2(50) not null,
    이메일 varchar2(100) not null,
    생년월일 varchar2(50) not null,
    성별 varchar2(10) not null,
    MBTI varchar2(30) not null, 
    연락처 varchar2(40) not null,
    가입일 varchar2(100) not null);

INSERT INTO 회원DB VALUES ('사용자', 'ENTJ', 'NEWYORK', '23232','이해현','19119',
'0101','05060@ANEM',sysdate);

SELECT 별명_ID,이름,MBTI FROM 회원DB;
SELECT * FROM 회원DB;
select * from 회원DB WHERE 별명_ID AND 이름;
SELECT * FROM 회원DB WHERE MBTI AND 성별;

UPDATE 회원DB SET 비밀번호_PW ='dakfg%#45' Where 별명_ID = 'haehyun93';

DELETE FROM 회원DB WHERE 별명_ID = 'haehyun93';

DELETE 회원DB WHERE MBTI = 'INTJ-T' AND 생년월일 = '1999-03-21' AND 연락처 = '010-1234-5678' 
AND 별명_ID = '다람쥐' AND 이메일 = 'aaa123@naver.com' AND 비밀번호_PW = 'dakfg%#45';














UPDATE 회원DB SET 비밀번호_PW = 'asd#@$675' WHERE 별명_ID = '다람쥐' AND 생년월일 = '1999-03-21' AND 성별 = '남자' AND MBTI = 'INTJ-T' AND 연락처='010-1234-5678';