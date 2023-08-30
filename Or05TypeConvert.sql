/*****************/
���ϸ� :  Or06TypeConvert.sql
����ȯ �Լ� / ��Ÿ�Լ�
����: ������ Ÿ���� �ٸ� Ÿ������ ��ȯ�ؾ� �� �� ����ϴ� �Լ��� ��Ÿ �Լ�
/*****************/

-- HR ����
/*
sysdate : ���� ��¥�� �ð��� �ʴ����� ��ȯ���ش�, �ַ� �Խ����̳�
    ȸ�����Կ��� ���ο� �Խù��� ������ �Է��� ��¥�� ǥ���ϱ� ����
    ����Ѵ�.
*/
select sysdate from dual;

/*
��¥ ���� : ����Ŭ�� ��ҹ��ڸ� �������� �����Ƿ�, ���� ���� ���� ��������
    �ʴ´�. ���� mm�� MM�� ������ ����� ����Ѵ�
*/
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'YY/MM/DD') from dual;

-- ���� ��¥�� "������ 0000�� 00�� 00�� �Դϴ�."�� ���� ���·� ����Ͻÿ�.
select to_char(sysdate, '������ yyyy�� mm�� dd�� �Դϴ�.') "�����ɱ�?"
    from daul; -- ���� �ߛ�, ��¥ ������ �������մϴ�.

/*
-(������), /(������) ���� ���ڴ� �ν����� ���ϹǷ� ���Ĺ��ڸ� ������ 
������ ���ڿ��� "(���������̼�)���� �����־�� �Ѵ�. ���Ĺ��ڸ� ���δ°�
�ƴԿ� �����ؾ� �Ѵ�.
*/

select to_char(sysdate, '"������ "yyyy"��"mm"��"dd"�� �Դϴ�."') "�����ȴ�."
    from dual;

-- �����̳� �⵵�� ǥ���ϴ� ���� ���ڵ�
select 
    to_char(Sysdate, 'day') "����(ȭ����)",
    to_char(Sysdate, 'dy') "����(ȭ����)",
    to_char(Sysdate, 'mon') "��(4��)",
    to_char(Sysdate, 'mm') "��(04)",
    to_char(Sysdate, 'month') "��",
    to_char(Sysdate, 'yy') "���ڸ� �⵵",
    to_char(Sysdate, 'dd') "���� ���ڷ� ǥ��",
    to_char(Sysdate, 'ddd') "1���� ���°��"
 from dual;
 
/*
�ó�����] ��� ���̺����� ����� �Ի����� ������ ���� ����� �� �ֵ���
    ������ �����Ͽ� �������� �ۼ��Ͻÿ�
    ���] 0000�� 00�� 00�� 0���� 
*/
select first_name, last_name, hire_date,
    to_char(hire_date, 'yyyy"�� "mm"�� "dd"�� " dy"����"') "�Ի���"
from employees
    order by hire_date;
    
/*
�ð� ����: ����ð��� 00:00:00 ���·� ǥ���ϱ� 
    �Ǵ� ��¥�� �ð��� ���ÿ� ǥ���� ���� �ִ�.
*/
select 
    to_char(sysdate, 'HH:MI:SS'),
    to_char(sysdate, 'hh:mi:ss'),
    to_char(sysdate, 'hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "����ð�"
 from dual;
 
/*
���� ����
    0 : ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ� ��� 0���� �ڸ��� ä���.
    9 : 0�� ���������� �ڸ����� ���� �ʴ� ��� �������� ä���.]
trim�� ������ �����.
*/
select 
    -- 0�� �������� ����ϸ� �ڸ����� ���� ��� 0�� ä������.
    to_char(123, '0000'),
    -- 9�� �������� ����ϸ� ������ ����Ƿ� trim���� ������ �� �ִ�.
    to_char(123, '9999'), trim(to_char(123, '9999'))
 from dual;
 
-- ������ 3�ڸ����� �ĸ� ǥ���ϱ�
/*
�ڸ����� Ȯ���� ����ȴٸ� 0�� ����ϰ�, �ڸ����� �ٸ� �κп�����
9�� ����Ͽ� ������ �����Ѵ�. ��� ������ trim() �Լ��� ����
�����ϸ� �ȴ�. 
*/
select 
    12345,
    to_char(12345, '000,000'), to_char(12345, '999,999'),
    ltrim(to_char(12345, '999,999')), ltrim(to_char(12345, '990,000'))
 from dual;
 
 -- ��ȭ ǥ�� : L => �� ���� �´� ��ȭǥ�ð� �ȴ�. �츮����� ������ ǥ�õ�
 select to_char(1000000, 'L9,999,000') from dual;

/*
���� ��ȯ �Լ�
    to_number() : ������ �����͸� ���������� ��ȯ�Ѵ٤�
*/
-- 2���� ���ڰ� ���ڷ� ��ȯ�Ǿ� ������ ����� ����Ѵ�.
select to_number('123') + to_number('456') from dual;
-- ���ڰ� �ƴ� ���ڰ� �����־ ������ �߻��Ѵ�.
select to_number('123a') + to_number('456') from dual;

/*
to_date() 
    : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� ������ش�.
    �⺻������ ��/��/�� ������ �����ȴ�.
*/
select 
    to_date('2023-06-16') "��¥ �⺻ ����1",
    to_date('20230616') "��¥ �⺻ ����2",
    to_date('2023/06/16') "��¥ �⺻ ����3"
 from dual;
    
/*
��¥ ������ ��-��-�� ���� �ƴ� ��쿡�� ����Ŭ�� �ν����� ���Ͽ�
������ �߻��ȴ�. �� ���� ��¥ ������ �̿��� ����Ŭ�� �ν��� �� �ֵ���
ó���ؾ� �Ѵ�.
*/
select to_date('16-06-2023') from dual; -- ����

/*
����] '2023-06-16 14:26:21'�� ���� ������ ���ڿ��� ��¥�� �ν��� �� �ֵ���
�������� �ۼ��Ͻÿ�
*/
-- ��¥ ������ �ν����� ���ϹǷ� ������ �߻��Ѵ�.
select to_date('2023-06-16 14:26:21') from dual;

-- ���1 : ���ڿ��� �߼� ����Ѵ�.
-- ���ڿ��� �Ʒ��� ���� �����Ѵٸ� ��¥�������� �ν��� �� �ִ�.
select to_date('2023-06-16') from dual;
-- substr() �Լ��� ���ڿ��� ��¥ �κи� �߶� to_date()�� ���ڷ� ����Ѵ�.
select
    substr('2023-06-16 14:26:21', 1, 10) "���ڿ��ڸ���",
    to_date(substr('2023-06-16 14:26:21', 1, 10)) "��¥ �������� ����"
 from dual;

-- ���2 : ��¥�� �ð� ������ Ȱ���Ѵ�. 
select 
    to_date('2023-06-16 14:26:21', 'yyyy-mm-dd hh24:mi:ss')
    from dual;

/*
����] ���ڿ� '2021/05/05'�� � �������� ��ȯ�Լ��� ���� ����غ��ÿ�.
    ��, ���ڿ��� ���Ƿ� ������ �� ����.
*/
select
    to_date('2021/12/25') "1�ܰ�:��¥����Ȯ��",
    to_char(sysdate, 'day') "2�ܰ�:���ϼ���Ȯ��",
    to_char(to_date('2021/12/25'), 'day') "3�ܰ�:����"
 from dual;
 
/*
����] ���ڿ� '2021�� 01�� 01��'�� � �������� ��ȯ�Լ��� ����
����Ͻÿ�. �� ���ڿ��� ���Ƿ� ������ �� �����ϴ�.
*/
select
    to_date('2021�� 01�� 01��', 'yyyy"��"mm"��"dd"��"') "1�ܰ�:��¥����Ȯ��",
    to_char(to_date('2021�� 01�� 01��', 'yyyy"��"mm"��"dd"��"'), 'day') "2�ܰ�:�������" 
 FROM dual;

/*
nul() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�
    ����] null(�÷���, ��ü�Ұ�
*/
-- �̿� ���� ������ �ϸ� ��������� �ƴ� ��� �޿��� null�� ��µȴ�
select salary+commission_pct from employees;
-- null ���� 0���� ������ �� ������ �����ϹǷ� �������� ����� ��µȴ�.
select
    first_name, commission_pct, salary+nvl(commission_pct, 0)
 from employees;
 
/*
decode() : jave�� switch���� ����ϰ� Ư������ �ش��ϴ� ��¹��� �ִ� ���
����մϴ�. 
    ����] decode(�÷���, 
            ��1, ���1, ��2, ���2, ...
            �⺻��)
    �� �������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����� �� ���� ���ȴ�
*/
select 
    first_name, last_name, department_id,
    decode(department_id, 10, 'Adminstration',
    20, 'Marketing',
    30, 'Purchasion',
    40, 'Human Resources',
    50, 'Shipping',
    60, 'IT',
    70, 'Public Relations',
    80, 'Sales',
    90, 'Executive',
    100, 'Finance',
    110, 'Accounting', '�μ��� Ȯ�ξȵ�') as department_name
 from employees;
 
 /*
 case() : java�� if-else���� ����� ������ �ϴ� �Լ� 
    ����] case
            when ����1 then ��1
            when ����2 then ��2
            ......
            else �⺻��
        end
 */
 
 /*
 �ó�����] ������̺����� �� �μ���ȣ�� �ش��ϴ� �μ����� ����ϴ�
 �������� case���� �̿��ؼ� �ۼ��Ͻÿ�
 */
select
    first_name, last_name, department_id,
    case
        /*when ���� then ��*/
        when department_id=10 then 'Administration' -- �濵������
        when department_id=20 then 'Marketing' -- ��������
        when department_id=30 then 'Purchasion' -- ������
        when department_id=40 then 'Human Resources' -- �λ������
        when department_id=50 then 'Shipping' -- ������
        when department_id=60 then 'IT' -- IT��
        when department_id=70 then 'Public Relations' -- ȫ����
        when department_id=80 then 'Sales' -- ������
        when department_id=90 then 'Executive' -- �濵��
        when department_id=100 then 'Finance' -- �繫��
        when department_id=110 then 'Accounting' -- ȸ����
        else '�μ��� ����'
    end team_name
from employees
order by department_id asc;

/*
��������
-- scott �������� �����մϴ�.
*/

/*
1. substr() �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select * from emp;
select 
    hiredate,
    substr(hiredate, 1, 5) "�Ի���1",
    to_char(hiredate, 'yy-mm') "�Ի���2"
 from emp;
 
/*
2. substr() �Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�.
��, ������ ������� 4���� �Ի��� ��� ����� ��µǸ� �ȴ�.
*/
select * from emp where substr(hiredate, 4, 2) = '04';

/*
3. mod() �Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����Ͻÿ�
*/
select * from emp where mod(empno, 2)=0;

/*
4. �Ի����� ������ 2�ڸ�(yy), ���� ����(mon)�� ǥ���ϰ� ������ 
���(dy)�� �����Ͽ� ����Ͻÿ�
*/
select
    hiredate,
    to_char(hiredate, 'yy') "�Ի�⵵",
    to_char(hiredate, 'mon') "�Ի��",
    to_char(hiredate, 'dy') "�Ի����",
    to_char(hiredate, 'yy') "�Ի�⵵"
 from emp;

/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� �����
����ϰ� To_Date()�Լ��� ����Ͽ� ������ ���� ��ġ ��Ű�ÿ�.
��, ��¥�� ���´� '01-01-2020' �������� ����Ѵ�.
�� sysdate - '01-01-2020' �̿Ͱ��� ������ �����ؾ��Ѵ�.
*/
-- sysdate - to_date('01-01-2023') �̿� �����ϸ� �����߻�
select
    sysdate - to_date('23/01/01') "�⺻��¥ ���Ļ��",
    to_date('01-01-2023', 'dd-mm-yyyy') "��¥ ���� ����",
    trunc(sysdate - to_date('01-01-2023', 'dd-mm-yyyy')) "��¥ ����"
 from dual;

/*
6. ������� �Ŵ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� 
null�� ��� 0���� ����Ͻÿ�.
*/
select * from emp;
select 
    ename, nvl(mgr,0) "�Ŵ������"
from emp;

/*
7. decode �Լ��� ���޿� ���� �޿��� �λ��Ͽ� ����Ͻÿ�.
'CLERK'�� 200, 'SALESMAN'�� 180, 'MANAGER'�� 150, 'PRESIDENT'�� 100��
�λ��Ͽ� ����Ͻÿ�
*/
select
    ename, sal,
    decode(job,
        'CLERK', sal+200,
        'SALESMAN', sal+180,
        'MANAGER', sal+150,
        'PRESIENT', sal+100,
        sal) as "�λ�� �޿�" 
 from emp;
 
 