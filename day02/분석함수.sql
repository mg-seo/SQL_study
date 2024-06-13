-- 분석함수 RANK(), DENSE_RANK(), ROW_NUMBER()
-- 분석함수() OVER(정렬방법)
SELECT first_name,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS 중복순서계산, -- 1 2 2 4 5
       DENSE_RANK() OVER(ORDER BY salary DESC) AS 중복없는등수, -- 1 2 2 3 4
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS 일련번호,
       ROWNUM AS 조회순서 -- ROWNUM은 ORDER 후 결과가 바뀜
FROM employees;
SELECT ROWNUM, FIRST_NAME, SALARY FROM employees ORDER BY salary DESC;