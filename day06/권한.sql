-- ���� PRIVS

--�������
SELECT * FROM all_users;
--���� ���� Ȯ��
SELECT * FROM user_sys_privs;

--���� ����
CREATE USER USER01 IDENTIFIED BY USER01; -- ID USER01 PW USER01
--���� �ο�(���ӱ���, ���̺� �� ������ ���ν��� ��������)
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01;
-- TABLESPACE : �����͸� �����ϴ� �������� ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- ���� ȸ��
REVOKE CREATE SESSION FROM USER01;
-- ���� ����
DROP USER USER01;

------------------------------------------------------------------------------
-- ROLE : ������ �׷��� ���� ���Ѻο�
CREATE USER USER01 IDENTIFIED BY USER01;
GRANT CONNECT, RESOURCE TO USER01; -- CONNECT ���ӷ�, RESOURCE ���߷�, DBA �����ڷ�
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;