-- PLSQL (���α׷� SQL)
-- �����ų ���� ���� �� F5�� ������ ���� ����

-- ��±����� ���� ���๮
SET SERVEROUTPUT ON;

-- �͸���
DECLARE
    V_NUM NUMBER; -- ���� ����
    V_NAME VARCHAR2(10) := 'ȫ�浿';
BEGIN
    V_NUM := 10; -- ���� �ʱ�ȭ
    -- V_NAME := 'ȫ�浿';
    
    dbms_output.put_line(V_NAME || '���� ���̴� ' || V_NUM || '���Դϴ�.');
END;

-- DML������ �Բ� ����� �� �ֽ��ϴ�.
DECLARE
    NAME VARCHAR2(30);
    SALARY NUMBER;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE; -- EMP���̺��� LAST_NAME�� ������ Ÿ������ ����
BEGIN
    SELECT FIRST_NAME, LAST_NAME, SALARY
    INTO NAME, LAST_NAME, SALARY -- ���� ����� ������ ����
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    dbms_output.put_line(NAME);
    dbms_output.put_line(SALARY);
    dbms_output.put_line(LAST_NAME);
END;
-------------------------------------------------------------------------------
-- 2008�� �Ի��� ����� �޿� ����� ���ؼ� ���ο� ���̺� INSERT
CREATE TABLE EMP_SAL(
    YEARS VARCHAR2(50),
    SALARY NUMBER(10)
);
SELECT AVG(SALARY) FROM employees
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2008;
DECLARE
    YEARS VARCHAR2(50) := 2008;
    SALARY NUMBER;
BEGIN
    SELECT AVG(SALARY) 
    INTO SALARY -- ���� SALARY�� ����
    FROM employees WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
    COMMIT;
END;
SELECT * FROM EMP_SAL;
-------------------------------------------------------------------------------
--3. ��� ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� ��, 
--	 �� ��ȣ +1������ �Ʒ��� ����� emps���̺� employee_id, last_name, email, hire_date, job_id��  �ű� �Է��ϴ� �͸� ����� ����� ���ô�.
--<�����>   : steven
--<�̸���>   : stevenjobs
--<�Ի�����> : ���ó�¥
--<JOB_ID> : CEO

SELECT * FROM EMPS_IT ORDER BY employee_id;
DECLARE
    EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE := 'Steven';
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE := 'Jobs';
    EMAIL EMPLOYEES.EMAIL%TYPE := 'STEVENJOBS';
    HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE := SYSDATE;
    JOB_ID EMPLOYEES.JOB_ID%TYPE := 'CEO';
BEGIN
    SELECT MAX(EMPLOYEE_ID) + 1
    INTO EMPLOYEE_ID
    FROM EMPLOYEES;
    
    INSERT INTO EMPS_IT(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID);
END;