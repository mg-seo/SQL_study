-- INDEX
-- INDEX는 PK, UNIQUE에 자동으로 생성되고, 조회를 바르게 하는 HINT역할을 합니다
-- INDEX종류는 고유인덱스, 비고유인덱스가 있습니다
-- UNIQUE한 컬럼에는 UNIQUE인덱스(고유)가 쓰입니다.
-- 일반 컬럼에는 비고유 인덱스를 지정할 수 있습니다.
-- INDEX는 조회를 빠르게 하지만, DML구문이 많이 사용되는 컬럼은 오히려 성능저하를 부를 수도 있습니다.

-- 인덱스 생성
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);

-- 인덱스가 없을 때 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';
-- 비고유 인덱스 생성(부착)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);
-- 인덱스 생성 후 FIRST_NAME으로 다시 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- 인덱스 삭제(인덱스는 삭제하더라도 테이블에 영향을 미치지 않습니다)
DROP INDEX EMPS_IT_IX;

-- 결합인덱스 (여러개 컬럼을 동시에 인덱스로 지정, 첫번째 주 컬럼만 인덱스 영향을 받을 수 있습니다)
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy'; --힌트 얻음
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg'; --힌트 얻음
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg'; --힌트 얻음

-- 고유인덱스(PK, UNIQUE 에서 자동 생성됨)
-- CREATE UNIQUE INDEX 인덱스명 ~~~~~
