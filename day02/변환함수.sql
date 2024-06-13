-- 변환 함수
-- 형변환 함수
-- 자동 형변환을 제공해줍니다 (문자와 숫자, 문자와 날짜)
SELECT salary FROM employees WHERE salary >= '20000'; -- 문자 -> 숫자 자동 형변환
SELECT * FROM employees WHERE hire_date >= '08/01/01'; -- 문자 -> 날짜 자동 형변환

-- 강제 형변환
-- TO_CHAR 날짜 -> 문자
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM HH12:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY"년" MM"월" DD"일"') FROM DUAL; -- 포멧값이 아닌 값을 쓰려면 "" 안에 써야함

-- TO_CHAR 숫자 -> 문자
SELECT TO_CHAR(20000, '999999999') AS RESULT FROM DUAL; -- 9~ 자리수
SELECT TO_CHAR(20000, '099999999') AS RESULT FROM DUAL; -- 빈칸을 0으로 채움
SELECT TO_CHAR(20000, '999') AS RESULT FROM DUAL; -- 자리수가 부족하면 #처리
SELECT TO_CHAR(20000.123, '999999.9999') AS RESULT FROM DUAL; -- 정수의 빈자리는 빈칸으로 처리되지만, 실수의 빈자리는 0이 들어옴
SELECT TO_CHAR(20000, '$99,999,999') AS RESULT FROM DUAL; -- 빈칸 한개를 $
SELECT TO_CHAR(20000, 'L99,999,999') AS RESULT FROM DUAL; -- 각 국 지역화폐기호

-- 오늘 환율 1372.17원 일때, SALARY 값을 원화로 표현
SELECT first_name, TO_CHAR(salary * 1372.17, 'L999,999,999') AS 원화 FROM employees;

-- TO_DATE 문자 -> 날짜
SELECT SYSDATE - TO_DATE('2024-06-13', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2024년 06월 13일', 'YYYY"년" MM"월" DD"일"') FROM DUAL;
SELECT TO_DATE('2024-06-13 11시 30분 23초', 'YYYY-MM-DD HH"시" MI"분" SS"초"') FROM DUAL;
-- '240613' -> '2024년06월13일'
SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"년"MM"월"DD"일"') FROM DUAL;

-- TO_NUMBER 문자를 숫자로
SELECT '4000' - 1000 FROM DUAL; -- 자동 형변환
SELECT TO_NUMBER('4000') - 1000 FROM DUAL; -- 명시적변환 후 연산
SELECT '$5,500' - 1000 FROM DUAL; -- 자동 형변환 불가
SELECT TO_NUMBER('$5,500', '$999,999') - 1000 FROM DUAL; -- 명시적변환 후 연산

-- NULL 처리 함수
-- NVL (대상값, NULL인 경우)
SELECT NVL(1000, 0), NVL(NULL, 0) FROM DUAL;
SELECT NULL + 1000 FROM DUAL; -- NULL에 연산이 들어가면 NULL이 나옴
SELECT first_name, salary, commission_pct, salary + salary * NVL(commission_pct, 0) AS 최종급여 FROM employees;
-- NVL2 (대상값, NULL이 아닌 경우, NULL인 경우)
SELECT NVL2(NULL, 'NULL이 아닙니다', 'NULL입니다') FROM DUAL;
SELECT first_name, salary, commission_pct, NVL2(commission_pct, salary + salary * commission_pct, salary) AS 최종급여 FROM employees;

-- COALESCE (값, 값, 값...) NULL이 아닌 첫번째 값을 반환 시켜줌
SELECT COALESCE(NULL, 1, 2) FROM DUAL;
SELECT COALESCE(NULL,NULL,NULL) FROM DUAL;
SELECT COALESCE(commission_pct, 0) FROM employees; -- NVL과 같음

-- DECODE (대상값, 비교값, 결과값, 비교값, 결과값.......) == IF, ELSE IF, ELSE
SELECT DECODE('A', 'A', 'A입니다') FROM DUAL; -- IF
SELECT DECODE('X', 'A', 'A입니다', 'A가 아닙니다') FROM DUAL; -- IF, ELSE
SELECT DECODE('B', 'A', 'A입니다'
                 , 'B', 'B입니다'
                 , 'C', 'C입니다'
                 , '전부 아닙니다')
FROM DUAL; -- IF, ELSE IF, ELSE
SELECT job_id, DECODE(job_id, 'IT_PROG', salary * 1.1
                            , 'AD_VP', salary * 1.2
                            , 'FI_MGR', salary * 1.3
                            , salary) AS 급여
FROM employees;

-- CASE ~ WHEN ~ THEN ~ ELSE ~ END == SWITCH
SELECT job_id,
       CASE job_id WHEN 'IT_PROG' THEN salary * 1.1
                   WHEN 'AD_VP' THEN salary * 1.2
                   WHEN 'FI_MGR' THEN salary * 1.3
                   ELSE salary
       END AS 급여
FROM employees;
-- 비교에 대한 조건을 WHEN절에 쓸 수도 있음
SELECT job_id,
       CASE WHEN job_id = 'IT_PROG' THEN salary * 1.1
            WHEN job_id = 'AD_VP' THEN salary * 1.2
            WHEN job_id = 'FI_MGR' THEN salary * 1.3
            ELSE salary
       END
FROM employees;