-- Ʈ���� : Ʈ���Ŵ� ���̺� ������ ���·� AFTER, BEFORE Ʈ���Ű� �ֽ��ϴ�.
-- AFTER�� DML������ Ÿ�����̺� ����� ���Ŀ� �����ϴ� Ʈ����
-- BEFORE�� DML������ Ÿ�����̺� ����Ǳ� ������ �����ϴ� Ʈ����

SET SERVEROUTPUT ON;
CREATE TABLE TBL_TEST(
    ID VARCHAR2(30),
    TEXT VARCHAR2(30)
);

--Ʈ���Ż���
CREATE OR REPLACE TRIGGER TBL_TEST_TRG
    AFTER UPDATE OR INSERT OR DELETE --Ʈ���� ������ ���۽���
    ON TBL_TEST --������ ���̺�
    FOR EACH ROW --��� �࿡ ����
BEGIN
    dbms_output.put_line('Ʈ���Ű� ������');
END;

INSERT INTO TBL_TEST VALUES('AAA123', 'HELLO');
UPDATE TBL_TEST SET TEXT = 'BYE' WHERE ID = 'AAA123';
DELETE FROM TBL_TEST WHERE ID = 'AAA123';
--------------------------------------------------------------------------------
-- AFTER TRIGGER
-- :OLD
CREATE TABLE TBL_USER(
    ID VARCHAR2(20),
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30)
);

CREATE TABLE TBL_USER_BACKUP(
    ID VARCHAR2(20),
    NAME VARCHAR2(20),
    ADDRESS VARCHAR2(30),
    UPDATEDATE DATE DEFAULT SYSDATE,
    M_TYPE CHAR(10), --����Ÿ��
    M_USER VARCHAR2(20) --������ �����
);
-- TBL_USER�� UPDATE OR DELETE�� �Ͼ�� ���������͸� ���
CREATE OR REPLACE TRIGGER TBL_USER_BACKUP_TRG
    AFTER UPDATE OR DELETE
    ON TBL_USER
    FOR EACH ROW
DECLARE
    V VARCHAR2(10); --��������
BEGIN
    IF UPDATING THEN
        V := '����';
    ELSIF DELETING THEN
        V := '����';
    END IF;
    INSERT INTO TBL_USER_BACKUP VALUES(:OLD.ID, :OLD.NAME, :OLD.ADDRESS, SYSDATE, V, USER()); --ID, NAME, ADDRESS
END;
INSERT INTO TBL_USER VALUES('AAA', 'AAA', 'AAA');
INSERT INTO TBL_USER VALUES('BBB', 'BBB', 'BBBB');
UPDATE TBL_USER SET NAME = 'NEWAAA' WHERE ID = 'AAA';
DELETE FROM TBL_USER WHERE ID = 'BBB';
SELECT * FROM TBL_USER_BACKUP;
--------------------------------------------------------------------------------
-- BEFORE TRIGGER
-- :NEW
CREATE OR REPLACE TRIGGER TBL_USER_MASKING_TRG
    BEFORE INSERT
    ON TBL_USER
    FOR EACH ROW
BEGIN
    -- INSERT �Ǳ� �� ������ �����͸� ȫ**�� ����
    :NEW.NAME := SUBSTR(:NEW.NAME, 1, 1) || '**';
END;
INSERT INTO TBL_USER VALUES('CCC', 'ȫ�浿', '�����');
INSERT INTO TBL_USER VALUES('DDD', '�̼���', '�����');
SELECT * FROM TBL_USER;