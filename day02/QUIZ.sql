--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�.
SELECT employee_id AS �����ȣ, CONCAT(first_name, last_name) AS �����, hire_date AS �Ի�����, ROUND((SYSDATE - hire_date) / 365) AS �ټӳ��       
FROM employees WHERE ROUND((SYSDATE - hire_date) / 365) >= 10 ORDER BY �ټӳ�� DESC;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �����塯 
--120�̶�� �����塯
--121�̶�� ���븮��
--122��� �����ӡ�
--�������� ������� ���� ����մϴ�.
--���� 1) �μ��� 50�� ������� ������θ� ��ȸ�մϴ�
SELECT first_name, manager_id,
--���� 2) DECODE�������� ǥ���غ�����.
--    DECODE(manager_id, 100, '����'
--                     , 120, '����'
--                     , 121, '�븮'
--                     , 122, '����'
--                     , '���') AS ����
--���� 3) CASE�������� ǥ���غ�����.
    CASE manager_id WHEN 100 THEN '����'
                    WHEN 120 THEN '����'
                    WHEN 121 THEN '�븮'
                    WHEN 122 THEN '����'
                    ELSE '���' 
    END AS ����
FROM employees WHERE department_id = 50;

--���� 3. 
--EMPLOYEES ���̺��� �̸�, �Ի���, �޿�, ���޴�� �� ����մϴ�.
--����1) HIRE_DATE�� XXXX��XX��XX�� �������� ����ϼ���. 
--����2) �޿��� Ŀ�̼ǰ��� �ۼ�Ʈ�� ������ ���� ����ϰ�, 1300�� ���� ��ȭ�� �ٲ㼭 ����ϼ���.
--����3) ���޴���� 5�� ���� �̷�� ���ϴ�. �ټӳ���� 5�� ������ ���޴������ ����մϴ�.
--����4) �μ��� NULL�� �ƴ� �����͸� ������� ����մϴ�.
SELECT CONCAT(first_name, last_name) AS �̸�
       , TO_CHAR(hire_date, 'YYYY"��"MM"��"DD"��"') AS �Ի���
       , TO_CHAR(DECODE(commission_pct, NULL, salary, salary + salary * commission_pct) * 1300, 'L999,999,999') AS �޿�
       , DECODE(MOD(ROUND((SYSDATE - hire_date) / 365), 5), 0, LPAD('O',5,' '), LPAD('X',5,' ')) AS ���޴��
FROM employees WHERE department_id IS NOT NULL;
