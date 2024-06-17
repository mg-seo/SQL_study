-- 서브쿼리 (SELECT 구문들의 특정위치에 다시 SELECT가 들어가는 문장)
-- 단일행 서브쿼리 - 서브쿼리의 결과가 1행인 서브쿼리

-- 낸시보다 급여가 높은 사람
-- 낸시의 급여를 찾는다 
SELECT salary 
FROM employees
WHERE first_name = 'Nancy';
-- 찾은 급여를 WEHRE절에 넣는다
SELECT * FROM employees WHERE salary > (SELECT salary 
                                        FROM employees
                                        WHERE first_name = 'Nancy');
                                        
-- 103번과 직업이 같은 사람
SELECT job_id FROM employees WHERE employee_id = 103;
SELECT * FROM employees WHERE job_id = (SELECT job_id 
                                        FROM employees 
                                        WHERE employee_id = 103);
                                        
-- 주의할 점, 비교할 컬럼은 반드시 한개여야 함 - * 안됌
SELECT * FROM employees WHERE job_id = (SELECT * FROM employees WHERE employee_id = 103);
                                            -- job_id.. ~ 한 개의 값

-- 주의할 점, 여러행이 나오는 구문이라면, 다중행 서브쿼리 연산자를 써줘야함
SELECT salary FROM employees WHERE first_name = 'Steven';  -- 이 경우 Steven이 2명으로 다중행
SELECT *
FROM employees
WHERE salary >= (SELECT salary FROM employees WHERE first_name = 'Steven');

-- 다중행 서브쿼리 IN, ANY, ALL
SELECT salary
FROM employees
WHERE first_name = 'David'; -- David 3명
-- David의 최소급여보다 많이 받는 사람 (4800 보다 큰) 
SELECT *
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David의 최대급여보다 적게 받는 사람 (9500 보다 작은)
SELECT *
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David의 최대급여보다 많이 받는 사람 (9500 보다 큰)
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David의 최소급여보다 적게 받는 사람 (4800 보다 작은)
SELECT *
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David와 부서가 같은 (60, 80, 80)
SELECT *
FROM employees
WHERE department_id IN (SELECT department_id
                    FROM employees
                    WHERE first_name = 'David');

---------------------------------------------------------                   
-- 스칼라 쿼리 : SELECT 문에 서브쿼리가 들어가는 경우 (= JOIN)
-- JOIN
SELECT e.first_name, d.department_name
FROM employees E
LEFT JOIN departments D
ON e.department_id = d.department_id;
-- SCALAR
SELECT e.first_name,
      (SELECT d.department_name
       FROM departments D
       WHERE d.department_id = e.department_id)
FROM employees E;
-- 다른 테이블의 1개의 컬럼을 가지고 올 때, JOIN보다 깔끔
SELECT first_name, job_id,(SELECT j.job_title FROM jobs J WHERE j.job_id = e.job_id)
FROM employees E;
-- 한번에 하나의 컬럼만을 가져오기 때문에, 여러개의 컬럼이 필요할 때에는 JOIN구문의 가독성이 더 좋을 수 있음
SELECT first_name, job_id,
      (SELECT j.job_title FROM jobs J WHERE j.job_id = e.job_id),
      (SELECT j.min_salary FROM jobs J WHERE j.job_id = e.job_id)
FROM employees E;
-- FIRST_NAME, DEPARTMENT_NAME, JOB_TITLE 동시에 SELECT
-- SCALAR
SELECT e.first_name,
      (SELECT d.department_name
      FROM departments D
      WHERE e.department_id = d.department_id) DEPARTMENT_NAME,
      (SELECT j.job_title
      FROM jobs J
      WHERE e.job_id = j.job_id) JOB_TITLE
FROM employees E;
-- JOIN
SELECT e.first_name, d.department_name, j.job_title
FROM employees E
LEFT JOIN departments D
    ON e.department_id = d.department_id
LEFT JOIN jobs J
    ON e.job_id = j.job_id;

----------------------------------------------------------------
-- 인라인 뷰 : FROM절 하위에 서브쿼리가 들어가는 경우
-- 인라인 뷰에서 가상컬럼을 만들고, 그 컬럼에 대해서 조회에 나갈때 사용함
SELECT *
FROM (SELECT * 
      FROM employees);
-- ROWNUM 은 조회된 순서에 대해 번호가 붙음
SELECT ROWNUM, 
       first_name,
       salary
FROM employees
ORDER BY salary DESC; -- ROWNUM 뒤죽박죽
-- ORDER를 먼저 시킨 결과에 대해서 재조회 : ROWNUM 깔끔
SELECT ROWNUM, first_name, salary
FROM(SELECT first_name,
     salary
     FROM employees
     ORDER BY salary DESC)
WHERE ROWNUM BETWEEN 11 AND 20; -- ROWNUM은 반드시 1부터 시작해야함. 중간부터 X

-- ORDER를 먼저 시킨 결과를 만들고, ROWNUM 가상열로 다시 만들고 재조회
SELECT *
FROM (SELECT ROWNUM AS RN, -- 가상열
             first_name,
             salary
      FROM(SELECT first_name,
                  salary
           FROM employees
           ORDER BY salary DESC))
WHERE RN BETWEEN 11 AND 20; -- 안에서 RN 가상열을 밖에서 사용가능

-- 근속년수 *5년째 되는 사람들만 출력
SELECT *
FROM (SELECT first_name,
             hire_date,
             TRUNC((SYSDATE - hire_date) / 365) AS 근속년수
      FROM employees
      ORDER BY 근속년수 DESC)
WHERE MOD(근속년수, 5) = 0; -- WHERE에서 근속년수 사용가능
-- 인라인 뷰에서 테이블 엘리어스로 조회
SELECT ROWNUM AS RN, A.*
FROM (
      SELECT E.*, -- E 테이블의 전체 +
             TRUNC((SYSDATE - hire_date) / 365) AS 근속년수 -- 가상열
      FROM employees E
      ORDER BY 근속년수 DESC
) A;


