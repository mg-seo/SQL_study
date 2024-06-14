-- �׷��Լ�
--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
SELECT job_id, COUNT(*) �����
FROM employees
GROUP BY job_id;
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;
--�ÿ� ���̺��� JOB_ID�� ���� ���� �Ի����� ���ϼ���. JOB_ID�� �������� �����ϼ���.
SELECT job_id, MIN(hire_date)
FROM employees
GROUP BY job_id
ORDER BY job_id DESC;

--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT CONCAT(20, SUBSTR(HIRE_DATE, 0, 2)) �Ի�⵵, COUNT(*) �����
FROM employees
GROUP BY SUBSTR(HIRE_DATE, 0, 2);

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT department_id, AVG(salary) ��ձ޿�
FROM employees
WHERE SALARY >= 1000
GROUP BY department_id
HAVING AVG(salary) >= 2000;

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT department_id, TRUNC(AVG(salary + salary * commission_pct), 2) ���, SUM(salary + salary * commission_pct) �հ�, COUNT(commission_pct) COUNT
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

--���� 5.
--�μ����̵� NULL�� �ƴϰ�, �Ի����� 05�⵵ �� ������� �μ� �޿���հ�, �޿��հ踦 ��ձ��� ���������մϴ�
--����) ����� 10000�̻��� �����͸�
SELECT department_id, AVG(salary) �޿����, SUM(salary) �޿��հ�
FROM employees
WHERE department_id IS NOT NULL AND SUBSTR(hire_date, 0, 2) = '05'
GROUP BY department_id
HAVING AVG(salary) >= 10000
ORDER BY AVG(salary) DESC;

--���� 6.
--������ ������, ���հ踦 ����ϼ���
SELECT DECODE(job_id, NULL, '���հ�', job_id) ����, SUM(salary) ������
FROM employees
GROUP BY ROLLUP(job_id);

--���� 7.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���
SELECT DECODE(GROUPING(department_id), 1, '�հ�', department_id) department_id,
       DECODE(GROUPING(job_id), 1, '�Ұ�', job_id) job_id,
       COUNT(*) TOTAL,
       SUM(salary) SUM
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY SUM(salary);

-- JOIN
--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E LEFT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E RIGHT JOIN departments D ON e.department_id = d.department_id;
SELECT * FROM employees E FULL JOIN departments D ON e.department_id = d.department_id;

--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT CONCAT(e.first_name, e.last_name), d.department_id
FROM employees E 
INNER JOIN departments D 
ON e.department_id = d.department_id
WHERE e.employee_id = 200;

--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT e.first_name, e.job_id, j.job_title
FROM employees E
INNER JOIN JOBS J
ON e.job_id = j.job_id
ORDER BY e.first_name;

--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT *
FROM jobs J
LEFT JOIN job_history H
ON j.job_id = h.job_id;

--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT CONCAT(e.first_name, LPAD(e.last_name, LENGTH(e.last_name)+1, ' ')) NAME, d.department_name
FROM employees E
INNER JOIN departments D
ON e.department_id = d.department_id
WHERE CONCAT(e.first_name, LPAD(e.last_name, LENGTH(e.last_name)+1, ' ')) = 'Steven King';


--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT *
FROM employees
CROSS JOIN departments;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT e.employee_id, e.first_name, TO_CHAR(e.salary, '$999,999') SALARY, d.department_name, l.city
FROM employees E
LEFT JOIN departments D ON e.department_id = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE e.job_id = 'SA_MAN';

--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM employees E
LEFT JOIN jobs J
ON e.job_id = j.job_id
WHERE j.job_title IN('Stock Manager', 'Stock Clerk');

--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT d.department_name
FROM departments D
LEFT JOIN employees E
USING(department_id)
WHERE e.employee_id IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT e.first_name, e2.first_name
FROM employees E
LEFT JOIN employees E2
ON e.manager_id = e2.employee_id;

--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT e.first_name, e2.first_name, e2.salary
FROM employees E
LEFT JOIN employees E2
ON e.manager_id = e2.employee_id
WHERE e.manager_id IS NOT NULL
ORDER BY e2.salary DESC;

--���ʽ� ���� 12.
--���������̽�(William smith)�� ���޵�(�����)�� ���ϼ���.
SELECT e3.first_name || ' > ' || e2.first_name || ' > ' || e.first_name ���޵�
FROM employees E
LEFT JOIN employees E2 ON e.manager_id = e2.employee_id
LEFT JOIN employees E3 ON e2.manager_id = e3.employee_id
WHERE e.first_name || ' ' || e.last_name = 'William Smith';

