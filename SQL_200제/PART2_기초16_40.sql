--  초보자를 위한 SQL200제 PART2. 기초 16~40 (230413) -----
-- ---------------------------------------------


-- 016. 첫 칼럼은 대문자로, 두번째 칼럼은 소문자로, 세번째 칼럼은 이름의 첫번째를 대문자로 나머지는 소문자로, 사원테이블 이름 출력
-- INITCAP() : ORACLE
SELECT UPPER(ename), LOWER(ename), 
	CONCAT(UPPER(LEFT(ename,1)),LOWER(SUBSTRING(ename,2))) as 첫글자만cap 
    FROM orcl.emp;
    
    
-- 017. SMITH에서 SMI만 출력
-- DUAL :  SQL 함수에 대한 쓰임을 알고 싶을 때, 출력되는 데이터를 확인하기 위한 임시공간
SELECT SUBSTR('SMITH',1,3) FROM DUAL;

-- 018. 사원테이블에서 이름을 출력하고 그 옆에 이름의 철자개수 출력
-- 바이트 길이 : LENGTHB(), 한글은 한글자 3byte
SELECT ename, LENGTH(ename) as 철자개수 
	FROM orcl.emp;
    
-- 019. SMITH 에서 알파벳 M 위치 출력
SELECT INSTR('SMITH','M') 
	FROM DUAL;
-- 이메일에서 포탈주소만 출력하기
SELECT SUBSTRING('AAA@naver.com',INSTR('AAA@naver.com','@')+1)
	FROM DUAL;
-- 이메일에서 ID만 출력하기
SELECT SUBSTR('AAA@naver.com',1,INSTR('AAA@naver.com','@')-1)
	FROM DUAL;
    
-- 020. 사원테이블에서 월급은 0을 *로 이름, 월급 출력
SELECT ename, REPLACE(sal,0,'*') 
	FROM orcl.emp;
-- 월급의 0~3까지 *로 출력
SELECT ename, REGEXP_REPLACE(sal,'[0-3]','*') 
	FROM orcl.emp;
-- 이름의 두번째 자리를 *로 출력
SELECT ename, REPLACE(ename,SUBSTR(ename,2,1),'*') 
	FROM orcl.emp;
    
-- 021. 이름, 월급 출력시 월급 컬럼의 자릿수를 10자리로, 월급 출력 후 남은 나머지 자리에 *로 출력
SELECT ename, sal, LPAD(sal,10,'*'), RPAD(sal,10,'*')
	FROM orcl.emp;
-- sql시각화에 사용
-- round(sal/100) 자리수 만큼 채워넣기
SELECT ename, sal, LPAD('■',round(sal/100),'■')
	FROM orcl.emp;
    
-- 022. 첫번째 칼럼은 SMITH 철자 출력, 두번째 칼럼은 SMITH의 S잘라서 출력, 세번째 칼럼은 H제외 나머지 출력, 네번째는 양쪽 S를 잘라서 출력
-- LTRIM(' SMITH'), RTRIM : MYSQL에서는 공백제거만 가능
-- LTRIM('SMITH','S') : ORACLE
SELECT 'SMITH', TRIM(LEADING 'S' FROM 'SMITH'), 
	TRIM(TRAILING 'H' FROM 'SMITH'), TRIM(BOTH 'S' FROM 'SMITHS')
	FROM DUAL;
    
-- 023. 876.567 소수점 두번째 자리에서 반올림
SELECT ROUND(876.567,1) FROM DUAL;

-- 024. 876.567 소수점 두번째 자리부터 버리고 출력
-- TRUNC(,) : ORACLE
SELECT TRUNCATE(876.567,1) FROM DUAL;

-- 025. 10을 3으로 나눈 나머지 값 출력
SELECT MOD(10,3) FROM DUAL;
-- 사원번호가 짝수인 사원들의 사원번호와 이름 출력
SELECT ename, empno 
	FROM orcl.emp
    WHERE MOD(empno,2)=0;
-- 10을 3으로 나눈 몫 출력 (나눈값보다 작은 정수중 가장 큰 수)
SELECT FLOOR(10/3) FROM DUAL;

-- 026. 이름, 입사한 날짜 출력시 입사한 날부터 오늘까지 개월수도 출력
-- MONTHS_BETWEEN(sysdate,hiredate) :ORACLE
-- TIMESTAMPDIFF(MONTH, 특정날짜, CURDATE( )) : mysql =PERIOD_DIFF(P1, P2)
-- DATEDIFF(CURDATE( ),hiredate) : 일단위 차이 계산, mysql 
-- SYSDATE()=CURDATE()
SELECT ename, hiredate, TIMESTAMPDIFF(MONTH,hiredate,CURDATE()) 
	FROM orcl.emp;
    
-- 027. 2019.05.01 부터 100달 뒤의 날짜출력
-- RR로 할시, 50보다 크거나 같으면 19**년도로 출력
-- ADD_MONTHS(TO_DATE('2019-05-01','RRRR-MM-DD',100)) : ORACLE
-- DATE_SUB() :  MYSQL, 뺴기 INTERCAL -100 MONTH 과 같음
SELECT DATE_ADD('2019-05-01', INTERVAL 100 MONTH)
	FROM DUAL;
    
-- 028. 2019-05-22로부터 바로 돌아올 월요일의 날짜 출력
-- ORACLE : NEXT_DAY('2019-05-22','월요일')
-- ORACLE : 100달 뒤 월요일 날짜 NEXT_DAY(ADD_MONTHS('2019-05-22',100),'월요일')
-- MYSQL 월요일=0
-- MYSQL : 1주일 후 날짜의 요일 WEEKDAY숫자 구해서 월요일0에 해당하는 날짜 출력
SELECT WEEKDAY(DATE_ADD('2019-05-22',INTERVAL 1 WEEK)) 
	FROM DUAL; -- 2
SELECT DATE_ADD('2019/05/22',INTERVAL 1 WEEK)-2 FROM DUAL;

-- 029. 2019-05-22 해당 달의 마지막 날짜 출력
-- ORACLE : LAST_DAY('2019-05-22')
-- 오늘부터 이번달 말까지 남을 일수 : LAST_DAY(SYSDATE)-SYSDATE
SELECT  LAST_DAY('2019-05-22')
	FROM DUAL;
-- 입사한 달의 마지막 날짜 추출
SELECT ename, LAST_DAY(hiredate)
	FROM orcl.emp;
    
-- 030. SCOTT사원의 이름과 입사 요일 출력, 월급에 천 단위 구분해서 콤마 넣고 출력
-- ORACLE : TO_CHAR(hiredate,'DAY')-한글요일출력, TO_CHAR(sal,'999,999'), 백만단위 : '999,999,999'
-- mysql : FORMAT(,소수점 몇 자리까지 표현할지)
SELECT ename, DATE_FORMAT(hiredate,'%W') ,FORMAT(sal,0)
	FROM orcl.emp
    WHERE ename='SCOTT';
-- EXTRACT 날짜 추출
SELECT ename, EXTRACT(YEAR FROM hiredate),
	EXTRACT(MONTH FROM hiredate),EXTRACT(DAY FROM hiredate)
	FROM orcl.emp;

-- 031. 1981-11-17에 입사한 사원의 이름과 입사일 출력
SELECT  ename,hiredate
	FROM orcl.emp
    WHERE hiredate='1981-11-17';
-- oracle : TO_DATE(SYSDATE, 'YY/MM/DD') 
-- mysql : DATE_FORMAT(NOW(), '%Y/%m/%d'), STR_TO_DATE(문자열, 날짜 형식)
SELECT  ename,hiredate
	FROM orcl.emp
    WHERE hiredate=DATE_FORMAT('1981-11-17','%Y/%m/%d');
    
-- 032. 연봉이 '3000' 인 사원출력
SELECT ename, sal
	FROM orcl.emp
    WHERE sal='3000'; 
    
-- 033. 이름, 커미션 출력시 커미션이 널인 사원들은 0으로 출력
-- ORACLE : NVL(comm,0), NVL2(comm, 널이아닐경우 출력값, 널일경우 출력값)
-- 모든 db : COALESCE(A,null일경우 출력값) 
SELECT ename, comm, IFNULL(comm,0)
	FROM orcl.emp;
-- NVL2 을 MYSQL에서 쓰려면...IF(ISNULL(), 널일경우 값, 아닐경우 값)
SELECT ename, comm, IF(ISNULL(comm),0,1) 
	FROM orcl.emp;
    
-- 034. 이름, 부서번호, 보너스 출력시 부서번호=10->300, 20->400, 둘다아니면 0으로 보너스 칼럼 출력
-- ORACLE : DECODE(deptno,10,300,20,400,0)
-- MYSQL 에서의 DECODE : 복호화
	-- # 암호화  SELECT ENCODE(str, key);
	-- # 복호화 SELECT DECODE(str, key);
SELECT ename, deptno, 
	(CASE deptno
    WHEN 10 THEN 300
    WHEN 20 THEN 400
    ELSE 0
    END
    ) as '보너스' 
	FROM orcl.emp;
-- 사원번호가 짝수인지 홀수인지 DECODE 로 출력 in ORACLE
SELECT ename, deptno, DECODE(MOD(deptno,2),0,'짝',1,'홀') 
	FROM orcl.emp;
    
    
-- 035. 이름, 직업, 월급, 보너스 출력시 월급3000이상시500, 2000이상 3000미만시 300, 1000이상 2000미만시 200, 나머지0
SELECT ename, job, sal,
	(CASE 
    WHEN sal>=3000 THEN 500
    WHEN sal BETWEEN 2000 AND 3000 THEN 300
    WHEN sal BETWEEN 1000 AND 2000 THEN 200
    ELSE 0
    END) AS '보너스'
	FROM orcl.emp;
    
-- 036. 사원테이블에서 최대 월급 출력
SELECT MAX(sal) FROM orcl.emp;
-- SALESMAN중 최대 월급 출력
-- ORACLE에서는 ERROR -> GROUP BY job 해줘야함
SELECT job,MAX(sal)
	FROM orcl.emp
    WHERE job='SALESMAN';
    
-- 037. SALESMAN중 최소 월급 출력
SELECT job,MIN(sal)
	FROM orcl.emp
    WHERE job='SALESMAN';
-- job별 최소 월급 출력
SELECT job,MIN(sal) 
	FROM orcl.emp
    GROUP BY job;

-- 038. 사원테이블에서 평균 월급 출력
-- null 포함시, notnull인 숫자만 더해서 그만큼 개수로 나눠서 평균 구험
SELECT AVG(sal) 
	FROM orcl.emp;
    
-- 039. 부서번호와 부서 번호별 월급 총합계 출력
-- 실행순서 : GROUP BY -> SELECT -> ORDER BY
SELECT deptno, SUM(sal) 
	FROM orcl.emp
    GROUP BY deptno
    ORDER BY deptno ASC;

-- 040. 사원 테이블 전체 사원수 출력
-- NULL 포함시 NULL이 아닌 개수만 출력
SELECT COUNT(*) 
	FROM orcl.emp;