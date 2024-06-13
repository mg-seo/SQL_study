SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

-- Ư�� �÷��� ��ȸ�ϱ�
-- ���ڿ� ��¥�� ���ʿ�, ���ڴ� �����ʿ� ǥ�õ˴ϴ�
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY FROM employees;

-- �÷��� �ڸ������� ���� �Ǵ� ��¥�� ������ �˴ϴ�
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM employees;

-- PK�� EMPLYEE_ID, FK�� DEPARTMENT_ID
SELECT * FROM employees;

-- �����(��Ī)
SELECT FIRST_NAME AS �̸�, SALARY AS �޿�, SALARY + SALARY * 0.1 AS "���� �޿�" FROM employees;

-- ���ڿ� ���� ||
-- Ȭ �ȿ��� Ȭ ����ʹٸ� ''
SELECT 'HELLO' || 'WORLD' FROM employees;
SELECT FIRST_NAME || '''���� �޿��� ' || SALARY || '$�Դϴ�' FROM employees;

-- DISTINCT(�ߺ�����) Ű����
SELECT DEPARTMENT_ID FROM employees;
SELECT DISTINCT DEPARTMENT_ID FROM employees;

-- ROWNUM(��ȸ�� ����), ROWID(���ڵ尡 ����� ��ġ)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM employees;



