--문자열 함수
SELECT LOWER('HELLO WORLD') FROM DUAL; -- SQL을 간단하게 연습하기 위한 가상테이블 DUAL
SELECT LOWER(first_name), UPPER(first_name), INITCAP(first_name) FROM employees; -- 소문자 대문자 앞대문자

-- LENGTH 문자열 길이
SELECT first_name, LENGTH(first_name) FROM employees;
-- INSTR 문자열 찾기
SELECT first_name, INSTR(first_name, 'a') FROM employees; -- a가 있는 위치 반환, 없는 경우 0반환
-- SUBSTR 문자열 자르기
SELECT first_name, SUBSTR(first_name, 3), SUBSTR(first_name, 3, 2) FROM employees; -- 3미만 절삭 / 3부터 2개 남기고 자름
-- CONCAT 문자열 합치기
SELECT first_name || last_name, CONCAT(first_name, last_name) FROM employees;
-- LPAD, RPAD 범위를 지정하고, 특정문자로 채움
SELECT LPAD('ABC', 10, '*') FROM DUAL; -- ABC를 10칸 잡고, 나머지 부분은 왼쪽에서 * 채움
SELECT LPAD(first_name, 10, '*'), RPAD(first_name, 10, '-') FROM employees;
-- TRIM, LTRIM, RTRIM 공백(문자)제거
SELECT TRIM('      HELLO WORLD      '), LTRIM('      HELLO WORLD      '), RTRIM('      HELLO WORLD      ') FROM DUAL;
SELECT LTRIM('HELLO WORLD', 'HE') FROM DUAL;
