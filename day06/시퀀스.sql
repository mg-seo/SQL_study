-- 시퀀스 (순차적으로 증가하는 값)
-- 주로 PK에 적용될 수 있습니다.
SELECT * FROM user_sequences;
-- 시퀀스 생성
CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCACHE -- 캐시에 시퀀스를 두지 않음
    NOCYCLE; -- 최대값에 도달했을 때 재사용X
    
-- 적용
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);
-- 시퀀스 사용방법 2개
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- 현재 시퀀스 (NEXTVAL가 선행 되어야함)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 현재 시퀀스 증가값만큼 증가

-- 시퀀스 적용
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'EXAMPLE');

-- 시퀀스 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;
SELECT * FROM DEPTS;

-- 시퀀스가 이미 사용되고 있다면, DROP하면 안됩니다
-- 만약 시퀀스를 초기화 해야한다면?
-- 시퀀스의 증가값을 -음수로 만들어서 초기화 한 것처럼 쓸 수 있습니다
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
-- 1. 시퀀스의 증가를 -(현재값 -1)로 바꿈
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -49;
-- 2. 현재 시퀀스 전진
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
-- 3. 다시 증가값을 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
----------------------------------------------------------------------
-- 시퀀스 응용(나중에 테이블을 설계할 때, 데이터가 엄청 많다면 PK에 시퀀스의 사용 고려)
-- 문자열 PK (년도값 - 일련번호)
CREATE TABLE DEPTS2(
    DEPT_NO VARCHAR2(20) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES(TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 6, 0), 'EX');
SELECT * FROM DEPTS2;

-- 시퀀스 삭제
DROP SEQUENCE DEPTS_SEQ;

