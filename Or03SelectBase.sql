/*****************/
���ϸ� :   Or03SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
�����ڵ� ���̿����� '����'�̶�� ǥ���ϱ⵵ �մϴ�.
����: select, where �� ���� �⺻���� DQL�� ����غ���
/*****************/

-- HR �������� �ϱ�
/*
SQL Developer ���� �ּ� ����ϱ�
    �������ּ� : �ڹٿ� ������. 
    ���δ����ּ� : -- ���๮��. ������ 2���� �������� ����մϴ�.

*/

-- select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�
/*
����) 
    selcet �÷�1, �÷�2, ... Ȥ�� * (����)
        from ���̺��
        where ����1 and ����2 or ����3
        ordaer vy ������ �÷� asc(��������), desc(��������);
*/
-- ������̺� ����� ��� ���ڵ带 ������� ��� �÷��� ��ȸ�ϱ�
-- (�������� ��ҹ��ڸ� �������� �ʴ´�.)
select * from employees;
SELECT * FROM employees;

/*
�÷����� �����ؼ� ��ȸ�ϰ� ���� �÷��� ��ȸ�ϱ�
=> �����ȣ, �̸�, �̸���, �μ���ȣ�� ��ȸ�Ͻÿ�.
*/
select employee_id, first_name, last_name, email, department_id
    from employees; -- �ϳ��� �������� ���� �� ;�� �ݵ�� ����ؾ� �մϴ�.
    
-- ���̺��� ������ �÷��� �ڷ��� �� ũ�⸦ ����Ѵ�.    
-- ��, ���̺��� ��Ű���� �� �� �ִ�.
desc employees;

-- as�� ������ �� �ս��ϴ�. 
select employee_id "������̵�", first_name "�̸�", last_name "��"
    from employees where first_name = 'William';
    
/*
����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �ʴ´�. 
������� ��� ��ҹ��� ���о��� ����� �� �ִ� ( �����ʹ� ��ҹ��ڸ� �����Ѵ�)
*/
-- �����ʹ� ��ҹ��� �����Ѵ�. (�߿���) select���� ǥ��
-- �÷����� "" // �����ʹ� '' 
SELECT employee_id "������̵�", first_name "�̸�", last_name "��"
    FROM Employees WHERE first_name = 'William';

-- ��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. ���� �Ʒ� SQL���� �����ϸ�
-- �ƹ��� ����� ������ �ʴ´�

select employee_id "������̵�", first_name "�̸�", last_name "��"
    FROM EMPLOyEES WHERE first_name = 'William';

/*
where ���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
-> last_name�� smith�� ���ڵ带 �����Ͻÿ�
employees ���̺��� smith�� ����� ����
*/
select employee_id "���ID", first_name "�̸�", last_name "��"
    From employees Where last_name = 'Smith';
    
/*
where���� 2�� �̻��� ������ �ʿ��Ҷ� and Ȥ�� or�� ����� �� �ִ�.
-> last_name�� smith�̸鼭 �޿��� 8000�� ����� �����Ͻÿ�
*�� ��θ� ���Ѵ� ( ��� �÷� )
*/
-- �÷��� �������� ��� �̱������̼����� ���Ѵ�. ������ ��� �����Ѵ�.
-- AND�� A�� B�� ������ ���ÿ� �����ؾ��Ѵ�, OR�� A�� B�� ������ �ϳ��� �����ϸ� ����
select * From employees Where last_name = 'Smith' AND Salary = 8000;
-- �����߻�. �÷��� �������� ��� �̱������̼��� ������ ������ �߻��Ѵ�.    
select * FROM EMPLOYEES WHERE last_name = Smith and Salary = 8000;
-- �÷��� �������϶��� ������ �⺻������, ������ ������ �߻����� �ʴ´�.
select * from employees where last_name = 'Smith' and salary = '8000';

/*
�񱳿����ڸ� ���� ������ �ۼ� : �̻�, ���Ͽ� ���� ���ǿ� >, <=�� ���� �񱳿����ڸ�
����� �� �ִ�. ��¥�� ��� ����, ���Ŀ� ���� ���ǵ� �����ϴ�.
*/
-- �޿��� 5000�̸��� ����� ������ �����Ͻÿ� 
Select * From employees where salary < 5000;
-- �Ի����� 04�� 01�� 01�� ������ ��������� �����Ͻÿ�
Select * From employees where HIRE_DATE >= '04/01/01';
    
/*
in ������ 
    : or �����ڿ� ���� �ϳ��� �÷��� �������� ������ ������ �ɰ� ���� ��
    => �޿��� 4200, 6400, 8000�� ����� ������ �����Ͻÿ�
*/

-- ���1 : or �� ����Ѵ�. �̶� �÷����� �ݺ������� ����ؾߵǼ� �����ϴ�    
Select * From employees where salary = 4200 or salary = 6400 or salary = 8000;

-- ���2 : in�� ����ϸ� �÷����� �ѹ��� ����ϸ� �Ǹ� ���ϴ�
Select * From employees where salary in (4200, 6400, 8000);
    
/*
not ������
    : �ش� ������ �ƴ� ���ڵ带 �����Ѵ� 
    => �μ���ȣ�� 50�� �ƴ� ��������� �����Ͻÿ� 
*/
Select * From employees where department_id <> 50;
Select * From employees where not (department_id = 50);

/*
between and ������
    : �÷��� ������ ���� �˻��� �� ����Ѵ�
    => �޿��� 4000~8000 ������ ����� �����Ͻÿ�
*/
-- ���1 
Select * From employees where salary >= 4000 and salary <= 8000;

-- ��� 2
Select * From employees where salary between 4000 and 8000;

/*
distinct
    : �÷����� �ߺ��Ǵ� ���ڵ带 ������ �� ����Ѵ� 
    Ư�� �������� select���� �� �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ� ���
    �ߺ����� ������ �� ����� �����Ѵ�
    -> ������ ���̵� �ߺ��� ������ �� ����Ͻÿ�
*/
-- ��ü ����� ���� ���������� ����Ǿ����ϴ�. 
select job_id from employees ;

select distinct job_id from employees;

/*
like������ 
    : Ư��Ű���带 ���� ���ڿ��� �˻��� �� ����Ѵ�
    ����) �÷��� like '%�˻���%'
    ���ϵ�ī�� ����
        %: ��� ���� Ȥ�� ���ڿ� ��ü�Ѵ�.
        Ex) D�� ���۵Ǵ� �ܾ� : D% -> Da, Dea, Deawoo
            Z�� ������ �ܾ� : %Z -> aZ, adxZ
            C�� ���Ե� �ܾ� : %C% -> ACB, ABCDE, Vitamin-C
        _ : ����ٴ� �ϳ��� ���ڸ� ��ü�Ѵ�. 
        Ex) D�� �����ϴ� 3������ �ܾ� : D__ -> Dad, Ddd, Dxy
            A�� �߰��� ���� 3������ �ܾ� : _A_ -> aAa, sAy
*/
-- First_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�
select * From employees where first_name like 'D%';
-- First_name�� 3��° ���ڰ� a�� ������ �����Ͻÿ�
select * From employees where first_name like '__a%';
-- last_name���� y�� ������ ������ �����Ͻÿ�
select * From employees where last_name like '%y';
-- ��ȭ��ȣ�� 1344�� ���Ե� ���� ��ü�� �����Ͻÿ�.
select * From employees where phone_number like '%1344%';

/*
���ڵ� �����ϱ�
 : �������� ���� : order by �÷��� asc (Ȥ�� ��������_
   �������� ���� : order by �÷��� desc 
   
   2�� �̻��� �÷����� �����ؾ� �� ��� �޸��� �����ؼ� �����Ѵ�
   ��, �� �� ���� �Է��� �÷����� ���ĵ� ���¿� 2��° �÷��� ���ĵȴ�.
*/
/*
������� ���̺��� �޿��� ���� �������� ���� ������ ����ǵ��� �����Ͻÿ�
����� �÷� : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number from employees 
    order by salary asc; --asc�� ������ �� �ִ�.
    
/*
�μ���ȣ�� ������������ ������ �� �ش� �μ����� ���� �޿��� �޴� ������ ���� ��µǵ��� 
sql���� �ۼ��Ͻÿ�
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
select employee_id, first_name, last_name, salary, department_id
    from employees 
    order by department_id desc, salary asc;
    
/*
is null Ȥ�� is not null
    : ���� null �̰ų� null�� �ƴ� ���ڵ� �������� 
    �÷��� null���� ����ϴ� ��� ���� �Կ����� ������ null ���� �Ǵµ�
    �̸� ������� select �� �� ����Ѵ�
*/
-- ���ʽ����� ���� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is null;

-- ��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�
select * from employees where salary >= 8000
    and commission_pct is not null;
    
/*
��������(scott�������� �����մϴ�)
1. ���� �����ڸ� �̿��ؼ� ��� ����� ���Ͽ� $300�� �޿��λ��� ����� �� 
�̸�, �޿�, �λ�� �޿��� ����Ͻÿ�
*/
select * from emp; -- ���̺� ��ȸ, AS(��Ī)
select ENAME, SAL, SAL+300 AS "�λ�� �޿�" from emp;
    
/*
2. ����� �̸�, �޿�, ������ ������ ���� �ͺ��� ���� ������ ����Ͻÿ�
������ ���޿� 12�� ���� �� $100�� ���ؼ� ����Ͻÿ�
*/
select ename, sal, (sal*12+100) AS "����" FROM emp; 
-- ���Ľ� ���������� �����ϴ� �÷����� ����ϴ� �� �⺻�̴�
select ename, sal, (sal*12+100) AS "����" FROM emp
    order by "����" desc;
-- ���������� �������� ���� �÷��̶�� ���� �״�θ� order by���� ����Ѵ�.
/*
3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal From emp where sal > 2000 order by ename desc, sal desc;

-- 4. �����ȣ�� 7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�
select ename, deptno from emp
    where empno = 7782;
    
/*
5. �޿��� 2000���� 3000 ���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�
*/
select ename, sal from emp
    where not (sal between 2000 and 3000);

select ename, sal from emp
    where sal >= 2000 and sal <= 3000;

/*
6. �Ի����� 81�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ ����� �̸�,
������, �Ի����� ����Ͻÿ�
*/
select ename, job, hiredate from emp
    where (hiredate between '81/02/20' and '81/05/01');

select ename, job, hiredate from emp
    where (hiredate >= '81/02/20' and hiredate <= '81/05/01');

/*
7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸���
����(��������)���� ����Ͻÿ�
*/
select ename, deptno from emp
    where deptno in (20,30)
    order by ename desc;

select ename, deptno from emp
    where deptno = 20 or deptno = 30
    order by ename desc;  
    
/*
9. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30��
����� �̸�, �޿�, �μ���ȣ ����ϵ� �̸���(��������)���� ����Ͻÿ�
*/
select ename, sal, deptno from emp
    where (sal between 2000 and 3000) and deptno in (20,30)
    order by ename asc;

/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�
(like �����ڿ�, ���ϵ�ī�� ���
*/
select ename, hiredate from emp
    where hiredate like '81%';

/*
10. �����ڰ� ���� ����� �̸��� ��� ������ ����Ͻÿ�
*/
select ename, job from emp 
    where mgr is null;

/*
11. Ŀ�̼��� ���� �� �մ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼���
����ϵ� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal, comm from emp
    where comm is not null
    order by sal desc, comm desc;
    
/*
12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�
*/
select ename from emp
    where ename like '__R%';

/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ��
*/
Select ename from emp
    where ename like '%A%' and ename like '%E%';

-- �Ʒ��� ���� ��� A�� E�� ���ԵǱ� �ϳ� ������ �����Ƿ� E�� �����ϰ� A�� ������
-- �̸��� �˻����� �ʴ´�. (�Ʒ��� ���� SQL���� ������� �ʴ´�) 
Select ename from emp
    where ename like '%A%E%';

/*
14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 �޿��� 1600 950 1300�� �ƴ�
����� �̸�, ������, �޿��� ����Ͻÿ�
*/
Select ename, job, sal from emp
    where job in ('CLERK','SALESMAN') and sal not in (1600, 950, 1300);

/*
15. Ŀ�̼��� 500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�
*/
Select ename, sal, comm from emp
    where comm >= 500;


