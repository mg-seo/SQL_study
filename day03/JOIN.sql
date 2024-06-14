SELECT * FROM info;
SELECT * FROM auth;

-- ANSI JOIN
-- INNER JOIN
SELECT * 
FROM info 
INNER JOIN auth 
ON info.auth_id = auth.auth_id;

SELECT info.id, info.title, info.content, info.auth_id, auth.name
FROM info 
INNER JOIN auth 
ON info.auth_id = auth.auth_id;

-- ���̺��� ALIAS
SELECT i.id,
       i.title,
       a.auth_id,
       a.name,
       a.job
FROM info I -- TABLE ALIAS
INNER JOIN AUTH A
ON i.auth_id = a.auth_id;

-- ������ Ű�� ���ٸ� USING ��� ����
SELECT * FROM info INNER JOIN auth USING (AUTH_ID);

-- OUTER JOIN
-- LEFT OUTER JOIN (OUTER ��������) �������̺��� ��������, �������̺��� �� ����
SELECT * FROM info I LEFT OUTER JOIN auth A ON i.auth_id = a.auth_id;
-- RIGHT OUTER JOIN
SELECT * FROM info I RIGHT OUTER JOIN auth A ON i.auth_id = a.auth_id;
-- FULL OUTER JOIN ���� ������ �������� �� ����
SELECT * FROM info I FULL OUTER JOIN auth A ON i.auth_id = a.auth_id;

-- CROSS JOIN �߸��� ������ ���·� ������ ������ ����
SELECT * FROM info I CROSS JOIN auth A ORDER BY i.id;

-- SELF JOIN �ϳ��� ���̺��� ������ ������ �Ŵ°�
SELECT e.first_name, e.manager_id, e2.employee_id, e2.first_name 
FROM employees E 
LEFT JOIN employees E2 
ON e.manager_id = e2.employee_id;

-- 
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;
-- JOIN ������ �� �� ����
SELECT e.employee_id, e.first_name, d.department_name, l.city 
FROM employees E 
LEFT JOIN departments D ON e.department_id = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE e.employee_id >= 150;

-- ORACLE JOIN : ����Ŭ������ ����� �� �ְ�, ������ ���̺��� FROM�� ���� ���������� WHERE�� ���ϴ�
SELECT *
FROM info I, auth A
WHERE i.auth_id = a.auth_id; -- = INNER JOIN
-- WHERE i.auth_id = a.auth_id(+); -- = LEFT OUTER JOIN
-- FULL OUTER JOIN �� ����

SELECT *
FROM info, auth; -- CROSS JOIN


