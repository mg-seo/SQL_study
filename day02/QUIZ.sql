--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
--조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다.
SELECT employee_id AS 사원번호, CONCAT(first_name, last_name) AS 사원명, hire_date AS 입사일자, ROUND((SYSDATE - hire_date) / 365) AS 근속년수       
FROM employees WHERE ROUND((SYSDATE - hire_date) / 365) >= 10 ORDER BY 근속년수 DESC;

--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘부장’ 
--120이라면 ‘과장’
--121이라면 ‘대리’
--122라면 ‘주임’
--나머지는 ‘사원’ 으로 출력합니다.
--조건 1) 부서가 50인 사람들을 대상으로만 조회합니다
SELECT first_name, manager_id,
--조건 2) DECODE구문으로 표현해보세요.
--    DECODE(manager_id, 100, '부장'
--                     , 120, '과장'
--                     , 121, '대리'
--                     , 122, '주임'
--                     , '사원') AS 직급
--조건 3) CASE구문으로 표현해보세요.
    CASE manager_id WHEN 100 THEN '부장'
                    WHEN 120 THEN '과장'
                    WHEN 121 THEN '대리'
                    WHEN 122 THEN '주임'
                    ELSE '사원' 
    END AS 직급
FROM employees WHERE department_id = 50;

--문제 3. 
--EMPLOYEES 테이블의 이름, 입사일, 급여, 진급대상 을 출력합니다.
--조건1) HIRE_DATE를 XXXX년XX월XX일 형식으로 출력하세요. 
--조건2) 급여는 커미션값이 퍼센트로 더해진 값을 출력하고, 1300을 곱한 원화로 바꿔서 출력하세요.
--조건3) 진급대상은 5년 마다 이루어 집니다. 근속년수가 5의 배수라면 진급대상으로 출력합니다.
--조건4) 부서가 NULL이 아닌 데이터를 대상으로 출력합니다.
SELECT CONCAT(first_name, last_name) AS 이름
       , TO_CHAR(hire_date, 'YYYY"년"MM"월"DD"일"') AS 입사일
       , TO_CHAR(DECODE(commission_pct, NULL, salary, salary + salary * commission_pct) * 1300, 'L999,999,999') AS 급여
       , DECODE(MOD(ROUND((SYSDATE - hire_date) / 365), 5), 0, LPAD('O',5,' '), LPAD('X',5,' ')) AS 진급대상
FROM employees WHERE department_id IS NOT NULL;
