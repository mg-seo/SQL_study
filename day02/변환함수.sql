-- ��ȯ �Լ�
-- ����ȯ �Լ�
-- �ڵ� ����ȯ�� �������ݴϴ� (���ڿ� ����, ���ڿ� ��¥)
SELECT salary FROM employees WHERE salary >= '20000'; -- ���� -> ���� �ڵ� ����ȯ
SELECT * FROM employees WHERE hire_date >= '08/01/01'; -- ���� -> ��¥ �ڵ� ����ȯ

-- ���� ����ȯ
-- TO_CHAR ��¥ -> ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD AM HH12:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY"��" MM"��" DD"��"') FROM DUAL; -- ���䰪�� �ƴ� ���� ������ "" �ȿ� �����

-- TO_CHAR ���� -> ����
SELECT TO_CHAR(20000, '999999999') AS RESULT FROM DUAL; -- 9~ �ڸ���
SELECT TO_CHAR(20000, '099999999') AS RESULT FROM DUAL; -- ��ĭ�� 0���� ä��
SELECT TO_CHAR(20000, '999') AS RESULT FROM DUAL; -- �ڸ����� �����ϸ� #ó��
SELECT TO_CHAR(20000.123, '999999.9999') AS RESULT FROM DUAL; -- ������ ���ڸ��� ��ĭ���� ó��������, �Ǽ��� ���ڸ��� 0�� ����
SELECT TO_CHAR(20000, '$99,999,999') AS RESULT FROM DUAL; -- ��ĭ �Ѱ��� $
SELECT TO_CHAR(20000, 'L99,999,999') AS RESULT FROM DUAL; -- �� �� ����ȭ���ȣ

-- ���� ȯ�� 1372.17�� �϶�, SALARY ���� ��ȭ�� ǥ��
SELECT first_name, TO_CHAR(salary * 1372.17, 'L999,999,999') AS ��ȭ FROM employees;

-- TO_DATE ���� -> ��¥
SELECT SYSDATE - TO_DATE('2024-06-13', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2024�� 06�� 13��', 'YYYY"��" MM"��" DD"��"') FROM DUAL;
SELECT TO_DATE('2024-06-13 11�� 30�� 23��', 'YYYY-MM-DD HH"��" MI"��" SS"��"') FROM DUAL;
-- '240613' -> '2024��06��13��'
SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"��"MM"��"DD"��"') FROM DUAL;

-- TO_NUMBER ���ڸ� ���ڷ�
SELECT '4000' - 1000 FROM DUAL; -- �ڵ� ����ȯ
SELECT TO_NUMBER('4000') - 1000 FROM DUAL; -- �������ȯ �� ����
SELECT '$5,500' - 1000 FROM DUAL; -- �ڵ� ����ȯ �Ұ�
SELECT TO_NUMBER('$5,500', '$999,999') - 1000 FROM DUAL; -- �������ȯ �� ����

-- NULL ó�� �Լ�
-- NVL (���, NULL�� ���)
SELECT NVL(1000, 0), NVL(NULL, 0) FROM DUAL;
SELECT NULL + 1000 FROM DUAL; -- NULL�� ������ ���� NULL�� ����
SELECT first_name, salary, commission_pct, salary + salary * NVL(commission_pct, 0) AS �����޿� FROM employees;
-- NVL2 (���, NULL�� �ƴ� ���, NULL�� ���)
SELECT NVL2(NULL, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;
SELECT first_name, salary, commission_pct, NVL2(commission_pct, salary + salary * commission_pct, salary) AS �����޿� FROM employees;

-- COALESCE (��, ��, ��...) NULL�� �ƴ� ù��° ���� ��ȯ ������
SELECT COALESCE(NULL, 1, 2) FROM DUAL;
SELECT COALESCE(NULL,NULL,NULL) FROM DUAL;
SELECT COALESCE(commission_pct, 0) FROM employees; -- NVL�� ����

-- DECODE (���, �񱳰�, �����, �񱳰�, �����.......) == IF, ELSE IF, ELSE
SELECT DECODE('A', 'A', 'A�Դϴ�') FROM DUAL; -- IF
SELECT DECODE('X', 'A', 'A�Դϴ�', 'A�� �ƴմϴ�') FROM DUAL; -- IF, ELSE
SELECT DECODE('B', 'A', 'A�Դϴ�'
                 , 'B', 'B�Դϴ�'
                 , 'C', 'C�Դϴ�'
                 , '���� �ƴմϴ�')
FROM DUAL; -- IF, ELSE IF, ELSE
SELECT job_id, DECODE(job_id, 'IT_PROG', salary * 1.1
                            , 'AD_VP', salary * 1.2
                            , 'FI_MGR', salary * 1.3
                            , salary) AS �޿�
FROM employees;

-- CASE ~ WHEN ~ THEN ~ ELSE ~ END == SWITCH
SELECT job_id,
       CASE job_id WHEN 'IT_PROG' THEN salary * 1.1
                   WHEN 'AD_VP' THEN salary * 1.2
                   WHEN 'FI_MGR' THEN salary * 1.3
                   ELSE salary
       END AS �޿�
FROM employees;
-- �񱳿� ���� ������ WHEN���� �� ���� ����
SELECT job_id,
       CASE WHEN job_id = 'IT_PROG' THEN salary * 1.1
            WHEN job_id = 'AD_VP' THEN salary * 1.2
            WHEN job_id = 'FI_MGR' THEN salary * 1.3
            ELSE salary
       END
FROM employees;