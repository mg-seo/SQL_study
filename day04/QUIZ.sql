--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
SELECT AVG(salary) FROM employees; -- 6461
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees)
ORDER BY salary DESC;
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
SELECT COUNT(*)
FROM (SELECT *
      FROM employees
      WHERE salary > (SELECT AVG(salary)
                      FROM employees));
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.
SELECT AVG(salary) FROM employees WHERE job_id = 'IT_PROG'; -- 5760
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE job_id = 'IT_PROG')
ORDER BY salary DESC;

--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE manager_id = 100);

--���� 3.
--- EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
SELECT first_name, manager_id FROM employees WHERE first_name = 'Pat'; -- 201
SELECT *
FROM employees
WHERE manager_id > (SELECT manager_id
                    FROM employees
                    WHERE first_name = 'Pat');
--- EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT manager_id FROM employees WHERE first_name = 'James'; -- 120, 121
SELECT *
FROM employees
WHERE manager_id IN (SELECT manager_id
                     FROM employees
                     WHERE first_name = 'James');
--- Steven�� ������ �μ��� �ִ� ������� ������ּ���.
SELECT department_id FROM employees WHERE first_name = 'Steven'; -- 90, 50
SELECT *
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE first_name = 'Steven');
--- Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.
SELECT salary FROM employees WHERE first_name = 'Steven'; -- 24000, 2200
SELECT *
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE first_name = 'Steven'); -- 2200���� ū

--���� 4.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT e.employee_id, e.last_name || e.first_name AS �̸�, e.department_id, d.department_name
FROM employees E
LEFT JOIN departments D
ON e.department_id = d.department_id
ORDER BY e.employee_id;

--���� 5.
--���� 4�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT employee_id, 
       last_name || first_name AS �̸�, 
       department_id, 
       (SELECT department_name
        FROM departments D
        WHERE e.department_id = d.department_id) DEPARTMENT_NAME
FROM employees E;

--���� 6.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT d.department_id, d.department_name, l.street_address, l.city
FROM departments D
LEFT JOIN locations L
ON d.location_id = l.location_id
ORDER BY d.department_id;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT department_id, 
       department_name, 
      (SELECT l.street_address
       FROM locations L
       WHERE d.location_id = l.location_id) STREET_ADDRESS,
       (SELECT l.city
       FROM locations L
       WHERE d.location_id = l.location_id) CITY
FROM departments D;

--���� 8.
--LOCATIONS���̺� COUNTRIES���̺��� ��Į�� ������ ��ȸ�ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT l.location_id, l.street_address, l.city,
      (SELECT c.country_id
       FROM countries C
       WHERE l.country_id = c.country_id) COUNTRY_ID,
       (SELECT c.country_name
       FROM countries C
       WHERE l.country_id = c.country_id) COUNTRY_NAME
FROM locations L
ORDER BY COUNTRY_NAME;

--���� 9.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT *
FROM (SELECT ROWNUM RN, first_name
      FROM(SELECT first_name
           FROM employees
           ORDER BY first_name DESC))
WHERE rn BETWEEN 41 AND 50;

--���� 10.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT *
FROM (SELECT ROWNUM RN, employee_id, first_name, phone_number, hire_date
      FROM (SELECT employee_id, first_name, phone_number, hire_date
            FROM employees
            ORDER BY hire_date))
WHERE rn BETWEEN 31 AND 40;

--���� 11.
--COMMITSSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������. (�ζ��κ並 ���� �˴ϴ�)
SELECT *
FROM (SELECT E.*, NVL2(commission_pct,salary + salary * commission_pct, salary) AS �ѱ޿�
      FROM employees E)
WHERE �ѱ޿� > 10000;

--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.
SELECT first_name FROM employees ORDER BY hire_date;
-- Alexander ~ Ellen
SELECT RN, employee_id, first_name, hire_date, department_name
FROM(SELECT ROWNUM RN, A.*
     FROM (SELECT employee_id, first_name, hire_date, department_id
           FROM employees
           ORDER BY hire_date)A)B
LEFT JOIN departments D
ON B.department_id = d.department_id
WHERE RN BETWEEN 10 AND 20
ORDER BY RN;


--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.
SELECT E.*, (SELECT department_name 
             FROM departments D 
             WHERE e.department_id = d.department_id) �μ���
FROM (SELECT ROWNUM RN, A.*
      FROM (SELECT first_name, salary, department_id
            FROM employees
            WHERE job_id = 'SA_MAN'
            ORDER BY salary DESC)A)E
ORDER BY FIRST_NAME;

--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.
SELECT d.department_name, d.manager_id, E.cnt
FROM departments D
INNER JOIN (SELECT COUNT(*) CNT, department_id
           FROM employees
           GROUP BY department_id) E
ON d.department_id = E.department_id
ORDER BY E.cnt DESC;

--����15
--�μ��� ��� �÷�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���
SELECT D.*, l.street_address, l.postal_code, NVL(E.��տ���, 0) AVG_SALARY
FROM departments D
LEFT JOIN locations L
ON d.location_id = l.location_id
LEFT JOIN (SELECT department_id, TRUNC(AVG(SALARY)) ��տ���
           FROM employees
           GROUP BY DEPARTMENT_ID) E
ON d.department_id = e.department_id;

--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���
SELECT ROWNUM, A.*
FROM(SELECT D.*, l.street_address, l.postal_code, NVL(E.��տ���, 0) AVG_SALARY
     FROM departments D
     LEFT JOIN locations L
     ON d.location_id = l.location_id
     LEFT JOIN (SELECT department_id, TRUNC(AVG(SALARY)) ��տ���
                FROM employees
                GROUP BY DEPARTMENT_ID) E
     ON d.department_id = e.department_id
     ORDER BY d.department_id DESC)A
WHERE ROWNUM BETWEEN 1 AND 10;


