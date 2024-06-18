-- DDL���� (Ʈ������� ����)
-- CREATE, ALTER, DROP
DROP TABLE DEPTS; -- ���̺� ����
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2), -- ���� 2�ڸ�
    DEPT_NAME VARCHAR2(30), -- 30����Ʈ (�ѱ��� 15����, ���� ���� 30����)
    DEPT_YN CHAR(1), -- �������� 1BYTE
    DEPT_DATE DATE,
    DEPT_BONUS NUMBER(10, 2), -- ���� 10�ڸ�, �Ҽ��� 2�ڸ������� ����
    DEPT_CONTENT LONG -- 2�Ⱑ �������ڿ� (VARCHAR2 ���� �� ū)
);
DESC DEPTS;
SELECT * FROM DEPTS;
INSERT INTO DEPTS VALUES (99, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~~~');

----------------------------------------------------------------------------
-- ���̺��� �������� ALTER
-- ADD, MODIFY, RENAME COLUMN, DROP COLUMN
DESC DEPTS;
ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); --�������� �÷��߰�

ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; --�÷��� ����

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5); --�÷��� ũ�⸦ ����
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1);
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(1); -- ���������Ͱ� ������ ũ�⺸�� ū ���, ����Ұ�

ALTER TABLE DEPTS DROP COLUMN EMP_COUNT; -- �÷� ����

----------------------------------------------------------------------------
-- ���̺� ����
DROP TABLE DEPTS CASCADE; --���̺��� ������ FK���������� �����ϸ鼭, ���̺��� ��������(����)
DROP TABLE DEPARTMENTS; -- DEPARTMENTS �� EMPLOYEES ���̺�� �������踦 ������ �־� �� ���� �������� ����