-- �м��Լ� RANK(), DENSE_RANK(), ROW_NUMBER()
-- �м��Լ�() OVER(���Ĺ��)
SELECT first_name,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS �ߺ��������, -- 1 2 2 4 5
       DENSE_RANK() OVER(ORDER BY salary DESC) AS �ߺ����µ��, -- 1 2 2 3 4
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS �Ϸù�ȣ,
       ROWNUM AS ��ȸ���� -- ROWNUM�� ORDER �� ����� �ٲ�
FROM employees;
SELECT ROWNUM, FIRST_NAME, SALARY FROM employees ORDER BY salary DESC;