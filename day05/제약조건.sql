--제약조건(컬럼에 대한 데이터 수정, 삭제, 삽입 등 이상을 방지하기 위한 조건
--PRIMARY KEY : 테이블 고유키, 중복X, NULL X, PK는 테이블에서 1개
--NOT NULL : NULL을 허용하지 않음
--UNIQUE KEY : 중복 X, NULL O
--FOREIGN KEY : 참조하는 테이블의 PK를 넣어 놓은 KEY, 중복O NULLO
--CHECK : 컬럼에 대한 데이터 제한

-- 전체 제약조건 확인
SELECT * FROM USER_CONSTRAINTS;
DROP TABLE DEPTS;

-- 열레벨 제약조건
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2) CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY,
    DEPT_NAME VARCHAR2(30) /*CONSTRAINT DEPTS_DEPT_NAME_NN*/ NOT NULL, --생략가능
    DEPT_DATE DATE DEFAULT SYSDATE, --제약조건은 아니며 (컬럼의 기본값)
    DEPT_PHONE VARCHAR2(30) CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE,
    DEPT_GENDER CHAR(1) CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M')),
    LOCA_ID NUMBER(4) CONSTRAINT DEPTS_LOCA_ID_FK REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, NULL, '010..', 'F', 1700); -- DEPT_NAME NOT NULL 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010..', 'X', 1700); -- DEPT_GENDER F와 M만 들어갈 수 있음 CHECK 제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010..', 'F', 100); -- LOCA_ID 참조제약 위배

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, 'HONG', '010..', 'F', 1700); --성공

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(2, 'HONG', '010..', 'F', 1700); -- DEPT_PHONE 중복X UNIQUE제약 위배

-- 테이블레벨 제약조건 정의
DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(30) NOT NULL, --NOT NULL은 열레벨 정의
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4),
    CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY (DEPT_NO /*, DEPT_NAME*/), --컬럼명 (슈퍼키는 테이블레벨로 지정 가능함)
    CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('F', 'M')),
    CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID)
);
DROP TABLE DEPTS;
-----------------------------------------------------------------------------------
-- ALTER로 제약조건 추가
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR2(30),
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4)
);
-- PK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY (DEPT_NO);
-- NOT NULL은 열 변경(MODIFY) 로 추가합니다
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;
-- UNIQUE추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
-- FK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID);
-- CHECK추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK (DEPT_GENDER IN ('F', 'M'));
-- 제약조건 삭제
ALTER TABLE DEPTS DROP CONSTRAINT DEPTS_DEPT_GENDER_CK;