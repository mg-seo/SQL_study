SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

-- 특정 컬럼만 조회하기
-- 문자와 날짜는 왼쪽에, 숫자는 오른쪽에 표시됩니다
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY FROM employees;

-- 컬럼명 자리에서는 숫자 또는 날짜가 연산이 됩니다
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM employees;

-- PK는 EMPLYEE_ID, FK는 DEPARTMENT_ID
SELECT * FROM employees;

-- 엘리어스(별칭)
SELECT FIRST_NAME AS 이름, SALARY AS 급여, SALARY + SALARY * 0.1 AS "최종 급여" FROM employees;

-- 문자열 연결 ||
-- 홑 안에서 홑 쓰고싶다면 ''
SELECT 'HELLO' || 'WORLD' FROM employees;
SELECT FIRST_NAME || '''님의 급여는 ' || SALARY || '$입니다' FROM employees;

-- DISTINCT(중복제거) 키워드
SELECT DEPARTMENT_ID FROM employees;
SELECT DISTINCT DEPARTMENT_ID FROM employees;

-- ROWNUM(조회된 순서), ROWID(레코드가 저장된 위치)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM employees;



