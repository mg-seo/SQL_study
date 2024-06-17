-- �������� (SELECT �������� Ư����ġ�� �ٽ� SELECT�� ���� ����)
-- ������ �������� - ���������� ����� 1���� ��������

-- ���ú��� �޿��� ���� ���
-- ������ �޿��� ã�´� 
SELECT salary 
FROM employees
WHERE first_name = 'Nancy';
-- ã�� �޿��� WEHRE���� �ִ´�
SELECT * FROM employees WHERE salary > (SELECT salary 
                                        FROM employees
                                        WHERE first_name = 'Nancy');
                                        
-- 103���� ������ ���� ���
SELECT job_id FROM employees WHERE employee_id = 103;
SELECT * FROM employees WHERE job_id = (SELECT job_id 
                                        FROM employees 
                                        WHERE employee_id = 103);
                                        
-- ������ ��, ���� �÷��� �ݵ�� �Ѱ����� �� - * �ȉ�
SELECT * FROM employees WHERE job_id = (SELECT * FROM employees WHERE employee_id = 103);
                                            -- job_id.. ~ �� ���� ��

-- ������ ��, �������� ������ �����̶��, ������ �������� �����ڸ� �������
SELECT salary FROM employees WHERE first_name = 'Steven';  -- �� ��� Steven�� 2������ ������
SELECT *
FROM employees
WHERE salary >= (SELECT salary FROM employees WHERE first_name = 'Steven');

-- ������ �������� IN, ANY, ALL
SELECT salary
FROM employees
WHERE first_name = 'David'; -- David 3��
-- David�� �ּұ޿����� ���� �޴� ��� (4800 ���� ū) 
SELECT *
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David�� �ִ�޿����� ���� �޴� ��� (9500 ���� ����)
SELECT *
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David�� �ִ�޿����� ���� �޴� ��� (9500 ���� ū)
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David�� �ּұ޿����� ���� �޴� ��� (4800 ���� ����)
SELECT *
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE first_name = 'David');
-- David�� �μ��� ���� (60, 80, 80)
SELECT *
FROM employees
WHERE department_id IN (SELECT department_id
                    FROM employees
                    WHERE first_name = 'David');

---------------------------------------------------------                   
-- ��Į�� ���� : SELECT ���� ���������� ���� ��� (= JOIN)
-- JOIN
SELECT e.first_name, d.department_name
FROM employees E
LEFT JOIN departments D
ON e.department_id = d.department_id;
-- SCALAR
SELECT e.first_name,
      (SELECT d.department_name
       FROM departments D
       WHERE d.department_id = e.department_id)
FROM employees E;
-- �ٸ� ���̺��� 1���� �÷��� ������ �� ��, JOIN���� ���
SELECT first_name, job_id,(SELECT j.job_title FROM jobs J WHERE j.job_id = e.job_id)
FROM employees E;
-- �ѹ��� �ϳ��� �÷����� �������� ������, �������� �÷��� �ʿ��� ������ JOIN������ �������� �� ���� �� ����
SELECT first_name, job_id,
      (SELECT j.job_title FROM jobs J WHERE j.job_id = e.job_id),
      (SELECT j.min_salary FROM jobs J WHERE j.job_id = e.job_id)
FROM employees E;
-- FIRST_NAME, DEPARTMENT_NAME, JOB_TITLE ���ÿ� SELECT
-- SCALAR
SELECT e.first_name,
      (SELECT d.department_name
      FROM departments D
      WHERE e.department_id = d.department_id) DEPARTMENT_NAME,
      (SELECT j.job_title
      FROM jobs J
      WHERE e.job_id = j.job_id) JOB_TITLE
FROM employees E;
-- JOIN
SELECT e.first_name, d.department_name, j.job_title
FROM employees E
LEFT JOIN departments D
    ON e.department_id = d.department_id
LEFT JOIN jobs J
    ON e.job_id = j.job_id;

----------------------------------------------------------------
-- �ζ��� �� : FROM�� ������ ���������� ���� ���
-- �ζ��� �信�� �����÷��� �����, �� �÷��� ���ؼ� ��ȸ�� ������ �����
SELECT *
FROM (SELECT * 
      FROM employees);
-- ROWNUM �� ��ȸ�� ������ ���� ��ȣ�� ����
SELECT ROWNUM, 
       first_name,
       salary
FROM employees
ORDER BY salary DESC; -- ROWNUM ���׹���
-- ORDER�� ���� ��Ų ����� ���ؼ� ����ȸ : ROWNUM ���
SELECT ROWNUM, first_name, salary
FROM(SELECT first_name,
     salary
     FROM employees
     ORDER BY salary DESC)
WHERE ROWNUM BETWEEN 11 AND 20; -- ROWNUM�� �ݵ�� 1���� �����ؾ���. �߰����� X

-- ORDER�� ���� ��Ų ����� �����, ROWNUM ���󿭷� �ٽ� ����� ����ȸ
SELECT *
FROM (SELECT ROWNUM AS RN, -- ����
             first_name,
             salary
      FROM(SELECT first_name,
                  salary
           FROM employees
           ORDER BY salary DESC))
WHERE RN BETWEEN 11 AND 20; -- �ȿ��� RN ������ �ۿ��� ��밡��

-- �ټӳ�� *5��° �Ǵ� ����鸸 ���
SELECT *
FROM (SELECT first_name,
             hire_date,
             TRUNC((SYSDATE - hire_date) / 365) AS �ټӳ��
      FROM employees
      ORDER BY �ټӳ�� DESC)
WHERE MOD(�ټӳ��, 5) = 0; -- WHERE���� �ټӳ�� ��밡��
-- �ζ��� �信�� ���̺� ������� ��ȸ
SELECT ROWNUM AS RN, A.*
FROM (
      SELECT E.*, -- E ���̺��� ��ü +
             TRUNC((SYSDATE - hire_date) / 365) AS �ټӳ�� -- ����
      FROM employees E
      ORDER BY �ټӳ�� DESC
) A;


