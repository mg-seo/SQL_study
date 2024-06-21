-- ���
/*
IF ������ THEN
ELSIF ������ THEN
ELSE ~~~
END IF;
*/
SET SERVEROUTPUT ON;
DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1, 101)); --������ �Ǽ���, ���� TRUNC
BEGIN
    dbms_output.put_line('����: ' || POINT || '��');
    
    IF POINT >= 90 THEN 
        dbms_output.put_line('A �Դϴ�.');
    ELSIF POINT >= 70 THEN
        dbms_output.put_line('B �Դϴ�.');
    ELSE
        dbms_output.put_line('F �Դϴ�.');
    END IF;
    ------------------------------------------------------------
    CASE WHEN POINT >= 90 THEN dbms_output.put_line('A �Դϴ�.');
     WHEN POINT >= 70 THEN dbms_output.put_line('B �Դϴ�.');
     ELSE dbms_output.put_line('F �Դϴ�.');
    END CASE;
END;
--------------------------------------------------------------------------------
-- WHILE��
DECLARE
    I NUMBER := 3;
    J NUMBER := 1;
BEGIN
    WHILE J <= 9
    LOOP
        dbms_output.put_line(I || ' x ' || J || ' = ' || I*J);
        J := J + 1;
    END LOOP;
END;
--------------------------------------------------------------------------------
-- FOR�� , CONTINUE, EXIT
DECLARE
    I NUMBER := 3;
BEGIN
    FOR J IN 1..9 --1~9����
    LOOP
        CONTINUE WHEN J = 2; -- J�� 2�� ��������
        dbms_output.put_line(I || ' x ' || J || ' = ' || I*J);
        EXIT WHEN J = 5; -- J�� 5�� Ż��
    END LOOP;
END;
--------------------------------------------------------------------------------
-- 2~9�ܱ��� ����ϴ� �͸���
DECLARE 
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP
        dbms_output.put_line(I || ' x ' || J || ' = ' || I*J);
        END LOOP;
    END LOOP;
END;

DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(I || ' x ' || J || ' = ' || I*J);
        EXIT WHEN I = 9 AND J = 9;
        IF J = 9 THEN 
            J := 1; I := I + 1;
        ELSE J := J+1;
        END IF;
    END LOOP;
END;
--------------------------------------------------------------------------------
-- Ŀ�� ������
DECLARE
    NAME VARCHAR2(30);
BEGIN
    -- SELECT�� ����� ���� ���̶� ������ ��
    SELECT FIRST_NAME
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
    dbms_output.put_line(NAME);
END;
-- Ŀ�� ����
DECLARE
    NM VARCHAR2(30);
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X; -- Ŀ�� ����
        dbms_output.put_line('------Ŀ�� ����------');
    LOOP
        FETCH X INTO NM, SALARY;
        EXIT WHEN X%NOTFOUND; -- XĿ���� �� �̻� ���� ���� ������ TRUE
        dbms_output.put_line(NM || ' ' || SALARY);
    END LOOP;
    dbms_output.put_line('------Ŀ�� ����------');
    dbms_output.put_line('������ ��: ' || X%ROWCOUNT); -- Ŀ������ ���� ������ ��
    CLOSE X;
END;
--------------------------------------------------------------------------------
-- ��������
-- �μ��� �޿����� ����ϴ� Ŀ�������� �ۼ��غ��ô�.
DECLARE
    DN DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    SS EMPLOYEES.SALARY%TYPE;
    CURSOR X IS 
        SELECT D.DEPARTMENT_NAME, SUM(SALARY) 
        FROM DEPARTMENTS D 
        FULL OUTER JOIN EMPLOYEES E 
        ON d.department_id = e.department_id 
        GROUP BY DEPARTMENT_NAME;
BEGIN
    OPEN X;
    LOOP
        FETCH X INTO DN, SS;
        EXIT WHEN X%NOTFOUND;
        IF DN IS NULL THEN DN := 'NULL';
        ELSIF SS IS NULL THEN SS := '0';
        END IF;
        dbms_output.put_line(DN || ' / ' || SS);
    END LOOP;
    CLOSE X;
END;

-- ������̺��� ������ �޿����� ���Ͽ� EMP_SAL�� ���������� INSERT�ϴ� Ŀ�������� �ۼ��غ��ô�.
SELECT * FROM EMP_SAL;
DECLARE
    CURSOR X IS
        SELECT YEARS, SUM(SALARY) SALARY
        FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') YEARS, SALARY
              FROM EMPLOYEES)
        GROUP BY YEARS
        ORDER BY YEARS;
BEGIN
    FOR I IN X
    LOOP
        INSERT INTO EMP_SAL VALUES(I.YEARS, I.SALARY);
    END LOOP;
END;

