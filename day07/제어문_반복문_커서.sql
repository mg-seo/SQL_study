-- 제어문
/*
IF 조건절 THEN
ELSIF 조건절 THEN
ELSE ~~~
END IF;
*/
SET SERVEROUTPUT ON;
DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1, 101)); --랜덤한 실수값, 따라서 TRUNC
BEGIN
    dbms_output.put_line('점수: ' || POINT || '점');
    
    IF POINT >= 90 THEN 
        dbms_output.put_line('A 입니다.');
    ELSIF POINT >= 70 THEN
        dbms_output.put_line('B 입니다.');
    ELSE
        dbms_output.put_line('F 입니다.');
    END IF;
    ------------------------------------------------------------
    CASE WHEN POINT >= 90 THEN dbms_output.put_line('A 입니다.');
     WHEN POINT >= 70 THEN dbms_output.put_line('B 입니다.');
     ELSE dbms_output.put_line('F 입니다.');
    END CASE;
END;
--------------------------------------------------------------------------------
-- WHILE문
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
-- FOR문 , CONTINUE, EXIT
DECLARE
    I NUMBER := 3;
BEGIN
    FOR J IN 1..9 --1~9까지
    LOOP
        CONTINUE WHEN J = 2; -- J가 2면 다음으로
        dbms_output.put_line(I || ' x ' || J || ' = ' || I*J);
        EXIT WHEN J = 5; -- J가 5면 탈출
    END LOOP;
END;
--------------------------------------------------------------------------------
-- 2~9단까지 출력하는 익명블록
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
-- 커서 미적용
DECLARE
    NAME VARCHAR2(30);
BEGIN
    -- SELECT한 결과가 여러 행이라서 에러가 남
    SELECT FIRST_NAME
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
    dbms_output.put_line(NAME);
END;
-- 커서 적용
DECLARE
    NM VARCHAR2(30);
    SALARY NUMBER;
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
BEGIN
    OPEN X; -- 커서 선언
        dbms_output.put_line('------커서 시작------');
    LOOP
        FETCH X INTO NM, SALARY;
        EXIT WHEN X%NOTFOUND; -- X커서에 더 이상 읽을 값이 없으면 TRUE
        dbms_output.put_line(NM || ' ' || SALARY);
    END LOOP;
    dbms_output.put_line('------커서 종료------');
    dbms_output.put_line('데이터 수: ' || X%ROWCOUNT); -- 커서에서 읽은 데이터 수
    CLOSE X;
END;
--------------------------------------------------------------------------------
-- 연습문제
-- 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
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

-- 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
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

