-- WHERE 조건절
SELECT * FROM employees WHERE job_id = 'IT_PROG';
SELECT first_name, job_id FROM employees WHERE FIRST_NAME = 'David';
SELECT * FROM employees WHERE salary >= 15000;
SELECT * FROM employees WHERE department_id <> 90;
SELECT * FROM employees WHERE hire_date = '06/03/07'; -- 날짜 비교도 문자열로 합니다
SELECT * FROM employees WHERE hire_date > '06/03/01'; -- 문자열도 대소 비교 가능

-- BETWEEN AND 연산자 ~사이에
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 10000;
SELECT * FROM employees WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- IN 연산자
SELECT * FROM employees WHERE department_id IN (50, 60, 70);
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'ST_MAN');

-- LIKE 연산자 검색에 사용됨, 리터럴문자 % , _
SELECT * FROM employees WHERE hire_date LIKE '03%'; -- 03으로 시작하는
SELECT * FROM employees WHERE hire_date LIKE '%03'; -- 03으로 끝나는
SELECT * FROM employees WHERE hire_date LIKE '%03%'; -- 03이 어디든 들어가는
SELECT * FROM employees WHERE job_id LIKE '%MAN%';
SELECT * FROM employees WHERE first_name LIKE '_a%'; -- 두번째글자가 a로 시작하는

-- NULL값 찾기 IS NULL, IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

-- AND, OR
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'FI_MGR');
SELECT * FROM employees WHERE job_id = 'IT_PROG' OR job_id = 'FI_MGR';
SELECT * FROM employees WHERE job_id = 'IT_PROG' OR salary >= 5000;
SELECT * FROM employees WHERE job_id = 'IT_PROG' AND salary >= 5000;
SELECT * FROM employees WHERE (job_id = 'IT_PROG' OR job_id = 'FI_MGR') AND salary >= 6000;

-- NOT 부정의 의미, 연산 키워드와 사용됨
SELECT * FROM employees WHERE department_id NOT IN (50, 60);
SELECT * FROM employees WHERE job_id NOT LIKE '%MAN%';

-- ORDER BY ASC(오름차순) / DESC(내림차순) 정렬
SELECT * FROM employees ORDER BY first_name ASC; --ASC는 생략가능
SELECT * FROM employees ORDER BY salary DESC;
SELECT first_name, salary * 12 AS 연봉 FROM employees ORDER BY 연봉; -- 별칭 사용가능
SELECT * FROM employees ORDER BY department_id DESC, salary DESC; -- 정렬조건 여러개
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'SA_MAN') ORDER BY first_name;


