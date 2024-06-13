-- 집합연산자
-- 컬럼 개수가 일치해야 집합연산자 사용이 가능
-- UNION, UNION ALL, INTERSECT, MINUS
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
UNION -- Michael 이 두명인데, 한 명만 출력함(중복제거)
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
UNION ALL -- Michael 두명 다 출력
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
INTERSECT -- 교집합 Michael만 출력
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
MINUS -- 차집합, 교집합 제거
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
