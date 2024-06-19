-- 권한 PRIVS

--유저목록
SELECT * FROM all_users;
--유저 권한 확인
SELECT * FROM user_sys_privs;

--계정 생성
CREATE USER USER01 IDENTIFIED BY USER01; -- ID USER01 PW USER01
--권한 부여(접속권한, 테이블 뷰 시퀀스 프로시자 생성권한)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01;
-- TABLESPACE : 데이터를 저장하는 물리적인 공간
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 권한 회수
REVOKE CREATE SESSION FROM USER01;
-- 계정 삭제
DROP USER USER01;

------------------------------------------------------------------------------
-- ROLE : 권한의 그룹을 통한 권한부여
CREATE USER USER01 IDENTIFIED BY USER01;
GRANT CONNECT, RESOURCE TO USER01; -- CONNECT 접속롤, RESOURCE 개발롤, DBA 관리자롤
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;