-- 그룹함수
--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
SELECT job_id, COUNT(*) 사원수
FROM employees
GROUP BY job_id;
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;
--시원 테이블에서 JOB_ID별 가장 빠른 입사일을 구하세요. JOB_ID로 내림차순 정렬하세요.
SELECT job_id, MIN(hire_date)
FROM employees
GROUP BY job_id
ORDER BY job_id DESC;

--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.
SELECT CONCAT(20, SUBSTR(HIRE_DATE, 0, 2)) 입사년도, COUNT(*) 사원수
FROM employees
GROUP BY SUBSTR(HIRE_DATE, 0, 2);

--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력
SELECT department_id, AVG(salary) 평균급여
FROM employees
WHERE SALARY >= 1000
GROUP BY department_id
HAVING AVG(salary) >= 2000;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
SELECT department_id, TRUNC(AVG(salary + salary * commission_pct), 2) 평균, SUM(salary + salary * commission_pct) 합계, COUNT(commission_pct) COUNT
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

--문제 5.
--부서아이디가 NULL이 아니고, 입사일은 05년도 인 사람들의 부서 급여평균과, 급여합계를 평균기준 내림차순합니다
--조건) 평균이 10000이상인 데이터만
SELECT department_id, AVG(salary) 급여평균, SUM(salary) 급여합계
FROM employees
WHERE department_id IS NOT NULL AND SUBSTR(hire_date, 0, 2) = '05'
GROUP BY department_id
HAVING AVG(salary) >= 10000
ORDER BY AVG(salary) DESC;

--문제 6.
--직업별 월급합, 총합계를 출력하세요
SELECT DECODE(job_id, NULL, '총합계', job_id) 직업, SUM(salary) 월급합
FROM employees
GROUP BY ROLLUP(job_id);

--문제 7.
--부서별, JOB_ID를 그룹핑 하여 토탈, 합계를 출력하세요.
--GROUPING() 을 이용하여 소계 합계를 표현하세요
SELECT DECODE(GROUPING(department_id), 1, '합계', department_id) department_id,
       DECODE(GROUPING(job_id), 1, '소계', job_id) job_id,
       COUNT(*) TOTAL,
       SUM(salary) SUM
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY SUM(salary);

-- JOIN
--문제 1.
--EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
--EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서 
--각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)
SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E LEFT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E RIGHT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E FULL JOIN departments D ON e.department_id = d.department_id;

--문제 2.
--EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
--조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
--조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다
SELECT CONCAT(e.first_name, e.last_name), d.department_id
FROM employees E 
INNER JOIN departments D 
ON e.department_id = d.department_id
WHERE e.employee_id = 200;

--문제 3.
--EMPLOYEES, JOBS테이블을 INNER JOIN하세요
--조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
--HINT) 어떤 컬럼으로 서로 연결되 있는지 확인
SELECT e.first_name, e.job_id, j.job_title
FROM employees E
INNER JOIN JOBS J
ON e.job_id = j.job_id
ORDER BY e.first_name;

--문제 4.
--JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.
SELECT *
FROM jobs J
LEFT JOIN job_history H
ON j.job_id = h.job_id;

--문제 5.
--Steven King의 부서명을 출력하세요.
SELECT CONCAT(e.first_name, LPAD(e.last_name, LENGTH(e.last_name)+1, ' ')) NAME, d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
WHERE CONCAT(e.first_name, LPAD(e.last_name, LENGTH(e.last_name)+1, ' ')) = 'Steven King';


--문제 6.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요
SELECT *
FROM employees
CROSS JOIN departments;

--문제 7.
--EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
--급여, 부서명, 근무지를 출력하세요. (Alias를 사용)
SELECT e.employee_id, e.first_name, TO_CHAR(e.salary, '$999,999') SALARY, d.department_name, l.city
FROM employees E
LEFT JOIN departments D ON e.department_id = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE e.job_id = 'SA_MAN';

--문제 8.
--employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
--출력하세요.
SELECT *
FROM employees E
LEFT JOIN jobs J
ON e.job_id = j.job_id
WHERE j.job_title IN('Stock Manager', 'Stock Clerk');

--문제 9.
--departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용
SELECT d.department_name
FROM departments D
LEFT JOIN employees E
USING(department_id)
WHERE e.employee_id IS NULL;

--문제 10. 
--join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
--힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.
SELECT e.first_name, e2.first_name
FROM employees E
LEFT JOIN employees E2
ON e.manager_id = e2.employee_id;

--문제 11. 
--EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
--조건) 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요
SELECT e.first_name, e2.first_name, e2.salary
FROM employees E
LEFT JOIN employees E2
ON e.manager_id = e2.employee_id
WHERE e.manager_id IS NOT NULL
ORDER BY e2.salary DESC;

--보너스 문제 12.
--윌리엄스미스(William smith)의 직급도(상급자)를 구하세요.
SELECT e3.first_name || ' > ' || e2.first_name || ' > ' || e.first_name 직급도
FROM employees E
LEFT JOIN employees E2 ON e.manager_id = e2.employee_id
LEFT JOIN employees E3 ON e2.manager_id = e3.employee_id
WHERE e.first_name || ' ' || e.last_name = 'William Smith';

