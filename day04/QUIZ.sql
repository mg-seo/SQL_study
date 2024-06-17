--문제 1.
--EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
SELECT AVG(salary) FROM employees; -- 6461
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
ORDER BY salary DESC;
--EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
SELECT COUNT(*)
FROM (SELECT *
      FROM employees
      WHERE salary > (SELECT AVG(salary)
                      FROM employees));
--EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요.
SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG'; -- 5760
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;

--문제 2.
--DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id(부서아이디) 와
--EMPLOYEES테이블에서 department_id(부서아이디) 가 일치하는 모든 사원의 정보를 검색하세요.
SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE manager_id = 100);

--문제 3.
--- EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
SELECT first_name, manager_id FROM employees WHERE first_name = 'Pat'; -- 201
SELECT *
FROM employees
WHERE manager_id > (SELECT manager_id
                    FROM employees
                    WHERE first_name = 'Pat');
--- EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.
SELECT manager_id FROM employees WHERE first_name = 'James'; -- 120, 121
SELECT *
FROM employees
WHERE manager_id IN (SELECT manager_id
                     FROM employees
                     WHERE first_name = 'James');
--- Steven과 동일한 부서에 있는 사람들을 출력해주세요.
SELECT department_id FROM employees WHERE first_name = 'Steven'; -- 90, 50
SELECT *
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE first_name = 'Steven');
--- Steven의 급여보다 많은 급여를 받는 사람들은 출력하세요.
SELECT salary FROM employees WHERE first_name = 'Steven'; -- 24000, 2200
SELECT *
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE first_name = 'Steven'); -- 2200보다 큰

--문제 4.
--EMPLOYEES테이블 DEPARTMENTS테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬
SELECT e.employee_id, e.last_name || e.first_name AS 이름, e.department_id, d.department_name
FROM employees E
LEFT JOIN departments D
ON e.department_id = d.department_id
ORDER BY e.employee_id;

--문제 5.
--문제 4의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT employee_id, 
       last_name || first_name AS 이름, 
       department_id, 
       (SELECT department_name
        FROM departments D
        WHERE e.department_id = d.department_id) DEPARTMENT_NAME
FROM employees E;

--문제 6.
--DEPARTMENTS테이블 LOCATIONS테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 스트릿_어드레스, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬
SELECT d.department_id, d.department_name, l.street_address, l.city
FROM departments D
LEFT JOIN locations L
ON d.location_id = l.location_id
ORDER BY d.department_id;

--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT department_id, 
       department_name, 
      (SELECT l.street_address
       FROM locations L
       WHERE d.location_id = l.location_id) STREET_ADDRESS,
       (SELECT l.city
       FROM locations L
       WHERE d.location_id = l.location_id) CITY
FROM departments D;

--문제 8.
--LOCATIONS테이블 COUNTRIES테이블을 스칼라 쿼리로 조회하세요.
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬
SELECT l.location_id, l.street_address, l.city,
      (SELECT c.country_id
       FROM countries C
       WHERE l.country_id = c.country_id) COUNTRY_ID,
       (SELECT c.country_name
       FROM countries C
       WHERE l.country_id = c.country_id) COUNTRY_NAME
FROM locations L
ORDER BY COUNTRY_NAME;

--문제 9.
--EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요
SELECT *
FROM (SELECT ROWNUM RN, first_name
      FROM(SELECT first_name
           FROM employees
           ORDER BY first_name DESC))
WHERE rn BETWEEN 41 AND 50;

--문제 10.
--EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요.
SELECT *
FROM (SELECT ROWNUM RN, employee_id, first_name, phone_number, hire_date
      FROM (SELECT employee_id, first_name, phone_number, hire_date
            FROM employees
            ORDER BY hire_date))
WHERE rn BETWEEN 31 AND 40;

--문제 11.
--COMMITSSION을 적용한 급여를 새로운 컬럼으로 만들고 10000보다 큰 사람들을 뽑아 보세요. (인라인뷰를 쓰면 됩니다)
SELECT *
FROM (SELECT E.*, NVL2(commission_pct,salary + salary * commission_pct, salary) AS 총급여
      FROM employees E)
WHERE 총급여 > 10000;

--문제12
--EMPLOYEES테이블, DEPARTMENTS 테이블을 left조인하여, 입사일 오름차순 기준으로 10-20번째 데이터만 출력합니다.
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 입사일, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 망가지면 안되요.
SELECT first_name FROM employees ORDER BY hire_date;
-- Alexander ~ Ellen
SELECT RN, employee_id, first_name, hire_date, department_name
FROM(SELECT ROWNUM RN, A.*
     FROM (SELECT employee_id, first_name, hire_date, department_id
           FROM employees
           ORDER BY hire_date)A)B
LEFT JOIN departments D
ON B.department_id = d.department_id
WHERE RN BETWEEN 10 AND 20
ORDER BY RN;


--문제13
--SA_MAN 사원의 급여 내림차순 기준으로 ROWNUM을 붙여주세요.
--조건) SA_MAN 사원들의 ROWNUM, 이름, 급여, 부서아이디, 부서명을 출력하세요.
SELECT E.*, (SELECT department_name 
             FROM departments D 
             WHERE e.department_id = d.department_id) 부서명
FROM (SELECT ROWNUM RN, A.*
      FROM (SELECT first_name, salary, department_id
            FROM employees
            WHERE job_id = 'SA_MAN'
            ORDER BY salary DESC)A)E
ORDER BY FIRST_NAME;

--문제14
--DEPARTMENTS테이블에서 각 부서의 부서명, 매니저아이디, 부서에 속한 인원수 를 출력하세요.
--조건) 인원수 기준 내림차순 정렬하세요.
--조건) 사람이 없는 부서는 출력하지 뽑지 않습니다.
--한트) 부서의 인원수 먼저 구한다. 이 테이블을 조인한다.
SELECT d.department_name, d.manager_id, E.cnt
FROM departments D
INNER JOIN (SELECT COUNT(*) CNT, department_id
           FROM employees
           GROUP BY department_id) E
ON d.department_id = E.department_id
ORDER BY E.cnt DESC;

--문제15
--부서에 모든 컬럼, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--조건) 부서별 평균이 없으면 0으로 출력하세요
SELECT D.*, l.street_address, l.postal_code, NVL(E.평균연봉, 0) AVG_SALARY
FROM departments D
LEFT JOIN locations L
ON d.location_id = l.location_id
LEFT JOIN (SELECT department_id, TRUNC(AVG(SALARY)) 평균연봉
           FROM employees
           GROUP BY DEPARTMENT_ID) E
ON d.department_id = e.department_id;

--문제16
--문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요
SELECT ROWNUM, A.*
FROM(SELECT D.*, l.street_address, l.postal_code, NVL(E.평균연봉, 0) AVG_SALARY
     FROM departments D
     LEFT JOIN locations L
     ON d.location_id = l.location_id
     LEFT JOIN (SELECT department_id, TRUNC(AVG(SALARY)) 평균연봉
                FROM employees
                GROUP BY DEPARTMENT_ID) E
     ON d.department_id = e.department_id
     ORDER BY d.department_id DESC)A
WHERE ROWNUM BETWEEN 1 AND 10;


