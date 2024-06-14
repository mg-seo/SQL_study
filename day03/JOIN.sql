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

-- 테이블이 ALIAS
SELECT i.id,
       i.title,
       a.auth_id,
       a.name,
       a.job
FROM info I -- TABLE ALIAS
INNER JOIN AUTH A
ON i.auth_id = a.auth_id;

-- 연결할 키가 같다면 USING 사용 가능
SELECT * FROM info INNER JOIN auth USING (AUTH_ID);

-- OUTER JOIN
-- LEFT OUTER JOIN (OUTER 생략가능) 왼쪽테이블이 기준으로, 왼쪽테이블은 다 나옴
SELECT * FROM info I LEFT OUTER JOIN auth A ON i.auth_id = a.auth_id;
-- RIGHT OUTER JOIN
SELECT * FROM info I RIGHT OUTER JOIN auth A ON i.auth_id = a.auth_id;
-- FULL OUTER JOIN 양쪽 데이터 누락없이 다 나옴
SELECT * FROM info I FULL OUTER JOIN auth A ON i.auth_id = a.auth_id;

-- CROSS JOIN 잘못된 조인의 형태로 실제로 쓸일은 없음
SELECT * FROM info I CROSS JOIN auth A ORDER BY i.id;

-- SELF JOIN 하나의 테이블을 가지고 조인을 거는것
SELECT e.first_name, e.manager_id, e2.employee_id, e2.first_name 
FROM employees E 
LEFT JOIN employees E2 
ON e.manager_id = e2.employee_id;

-- 
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

SELECT * FROM employees E INNER JOIN departments D ON e.department_id = d.department_id;
-- JOIN 여러번 할 수 있음
SELECT e.employee_id, e.first_name, d.department_name, l.city 
FROM employees E 
LEFT JOIN departments D ON e.department_id = d.department_id
LEFT JOIN locations L ON d.location_id = l.location_id
WHERE e.employee_id >= 150;

-- ORACLE JOIN : 오라클에서만 사용할 수 있고, 조인할 테이블을 FROM에 쓰고 조인조건을 WHERE에 씁니다
SELECT *
FROM info I, auth A
WHERE i.auth_id = a.auth_id; -- = INNER JOIN
-- WHERE i.auth_id = a.auth_id(+); -- = LEFT OUTER JOIN
-- FULL OUTER JOIN 은 없음

SELECT *
FROM info, auth; -- CROSS JOIN


