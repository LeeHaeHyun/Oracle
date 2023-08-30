/*****************
���ϸ� :  Or14Sequence&Index.sql
������ & �ε���
����: ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ��
�ο��ϴ� �������� �˻��ӵ��� ����ų �� �ִ� �ε���
/*****************/
-- study ����

/*
������ 
    - ���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�.
    - �������� ���̺� ���� �� ������ ������ �Ѵ�. ��, �������� ���̺��
        ���������� ����ǰ� �����ȴ�.
[������ ���� ����]
create sequence ��������
    [increment by N] -> ����ġ ����
    [Start with N] -> ���۰� ����
    [Minvalue n | NoMinvalue] -> ������ �ּҰ� ���� : ����Ʈ 1
    [Maxvalue n | NoMaxvalue] -> ������ �ִ밪 ���� : ����Ʈ 1.0000E + 28
    [Cycle | No Cycle] -> ����/�ּҰ��� ������ ��� ó������ �ٽ� ��������
    ���θ� ����(Cycle�� �����ϸ� �ִ밪���� ������ �ٽ� ���۰����� ����۵�)
    [Cache | NoCache] -> cache �޸𸮿� ����Ŭ ������ ���������� �Ҵ��ϴ� 
    ���θ� ����
    
���ǻ���
    1. start with �� minvalue���� ���� ���� ������ �� ����. �� start with����
    minvalue�� ���ų� Ŀ�� �մϴ�.
    2. nocycle�� �����ϰ� �������� ��� ���ö� maxvalue�� �������� �ʰ��ϸ�
    ������ �߻��Ѵ�
    3. primary key�� cycle�ɼ��� ���� �����ϸ� �ȵȴ�.
*/
-- ���̺� �����ϱ�
drop table tb_goods;
drop sequence seq_serial_num;

create table tb_goods (
    g_idx number(10) primary key,
    g_name varchar2(30)
);

insert into tb_goods values(1, '�������ݸ�');
-- �Է½���(�������� ����)/-- primary key : �ߺ��ȵ� 1�� ����
insert into tb_goods values(1, '�����');
insert into tb_goods values(2, '�����');

-- ������ ����
create sequence seq_serial_num
    increment by 1 -- ����ġ : 1
    start with 100 -- �ʱⰪ : 100
    minvalue 99 -- �ּҰ� : 99
    maxvalue 110 -- �ִ밪 : 110
    cycle -- �ִ밪 ���޽� ���۰����� ��������� ���� : Yes
    nocache; -- ĳ�ø޸� ��뿩�� : no

-- ������ �������� ������ ������ Ȯ���ϱ�
select * from user_sequences;

/*
������ ���� �� ���� ����� ������ �߻��Ѵ�.
nestval�� ���� ������ �� �����ؾ� �����ؾ� ��µȴ�.
*/
select seq_serical_num.currval from dual;
/*
���� �Է��� ������(�Ϸù�ȣ)�� ��ȯ�Ѵ�
�����Ҷ����� �������� �Ѿ��.
*/
select seq_serical_num.nextval from dual;

insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��1');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��2');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��3');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��4');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��5');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��6');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��7');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��8');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��9');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��10');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��11');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��12');
/*
    �������� cycle �ɼǿ� ���� �ִ밪�� �����ϸ�
    �ٽ� ó������ �Ϸù�ȣ�� �����ǹǷ� ���Ἲ �������ǿ�
    ����ȴ�. �� �⺻Ű�� ����� �������� cycle �ɼ��� ������� �ʾƾ� �Ѵ�.
*/
-- ������ ������ �� �ڸ��� ����.
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��13');

delete tb_goods;
select * from tb_goods;

/*
������ ����
 : start with�� �������� �ʴ´�
*/
alter sequence seq_serial_num
    increment by 10
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
-- ���� �� ������ �������� Ȯ���մϴ�.
select * from user_sequences;
-- ����ġ�� 10���� ����� ���� Ȯ���Ѵ�.
select seq_serial_num.nextval from dual;

-- ������ ����
drop sequence seq_serial_num;
select * from user_sequences;

create sequence seq_serial_num
    start with 1 -- �ʱⰪ : 1
    increment by 1 -- ����ġ : 1
    minvalue 1 -- �ּҰ� : 1
    nomaxvalue -- �ִ�� ������ ���ϴ� ���� ����
    nocycle -- �ִ밪 ���޽� ���۰����� ��������� ���� : no
    nocache;

/*
�ε���(Index)
    - ���� �˻��ӵ��� ����Ű�� ��ü
    - �ε����� �����(create index)�� �ڵ���(primary key, unique)���� 
    ������ �� �ִ�
    - �÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��ϰ� �ȴ�.
    - �� �ε����� ������ ������ ����Ű�� ���� �����̴�.
    - �ε����� �Ʒ��� ���� ��쿡 �����Ѵ�.
        1. where�����̳� join���ǿ� ���� ����ϴ� �÷�
        2. �������� ���� �����ϴ� �÷�
        3. ���� null���� �����ϴ� �÷�
*/
desc tb_goods;
select * from tb_goods;

-- �ε��� �����ϱ�. Ư�� ���̺��� �÷��� �����Ͽ� �����Ѵ�.
create index tb_goods_name_idx on tb_goods (g_name);

-- ���� �÷� Ȯ���ϱ�
select * from user_ind_columns;
/*
Ư�� ���̺��� �ε��� Ȯ��
    : ������ ������ ��Ͻ� �빮�ڷ� �ԷµǹǷ� upper�� ����
    ��ȯ�Լ��� ����ϸ� ���ϴ�
*/
select * from user_ind_columns where table_name=upper('tb_goods');

-- ������ ���� ���ڵ尡 �ִٰ� �������� �� �˻��ӵ��� ����� �ֵ�.
select * from tb_goods where g_name like '%��%';

-- �ε��� ����
drop index tb_goods_name_idx;

-- �ε��� ����: ������ �Ұ����ϴ�. ���� �� �ٽ� �����ؾ� �Ѵ�.











