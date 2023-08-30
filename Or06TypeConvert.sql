/*****************/
���ϸ� :  Or05TypeConvert.sql
����(����) ���� �Լ�
����: ���� �����͸� ó���ϱ� ���� ���� ���� �Լ��� �˾ƺ���.
    ���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸� 
    ������� �Ѵ�.
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
�ó�����] ��� ���̺��� ����� �Ի����� ������ ���� ����� �� �ֵ���
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
    to_char(123, '0000'),
    to_char(123, '9999'), trim(to_char(123, '9999'))
 from dual;