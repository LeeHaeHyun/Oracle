/*****************/
���ϸ� :  Or05String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸�
��ȯ�ϴ� �� ���ڿ��� �����ϴ� �Լ� 
/*****************/
-- HR ����

/*
concat(���ڿ�1, ���ڿ�2) 
    : ���ڿ�1�� ���ڿ�2�� �����ؼ� ����ϴ� �Լ�
    ���� 1 : concat('���ڿ�1', '���ڿ�2)
    ���� 2 : '���ڿ�1' || '���ڿ�2'
*/
select concat('Good ', 'morning') as "��ħ �λ�" from dual;
select 'Good ' || 'morning' from dual;


select 'Oracle ' ||'21C '||'Good..!!' from dual;
-- => �� sql���� concat()���� �����ϸ� ������ ����.(���� �����ϴ�)
select concat(concat('Oracle ' , '21C '), 'Good..!!') from dual;

/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�
    ��³���: first+last name, �޿�, �μ���ȣ
*/
-- Step1 : �̸��� �����ؼ� ��������� ���Ⱑ �ȵǾ� �������� ��������
select
    concat(first_name, last_name), salary, department_id
 from employees;
 
-- Step2 : �����̽��� �߰��ϱ� ���� concat()�� �ϳ� �� ����Ѵ�.
 select
    concat(concat(first_name,' '), last_name), salary, department_id
 from employees;
 
 -- Step3 : 2���� �Լ��� ����ϴ� �ͺ��� ||�� �̿��ϸ� ������ 
 -- ǥ���� �� �ִ�. ���� �÷����� as�� �̿��ؼ� ��Ī�� �ο��Ѵ�.
select first_name|| ' ' ||last_name as full_name, salary, department_id 
    from employees;
    
/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�.
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����.
    - ���鹮�� ������ ������ ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
    - ���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù��° ���ڸ� 
    �빮�ڷ� ��ȯ�Ѵ�
*/
-- hi, hello�� ù���ڸ� �빮�ڷ� ����(���� ������ ���ο� ���ڷ� ���)
select initcap('hi hello �ȳ�') from dual;

-- g, b, m�� �빮�ڷ� ����(������ ������ ���ο� ���ڷ� ���)
select initcap('good/bad morning') from dual;

-- n, g, b�� �빮�ڷ� ����(6�� ���ڶ� say�� ������� �ʴ´�.
-- Ư������ ������ ���ο� ���ڷ� ���)
select initcap('naver9say*good��bye') from dual;

/*
�ó�����] ������̺��� first_name�� john�� ����� ã�Ƽ� �����Ͻÿ�
*/
-- �̿� ���� �����ϸ� ����� ������� �ʽ��ϴ�. (�����ʹ� ��ҹ��� ����)
select * from employees where first_name = 'john';

-- ���� �Ʒ��� ���� �Լ��� ����ϰų� �빮�ڰ� ���Ե� �̸��� ���
-- �Ѵ� 3���� �˻� ����� ����ȴ�.
select * from employees where first_name = initcap('john');
select * from employees where first_name = 'John';

/*
��ҹ��� �����ϱ�
lower() : �ҹ��ڷ� �����Ѵ�
upper() : �빮�ڷ� ������
*/
select lower('GOOD'), upper('bad') from dual;

-- ���� ���� john�� �˻��ϱ� ���� ������ ���� Ȱ���� �� �ִ�.
-- �÷� ��ü�� �빮�� Ȥ�� �ҹ��ڷ� ������ �� �����Ѵ�. 
-- first_name ��Ʈ ��ü�� �ҹ��� �� �빮�ڷ� �ٲ۴� �׷��� �˻��� ��
select * from employees where lower(first_name) = 'john';
select * from employees where upper(first_name) = 'JOHN';

/*
lpad() : rpad()
    : ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�� �� ����Ѵ�.
    ����] lpad('���ڿ�, '��ü�ڸ���', 'ä�﹮�ڿ�')
        -> ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ä���ִ� �Լ�
        rpad()�� �������� ä����
*/
-- ��°�� : good, ###good, good###, ---good(����3���� ������ ���)
select 
    'good', lpad('good', 7, '#'), rpad('good', 7, '#'), lpad('good', 7)
 from dual;

-- �̸� ��ü�� 12�ڷ� �����Ͽ� �̸��� ������ ������ �κ��� *�� ä���. 
select rpad(first_name, 12, '*') from employees;
select rpad(first_name, 12)||rpad(last_name, 12) as fullname from employees;

/*
�ó�����] ������̺� first_name�� ù���ڸ� ������ ������ �κ���
    *�� ����ŷ ó���ϴ� �������� �ۼ��Ͻÿ� 
*/
-- substr(���ڿ� Ȥ�� �÷�, ���� �ε���, ����) : ���� �ε������� ���̸�ŭ
-- �߶󳽴�.
select substr('abcdefg', 1,1) from dual;
select substr(first_name,1,1) from employees;

-- ���ڿ��� ���̸� 10���� �����Ͽ� ���� �κ��� *�� ä���.
-- ��, �̸��� ������ ������ 5�� *�� ä���ش�.
select rpad('Ellen' , 10, '*') from dual;

-- length(���ڿ� Ȥ�� �÷���) : �ش� ���ڿ��� ���̸� ��ȯ�Ѵ�.
select
    first_name, 
    rpad(substr(first_name,1,1), length(first_name), '*') "����ŷ"
 from employees;

/*
trim() : ������ �����Ҷ� ����Ѵ�.
    ����] trim[leading | trailing | both] ������ ���� from �÷���)
    - leading : ���ʿ��� ������
    - trailing : �����ʿ��� ������
    - both : ���ʿ��� ������, �������� ������ both�� �⺻����
    [����1] ���� ���� ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� ����
    [����2] ���ڸ� ������ �� �ְ� ���ڿ��� ������ �� ����(�����߻�)
*/
select 
    '���������׽�Ʈ' as trim1,
    trim(' ���������׽�Ʈ ') as trim2, -- ������ ���� ���ŵ�
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') trim3, -- ���ʿ� '��' ���� 
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') trim4, -- both�� �⺻��
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') trim5, -- ������ '��' ����
    trim(trailing'��' from '�ٶ��㰡 ������ ž�ϴ�') trim6 -- ������ '��' ����
 from dual;
-- trim()�� �߰��� ���ڴ� ������ �� ����, ���� ���� ���ڸ� ������ �� �ִ�.

-- trim()�� '�ٶ���' ���ڿ��� ������ �� ���� ������ �߻��մϴ�.
select 
    trim('�ٶ���' from '�ٶ��㰡 ������ Ÿ�ٰ� ���������TT') "TrimError"
 from dual;

/*
ltrim(), rtrim() : Left, Right
 : ���� Ȥ�� ���� ���ڿ��� ������ �� ����Ѵ�.
  �� Trim�� ���ڿ��� ������ �� ������, LTrim, RTim�� ���ڿ����� ������ �� �ִ�.
*/
select 
    -- ���� ������ ���ŵȴ�. 
    ltrim(' ������������ ') ltrim,
    -- �� ��� ������ �����̽��� ���Ե� ���ڿ��̹Ƿ� �������� �ʴ´�.
    ltrim(' ������������ ', '����') ltrim2,
    -- ���⼭�� '����'�̶�� ���ڿ��� �����ȴ�.
    ltrim('������������ ', '����') ltrim3,
    -- ������ ���ڿ��� ���ŵȴ�.
    rtrim('������������', '����') rtrim1,
    -- ���ڿ� �߰��� ���ŵ��� �ʴ´�.
    rtrim('������������ ', '����') rtrim2
 from dual;
 
 /*
 substr() : ���ڿ����� ���� �ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�), �����ε���, ����) 
    
    ����1] ����Ŭ�� �ε����� 1���� �����Ѵ�. (0���� �ƴ�)
    ����2] '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3] ���� �ε����� ������ ���� ������ �·� �ε����� �����Ѵ�. 
 */
 select substr('good morning john', 8,4) from dual;
 select substr('good morning john', 8) from dual;
 
 /*
 replace() ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ����Ѵ�.
 ���� �������� ���ڿ��� ��ġ�Ѵٸ�, ���ڿ��� �����Ǵ� ����� �ȴ�.
 ����] repace(���ڿ� or ���ڿ�, '������ ����� ����', '������ ����')
 
 ��  trim(), ltrim(), rtrim() �Լ������ ���� replace() 
 �Լ� �ϳ��� ��ü�� �� �־� trim()�� ���� replace()�� �ξ� �� ���󵵰� ����.
 
 */
-- ���ڿ��� �����Ѵ�
select replace('good morning john', 'morning', 'evening') from dual;
-- ���ڿ��� �����Ѵ�
select replace('good morning john', 'john', '') from dual;
-- trim�� ������ ���鸸 ���ŵȴ�.
select trim(' good morning john ') from dual;
-- replace�� �¿����� �ƴ϶� �߰��� ���鵵 ������ �� �ִ�.
select replace(' good morning john ', ' ', '') from dual;
 
-- 102�� ����� ���ڵ带 ������� ���ڿ� ������ �غ���
select first_name, last_name,
    ltrim(first_name, 'L') "����L����",
    rtrim(first_name, 'ex') "����ex����",
    replace(last_name, ' ','') "�߰���������",
    replace(last_name, 'De', 'Dea') "�̸�����"
 from employees where employee_id=102;
 
 /*
 instr() : �ش� ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�.
    ����1] instr(�÷���, 'ã������')
        : ���ڿ��� ó������ ���ڸ� ã�´�.
    ����2] instr(�÷���, 'ã������' 'Ž���� ������ �ε���','���° ����')
        : Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ� 
        �������� ������ �� �ִ�.
    * Ž���� ������ �ε����� ������ ��� �������� �������� ã�� �ȴ�.
 */
 -- n�� �߰ߵ� ù��° �ε��� ��ȯ
 select instr('good morning john', 'n') from dual; 
 
 -- �ε��� 1���� Ž���� �����ؼ� 2��° n�� ã�Ƽ� �ε����� ��ȯ
 select instr('good morning john', 'n', 1, 2) from dual;
 
 -- �ε��� 8���� Ž���� �����Ͽ� h�� �߰ߵ� ù��° �ε��� ��ȯ 
 select instr('good morning john', 'h', 8,1) from dual;
 
 