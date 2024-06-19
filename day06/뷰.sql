-- 뷰는 제한적인 데이터를 쉽게 보기위해서 미리 만들어 놓은 가상테이블 입니다.
-- 자주 사용되는 컬럼을 지정하면, 관리가 용이합니다
-- 뷰는 물리적으로 데이터가 저장된 것으 ㄴ아니고, 원본테이블을 기반으로 한 가상테이블 이라고 생각하면 됩니다.
-- 뷰를 만드려면 권한이 필요합니다 (HR) 권한을 가지고 있습니다.
SELECT * FROM  emp_details_view; -- 미리 만들어져 있는 뷰
SELECT * FROM user_sys_privs; --

-- 단순뷰 (하나의 테이블로 생성된 뷰)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID AS EMP_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           JOB_ID,
           SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 60
);
SELECT * FROM VIEW_EMP;

 복합뷰 (두개 이상의 테이블로 생성된 뷰)
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT e.employee_id,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       J.JOB_TITLE,
       D.DEPARTMENT_NAME
    FROM employees E 
    JOIN departments D
    ON e.department_id = d.department_id
    LEFT JOIN jobs J
    ON e.job_id = j.job_id
);
SELECT JOB_TITLE, COUNT(*) AS 사원수 
FROM VIEW_EMP_JOB
GROUP BY JOB_TITLE;

-- 뷰의 수정 (OR REPLACE)
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT e.employee_id,
       FIRST_NAME || ' ' || LAST_NAME AS NAME,
       J.JOB_TITLE,
       J.MAX_SALARY, -- 수정
       J.MIN_SALARY, -- 수정
       D.DEPARTMENT_NAME
    FROM employees E 
    JOIN departments D
    ON e.department_id = d.department_id
    LEFT JOIN jobs J
    ON e.job_id = j.job_id
);
SELECT * FROM VIEW_EMP_JOB;

-- 뷰의 삭제 DROP VIEW
DROP VIEW VIEW_EMP_JOB;

-- 단순뷰는 뷰를 통해서 INSERT, UPDATE가 가능한데, 제약사항들이 있습니다.
-- 복합뷰는 INSERT, UPDATE 불가능
SELECT * FROM VIEW_EMP; -- 단순뷰
-- EMP_ID, NAME이 가상열이기 때문에 INSERT가 들어가지 못함
INSERT INTO VIEW_EMP VALUES(108, 'HONG', 'IT_PROG', 10000);
-- 원본테이블의 NOT NULL 제약에 위배되기 때문에 들어가지 못함
INSERT INTO VIEW_EMP(JOB_ID, SALARY) VALUES ('IT_PROG', 10000);

-- 뷰의 옵션
-- WITH CHECK OPTION (WHERE절에 있는 컬럼의 변경을 금지함)
-- WITH READ ONLY (SELECT만 허용함)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID,
           FIRST_NAME,
           EMAIL,
           JOB_ID,
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN(60, 70, 80)
) WITH CHECK OPTION; /* WITH READ ONLY; */
UPDATE VIEW_EMP SET DEPARTMENT_ID = 10; --불가
