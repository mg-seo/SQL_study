-- 날짜 함수
SELECT SYSDATE FROM DUAL; -- 년/월/일
SELECT SYSTIMESTAMP FROM DUAL; -- 년/월/일 시:분:초

-- 연산 가능
SELECT hire_date, hire_date + 1, hire_date - 1 FROM employees; -- 일자 기준으로 연산
SELECT first_name, SYSDATE - hire_date FROM employees; -- 일
SELECT first_name, (SYSDATE - hire_date) / 7 FROM employees; -- 주
SELECT first_name, (SYSDATE - hire_date) / 365 FROM employees; -- 연

-- 날짜의 반올림, 절삭
SELECT ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL; -- 일자 기준 반올림, 절삭
SELECT ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- 월기준
SELECT ROUND(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- 연기준
