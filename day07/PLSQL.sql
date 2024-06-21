-- PLSQL (프로그램 SQL)
-- 실행시킬 범위 지정 후 F5로 컴파일 시켜 실행

-- 출력구문을 위한 실행문
SET SERVEROUTPUT ON;

-- 익명블록
DECLARE
    V_NUM NUMBER; -- 변수 선언
    V_NAME VARCHAR2(10) := '홍길동';
BEGIN
    V_NUM := 10; -- 변수 초기화
    -- V_NAME := '홍길동';
    
    dbms_output.put_line(V_NAME || '님의 나이는 ' || V_NUM || '살입니다.');
END;

-- DML구문과 함께 사용할 수 있습니다.
DECLARE
    NAME VARCHAR2(30);
    SALARY NUMBER;
    LAST_NAME EMPLOYEES.LAST_NAME%TYPE; -- EMP테이블의 LAST_NAME과 동일한 타입으로 선언
BEGIN
    SELECT FIRST_NAME, LAST_NAME, SALARY
    INTO NAME, LAST_NAME, SALARY -- 위에 선언된 변수에 대입
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    dbms_output.put_line(NAME);
    dbms_output.put_line(SALARY);
    dbms_output.put_line(LAST_NAME);
END;
-------------------------------------------------------------------------------
-- 2008년 입사한 사원의 급여 평균을 구해서 새로운 테이블에 INSERT
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
    INTO SALARY -- 변수 SALARY에 대입
    FROM employees WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY);
    COMMIT;
END;
SELECT * FROM EMP_SAL;
-------------------------------------------------------------------------------
--3. 사원 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 
--	 이 번호 +1번으로 아래의 사원을 emps테이블에 employee_id, last_name, email, hire_date, job_id를  신규 입력하는 익명 블록을 만들어 봅시다.
--<사원명>   : steven
--<이메일>   : stevenjobs
--<입사일자> : 오늘날짜
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