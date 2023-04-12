-- 초보자를 위한 SQL200제 PART1. 입문 (230412)
-- ---------------------------------------------
-- 001. 사원 테이블에서 사원 번호와 이름, 월급 출력
-- 가독성을 위해 테이블명, 칼럼명은 소문자 권장
SELECT * FROM orcl.EMP;
SELECT empno, ename, sal FROM orcl.emp;

-- 002. 사원 테이블의 모든 열 출력
SELECT * FROM orcl.emp;

-- 003. 별칭사용해서 사원 테이블의 사원번호, 이름, 월급 출력
-- 별칭에 대소문자 구분 필요시 '' 붙일것.
SELECT empno as 사원번호, ename as 이름, sal as 월급 FROM orcl.emp;

-- 004. 사원 테이블의 이름과 월급을 붙여서 출력하기
-- oracle : ename || sal
SELECT CONCAT(ename,sal) FROM orcl.emp;
SELECT CONCAT(ename,'의 급여는 ',sal,'입니다.') as 급여정보 FROM orcl.emp;

-- 005. 사원 테이블에서 직업 출력시, 중복 데이터 제거하고 출력
SELECT DISTINCT job FROM orcl.emp;

-- 006. 사원 테이블에서 이름과 월급 출력시, 월급 낮은 사원부터 출력
SELECT ename, sal 
	FROM orcl.emp 
	ORDER BY sal ASC ;

-- 007. 월급이 3000인 사원들의 이름, 급여, 직업 출력
SELECT ename, sal, job 
	FROM orcl.emp
	WHERE sal=3000;

-- 008. 이름이 SCOTT인 사원의 이름, 월급, 직업, 입사일, 부서번호 출력
SELECT ename, sal, job, hiredate 
	FROM orcl.emp
	WHERE ename='SCOTT';
    
SELECT ename, sal, job, hiredate
	FROM orcl.emp
    WHERE hiredate='82/12/22';
-- 현재 접속한 세션의 날짜 형식 확인 (ORCALE)
SELECT * FROM NLS_SESSION_PARAMETERS
	WHERE PARAMETER='NLS_DATE_FORMAT';
-- MYSQL 
SELECT NOW();

-- 009. 연봉 36000 이상인 사원들의 이름과 연봉 출력
SELECT ename, sal , sal*12 as 연봉
	FROM orcl.emp
	WHERE sal*12>=36000 ;
    
-- 부서번호 10인 사원들의 이름, 월급, 커미션, 월급+커미션 출력
-- null 포함시, 연산값도 null
SELECT ename, sal, comm, sal+comm 
	FROM orcl.emp
	WHERE deptno=10;

-- 010. 월급이 1200이하인 사원들의 이름, 월급, 직업, 부서번호 출력
SELECT ename, sal, job, deptno 
	FROM orcl.emp
    WHERE sal<=1200;
    
-- 011. 월급이 1000~3000인 사원들의 이름, 월급 출력
-- (sal>=1000 and sal<=3000)
-- sal NOT BETWEEN AND 
SELECT ename, sal 
	FROM orcl.emp
	WHERE sal BETWEEN 1000 AND 3000;
    
-- 012.이름 첫글자가 S인 사원들의 이름, 월급 출력
SELECT ename, sal 
	FROM orcl.emp
    WHERE ename LIKE 'S%';
-- 두번째가 M일 경우  : LIKE '_M%'
-- A를 포함할 경우 : LIKE '%A%'

-- 013. 커미션이 NULL 인 사원들의 이름과 커미션 출력
SELECT ename, comm 
	FROM orcl.emp
	WHERE comm IS NULL ;
    
-- 014. 직업이 SALESMAN, ANALYST,MANAGER인 사원들의 이름, 월급, 직업 출력
-- (job ='SALESMAN'or job ='ANALYST' or job ='MANAGER')
-- 부정 : NOT IN ()
SELECT ename, sal, job
	FROM orcl.emp
    WHERE job IN ('SALESMAN','ANALYST','MANAGER');
    
-- 015. 직업이 MANAGER이고 월급이 1200이상인 사원들의 이름, 월급, 직업 출력
SELECT ename, sal, job
	FROM orcl.emp
    WHERE job='MANAGER' AND sal>=1200;