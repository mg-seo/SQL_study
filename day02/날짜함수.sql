-- ��¥ �Լ�
SELECT SYSDATE FROM DUAL; -- ��/��/��
SELECT SYSTIMESTAMP FROM DUAL; -- ��/��/�� ��:��:��

-- ���� ����
SELECT hire_date, hire_date + 1, hire_date - 1 FROM employees; -- ���� �������� ����
SELECT first_name, SYSDATE - hire_date FROM employees; -- ��
SELECT first_name, (SYSDATE - hire_date) / 7 FROM employees; -- ��
SELECT first_name, (SYSDATE - hire_date) / 365 FROM employees; -- ��

-- ��¥�� �ݿø�, ����
SELECT ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL; -- ���� ���� �ݿø�, ����
SELECT ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- ������
SELECT ROUND(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- ������
