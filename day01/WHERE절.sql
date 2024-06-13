-- WHERE ������
SELECT * FROM employees WHERE job_id = 'IT_PROG';
SELECT first_name, job_id FROM employees WHERE FIRST_NAME = 'David';
SELECT * FROM employees WHERE salary >= 15000;
SELECT * FROM employees WHERE department_id <> 90;
SELECT * FROM employees WHERE hire_date = '06/03/07'; -- ��¥ �񱳵� ���ڿ��� �մϴ�
SELECT * FROM employees WHERE hire_date > '06/03/01'; -- ���ڿ��� ��� �� ����

-- BETWEEN AND ������ ~���̿�
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 10000;
SELECT * FROM employees WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- IN ������
SELECT * FROM employees WHERE department_id IN (50, 60, 70);
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'ST_MAN');

-- LIKE ������ �˻��� ����, ���ͷ����� % , _
SELECT * FROM employees WHERE hire_date LIKE '03%'; -- 03���� �����ϴ�
SELECT * FROM employees WHERE hire_date LIKE '%03'; -- 03���� ������
SELECT * FROM employees WHERE hire_date LIKE '%03%'; -- 03�� ���� ����
SELECT * FROM employees WHERE job_id LIKE '%MAN%';
SELECT * FROM employees WHERE first_name LIKE '_a%'; -- �ι�°���ڰ� a�� �����ϴ�

-- NULL�� ã�� IS NULL, IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

-- AND, OR
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'FI_MGR');
SELECT * FROM employees WHERE job_id = 'IT_PROG' OR job_id = 'FI_MGR';
SELECT * FROM employees WHERE job_id = 'IT_PROG' OR salary >= 5000;
SELECT * FROM employees WHERE job_id = 'IT_PROG' AND salary >= 5000;
SELECT * FROM employees WHERE (job_id = 'IT_PROG' OR job_id = 'FI_MGR') AND salary >= 6000;

-- NOT ������ �ǹ�, ���� Ű����� ����
SELECT * FROM employees WHERE department_id NOT IN (50, 60);
SELECT * FROM employees WHERE job_id NOT LIKE '%MAN%';

-- ORDER BY ASC(��������) / DESC(��������) ����
SELECT * FROM employees ORDER BY first_name ASC; --ASC�� ��������
SELECT * FROM employees ORDER BY salary DESC;
SELECT first_name, salary * 12 AS ���� FROM employees ORDER BY ����; -- ��Ī ��밡��
SELECT * FROM employees ORDER BY department_id DESC, salary DESC; -- �������� ������
SELECT * FROM employees WHERE job_id IN ('IT_PROG', 'SA_MAN') ORDER BY first_name;


