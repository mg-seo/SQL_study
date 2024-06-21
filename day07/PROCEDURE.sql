-- STORED PROCEDURE (�Ϸ��� SQL ó�������� ����ó�� ��� ����ϴ� ����)

-- ����� ȣ��
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE NEW_JOB_POC -- PROCEDURE �̸�
IS
BEGIN
    dbms_output.put_line('HELLO WORLD');    
END; -- ���ν��� ������ ����
EXEC new_job_poc; -- ȣ��

--------------------------------------------------------------------------------
-- �Ű����� IN
CREATE OR REPLACE PROCEDURE NEW_JOB_POC
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 0, -- :=0 �⺻�� ����
     P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000
    )
IS
BEGIN
    INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    COMMIT;
END;
EXEC new_job_poc('EXAMPLE2', 'EXAMPLE2'); -- MIN�� MAX�� �⺻������ ��
EXEC new_job_poc('EXAMPLE', 'EXAMPLE', 1000, 10000); -- ������ ������ ��
SELECT * FROM JOBS_IT;
--------------------------------------------------------------------------------
-- PLSQL ��� ������ PROCEDURE�� ��밡��
-- JOB_ID�� �����ϸ� UPDATE, ������ INSERT
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (ID IN VARCHAR2,
     TITLE IN VARCHAR2,
     MIN IN NUMBER,
     MAX IN NUMBER
    )
IS
    CNT NUMBER; --��������
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS_IT
    WHERE JOB_ID = ID;
    
    IF CNT = 0 THEN
        --INSERT
        INSERT INTO JOBS_IT VALUES(ID, TITLE, MIN, MAX);
    ELSE
        --UPDATE
        UPDATE JOBS_IT
        SET JOB_ID = ID,
            JOB_TITLE = TITLE,
            MIN_SALARY = MIN,
            MAX_SALARY = MAX
        WHERE JOB_ID = ID;
    END IF;
    COMMIT;
END;
EXEC new_job_proc('AD', 'ADMIN', 3000,20000);
SELECT * FROM JOBS_IT;
--------------------------------------------------------------------------------
-- OUT �Ű����� : �ܺη� ���� �����ֱ� ���� �Ű�����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (ID IN VARCHAR2,
     TITLE IN VARCHAR2,
     MIN IN NUMBER,
     MAX IN NUMBER,
     NUM OUT NUMBER -- �ܺη� ������ �Ű�����
    )
IS
    CNT NUMBER; --��������
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS_IT
    WHERE JOB_ID = ID;
    
    IF CNT = 0 THEN
        --INSERT
        INSERT INTO JOBS_IT VALUES(ID, TITLE, MIN, MAX);
    ELSE
        --UPDATE
        UPDATE JOBS_IT
        SET JOB_ID = ID,
            JOB_TITLE = TITLE,
            MIN_SALARY = MIN,
            MAX_SALARY = MAX
        WHERE JOB_ID = ID;
    END IF;
    
    -- �ƿ� �Ű������� ���� �Ҵ�
    NUM := CNT;    
    COMMIT;
END;

DECLARE
    CNT NUMBER;
BEGIN
    -- �͸��� �ȿ����� EXEC����
    NEW_JOB_PROC('AD_VP', 'ADMIN', 2000, 20000, CNT);
    dbms_output.put_line('PROCEDURE���� �Ҵ���� ��:' || CNT);
END;

--------------------------------------------------------------------------------
-- RETURN�� : PROCEDURE�� ������
-- EXCEPTION WHEN OTHERS THEN : ���� �߻��� ����
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC2
    (P_JOB_ID IN JOBS.JOB_ID%TYPE)
IS
    CNT NUMBER;
    SALARY NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        dbms_output.put_line('���� �����ϴ�.');
        RETURN; --���ν��� ����
    ELSE
        SELECT MAX_SALARY
        INTO SALARY
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
        dbms_output.put_line('�ִ�޿�: ' || SALARY);
    END IF;
    dbms_output.put_line('��������');
    
    --����ó������
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
END;
EXEC NEW_JOB_PROC2('AD'); --RETURN���� ������ ���ν��� ����
EXEC NEW_JOB_PROC2('AD_VP');
--------------------------------------------------------------------------------
-- ��������
-- ���ν����� DEPTS_PROC
-- �μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
-- DEPTS���̺� ���� flag�� i�� INSERT, u�� UPDATE, d�� DELETE �ϴ� ���ν����� �����մϴ�.
-- �׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
-- ����ó���� �ۼ����ּ���.
SELECT * FROM DEPTS;
CREATE OR REPLACE PROCEDURE DEPTS_PROC
    (DEPT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE,
     DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE,
     FLAG VARCHAR2
     )
IS
BEGIN
    IF FLAG = 'I' THEN
        INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(DEPT_ID, DEPT_NAME);
    ELSIF FLAG = 'U' THEN
        UPDATE DEPTS
        SET DEPARTMENT_NAME = DEPT_NAME
        WHERE DEPARTMENT_ID = DEPT_ID;
    ELSIF FLAG = 'D' THEN
        DELETE FROM DEPTS WHERE DEPARTMENT_ID = DEPT_ID;
    END IF;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
END;
EXEC DEPTS_PROC(10, 'AD', 'I');
EXEC DEPTS_PROC(10, 'AA', 'U');
EXEC DEPTS_PROC(10, 'AA', 'D');
SELECT * FROM DEPTS;

-- ���ν����� - SALES_PROC
-- sales���̺��� ������ �Ǹų����̴�.
-- day_of_sales���̺��� �Ǹų��� ������ ���� ������ �Ѹ����� ����ϴ� ���̺��̴�.
-- ������ sales�� ���ó�¥ �Ǹų����� �����Ͽ� day_of_sales�� �����ϴ� ���ν����� �����غ�����.
-- ����) day_of_sales�� ���������� �̹� �����ϸ� ������Ʈ ó��
CREATE TABLE SALES(
    SNO NUMBER(5) CONSTRAINT SALES_PK PRIMARY KEY, --��ȣ
    NAME VARCHAR2(30), --��ǰ��
    TOTAL NUMBER(10), --����
    PRICE NUMBER(10), --����
    REGDATE DATE DEFAULT SYSDATE --��¥
);
INSERT INTO SALES (SNO, NAME, TOTAL, PRICE) VALUES (1, '�Ƹ޸�ī��', 3, 1000);
INSERT INTO SALES (SNO, NAME, TOTAL, PRICE) VALUES (2, '�ݵ���', 2, 2000);
INSERT INTO SALES (SNO, NAME, TOTAL, PRICE) VALUES (3, '��ü��', 1, 3000);

CREATE TABLE DAY_OF_SALES(
    REGDATE DATE CONSTRAINT DOS_PK PRIMARY KEY,
    FINAL_TOTAL NUMBER(10)
);



CREATE OR REPLACE PROCEDURE SALES_PROC
IS
    CNT NUMBER := 0; --��Ż��
    FLAG NUMBER := 0; --���� ��¥ �����Ͱ� �ִ��� ����
BEGIN
    --1. ���ó�¥�� �ݾ� ����
    SELECT SUM(TOTAL * PRICE) 
    INTO CNT
    FROM SALES 
    WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');
    
    --2. �������̺� ���ó�¥ ���������Ͱ� �ִ��� Ȯ��
    SELECT COUNT(*)
    INTO FLAG
    FROM DAY_OF_SALES
    WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD');
    
    IF FLAG <> 0 THEN
        UPDATE DAY_OF_SALES
        SET FINAL_TOTAL = CNT --�ݾ� �հ�
        WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD'); 
    ELSE
        INSERT INTO DAY_OF_SALES VALUES(SYSDATE, CNT);
    END IF;
    COMMIT;
END;
EXEC SALES_PROC;
SELECT * FROM DAY_OF_SALES;