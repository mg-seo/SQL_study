-- �׷��Լ�
-- MAX �ִ밪, MIN �ּҰ�, SUM ��, COUNT ���� ���� / NULL�� ���ܵ� �����͵鿡 ���ؼ� ����
SELECT MAX(salary), MIN(salary), SUM(salary), COUNT(salary) FROM employees;
-- MIN , MAX�� ��¥, ���ڿ��� ���� ����
SELECT MIN(hire_date), MAX(hire_date), MIN(first_name), MAX(first_name) FROM employees;
-- COUNT() �ΰ��� ��� ���
SELECT COUNT(*), COUNT(commission_pct) FROM employees;
-- �μ��� 80�� ����� ��, Ŀ�̼��� ���� ���� ���
SELECT MAX(commission_pct) FROM employees WHERE department_id = 80;
-- �׷��Լ���, �Ϲ��÷��� ���ÿ� ����� �Ұ��� / OVER()�� �ٿ� ��� ����
SELECT first_name, AVG(salary) OVER(), COUNT(*) OVER(), SUM(salary) OVER() FROM employees;

-- GROUP BY �� / WHERE �� ORDER ���̿� ��ġ
SELECT department_id, job_id
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id, job_id, SUM(salary) AS �μ��������޿���, AVG(salary) AS �μ��������޿����, COUNT(*) AS �μ��ο���, COUNT(*) OVER() ��üī��Ʈ
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees
-- WHERE AVG(salary) >= 5000 �׸��ռ��� WHERE�� ���� �� ���� / HAVING�� �������
GROUP BY department_id;
-- HAVING�� GROUP BY�� ����
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

-- �μ� ���̵� NULL�� �ƴ� ������ �߿��� �Ի����� 05�⵵�� ������� �޿����,
-- �޿����� ���ϰ�, ��ձ޿��� 5000�̻��� �����͸�, �μ����̵�� ��������
SELECT department_id, AVG(salary) ��ձ޿�, SUM(salary) �޿���, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL AND hire_date LIKE '05%'
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

-- ROLLUP, GROUP BY ���� �Բ� ���ǰ�, �����׷��� �հ� ���� ����
SELECT department_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id); -- �������ٿ� ��ü �׷쿡 ���� �Ѱ�

SELECT department_id, job_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id, job_id) -- �ֱ׷� ���� ���, �������� ��ü �׷쿡 ���� �Ѱ�
ORDER BY department_id;

-- CUBE, ROLLUP + ����׷��� �Ѱ�
SELECT department_id, job_id, SUM(salary), AVG(salary), COUNT(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id;

-- GROUPING, �ش� ROW�� GROUP BY �� ���� ����Ǿ����� 0 ��ȯ, ROLLUP �Ǵ� CUBE�� ����������� 1��ȯ
SELECT DECODE(GROUPING(department_id), 1, '�Ѱ�', department_id) AS DEPARTMENT_ID, 
       DECODE(GROUPING(job_id), 1, '�Ұ�', JOB_ID) AS JOB_ID, 
       AVG(salary), 
       GROUPING(department_id), 
       GROUPING(job_id)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id;