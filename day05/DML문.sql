-- INSERT
-- ���̺� ������ ������ Ȯ���ϴ� ���
DESC departments;
SELECT * FROM departments;
-- 1ST
INSERT INTO departments VALUES(280, 'DEVELOPER', NULL, 1700);
-- DML���� Ʈ�������� �׻� ��ϵǴµ�, ROLLBACK���� �ǵ��� �� ����
ROLLBACK;
-- 2ND
INSERT INTO departments(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);

-- INSERT  ������ ���������� �ȴ�(���ϰ�)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES((SELECT MAX(DEPARTMENT_ID) + 10 FROM DEPARTMENTS), 'DEVELOPER');
-- INSERT ������ ��������(���� ��)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ���̺� ���� ����
SELECT * FROM EMPS;
INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');
DESC EMPS;
COMMIT; -- Ʈ�������� �ݿ���

---------------------------------------------------------------------------------------
-- UPDATE : SELECT�� �ش簪�� ������ ������ Ȯ���ϰ�, ������Ʈ�� ��
SELECT * FROM EMPS;
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1 WHERE EMPLOYEE_ID = 148;
ROLLBACK;
UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

-- UPDATE ������ ��������
-- ���ϰ� ��������
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;
-- ������ ��������
UPDATE EMPS
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 140;
-- WHERE ���� ��
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
-----------------------------------------------------------------------------------------
--DELETE ���� : Ʈ�������� �ֱ�������, �����ϱ� ���� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� �� Ȯ���ϴ� ������ ������
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; --KEY�� ���� ����� ���� ����
--DELETE�� ��������
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
ROLLBACK;
-- DELETE���� ���� ����Ǵ� ���� �ƴմϴ�.
-- ���̺��� ��������(FK) ������ ������ �ִٸ�, �������� �ʽ��ϴ�.(�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; -- EMPLOYEES ���� 100�� �����͸� FK�� ����ϰ� �־ ���� �� ����
--------------------------------------------------------------------------------------------
-- MERGE�� : Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT������ �����ϴ� ����
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
MERGE INTO EMPS A -- Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B -- ��ĥ���̺�
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID)
WHEN MATCHED THEN -- ��ġ�ϴ� ���
    UPDATE SET A.SALARY = B.SALARY,
               A.COMMISSION_PCT = B.COMMISSION_PCT,
               A.HIRE_DATE = SYSDATE
WHEN NOT MATCHED THEN -- ��ġ���� �ʴ� ���
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);

SELECT * FROM EMPS;
ROLLBACK;

-- �������� ���� �ٸ����̺��� �������°� �ƴ϶�, ���� ���� ���� �� DUAL�� �� ���� �ֽ��ϴ�
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID = 107) --����
WHEN MATCHED THEN
    UPDATE SET A.SALARY = 10000,
               A.COMMISSION_PCT = 0.1,
               A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (107, 'HONG', 'EXAMPLE', SYSDATE, 'DBA');
SELECT * FROM EMPS;
-------------------------------------------------------------------------------
DROP TABLE EMPS;
-- CTAS: ���̺� ���� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); -- �����ͱ��� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ������ ����
SELECT * FROM EMPS;