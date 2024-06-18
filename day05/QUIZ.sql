--DML QUIZ
--문제 1.
--DEPTS테이블을 데이터를 포함해서 생성하세요.
--DEPTS테이블의 다음을 INSERT 하세요.
CREATE TABLE DEPTS AS
SELECT *
FROM DEPARTMENTS;
INSERT INTO DEPTS VALUES (280, '개발', NULL, 1800);
INSERT INTO DEPTS VALUES (290, '회계부', NULL, 1800);
INSERT INTO DEPTS VALUES (300, '재정', 301, 1800);
INSERT INTO DEPTS VALUES (310, '인사', 302, 1800);
INSERT INTO DEPTS VALUES (320, '영업', 303, 1700);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 1
--문제 2.
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
UPDATE DEPTS SET department_name = 'IT bank' WHERE department_name = 'IT Support'; --dept_id 210
--2. department_id가 290인 데이터의 manager_id를 301로 변경
UPDATE DEPTS SET manager_id = 301 WHERE department_id = 290;
--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요
UPDATE DEPTS SET department_name = 'IT Help',
                 manager_id = 303,
                 location_id = 1800
WHERE department_name = 'IT Helpdesk'; --dept_id 230
--4. 부서번호 290, 300, 310, 320 의 매니저아이디를 301로 한번에 변경하세요.
UPDATE DEPTS SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 2
--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
--2. 부서명 NOC를 삭제하세요
DELETE FROM DEPTS WHERE department_name = '영업';
DELETE FROM DEPTS WHERE department_name = 'NOC';
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 3

--문제4
CREATE TABLE DEPTS_COPY AS SELECT * FROM DEPTS;
SELECT * FROM DEPTS_COPY;
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제해 보세요.
DELETE FROM DEPTS_COPY WHERE department_id > 200;
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
UPDATE DEPTS_COPY SET manager_id = 100 WHERE manager_id IS NOT NULL;
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고, 새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
MERGE INTO DEPTS D1
USING DEPARTMENTS D2
ON (D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAME,
               D1.MANAGER_ID = D2.MANAGER_ID,
               D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT VALUES (D2.DEPARTMENT_ID, D2.DEPARTMENT_NAME, D2.MANAGER_ID, D2.LOCATION_ID);
SELECT * FROM DEPTS;
COMMIT; -- COMMIT 4
--문제 5
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE jobs.min_salary > 6000);
SELECT * FROM JOBS_IT;
--2. jobs_it 테이블에 아래 데이터를 추가하세요
INSERT INTO JOBS_IT VALUES('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '보안개발팀', 6000, 19000);
--3. jobs_it은 타겟 테이블 입니다
--jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요.
MERGE INTO JOBS_IT J1
USING (SELECT * FROM JOBS WHERE MIN_SALARY > 0) J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET J1.MIN_SALARY = J2.MIN_SALARY,
               J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT VALUES(J2.JOB_ID, J2.JOB_TITLE, J2.MIN_SALARY, J2.MAX_SALARY);
SELECT * FROM JOBS_IT;
COMMIT; -- COMMIT 5

------------------------------------------------------------------------------------------------
--제약조건 QUIZ
--문제1.
--다음과 같은 테이블을 생성하고 데이터를 insert해보세요.
--테이블 제약조건은 아래와 같습니다. 
--조건) M_NAME 는 가변문자형 20byte, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형 5자리, PRIMARY KEY 이름(mem_memnum_pk) 
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, UNIQUE KEY 이름:(mem_regdate_uk)
--조건) GENDER 고정문자형 1byte, CHECK제약 (M, F)
--조건) LOCA 숫자형 4자리, FOREIGN KEY ? 참조 locations테이블(location_id) 이름:(mem_loca_loc_locid_fk)
CREATE TABLE MEM(
    M_NAME VARCHAR2(20) NOT NULL,
    M_NUM NUMBER(5) CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE NOT NULL CONSTRAINT MEM_REGDATE_UK UNIQUE,
    GENDER CHAR(1) CONSTRAINT MEM_GENDER_CK CHECK(GENDER IN ('M', 'F')),
    LOCA NUMBER(4) CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);
DESC MEM;
DROP TABLE MEM;
INSERT INTO MEM VALUES('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO MEM VALUES('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO MEM VALUES('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO MEM VALUES('DDD', 4, SYSDATE, 'M', 2000);
SELECT * FROM MEM;

--문제2.
--도서 대여 이력 테이블을 생성하려 합니다.
--도서 대여 이력 테이블은
--대여번호(숫자) PK, 대출도서번호(문자), 대여일(날짜), 반납일(날짜), 반납여부(Y/N)
--를 가집니다.
--적절한 테이블을 생성해 보세요.
CREATE TABLE BR(
    RENTAL_NUM NUMBER(5) CONSTRAINT BR_RENTAL_NUM_PK PRIMARY KEY,
    BOOK_NUM VARCHAR2(10) NOT NULL CONSTRAINT BR_BOOK_NUM_UK UNIQUE,
    RENTAL_DATE DATE NOT NULL,
    RETURN_DATE DATE,
    RETURN_STATUS CHAR(1) CONSTRAINT BR_RETURN_STATUS_CK CHECK (RETURN_STATUS IN ('Y', 'N'))
);
SELECT * FROM BR;
INSERT INTO BR VALUES(1, 'A101', '2024-05-01', '2024-05-29', 'Y');
