/*****************
���ϸ� :  Or011Join.sql
���̺� ���� 
����: �� �� �̻��� ���̺��� ���ÿ� �����Ͽ� �����͸� �����;� �� ��
    ����ϴ� sql��
/*****************/
-- HR ����

/*
1] inner join(��������) 
    - ���� ���� ���Ǵ� ���ι����� ���̺� ���� 
    ���������� ��� �����ϴ� ���ڵ带 �˻��Ҷ� ����Ѵ�.
    - �Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű(foreign key)��
    ����Ͽ� join�ϴ� ��찡 ��κ��̴�.
    - �� ���� ���̺��� ������ �̸��� �÷��� �����ϸ� "���̺���.�÷���"
    ���·� ����ؾ� �մϴ�.
    - ���̺��� ��Ī�� ����ϸ� "��Ī.�÷���" ���·� ����� �� �ִ�.

����1(ǥ�ع��)
    select �÷�1, �÷�2...
    from ���̺�1 inner join ���̺�2
        on ���̺�1:�⺻Ű�÷� = ���̺�2:�ܷ�Ű�÷�
    where ����1 and ����2...;
*/

/*
�ó�����] ������̺��� �μ����̺��� �����Ͽ�
�� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ�
��, ǥ�ع������ �ۼ��Ͻÿ�.
��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
desc employees;
desc departments;

-- ù��° �������� ������ �߻��Ѵ�.
/*
ORA-00918 : ���� ���ǰ� �ָ��մϴ�.
00918. 00000 -  "column ambiguously defined"
department_id�� ������ ���� ���̺��� �����ϴ� �÷��̹Ƿ�
� ���̺����� ������ ������� �����ؾ� �Ѵ�.
*/
select
	employee_id, first_name, last_name, email, 
    employees.department_id, department_name
from
	employees inner join departments
on
	employees.department_id=departments.department_id;
    -- ���� ���ǰ� �ָ��� ��� �÷� �տ� ���̺����� �߰��մϴ�.

-- as(�˸��ƽ�)�� ���� ���̺��� ��Ī�� �ο��Ͽ� �������� ����ȭ�� �� �ִ�.
select
	employee_id, first_name, last_name, email, 
    Emp.department_id, department_name
from
	employees Emp inner join departments Dep
on
	Emp.department_id=Dep.department_id;

/*
    ���� ��������� �Ҽӵ� �μ��� ���� 1���� ������
    ������ 106���� ���ڵ尡 ����ȴ�. 
    ��, inner join�� ������ ���̺����� ���� ���
    �����Ǵ� ���ڵ常 �������� �ȴ�.
*/

-- 3�� �̻��� ���̺� �����ϱ�
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ�
������ ������ ����ϴ� �������� �ۼ��Ͻÿ�.
��, ǥ�ع������ �ۼ��Ͻÿ�
��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�
    ��������, �ٹ����� 
�� ��°���� ���� ���̺��� �����Ѵ�.
������̺� : ����̸�, �̸���, �μ����̵�, ������ ���̵�
�μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
���������̺� : ��������, ���������̵�(����)
�������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
-- 1. ���� ���̺��� ���� ���ڵ� Ȯ���ϱ� -> �����Ϸù�ȣ 1700Ȯ��
select * from locations where lower(city) = 'seattle';
-- 2. ���� �Ϸù�ȣ�� ���� �μ� ���̺��� ���ڵ� Ȯ���ϱ�-> 21�� �μ� Ȯ��
select * from departments where location_id = 1700;
-- 3. �μ� �Ϸù�ȣ�� ���� ������̺��� ���ڵ� Ȯ���ϱ� -> 6�� Ȯ���ϱ�
select * from employees where department_id = 30;
-- 4. ������ �������� Ȯ���ϱ�
select * from jobs where job_id='PU_MAN';
select * from jobs where job_id='PU_CLERK';

select
    first_name, last_name, email, D.department_id, department_name,
    E.job_id, job_title, city, state_province
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id = J.job_id
where
    lower(city) = 'seattle';
/*
����2] ����Ŭ���
    select �÷�1, �÷�2,...
    from ���̺�1, ���̺�2,...
    where
        ���̺�1.�⺻Ű�÷� = ���̺�2.�ܷ�Ű�÷�
        and ����1 and ����2 ... ;
*/
/*
�ó�����] ������̺��� �μ����̺��� �����Ͽ�
�� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ�
��, ����Ŭ ������� ����Ͻÿ�
��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select 
    employee_id, first_name, last_name, email, 
    E.department_id, department_name
from employees E, departments D
where 
  E.department_id=D.department_id;  

/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. ��, ����Ŭ ������� �ۼ��Ͻÿ�
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�,
        ��������, �ٹ�����
    �� ��°���� ���� ���̺��� �����Ѵ�.
������̺� : ����̸�, �̸���, �μ����̵�, ������ ���̵�
�μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
���������̺� : ��������, ���������̵�(����)
�������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
-- ����Ŭ
select
    first_name, last_name, email,D.department_id, 
    department_name, E.job_id, job_title, city, state_province
from locations L, departments D, employees E, jobs J 
where
    L.location_id=D.location_id and 
    D.department_id=E.department_id and
    E.job_id=J.job_id and city=initcap('seattle');
   
-- ǥ��
select
    first_name, last_name, email, D.department_id, department_name,
    E.job_id, job_title, city, state_province
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id = J.job_id
where
    lower(city) = 'seattle';

/*
2] outer join (�ܺ�����)
    outer join�� inner join���� �޸� �� ���̺��� 
    ���������� ��Ȯ�� ��ġ���� �ʾƵ� ������ �Ǵ�
    ���̺����� ���ڵ带 �����ϴ� join����̴�
    outer join�� ����Ҷ��� �ݵ�� outer ���� ������ �Ǵ�
    ���̺��� �����ϰ� �������� �ۼ��ؾ� �Ѵ�.
    -> left(���� ���̺�), right(������ ���̺�), full(���� ���̺�)
    
����1(ǥ�ع��) 
    select �÷�1, �÷�2, ...
    from ���̺�1
        left[right, full] outer join ���̺�2
            on ���̺�1.�⺻Ű=���̺�2.����Ű
    where ����1 and ����2 or ����3
*/

/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������
    �ܺ�����(left)�� ���� ����Ͻÿ�.
*/
-- �������� ���� �������ΰ��� �ٸ��� 107���� ����ȴ�. 
-- �μ��� �������� ���� ������� ����Ǳ� �����ε� �� ���
-- �μ��ʿ� ���ڵ尡 �����Ƿ� null�� �ȴ�.
select * from employees; -- �����̶� 107�� 

select
    employee_id, first_name, E.department_id, department_name, city
    from employees E
        left outer join departments D on E.department_id=D.department_id
         left outer join locations L on D.location_id=L.location_id;
         
/*
����2 (����Ŭ ���)
    select �÷�1, �÷�2, ...
    from ���̺�1, ���̺�2 
    where
        ���̺�1.�⺻Ű=���̺�2.����Ű (+)
        and ����1 or ����2;
        
=> ����Ŭ ������� ����ÿ��� outer join �������� (+)�� �ٿ��ش�.
=> ���� ��� ���� ���̺��� ������ �ȴ�.
=> ������ �Ǵ� ���̺��� �����Ҷ��� ���̺��� ��ġ�� �Ű��ش�.
*/
/*
�ó�����] ��ü ������ �����ȣ, �̸�, �μ����̵�, �μ���, ������
�ܺ�����(left)�� ���� ����Ͻÿ�. �� ����Ŭ ������� �ۼ��Ͻÿ�
*/

-- ����Ŭ ���
select
    employee_id, first_name, E.department_id, department_name, city
    from employees E, departments D, locations L
    where
        E.department_id=D.department_id (+)
        and D.location_id=L.location_id (+);
        
-- ǥ��
select
    employee_id, first_name, E.department_id, department_name, city
    from employees E
        left outer join departments D on E.department_id=D.department_id
         left outer join locations L on D.location_id=L.location_id;
         
/*
��������] 2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ�. �� �μ��� 
��ġ���� ���� ������ ��� <�μ�����>���� ����Ͻÿ�.
��, ǥ�ع������ �ۼ��Ͻÿ�
����׸�: ���, �̸�, ��, �μ���
*/
-- �켱 ����� ���ڵ� Ȯ��
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees; 
-- 2007�⿡ �Ի��� ����� ����
-- ���1 : like�� �̿��Ͽ� 07�� �����ϴ� ���ڵ带 �����Ѵ�
select first_name, hire_date from employees where hire_date like '07%';
-- ���2 : to_char()�� ���� ��¥������ ���� �� ���ڵ带 ����Ѵ�
select first_name, hire_date from employees 
where to_char(hire_date, 'yyyy')= 2007;
-- �ܺ�����(ǥ�ع��)���� ��� Ȯ��
-- nvl(�÷���, '������ ��') : null ���� �����͸� Ư���� ������ ���
select 
    employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')
from employees E
    left outer join departments D on E.department_id=D.department_id
    where to_char(hire_date, 'yyyy')= 2007;
    
/*
�ó�����] 2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ�. ��, �μ���
��ġ���� ���� ������ ��� <�μ�����>���� ����Ͻÿ�.
��, ����Ŭ ������� �ۼ��Ͻÿ�
����׸� : ���, �̸�, ��, �μ���
*/
select 
    employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')
from employees E, departments D
where E.department_id=D.department_id (+)
    and to_char(hire_date, 'yyyy')= 2007;
    
/*
3] self join(��������)
    ���� ������ �ϳ��� ���̺��� �ִ� �÷����� �����ؾ�
    �ϴ� ��� ����Ѵ�. �� �ڱ� �ڽ��� ���̺��� ������
    �δ� ���̴�. ���� ���ο����� ��Ī�� ���̺��� �����ϴ� �������� ������
    �ϹǷ� ������ �߿��ϴ�.
    
����]
    select 
        ��Ī1.�÷�, ��Ī2.�÷�...
    from
        ���̺� ��Ī1, ���̺� ��Ī2
    where 
        ��Ī1.�÷� = ��Ī2.�÷�;
*/  

/*
�ó�����] ������̺����� �� ����� �Ŵ��� ���̵�� �Ŵ��� �̸��� ����Ͻÿ�
    ��, �̸��� first_name�� last_name�� �ϳ��� �����ؼ� ����Ͻÿ�
*/    
/*
���⼭�� ��������� ���̺� empClerk�� �Ŵ��������� ���̺� empManager��
��Ī���� ������ �� where���� �������� ������ ����Ѵ�.
�Ŵ����� ����̱� ������ ��������� �Ŵ��� ID�� �Ŵ��� ���忡���� 
��� ID�� �ȴ�.
*/    
select
    empClerk.employee_id "�����ȣ", 
    empClerk.first_name||' '||empClerk.last_name "����̸�",
    empManager.employee_id "�Ŵ��� �����ȣ",
    concat(empManager.first_name,' '||empManager.last_name) "�Ŵ����̸�"
 from employees empClerk, employees empManager
 where empClerk.manager_id = empManager.employee_id;
    
/*
 �ó�����] self join�� ����Ͽ� "Kimberely / Grant" ������� �Ի����� ����
    ����� �̸��� �Ի����� ����Ͻÿ�.
    ��¸�� : first_name, last_name, hire_date
*/    
-- 1. Kimberely�� ���� Ȯ��
select * from employees where first_name='Kimberely';
-- 2. 07/05/24 ������ �Ի��� ����� ���ڵ带 ����Ͻÿ�.
select * from employees where hire_date>'07/05/24';
-- 3. self join���� ������ ��ġ��
select 
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
 from employees Kimberely, employees Clerk
 where
    Kimberely.hire_date <= Clerk.hire_date
    and Kimberely.first_name='Kimberely' and Kimberely.last_name='Grant'
 order by hire_date;

/*
using : join������ �ַ� ����ϴ� on���� ��ü�� �� �ִ� ����
    ����] on ���̺�1.�÷� = ���̺�2.�÷�
        ==> using(�÷�)
*/
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� using�� ����ؼ� �ۼ��Ͻÿ�.
    ��� ���: ����̸�, �̸���, �μ����̵�, �μ���, ��� ���� ���̵�,
        ��� ������, �ٹ�����
*/
select
    first_name, last_name, email, department_id, 
    department_name, job_id, job_title, city, state_province
 from locations
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join jobs using(job_id)
 where
    lower(city)='seattle';
    
/*
    using���� ���� ���� �÷��� ��� select������
    ���̺��� ��Ī�� ���̸� ������ ������ �߻��Ѵ�.
    using���� ���� �÷��� ������ ���̺��� ���ÿ� �����ϴ� �÷��̶��
    ���� ����� �ۼ��Ǳ� ������ ���� ��Ī�� ����� ������ ���� �����̴�.
    �� using�� ���̺��� ��Ī �� on���� �����Ͽ� �� �� �����ϰ� join��������
    �ۼ��� �� �ְ� ���ش�.
*/

/*
����] 2005�⿡ �Ի��� ������� California(STATE_PROVINCE) /
    South San Francisco(CITY)���� �ٹ��ϴ� ������� ������ ����Ͻÿ�.
    ��, ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.

    ��°��] �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(COUNTRY_NAME)
        �޿��� ���ڸ����� �޸��� ǥ���Ѵ�.
    ����] '������'�� countries ���̺��� �ԷµǾ��ִ�.
*/    
-- 1. 2005�⿡ �Ի��� ���
select first_name, hire_date, substr(hire_date,1,2) from employees;
select * from employees where substr(hire_date,1,2)='05';
-- 2. South San Franciso�� ��ġ�� �μ� Ȯ��
select * from locations where city='South San Francisco';
    -- location_id 1500�� ���� Ȯ��
select * from departments where location_id=1500;
    -- department_id�� 50�� ���� Ȯ��
-- 3. ������ Ȯ���� ������ ���� ������ �ۼ�
select * from employees 
    where department_id=50 and substr(hire_date,1,2)='05';
    -- 50�� �μ�(��ۺ� shipping)���� �ٹ��ϸ鼭 �Ի���� 2005���� ������� = 12��
-- 4. join ������ �ۼ��ϱ�
select 
    employee_id, first_name, last_name, trim(to_char(salary, '$999,000')) as "����",
    department_name, country_id, country_name
 from employees 
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
 where 
    substr(hire_date,1,2)='05' and city='South San Francisco'
    and state_province='California';
    
---------------------------------------------------
-- ��������