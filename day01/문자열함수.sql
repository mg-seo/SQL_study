--���ڿ� �Լ�
SELECT LOWER('HELLO WORLD') FROM DUAL; -- SQL�� �����ϰ� �����ϱ� ���� �������̺� DUAL
SELECT LOWER(first_name), UPPER(first_name), INITCAP(first_name) FROM employees; -- �ҹ��� �빮�� �մ빮��

-- LENGTH ���ڿ� ����
SELECT first_name, LENGTH(first_name) FROM employees;
-- INSTR ���ڿ� ã��
SELECT first_name, INSTR(first_name, 'a') FROM employees; -- a�� �ִ� ��ġ ��ȯ, ���� ��� 0��ȯ
-- SUBSTR ���ڿ� �ڸ���
SELECT first_name, SUBSTR(first_name, 3), SUBSTR(first_name, 3, 2) FROM employees; -- 3�̸� ���� / 3���� 2�� ����� �ڸ�
-- CONCAT ���ڿ� ��ġ��
SELECT first_name || last_name, CONCAT(first_name, last_name) FROM employees;
-- LPAD, RPAD ������ �����ϰ�, Ư�����ڷ� ä��
SELECT LPAD('ABC', 10, '*') FROM DUAL; -- ABC�� 10ĭ ���, ������ �κ��� ���ʿ��� * ä��
SELECT LPAD(first_name, 10, '*'), RPAD(first_name, 10, '-') FROM employees;
-- TRIM, LTRIM, RTRIM ����(����)����
SELECT TRIM('      HELLO WORLD      '), LTRIM('      HELLO WORLD      '), RTRIM('      HELLO WORLD      ') FROM DUAL;
SELECT LTRIM('HELLO WORLD', 'HE') FROM DUAL;
