-- ���տ�����
-- �÷� ������ ��ġ�ؾ� ���տ����� ����� ����
-- UNION, UNION ALL, INTERSECT, MINUS
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
UNION -- Michael �� �θ��ε�, �� �� �����(�ߺ�����)
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
UNION ALL -- Michael �θ� �� ���
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
INTERSECT -- ������ Michael�� ���
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '04%'
MINUS -- ������, ������ ����
SELECT first_name, hire_date FROM employees WHERE department_id = 20;
-----------------------------------------------------------------------
-- ���տ����ڴ� DUAL���� ���� �����͸� ���� ��ĥ ���� �ִ�
SELECT 200 AS ��ȣ, 'HONG' AS �̸�, '�����' AS ���� FROM DUAL
UNION ALL
SELECT 300, 'LEE', '��⵵' FROM DUAL
UNION ALL
SELECT EMPLOYEE_ID, LAST_NAME, '�����' FROM EMPLOYEES;
