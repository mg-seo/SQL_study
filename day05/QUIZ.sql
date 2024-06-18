--DML QUIZ
--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
--DEPTS���̺��� ������ INSERT �ϼ���.
CREATE TABLE DEPTS AS
SELECT *
FROM DEPARTMENTS;
INSERT INTO DEPTS VALUES (280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES (290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES (300, '����', 301, 1800);
INSERT INTO DEPTS VALUES (310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES (320, '����', 303, 1700);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 1
--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
UPDATE DEPTS SET department_name = 'IT bank' WHERE department_name = 'IT Support'; --dept_id 210
--2. department_id�� 290�� �������� manager_id�� 301�� ����
UPDATE DEPTS SET manager_id = 301 WHERE department_id = 290;
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵� 1800���� �����ϼ���
UPDATE DEPTS SET department_name = 'IT Help',
                 manager_id = 303,
                 location_id = 1800
WHERE department_name = 'IT Helpdesk'; --dept_id 230
--4. �μ���ȣ 290, 300, 310, 320 �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
UPDATE DEPTS SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 2
--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
DELETE FROM DEPTS WHERE department_name = '����';
DELETE FROM DEPTS WHERE department_name = 'NOC';
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 3

--����4
CREATE TABLE DEPTS_COPY AS SELECT * FROM DEPTS;
SELECT * FROM DEPTS_COPY;
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
DELETE FROM DEPTS_COPY WHERE department_id > 200;
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTS_COPY SET manager_id = 100 WHERE manager_id IS NOT NULL;
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS D1
USING DEPARTMENTS D2
ON (D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAME,
               D1.MANAGER_ID = D2.MANAGER_ID,
               D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (D2.DEPARTMENT_ID, D2.DEPARTMENT_NAME, D2.MANAGER_ID, D2.LOCATION_ID);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 4
--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE jobs.min_salary > 6000);
SELECT * FROM JOBS_IT;
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO JOBS_IT J1
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
               J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(J2.JOB_ID, J2.JOB_TITLE, J2.MIN_SALARY, J2.MAX_SALARY);
SELECT * FROM JOBS_IT;
COMMIT; -- COMMIT 5

------------------------------------------------------------------------------------------------
--�������� QUIZ
--����1.
--������ ���� ���̺��� �����ϰ� �����͸� insert�غ�����.
--���̺� ���������� �Ʒ��� �����ϴ�. 
--����) M_NAME �� ���������� 20byte, �ΰ��� ������� ����
--����) M_NUM �� ������ 5�ڸ�, PRIMARY KEY �̸�(mem_memnum_pk) 
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, UNIQUE KEY �̸�:(mem_regdate_uk)
--����) GENDER ���������� 1byte, CHECK���� (M, F)
--����) LOCA ������ 4�ڸ�, FOREIGN KEY ? ���� locations���̺�(location_id) �̸�:(mem_loca_loc_locid_fk)
CREATE TABLE MEM(
    M_NAME VARCHAR2(20) NOT NULL,
    M_NUM NUMBER(5) CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE NOT NULL CONSTRAINT MEM_REGDATE_UK UNIQUE,
    GENDER CHAR(1) CONSTRAINT MEM_GENDER_CK CHECK(GENDER IN ('M', 'F')),
    LOCA NUMBER(4) CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);
DESC MEM;
DROP TABLE MEM;
INSERT INTO MEM VALUES('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO MEM VALUES('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO MEM VALUES('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO MEM VALUES('DDD', 4, SYSDATE, 'M', 2000);
SELECT * FROM MEM;

--����2.
--���� �뿩 �̷� ���̺��� �����Ϸ� �մϴ�.
--���� �뿩 �̷� ���̺���
--�뿩��ȣ(����) PK, ���⵵����ȣ(����), �뿩��(��¥), �ݳ���(��¥), �ݳ�����(Y/N)
--�� �����ϴ�.
--������ ���̺��� ������ ������.
CREATE TABLE BR(
    RENTAL_NUM NUMBER(5) CONSTRAINT BR_RENTAL_NUM_PK PRIMARY KEY,
    BOOK_NUM VARCHAR2(10) NOT NULL CONSTRAINT BR_BOOK_NUM_UK UNIQUE,
    RENTAL_DATE DATE NOT NULL,
    RETURN_DATE DATE,
    RETURN_STATUS CHAR(1) CONSTRAINT BR_RETURN_STATUS_CK CHECK (RETURN_STATUS IN ('Y', 'N'))
);
SELECT * FROM BR;
INSERT INTO BR VALUES(1, 'A101', '2024-05-01', '2024-05-29', 'Y');
