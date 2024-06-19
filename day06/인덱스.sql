-- INDEX
-- INDEX�� PK, UNIQUE�� �ڵ����� �����ǰ�, ��ȸ�� �ٸ��� �ϴ� HINT������ �մϴ�
-- INDEX������ �����ε���, ������ε����� �ֽ��ϴ�
-- UNIQUE�� �÷����� UNIQUE�ε���(����)�� ���Դϴ�.
-- �Ϲ� �÷����� ����� �ε����� ������ �� �ֽ��ϴ�.
-- INDEX�� ��ȸ�� ������ ������, DML������ ���� ���Ǵ� �÷��� ������ �������ϸ� �θ� ���� �ֽ��ϴ�.

-- �ε��� ����
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

-- �ε����� ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';
-- ����� �ε��� ����(����)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);
-- �ε��� ���� �� FIRST_NAME���� �ٽ� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- �ε��� ����(�ε����� �����ϴ��� ���̺� ������ ��ġ�� �ʽ��ϴ�)
DROP INDEX EMPS_IT_IX;

-- �����ε��� (������ �÷��� ���ÿ� �ε����� ����, ù��° �� �÷��� �ε��� ������ ���� �� �ֽ��ϴ�)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; --��Ʈ ����
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg'; --��Ʈ ����
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg'; --��Ʈ ����

-- �����ε���(PK, UNIQUE ���� �ڵ� ������)
-- CREATE UNIQUE INDEX �ε����� ~~~~~
