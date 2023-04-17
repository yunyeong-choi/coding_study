-- ---------------------------------------------------------------------
-- PART2. 초급 041~ 230417
-- ----------------------------------------------------------------------

-- 041. 직업이 ANALYSYT, MANAGER인 사원들의 이름, 직업, 월급 순위 출력
-- RANK() : 값이 같은 경우, 즉 동 순위일 경우 그대로 표기 후 다음 순위 하나 건너뜀 ->1,1,3
SELECT ename, job, sal, RANK() OVER( ORDER BY sal DESC)
FROM orcl.emp
WHERE job='ANALYST' or job='MANAGER';
-- 직업별로 월급이 높은 순대로 순위 부여
-- DENSE_RANK() : 동 순위일경우 그대로 표기 후 바로 다음순위 1,1,2
SELECT ename, job, sal, DENSE_RANK() OVER( PARTITION BY job ORDER BY sal DESC)
FROM orcl.emp;


-- 042. 직업이 ANALYSYT, MANAGER인 사원들의 이름, 직업, 월급 순위 출력시 순위1위인 사원이 둘일경우, 다음 순위가 2위가 출력되도록
SELECT ename, job, sal, DENSE_RANK() OVER(ORDER BY sal DESC)
FROM orcl.emp
WHERE job='ANALYST' OR job='MANAGER';
-- 81년도에 입사한 사원들의 직업, 이름, 월급, 순위 출력시 직업별로 월급이 높은 순서대로 순위부여
SELECT ename,job,sal, DENSE_RANK() OVER(PARTITION BY job ORDER BY sal DESC)
FROM orcl.emp
WHERE hiredate BETWEEN '1981-01-01' AND '1981-12-31' ;


-- 043. 이름, 직업, 월급, 월급의 등급 출력 (1등급 0~25%, 2등급 25~50%, 3등급 50~75%, 4등급 75~100%)
-- NULL은 맨 마지막에 출력되도록
-- mysql : hiredate is null ASC
-- oracle : null last, null first
SELECT ename, job, sal, NTILE(4) OVER (ORDER BY sal IS NULL ASC,sal DESC)
FROM orcl.emp
WHERE job='ANALYST' OR job='MANAGER' OR job='CLERK';


-- 044. 이름, 월급, 월급의 순위, 월급의 순위비율 출력 (순위는 1,1,2가 되도록)
SELECT ename, sal, RANK() OVER(ORDER BY sal DESC),
ROUND(CUME_DIST() OVER(ORDER BY sal DESC),3)
FROM orcl.emp;


-- 045. 부서번호, 부서번호 옆에 해당 부서에 속한 사원들의 아름 가로로 출력
-- group by 반드시 필요
-- ORACLE LISTAGG(ename,'원하는 구분자') WITHIN GROUP(ORDER BY ename DESC) GROUP BY deptno
-- MYSQL GROUP_CONCAT(ename SEPARATOR '원하는 구분자')
SELECT deptno, GROUP_CONCAT(ename ORDER BY ename DESC SEPARATOR ',')
 FROM orcl.emp
 GROUP BY deptno;
 
 
 -- 046. 이름, 월급, 바로전행의 월급, 바로다음행의 월급 출력
 -- LEAD : 현재 행 기준 N번째 다음 행 값 가져오기
 -- LAG : 현재 행 기준 N번째 이전 행 값 가져오기
 SELECT ename, sal, LEAD(sal,1) OVER (ORDER BY sal DESC),
 LAG(sal,1) OVER (ORDER BY sal DESC)
 FROM orcl.emp;
 -- 부서별로 구분해서 이름, 부서, 입사날짜 출력시 바로 전에 입사한 사원의 입사날짜 출력
 SELECT deptno, ename, hiredate,
 LAG(hiredate,1) OVER (PARTITION BY deptno ORDER BY deptno ASC)
 FROM orcl.emp;
 
 
 -- 047. 부서번호, 부서번호별 월급합 출력시, 월급합을 가로로출력
 -- oracle : SUM(DECODE(deptno ,10-부서번호,sal))
 -- oracle 조건문 decode : DECODE(deptno, 10 , 'ACCOUNTING'(true일때값) ,
 --                            20 , 'RESEARCH' ,
 --                           30 , 'SALES', 'OPERATIONS') name
 -- mysql 조건문 case when then 혹은 IF문
 SELECT
SUM( CASE WHEN deptno=10 THEN sal END) AS '10',
SUM( CASE WHEN deptno=20 THEN sal END) AS '20',
SUM( CASE WHEN deptno=30 THEN sal END) AS '30'
 FROM orcl.emp;
 
 
-- 048. 부서번호, 부서번호별 월급합을 피봇으로 가로로 출력
-- 047과 결과 같음
-- oracle : pivot 함수 이용, 필요한 데이터 조회후 피벗함수 활용
-- select * from (select deptno, sal from emp) PIVOT (sum(sal) for deptno in (10,20,30));
SELECT 
SUM(CASE WHEN deptno=10 THEN sal END) AS '10',
SUM(CASE WHEN deptno=20 THEN sal END) AS '20',
SUM(CASE WHEN deptno=30 THEN sal END) AS '30'
FROM orcl.emp;
-- 직업별 토탈 월급 가로로 출력
SELECT 
SUM(CASE WHEN job='ANALYST' THEN sal END) AS 'ANALYST',
SUM(CASE WHEN job='CLERK' THEN sal END) AS 'CLERK'
FROM orcl.emp;


-- 049. UNPIVOT으로 칼럼을 로우로 출력 (ORACLE)
-- SELECT * FROM order
-- UNPIVOT ( 건수 FOR 아이템 IN ( BICYCLE,CAMERA,NOTEBOOK));


-- 050. 직업이 ANALYST, MANAGER인 사원들의 사원번호, 이름, 월급, 직업별 월급의 누적합 출력
SELECT empno, job,ename, sal, SUM(sal) OVER (PARTITION BY job ORDER BY empno)
FROM orcl.emp
WHERE job IN ('ANALYST','MANAGER');


-- 051. 부서번호20인 사원들의 사원번호, 이름, 월급 출력시 20번 부서의 월급비율 확인
-- oracle : ratio_to_report
-- select empno, ename, sal, RATIO_TO_REPORT(sal) OVER () from emp where deptno=20;
-- mysql : 직접 비율 계산
SELECT empno, ename, sal,
sal/sum(sal) OVER() as '비율'
FROM orcl.emp
WHERE deptno=20;


-- 052. 직업과 직업별 월급합 출력시 맨마지막 행에 월급합의 총합 출력
-- oracle : ROLLUP(job)
-- MYSQL : WITH ROLLUP
-- ROLLUP(A,B) : A별 , AB별, TOTAL
SELECT job, SUM(sal)
FROM orcl.emp
GROUP BY job WITH ROLLUP;
-- 월급의 총합과 deptno별 총합 출력
SELECT deptno, job, SUM(sal)
FROM orcl.emp
GROUP BY deptno, job WITH ROLLUP;


-- 053. 직업, 직업별 월급합 출력시 첫번째 행에 월급의 총합 출력
-- ORACLE : GROUP BY CUBE(job)
-- MySQL 5.6 에서 지원 하지 않음
-- CUBE(A,B) : A별, B별, AB별, TOTAL
SELECT job, SUM(job)
FROM orcl.emp
GROUP BY job WITH CUBE;
-- 부서번호별, 직업별, 전체, 부서번호와 직업별 급여합 출력
SELECT deptno, job, sum(job)
FROM orcl.emp
GROUP BY deptno,job WITH CUBE;


-- 054. 부서번호, 직업, 부서번호별 월급합, 직업별 월급합, 전체 월급합 출력
-- GROUPING SETS 
-- ORACLE : 
-- SELECT deptno, job
-- FROM emp
-- GROUP BY GROUPING SETS((deptno),(job),()) ;
-- MYSQL  : CUBE, GROUPING SETS없음
-- https://dev.mysql.com/doc/refman/8.0/en/group-by-modifiers.html
SELECT deptno, job, sum(sal)
FROM orcl.emp
GROUP BY deptno,job,empno WITH ROLLUP; -- deptno별, deptno+job별, deptno+job+empno별, 전체


-- 055. 사원번호, 이름, 급여 출력시 출력되는 순서대로 각 행에 넘버링 하기
-- ORDER BY 필수!!
-- ROW_NUMBER() OVER (ORDER BY COL DESC) 
SELECT deptno, empno, ename, sal, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC)
FROM orcl.emp;