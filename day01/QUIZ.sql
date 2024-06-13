--1. 모든 사원의 사원번호, 이름, 입사일, 급여를 출력하세요.
SELECT employee_id, first_name, last_name, hire_date, salary FROM employees;
--2. 모든 사원의 이름과 성을 붙여 출력하세요. 열 별칭은 name으로 하세요.
SELECT first_name || ' ' || last_name AS NAME FROM employees;
--3. 50번 부서 사원의 모든 정보를 출력하세요.
SELECT * FROM employees WHERE department_id = 50;
--4. 50번 부서 사원의 이름, 부서번호, 직무아이디를 출력하세요.
SELECT first_name, department_id, job_id FROM employees WHERE department_id = 50;
--5. 모든 사원의 이름, 급여 그리고 300달러 인상된 급여를 출력하세요.
SELECT first_name, salary, salary + 300 FROM employees;
--6. 급여가 10000보다 큰 사원의 이름과 급여를 출력하세요.
SELECT first_name, salary FROM employees WHERE salary > 10000;
--7. 보너스를 받는 사원의 이름과 직무, 보너스율을 출력하세요.
SELECT first_name, job_id, commission_pct FROM employees WHERE commission_pct IS NOT NULL;
--8. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요.(BETWEEN 연산자 사용)
SELECT first_name, hire_date, salary FROM employees WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';
--9. 2003년도 입사한 사원의 이름과 입사일 그리고 급여를 출력하세요.(LIKE 연산자 사용)
SELECT first_name, hire_date, salary FROM employees WHERE hire_date LIKE '03%';
--10. 모든 사원의 이름과 급여를 급여가 많은 사원부터 적은 사원순서로 출력하세요.
SELECT first_name, salary FROM employees ORDER BY salary DESC;
--11. 위 질의를 60번 부서의 사원에 대해서만 질의하세요. (컬럼: department_id)
SELECT first_name, salary FROM employees WHERE department_id = 60 ORDER BY salary DESC;
--12. 직무아이디가 IT_PROG 이거나, SA_MAN인 사원의 이름과 직무아이디를 출력하세요.
SELECT first_name, job_id FROM employees WHERE job_id IN ('IT_PROG', 'SA_MAN');
--13. Steven King 사원의 정보를 “Steven King 사원의 급여는 24000달러 입니다” 형식으로 출력하세요.
SELECT first_name || ' ' || last_name || ' 사원의 급여는 ' || salary || '달러 입니다' FROM employees WHERE first_name = 'Steven' AND last_name = 'King';
--14. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 출력하세요. (컬럼:job_id)
SELECT first_name, job_id FROM employees WHERE job_id LIKE '%MAN%';
--15. 매니저(MAN) 직무에 해당하는 사원의 이름과 직무아이디를 직무아이디 순서대로 출력하세요.
SELECT first_name, job_id FROM employees WHERE job_id LIKE '%MAN%' ORDER BY job_id;

--------------------------------------------------------------------------------------------------------------------------------------------------------
--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT CONCAT(first_name, LPAD(last_name, LENGTH(last_name)+1, ' ')) AS NAME, REPLACE(hire_date, '/', '') AS HIRE_DATE FROM employees;

--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT CONCAT('02', SUBSTR(phone_number, 4)) AS TEL FROM employees;

--문제 3. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT RPAD(SUBSTR(first_name, 0, 3), LENGTH(first_name), '*') AS NAME, LPAD(salary, 10, '*') FROM employees WHERE LOWER(job_id) = 'it_prog';