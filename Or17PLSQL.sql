/*****************
���ϸ� :  Or17PLSQL.sql
PL/SQL
����: ����Ŭ���� �����ϴ� ���α׷��� ���
/*****************/
-- HR ����
/*
PL/SQL(procedural language)
    : �Ϲ� ���α׷��� ���� ������ �ִ� ��Ҹ� ��� ������
    ������ DB������ ó���ϱ� ���� ����ȭ�� ����̴�.
*/
/*
- ����1] PL/SQL ������
- ȭ��� ������ ����ϰ� ���� �� on���� �����Ѵ�.
off�϶��� ��µ��� �ʴ´�.
*/
set serveroutput on;
declare -- ����� : �ַ� ������ �����Ѵ�.
    cnt number; -- ���� Ÿ���� ������ ������.
begin -- ����� : begin~end�� ���̿� ������ ���� ������ ����Ѵ�.
    cnt := 10; -- ������ 10�� �����Ѵ�. ���Կ����ڴ� :=�� ����Ѵ�.
    cnt := cnt + 1;
    dbms_output.put_line(cnt); --java�� println()�� �����ϴ�.
end;
/

/*
    PL/SQL������ ������ /�� �ٿ��� �ϴµ�, ���� ������
    ȣ��Ʈ ȯ������ ���������� ���Ѵ�. �� PL/SQL ������ ����
    �ʿ��ϴ�.
    ȣ��Ʈ ȯ���̶� �������� �Է��ϱ� ���� SQL> ���¸� ���Ѵ�.
*/

-- ����2] �Ϲݺ��� �� into

/*
�ó�����] ��� ���̺����� �����ȣ�� 120�� ����� �̸���
����ó�� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�
*/

select * from employees where employee_id=120;

select concat(first_name||' ', last_name), phone_number
from employees where employee_id=120);

declare
    /*
    ����ο��� ������ ������ ���� ���̺� �����ÿ� �����ϰ�
    �����մϴ�.
    => ������ �ڷ��� (ũ��)
    ��, ������ ������ �÷��� Ÿ�԰� ũ�⸦ �����Ͽ� 
    �������ִ� ���� ����.
    �Ʒ� '�̸�'�� ��� �ΰ��� �÷��� ������ �����̹Ƿ�
    ���� �� �˳��� ũ��� �������ִ� ���� ����.
    */
    empName varchar2(50);
    empPhone varchar2(30);
begin
    /*
    ����� : select������ ������ ����� ����ο���
    ������ ������ 1:1�� �����Ͽ� ���� �����Ѵ�.
    */
    select
        concat(concat(first_name,' '), last_name),
        phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
    
    dbms_output.put_line(empName ||' '|| empPhone);
end;
/

-- ����3] ��������1 (�ϳ��� �÷� ����)
/*
    �������� : Ư�� ���̺��� �÷��� �����ϴ� �����ν�
    ������ �ڷ����� ũ��� �����ϰ� ������ ����Ѵ�.
    ����] ���̺���, �÷���%type
    => ���̺��� '�ϳ�'�� �÷��� �����Ѵ�.
*/

/*
�ó�����] �μ���ȣ 10�� ����� �����ȣ, �޿�, �μ���ȣ�� �����ͼ�
    �Ʒ� ������ ������ ȭ��� ����ϴ� pl/sql���� �ۼ��Ͻÿ�.
    ��, ������ �������̺��� �ڷ����� �����ϴ� '��������'�� �����Ͻÿ�.
*/
-- �ó������� ���ǿ� �´� select���� �ۼ��Ͻÿ�.
select employee_id, salary, department_id from employees
    where department_id=10;

declare
    -- ������̺��� Ư�� �÷��� Ÿ�԰� ũ�⸦ �״�� �����ϴ� ������ �����Ѵ�.
    empNo employees.employee_id%type; --Number(6,0) --employee_id�� Ÿ���� ���ڴ�
    empSal employees.salary%type; --Number(8,2)
    deptId employees.department_id%type; --Number(4,0)�� �����ϰ� �����
begin
    -- select�� ����� into�� ���� ������ ������ �Ҵ��Ѵ�.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees where department_id=10;
    
    dbms_output.put_line(empNo ||' '|| empSal ||' '|| deptId);
end;
/

-- ����4] ��������2 (��ü�÷��� ����)
/*
�ó�����] �����ȣ�� 100�� ����� ���ڵ带 �����ͼ� emp_row������
��ü �÷��� ������ ȭ�鿡 ���� ������ ����Ͻÿ�.
��, emp_row�� ������̺��� ��ü �÷��� ������ �� �ִ� ���������� �����ؾ��Ѵ�.
������� : �����ȣ, �̸�, �̸���, �޿�
*/
declare
    /*
    ������̺� ��ü �÷��� �����ϴ� ���������� �����Ѵ�.
    �� �� ���̺��� �ڿ� %rowtype�� �ٿ� �����Ѵ�.(��ü�� ���� *)
    */
    emp_row employees%rowtype;
begin
/*
    ���ϵ�ī�� *�� ���� ���� ��ü�÷��� ���� emp_row��
    �Ѳ����� �����Ѵ�. 
*/
    select * into emp_row
    from employees where employee_id=100;
    /*
    emp_row���� ��ü �÷��� ������ ����ǹǷ� ��½� 
    ������.�÷��� ���·� ����ؾ� �Ѵ�.
    */
    dbms_output.put_line(emp_row.employee_id ||' '||
                    emp_row.first_name||' '||
                    emp_row.email ||' '||
                    emp_row.salary);
end;
/

-- ����5] ���պ���
/*
���պ���
    : class�� �����ϵ� �ʿ��� �ڷ����� ���� �ϳ��� �ڷ����� ���� ��
    �����ϴ� ������ ���Ѵ�.
    ����]
        type ���պ����ڷ��� is record(
            �÷���1 �ڷ��� (ũ��),
            �÷���2 ���̺���.�÷���%type
        );
    �տ��� ������ �ڷ����� ������� ������ �����Ѵ�.
    ���պ��� �ڷ����� ���鶧�� �Ϲݺ����� �������� 2������ �����ؼ�
    ����� �� �ִ�.
*/

/*
�ó�����] �����ȣ, �̸�(first_name+last_name), ���������� ������ �� �ִ� 
���պ����� ������ ��, 100�� ����� ������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/
--���ǿ� �´� ������ �ۼ�
select employee_id, first_name||' '||last_name, job_id
from employees where employee_id=100;

declare
    -- 3���� ���� ������ �� �ִ� ���պ��� �ڷ����� ����
    type emp_3type is record(
    /*��� ���̺��� �÷��� �����ϴ� ���������� ����*/
        emp_id employees.employee_id%type,
        -- ���Ӱ� ������ ����
        emp_name varchar2(50),
        emp_job employees.job_id%type
    );
    /*�տ��� ������ ���պ��� �ڷ����� ���� ������
    ���պ����� 3���� ���� ������ �� �ִ�;*/
    record3 emp_3type;
begin
    -- select ������ ������ 3���� ���� ���պ����� �����Ѵ�.
    -- ���ڵ�3(�޼ҵ�)�� �θ���.
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
    -- ��½� ���պ��� �ڷ����� �÷��� �����Ѵ�.
    dbms_output.put_line(record3.emp_id||' '||record3.emp_name||' '||
                        record3.emp_job);
end;
/
/*
[����] �Ʒ� ������ ���� PL/SQL���� �ۼ��Ͻÿ�.
1.���պ�������
- �������̺� : employees
- ���պ����ڷ����� �̸� : empTypes
        ���1 : emp_id -> �����ȣ
        ���2 : emp_name -> �������ü�̸�(�̸�+��)
        ���3 : emp_salary -> �޿�
        ���4 : emp_percent -> ���ʽ���
������ ������ �ڷ����� �̿��Ͽ� ���պ��� rec2�� ������ �����ȣ 100���� ������ �Ҵ��Ѵ�.
2.1�� ������ ����Ѵ�.
3.�� ������ �Ϸ����� ġȯ�����ڸ� ����Ͽ� �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ������ ����Ҽ��ֵ��� �����Ͻÿ�.[����]
*/
select
    employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
from employees where employee_id=100;

set serveroutput on; -- ����� ���
declare
    -- 4���� ���� ������ �� �ִ� ���պ��� �ڷ����� ����
    type emp_4type is record(
    /*��� ���̺��� �÷��� �����ϴ� ���������� ����*/
        emp_id employees.employee_id%type,
        -- ���Ӱ� ������ ����
        emp_name varchar2(50),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    /*�տ��� ������ ���պ��� �ڷ����� ���� ������
    ���պ����� 4���� ���� ������ �� �ִ�;*/
    rec2 emp_4type;
begin
    -- select ������ ������ 4���� ���� ���պ����� �����Ѵ�.
    -- rec2(�޼ҵ�)�� �θ���.
    select employee_id, first_name||' '||last_name, salary, 
        nvl(commission_pct,0) into rec2
    from employees where employee_id=100;
    -- ��½� ���պ��� �ڷ����� �÷��� �����Ѵ�
    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ���');
    dbms_output.put_line(rec2.emp_id||' '||rec2.emp_name||' '||
                        rec2.emp_salary||' '||rec2.emp_percent);
end;
/

/*
ġȯ������ : PL/SQL���� ����ڷκ��� �����͸� �Է¹�����
����ϴ� �����ڷ� ���� �տ� &�� �ٿ��ָ� �ȴ�. ����� �Է�â�� ���
*/

-- �տ��� �ۼ��� PL/SQL�� ġȯ�����ڸ� �����Ͽ� �����غ���.
declare
    -- 4���� ���� ������ �� �ִ� ���պ��� �ڷ����� ����
    type emp_4type is record(
    /*��� ���̺��� �÷��� �����ϴ� ���������� ����*/
        emp_id employees.employee_id%type,
        -- ���Ӱ� ������ ����
        emp_name varchar2(50),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    /*�տ��� ������ ���պ��� �ڷ����� ���� ������
    ���պ����� 4���� ���� ������ �� �ִ�;*/
    rec2 emp_4type;
    -- ġȯ �����ڸ� ���� �Է¹��� ���� �Ҵ��Ͽ� ������ �����Ѵ�.
    inputNum number(3);
begin
    -- �Է¹��� �����ȣ�� ������ �����Ѵ�.
    select employee_id, first_name||' '||last_name, salary, 
        nvl(commission_pct,0) into rec2
    from employees where employee_id=&inputNum;
    -- ��½� ���պ��� �ڷ����� �÷��� �����Ѵ�
    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ���');
    dbms_output.put_line(rec2.emp_id||' '||rec2.emp_name||' '||
                        rec2.emp_salary||' '||rec2.emp_percent);
end;
/
/*
���ε� ���� 
    : ȣ��Ʈȯ�濡�� ����� �����ν� �� PL/SQL �����̴�.
    ȣ��Ʈȯ���̶� PL/SQL�� ������ ������ ������ �κ��� ���Ѵ�.
    �ܼ�(CMD)������ SQL > ����������Ʈ�� �ִ� ���¸� ���Ѵ�.
    
    ����]
        var ������ �ڷ���;
        Ȥ��
        variable ������ �ڷ���;
*/
set serveroutput on;
-- ȣ��Ʈȯ�濡�� ���ε庯�� ����
var return_var number;
-- PL/SQL �ۼ�
declare
    -- ����ο��� �̿Ͱ��� �ƹ������� ���� ���� �ִ�.
begin
    -- ���ε庯���� �Ϲݺ������� ������ ���� :(�ݷ�)�� �߰��ؾ��Ѵ�.
    :return_var := 999;
    dbms_output.put_line(:return_var);
end;
/
-- ȣ��Ʈȯ�濡���� ��½ÿ��� print�� ����Ѵ�.
-- ���� ����� �ȵȴٸ� cmd���� Ȯ���غ��� ���������� ��µȴ�.
print return_var;

-- ����7] if�� �⺻
/*
�ó�����] ������ ����� ���ڰ� Ȧ�� or ¦������ �Ǵ��ϴ�
PL/SQL�� �ۼ��Ͻÿ�.
*/
-- if�� : Ȧ���� ¦���� �Ǵ��ϴ� if�� �ۼ�
declare
    -- ����ο��� ����Ÿ���� ������ ����
    num number;
begin
    -- 10�� �Ҵ��� �� ¦������ �Ǵ��Ѵ�.
    num := 10;
    -- mod(����, ����) : ������ ������ ���� �������� ��ȯ�ϴ� �Լ�
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

-- ����] �� ������ ġ�ѿ����ڸ� ���� ���ڸ� �Է¹��� �� �ֵ��� �����Ͻÿ�
declare
    -- ����ο��� ����Ÿ���� ������ ����
    num number;
begin
    -- �Է��� �޴´�.
    num := &num;
    -- mod(����, ����) : ������ ������ ���� �������� ��ȯ�ϴ� �Լ�
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

-- ����8] if ~ else if��
/*
�ó�����] �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ��μ�����
�ٹ��ϴ����� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. ��, if~elsif���� ����Ͽ�
�����Ͻÿ�.
*/
declare
    -- ġȯ�����ڸ� ���� �����ȣ�� �Է¹���
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    -- �μ����� ����� ���ÿ� �ʱ�ȭ�Ѵ�. ��ġ�ϴ� ������ ���� ���
    -- �ʱⰪ���� ��µȴ�.
    dept_name varchar2(30) := '�μ���������';
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id; -- �Է¹��� �����ȣ�� ������ ����
    
    /*
    �������� ������ ����� ��� java�� ���� else if�� ������� �ʰ�
    elseif�� ����ؾ� �Ѵ�. ���� �߰�ȣ ��� then�� end if;��
    ���ȴ�.
    */
    
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';   
    elsif emp_dept = 80 then
        dept_name := 'Sales';  
    elsif emp_dept = 90 then
        dept_name := 'Executive'; 
    elsif emp_dept = 100 then
        dept_name := 'Finance'; 
    end if;
    
    dbms_output.put_line('�����ȣ'|| emp_id ||'�� ����');
    dbms_output.put_line('�̸�:'|| emp_name ||', �μ���ȣ:'|| emp_dept||', �μ���:'|| dept_name );
end;
/

/*
case�� : java�� switch���� ����� ���ǹ�
    ����]
        case ����
            when ��1 then '�Ҵ簪1'
            when ��2 then '�Ҵ簪2'
            ... ��N
        end;
*/
/*
    �ó�����] �տ��� if~elsif�� �ۼ��� PL/SQL���� case~when������ �����Ͻÿ�.
*/
declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar(30) := '�μ���������';
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    /*
    case-when���� if���� �ٸ� ���� �Ҵ��� ������
    ���� ������ �� ���峻���� ������ �Ǵ��Ͽ� �ϳ��� ����
    �Ҵ��ϴ� ����̴�. ���� ������ �ߺ����� ������� �ʾƵ� �ȴ�.
    */
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Sales'
            when 90 then 'Executive'
            when 100 then 'Finance'
        end;
    dbms_output.put_line('�����ȣ'|| emp_id ||'�� ����');
    dbms_output.put_line('�̸�:'|| emp_name ||', �μ���ȣ:' || emp_dept
            ||', �μ���:'|| dept_name);
end;
/

-----------------------------------------------------
-- ���(�ݺ���)
/*
�ݺ���1 : Basic loop
    Java�� do-while���� ���� ���� üũ���� loop������ ��
    Ż�������� �� ������ �ݺ��Ѵ�. Ż��ÿ��� exit�� ����Ѵ�.
*/
-- ����10] ���(�ݺ��� : base loop)
declare
    num number := 0;
begin
    -- ���� üũ���� ������ �����Ѵ�.
    loop
        --0~10���� ����Ѵ�
        dbms_output.put_line(num);
        --���������� ���մ��Կ����ڰ� �����Ƿ� �Ϲ����� �������
        --������ �������Ѿ� �Ѵ�.
        num := num +1;
        -- num1 10�� �ʰ��ϸ� loop���� Ż���Ѵ�.
        -- esitms java�� break;�� ������ ������ �Ѵ�.
        exit when (num>10);
    end loop;
end;
/

/*
�ó�����] Basic loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�.
*/
declare
    -- �ݺ������� ������Ų ���� 
    i number := 1;
    -- �������� ������ ����
    sumNum number := 0;
    -- ���������� sum�� ����� �� ����. �����(�׷��Լ�)�̹Ƿ� 
    -- ������ �߻��Ѵ�.
begin
    loop
        -- �����ϴ� ���� i�� �����ؼ� ���Ѵ�.
        sumNum := sumNum + i;
        -- ���� i�� 1�� �����Ѵ�.
        i := i + 1;
        -- 10�� �ʰ��ϸ� Ż���Ѵ�.
        exit when (i>10);
    end loop;
    dbms_output.put_line('1~10������ ����:'|| sumNum);
end;
/

/*
�ݺ���2 : while��
    Basic loop�ʹ� �ٸ��� ������ ���� Ȯ���� �� �����Ѵ�.
    ��, ���ǿ� ���� �ʴ´ٸ� �ѹ��� ������� ���� ���� �ִ�.
    �ݺ��� ������ �����Ƿ� Ư���� ��찡 �ƴ϶�� exit�� 
    ������� �ʾƵ� �ȴ�.
*/
-- ����12] ���(�ݺ��� : while)
declare
    num1 number := 0;
begin
    -- while�� ������ ������ Ȯ���Ѵ�.
    while num1<11 loop
        -- 0~10���� ����Ѵ�.
        dbms_output.put_line('�̹����ڴ�:'|| num1);
        num1 := num1 + 1;
        end loop;
end;
/

-- ����13] ���(�ݺ��� : while) 
/*
�ó�����] while loop������ ������ ���� ����� ����Ͻÿ�.
*
**
***
****
*****
*/
declare
    starStr varchar2(100);
    -- �ݺ��� ������ �����Ѵ�.
    i number := 1;
    j number := 1;
begin
    while i <= 5 loop
        while j <=5 loop
            starStr := starStr || '*';
            exit when (j<=i);
            j := j+1;
        end loop;
        dbms_output.put_line(starStr);
        i := i + 1;
        j := 1;
    end loop;
end;
/
-- ����14] ���(�ݺ��� : while) 
-- �ó�����] while loop������ 1���� 10������ ������ ���� 
-- ���ϴ� ���α׷��� �ۼ��Ͻÿ�. 
declare
    i number := 1;
    sumNum number := 0;
begin
    while i<= 10 loop
      sumNum := sumNum + i;
        i := i + 1;
    end loop;
    dbms_output.put_line('1~10������ ����:'|| sumNum);
end;
/*
-- ����15] ���(�ݺ��� : for)
    : �ݺ��� Ƚ���� �����Ͽ� ����� �� �ִ� �ݺ���
    */
    
declare
    -- ������ ������ ����.
begin
    -- �ݺ��� ���� ������ ������ ������� for������ ����� �� �ִ�
    for num2 in 0 .. 10 loop
        dbms_output.put_line('for��¯�ε�:'|| num2);
    end loop;
end;
/

begin
    for num3 in reverse 0.. 10 loop
        dbms_output.put_line('�Ųٷ� for�� ¯�ε�:'|| num3);
    end loop;
end;
/    
-- �ʿ���� ����� declear���� ������ �� �ִ�.

-- ����16] ���(�ݺ��� : for) 
-- ��������] for loop������ �������� ����ϴ� ���α׷��� �ۼ��Ͻÿ�
begin -- �ٹٲ� �ִ� 
    for dan in 2...9 loop
        dbms_output.put.line(dan||'��');
        for su in 1...9 loop
            dbms_output.put.line(dan||'*'||su||'='||(dan*su));
        end loop;
     end loop;
end;
/

declare -- �ٹٲ� ���� ����
    guguStr varchar2(1000);
begin
    for dan in 2..9 loop
        for su in 1..9 loop
            guguStr := guguStr || dan||'*'||su||'='||(dan*su) ||' ';
            end loop;
            dbms_output.put_line(guguStr);
            guguStr := '';
        end loop;
    end;
    /
/*
Ŀ��(Cursor)
    : select ���忡 ���� �������� ��ȯ�Ǵ� ���
    �� �࿡ �����ϱ� ���� ��ü
    ���� ���]
        Select ������, �� into���� ���� ���·� �����
    Open Cursor
        : ������ �����϶�� �ǹ�, �� Open�Ҷ� 
        Cursor ����� select ������ ����Ǿ�
        ������� ��� �ȴ�. Cursor�� �� ������� ù��° �࿡
        ��ġ�ϰ� �ȴ�.
    Fetch~into~
        : ����¿� �ϳ��� ���� �о���̴� �۾����� �������
        ����(Fetch) �Ŀ� Cursor�� �ٸ� ������ �̵��Ѵ�.
    Close Cursor
        : Ŀ�� �ݱ�� ������� �ڿ��� �ݳ��Ѵ�.
        select ������ ��� ó���� �� Cursor�� �ݾ��ش�.
        
    Cursor�� �Ӽ�
        %Found : ���� �ֱٿ� ����(Fetch)�� ���� Return�ϸ�
        true, �ƴϸ� false�� ��ȯ
        &Notfound : %Found�� �ݴ��� ���� ��ȯ�Ѵ�.
        %RowCount : ���ݱ��� Return�� ���� ������ ��ȯ�Ѵ�.
    */
-- �ó�����] �μ����̺��� ���ڵ带 Cursor�� ���� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
declare
        --�μ����̺��� ��ü Į���� �����ϴ� �������� ����
        v_dept departments%rowtype;
        /*
        Ŀ�� ����: �μ����̺��� ��� ���ڵ带 ��ȸ�ϴ� select������
        into���� ���� ���·� ����Ѵ�. ������ ������
        cur1�� ����ȴ�.
        */
        cursor cur1 is
            select
                department_id, department_name, location_id
            from departments;
begin
    /*
    �ش� �������� �����ؼ� �����(ResultSet)�� ������ �´�.
    ������̶� ����(����)���� ������ �� ��ȯ�Ǵ� ���ڵ��� ����� ���Ѵ�.
    */
    open cur1;

    loop
        fetch cur1 into
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
            
        exit when cur1%notfound;
        
        dbms_output.put_line(v_dept.department_id||' '||
                            v_dept.department_name||' '||
                            v_dept.location_id);
    end loop;
    close cur1;
end;
/

/*
�ó�����] Cursor�� ����Ͽ� ������̺����� Ŀ�̼��� null�� �ƴ� ����� �����ȣ, �̸�, �޿��� ����Ͻÿ�. 
��½ÿ��� �̸��� ������������ �����Ͻÿ�.
*/
-- ������ ���ǿ� �´� ������ �ۼ�
select * from employees where commission_pct is not null
order by last_name asc;

declare
    -- �ۼ��� ������ ���� Ŀ���� �����Ѵ�.
    cursor curEmp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
    -- ������̺��� ��ü�÷��� �����ϴ� �������� ����
    varEmp employees%rowType;
begin
    -- Ŀ���� �����Ͽ� �������� �����Ѵ�.
    open curEmp;
    -- Basic loop���� ���� Ŀ���� ����� ������� �����Ѵ�.
    loop
        fetch curEmp
            into varEmp.employee_id, varEmp.last_name, varEmp.salary;
        -- ������ ������� ������ loop���� Ż���Ѵ�.
        exit when curEmp%notFound;
        dbms_output.put_line(varEmp.employee_id ||' '||varEmp.last_name||' '||varEmp.salary);
        
    end loop;
    --���ϱ� ���� ���
    dbms_output.put_line('��������ǰ���:'|| curEmp%rowcount);
    -- Ŀ���� �ݾ��ش�.
    close curEmp;
end;
/

/*
�÷���(�迭)
    : �Ϲ� ���α׹� ���� ����ϴ� �迭Ÿ���� PL/SQL������ ���̺�Ÿ��
    �̶�� �Ѵ�. 1,2���� �迭�� �����غ��� ���̺�(ǥ)�� ���� �����̱� �����̴�.
����
    - �����迭
    - Varray
    - ��ø���̺�
1. �����迭(Associativ Array) 
    : key�� Value�� �ѽ����� ������ �÷������� java�� �ؽøʰ� ���� �����̴�.
    key : �ڷ����� �ַ� ���ڸ� ����Ѵ�. Binary_integer, pls_integer�� �ַ� 
    ����ϴµ� number Ÿ�Ժ��� ũ��� ������, ������꿡 ���� Ư¡�� 
    ������.
    Value : �������� �ַ� ����ϰ� varchar2�� ���� �ȴ�.
    ����] Type �����迭�ڷ��� Is 
            Table of ���� Ÿ��
            Index by Ű�� Ÿ��;
*/

/*
�ó�����] ������ ���ǿ� �´� �����迭�� ������ �� ���� �Ҵ��Ͻÿ�.
    �����迭 �ڷ��� �� : avType, �����ڷ���:������, Ű���ڷ���:������
    key : girl, boy
    value : Ʈ���̽�, ��ź�ҳ��
    ������ : var_array
*/
-- ȭ����� ������ ����ϰ� ������ on���� �����Ѵ�.]
-- off�϶��� ��µ��� �ʴ´�.
set serveroutput on;
-- PL/SQL �ۼ�
declare
    -- ���� �迭 �ڷ��� �ۼ�
    Type avType Is
        Table Of varchar2(30) -- value(��)�� �ڷ��� ����
        Index By varchar2(10); -- key(Ű,�ε���)�� �ڷ��� ����
    -- �����迭 Ÿ���� ���� ����
    var_array avType;
begin
    -- ���� �迭 �� �Ҵ�
    var_array('girl') := 'Ʈ���̽�';
    var_array('boy') := '��ź�ҳ��';
    -- ���
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/

/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� 
�����迭�� �����Ͻÿ�.
key�� ����, value�� full_name ���� �����Ͻÿ�.
*/
-- 100�� �μ��� �ٹ��ϴ� ������� : 6��
select * from employees where department_id=100;

-- Full name�� ����ϱ� ���� ������ �ۼ�
select first_name||' '||last_name
    from employees where department_id=100;

-- ������ ������ ���� �������� 
-- �ټ����� ����Ǿ����Ƿ� Cursor�� ����Ѵ�
declare
    -- �������� ���� Ŀ���� �����Ѵ�.
    cursor emp_cur is
    select first_name||' '||last_name from employees
    where department_id=100;
    -- �����迭 �ڷ��� ����(key: ������, value: ������)
    Type nameAvType Is
        Table Of varchar2(30)
        Index By binary_integer;
    -- �ڷ����� ������� ������ �����Ѵ�.
    names_arr nameAvType;
    -- ����� �̸��� �ε����� ����� ���� ����
    fname varchar2(50);
    idx number := 1;
begin
    /*
    Ŀ���� �����Ͽ� �������� ������ �� ���� �������
    ������ŭ �ݺ��Ͽ� ������� �����Ѵ�.
    */
    open emp_cur;
    loop
        fetch emp_cur into fname;
        -- ���̻� ������ ������ ������ loop�� Ż���Ѵ�.
        exit when emp_cur%NotFound;
        -- �����迭 ������ ����̸��� �Է��Ѵ�.
        names_arr(idx) := fname;
        -- Ű�� ���� �ε����� ������Ų��.
        idx := idx + 1;
    end loop;
    close emp_cur;
    
    -- �����迭.count : �����迭�� ����� ������ ������ ��ȯ�Ѵ�.
    for i in 1 .. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/
/*
 ����21] VArray(Variable Array)
 �������̸� ���� �迭�ν� �Ϲ� ���α׷��� ���� 
 ����ϴ� �迭�� �����ϴ�. ũ�⿡ ������ �־ �����Ҷ�
 ũ��(������ ����)�� �����ϸ� �̺��� ū �迭�� ���������.
    ����] Type �迭Ÿ�Ը� Is
            Array(�迭ũ��) of ���� Ÿ��;
*/
declare
    -- VArray Ÿ�Լ��� : ũ��� 5, ������ �����ʹ� ���������� �����Ѵ�.
    type vaType is
        array(5) of varchar2(20);
    -- VArray�� �迭���� ����
    v_arr vaType;
    -- �ε����� ����� �������� �� �ʱ�ȭ
    cnt number := 0;
begin
    -- �����ڸ� ���� ���� �ʱ�ȭ. �� 5���� 3���� �Ҵ�
    v_arr := vaType('First','Second','Third','','');
    
    -- Basic �������� ���� �迭�� ���Ҹ� ����Ѵ�.
    --(* �ε����� 1���� �����Ѵ�)
    loop
        cnt := cnt + 1;
        -- Ż�������� where��� if�� ����� ���� �ִ�.
        if cnt>5 then
            exit;
        end if;
        -- �迭ó�� �ε����� ���� ����Ѵ�.
        dbms_output.put_line(v_arr(cnt));
    end loop;
    
    -- �迭�� ���� ���Ҵ�
    v_arr(3) := '�츮��';
    v_arr(4) := 'JAVA';
    v_arr(5) := '�����ڴ�';
    
    for i in 1 .. 5 loop
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/

-- ����22]  VArray(Variable Array)
/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� 
�����迭�� �����Ͻÿ�.     
key�� ����, value�� full_name ���� �����Ͻÿ�.
*/
-- 6���� ���ڵ尡 ����ȴ�.
select * from employees where department_id=100;

declare
    -- VArray�ڷ��� ����. �迭�� ������ ���� ������̵� �÷��� �����Ͽ�
    -- �����Ѵ�.
    type vaType1 is
        array(6) of employees.employee_id%Type;
    -- �迭 ���� ���� �� �����ڸ� ���� �ʱ�ȭ�� �����Ѵ�.
    va_one vaType1 := vaType1('','','','','','');
    cnt number := 1;
begin
/*
Java�� ������ for���� ����ϰ� ������ ����� ������ŭ �ڵ����� �ݺ��ϴ�
���·� ����Ѵ�. select���� employee_id�� ���� i�� �Ҵ�ǰ� �̸� ����
������ �� �ִ�.
*/
    for i in (select employee_id from employees
                        where department_id=100) loop
        -- ������ ������(�����ȣ)�� �迭�� ������� �����Ѵ�.
        va_one(cnt) := i.employee_id;
        cnt := cnt + 1;
    end loop;
    
    -- �迭�� ũ�⸸ŭ �ݺ��Ͽ� �� ���Ҹ� �����Ѵ�.
    for j in 1 .. va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/

/*
3. ��ø ���̺�(Nested table)
    : VArray�� ����� ������ �迭�ν� �迭�� ũ�⸦ �������� �����Ƿ�
    �������� �迭�� ũ�Ⱑ �����ȴ�. ���⼭ ���ϴ� ���̺��� �ڷᰡ ����Ǵ�
    ���� ���̺��� �ƴ϶� �÷����� �� ������ �ǹ��Ѵ�.
    ����] Type ��ø���̺� Is 
            table Of ���� Ÿ��;
*/
-- ����23] ��ø���̺�(Nested Table) 
declare
    -- ��ø ���̺��� �ڷ����� ������ �� ���� ����
    type ntType is
        table of varchar2(30);
    nt_array ntType;
begin
    -- �����ڸ� ���� ���� �Ҵ��Ѵ�.�� �� ũ�� 4�� ��ø ���̺��� �����ȴ�.
    nt_array := ntType('ù��°', '�ι�°', '����°','');
    
    -- 4��° �������� ���������� �Ҵ� �� ��µȴ�.
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '�׹�°���Ҵ�';
    dbms_output.put_line(nt_array(4));
    
    -- �����߻�. ÷�ڰ� ������ �Ѿ����ϴ�.(�ڵ����� Ȯ����� �ʴ´�.)
    --nt_array(5) := '�ټ���°��??�Ҵ�??';
    
    -- ũ�⸦ Ȯ�������� �����ڸ� ���� �迭�� ũ�⸦ �������� Ȯ���Ѵ�.
    -- ũ�Ⱑ 7�� ��ø ���̺��� Ȯ��ȴ�.
    nt_array := ntType('1a','2b','3c','4d','5e','6f','7g');
    
    for i in 1 .. 7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

-- ����24] ��ø���̺�(Nested Table)
/*
�ó�����] ��ø���̺��� for���� ���� ������̺��� ��ü ���ڵ��� 
�����ȣ�� �̸��� ����Ͻÿ�.
*/
declare
    type ntType is
        table of employees%rowtype;
    nt_array ntType;
begin
    -- ũ�⸦ �������� ���� ���·� �����ڸ� ����
    -- ��ø ���̺��� �ʱ�ȭ�Ѵ�.
    nt_array := ntType();
   
   /*
   ������̺��� ���ڵ� �� ��ŭ �ݺ��ϸ鼭 ���ڵ带 �ϳ��� ���� rec��
   �����Ѵ�. Ŀ��ó�� �����ϴ� for���� ���·� JAVA�� Ȯ�� for��ó��
   ����� �� �ִ�.
   */ 
    for rec in (select * from employees) loop
        -- ��ø ���̺��� ���κ��� Ȯ���ϸ鼭 null�� �����Ѵ�.
        nt_array.extend;
        -- ������ �ε������� ���� �� ������� ���ڵ带 �����Ѵ�.
        nt_array(nt_array.last) := rec;
    end loop;
    
    -- ��ø ���̺��� ù��° �ε������� ������ �ε������� ����Ѵ�.
    for i in nt_array.first .. nt_array.last loop
        -- �����ȣ�� �̸��� ����Ѵ�.
        dbms_output.put_line(nt_array(i).employee_id||
            '>'||nt_array(i).first_name);
    end loop;
    
end;
/