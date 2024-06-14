-- 그룹함수
-- MAX 최대값, MIN 최소값, SUM 합, COUNT 행의 개수 / NULL이 제외된 데이터들에 대해서 적용
SELECT MAX(salary), MIN(salary), SUM(salary), COUNT(salary) FROM employees;
-- MIN , MAX는 날짜, 문자에도 적용 가능
SELECT MIN(hire_date), MAX(hire_date), MIN(first_name), MAX(first_name) FROM employees;
-- COUNT() 두가지 사용 방법
SELECT COUNT(*), COUNT(commission_pct) FROM employees;
-- 부서가 80인 사람들 중, 커미션이 가장 높은 사람
SELECT MAX(commission_pct) FROM employees WHERE department_id = 80;
-- 그룹함수는, 일반컬럼과 동시에 사용이 불가능 / OVER()를 붙여 사용 가능
SELECT first_name, AVG(salary) OVER(), COUNT(*) OVER(), SUM(salary) OVER() FROM employees;

-- GROUP BY 절 / WHERE 과 ORDER 사이에 위치
SELECT department_id, job_id
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id, job_id, SUM(salary) AS 부서직무별급여합, AVG(salary) AS 부서직무별급여평균, COUNT(*) AS 부서인원수, COUNT(*) OVER() 전체카운트
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees
-- WHERE AVG(salary) >= 5000 그릅합수는 WHERE에 적을 수 없음 / HAVING에 적어야함
GROUP BY department_id;
-- HAVING절 GROUP BY의 조건
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
HAVING SUM(salary) >= 100000 OR COUNT(*) >= 5;

SELECT department_id, job_id, AVG(salary), COUNT(*), COUNT(commission_pct)
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY department_id, job_id
HAVING AVG(salary) >= 10000
ORDER BY AVG(salary) DESC;

-- 부서 아이디가 NULL이 아닌 데이터 중에서 입사일은 05년도인 사람들의 급여평균,
-- 급여합을 구하고, 평균급여는 5000이상인 데이터만, 부서아이디로 내림차순
SELECT department_id, AVG(salary) 평균급여, SUM(salary) 급여합, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL AND hire_date LIKE '05%'
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

-- ROLLUP, GROUP BY 절과 함께 사용되고, 상위그룹의 합계 등을 구함
SELECT department_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id); -- 마지막줄에 전체 그룹에 대한 총계

SELECT department_id, job_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id, job_id) -- 주그룹 이후 통계, 마지막줄 전체 그룹에 대한 총계
ORDER BY department_id;

-- CUBE, ROLLUP + 서브그룹의 총계
SELECT department_id, job_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

-- GROUPING, 해당 ROW가 GROUP BY 에 의해 산출되었으면 0 반환, ROLLUP 또는 CUBE로 만들어졌으면 1반환
SELECT DECODE(GROUPING(department_id), 1, '총계', department_id) AS DEPARTMENT_ID, 
       DECODE(GROUPING(job_id), 1, '소계', JOB_ID) AS JOB_ID, 
       AVG(salary), 
       GROUPING(department_id), 
       GROUPING(job_id)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id;