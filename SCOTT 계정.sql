select * from emp;
select * from test1;
drop TABLE test1;

create table test3 (
    id varchar2(10),
    password varchar2(10)
);
insert into test3 values ('�̼���', '0000');
commit;

-- �ظ��ϸ� �̰ɷ� �����Ѵ� -
CREATE TABLE dept (dno number(2),
                    dnam varchar2(14),
                    loc varchar2(13),
                    birth Date);
drop table dept;                    
                    
-- ���� ���� �ʴ´�             
ALTER TABLE dept
    MODIFY dnam varchar2(30);

ALTER TABLE dept
    ADD (birth Date) ; 
    
    ----
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK', SYSDATE);

UPDATE DEPT SET dnam = 'ȫ����' Where dno = 10;

DELETE DEPT WHERE dno = 10; -- ���̺� �ȿ� �ִ� ������

select * from dept;
    ----
    
drop table ȸ��DB;
drop table user_info;
create table �뿩DB
    (rent_id varchar2(20) primary key,
    book_number varchar2(30) not null,
    member_id varchar2(30) not null,
    rent_date date not null,
    return_date date not null);
    
select * from ȸ��DB;

create sequence num increment by 1 start with 1 maxvalue 99999 cycle;

create table ȸ��DB
    (����_ID varchar2(40) primary key, -- 10�ڸ�
    ��й�ȣ_PW varchar2(50) not null,
    �̸��� varchar2(100) not null,
    ������� varchar2(50) not null,
    ���� varchar2(10) not null,
    MBTI varchar2(30) not null, 
    ����ó varchar2(40) not null,
    ������ varchar2(100) not null);

INSERT INTO ȸ��DB VALUES ('�����', 'ENTJ', 'NEWYORK', '23232','������','19119',
'0101','05060@ANEM',sysdate);

SELECT ����_ID,�̸�,MBTI FROM ȸ��DB;
SELECT * FROM ȸ��DB;
select * from ȸ��DB WHERE ����_ID AND �̸�;
SELECT * FROM ȸ��DB WHERE MBTI AND ����;

UPDATE ȸ��DB SET ��й�ȣ_PW ='dakfg%#45' Where ����_ID = 'haehyun93';

DELETE FROM ȸ��DB WHERE ����_ID = 'haehyun93';

DELETE ȸ��DB WHERE MBTI = 'INTJ-T' AND ������� = '1999-03-21' AND ����ó = '010-1234-5678' 
AND ����_ID = '�ٶ���' AND �̸��� = 'aaa123@naver.com' AND ��й�ȣ_PW = 'dakfg%#45';














UPDATE ȸ��DB SET ��й�ȣ_PW = 'asd#@$675' WHERE ����_ID = '�ٶ���' AND ������� = '1999-03-21' AND ���� = '����' AND MBTI = 'INTJ-T' AND ����ó='010-1234-5678';