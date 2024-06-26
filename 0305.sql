--Data Manipulation Language (DML) 조작어
--TCL (TRANSACTION CONTROL LANGUAGE) : COMMIT(최종변경) / ROLLBACK(취소)을 함께 실행
--실습데이터 원본 복사
--Data Definition Language (DDL) 정의어
--실행을 하면 자동으로 COMMIT
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;
--
SELECT * FROM DEPT_TEMP;
--DROP TABLE DEPT_TEMP;
--문제
CREATE TABLE EMP_TEMP10
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP10;
--
SELECT * FROM DEPT_TEMP; --데이터 추가전에 꼭 확인
--데이터 추가 INSERT
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'DATABASE', 'SEOUL'); -- 위의 넣은 열 순서대로 값을 넣어주면 됨
--
SELECT * FROM DEPT_TEMP;
--데이터 타입 확인하기
DESC DEPT_TEMP;

--INSERT문 오류 발생의 경우
--1) 열 개수와 데이터 개수 불일치
COMMIT;
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK');
--오류 수정
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES (60, 'NETWORK');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN', 'WRONG');
--오류 수정
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--2) 데이터타입 불일치
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES ('WRONG', 'NETWORK', 'BUSAN');
--오류 수정
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--3) 데이터 입력 범위 벗어남
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (6, 'NETWORK', 'BUSAN');
--오류 수정
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
--테이블 전체열에 추가할 때는 열 지정 없이 입력 가능
ROLLBACK;
INSERT INTO DEPT_TEMP
VALUES (60 , 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
--

--NULL 데이터 추가하기
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (70 , 'WEB', NULL);
SELECT * FROM DEPT_TEMP;
--BLANK 데이터 추가하기
INSERT INTO DEPT_TEMP (DEPTNO, DNAME , LOC)
               VALUES (80 , 'MOBILE', '');
SELECT * FROM DEPT_TEMP;
--실무에서 특히 개발자와 협업할 때는 BLANK보다 NULL를 이용하는 것이 비어있는 값이라는 의미가 더 명확함
--NULL 값을 입력할 열을 제외하고 데이터 추가하기(암시적 입력)
INSERT INTO DEPT_TEMP (DEPTNO, LOC)
               VALUES (90 , 'INCHEON');
SELECT * FROM DEPT_TEMP;
--

--똑같은 열만 가지고 테이블 복사하기 : 데이터 없이 구조만 복사 -> 항상 거짓인 조건으로 SELECT
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
       WHERE 1 != 1; --항상 거짓인 조건!!! 1은 1임
SELECT * FROM EMP_TEMP;
--
--날짜 데이터 입력하기
--YYYY/MM/DD
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
               VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
SELECT * FROM EMP_TEMP;
--YYYY-MM-DD
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
               VALUES (1111, '성춘향', 'MANAGER', 9999, '2001-01-05', 4000, NULL, 20);
SELECT * FROM EMP_TEMP;
--
--DD/MM/YYYY
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR , HIREDATE, SAL , COMM, DEPTNO)
              VALUES (2111, '이순신', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);
--오류 수정: TO_DATE 함수를 이용하여 날짜 표현 형식을 맞춰야 함
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (2111, '이순신', 'MANAGER', 9999,
        TO_DATE('07/01/2001', 'DD/MM/YYYY'), 4000, NULL, 20);
SELECT * FROM EMP_TEMP;
--

--현재 날짜 입력 SYSDATE
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM EMP_TEMP;

--서브쿼리를 이용하여 한번에 입력하기
--주의할 점: VALUES 생략, 열의 순서와 데이터타입 일치해야 함
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL --비등가조인
   AND S.GRADE = 1; --조건이 하나 더 추가 되었음! 급여 등급이 1인 애들을
SELECT * FROM EMP_TEMP;
--

--데이터 변경하기 UPDATE
--부서 테이블 복사
CREATE TABLE DEPT_TEMP2
    AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP2;
--일괄적으로 변경
UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL';
SELECT * FROM DEPT_TEMP2;
--취소
ROLLBACK;
SELECT * FROM DEPT_TEMP2;
--

--조건으로 일부분 변경
--먼저 조건이 맞는지 확인
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = 40;
--변경
UPDATE DEPT_TEMP2
   SET DNAME = 'DATABASE',
       LOC = 'SEOUL'
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;
ROLLBACK;
--문제
SELECT * FROM EMP_TEMP;
--먼저 조건이 맞는지 확인
SELECT * FROM EMP_TEMP WHERE SAL <= 2500;
--변경
UPDATE EMP_TEMP
  SET COMM = 50
 WHERE SAL <= 2500;
SELECT * FROM EMP_TEMP;
--

--서브쿼리를 이용하여 변경
--서브쿼리
SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40;
--먼저 조건이 맞는지 확인
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = 40;
--변경
UPDATE DEPT_TEMP2
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;
ROLLBACK;
--열을 따로 변경 가능하지만, 반복 작성으로 비효율적임
UPDATE DEPT_TEMP2
   SET DNAME = (SELECT DNAME FROM DEPT WHERE DEPTNO = 40),
       LOC = (SELECT LOC FROM DEPT WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
--

--서브쿼리를 조건으로 사용하여 변경
--서브쿼리
SELECT DEPTNO FROM DEPT_TEMP2 WHERE DNAME='OPERATIONS';
--먼저 조건이 맞는지 확인
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT_TEMP2 WHERE DNAME='OPERATIONS');
--변경
UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL'
 WHERE DEPTNO = (SELECT DEPTNO
                   FROM DEPT_TEMP2
                  WHERE DNAME='OPERATIONS');
SELECT * FROM DEPT_TEMP2;
--
ROLLBACK;

--데이터 삭제하기 DELETE
--EMP 테이블 복사
CREATE TABLE EMP_TEMP2
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;
--데이터 일부 삭제
--확인
SELECT * FROM EMP_TEMP2 WHERE JOB = 'MANAGER';
--삭제
DELETE FROM EMP_TEMP2
 WHERE JOB = 'MANAGER';
SELECT * FROM EMP_TEMP2;
--

--서브쿼리를 이용하여 데이터 일부 삭제
--확인
SELECT E.EMPNO
  FROM EMP_TEMP2 E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 3 AND DEPTNO = 30;
SELECT * FROM EMP_TEMP2 WHERE EMPNO IN (7499,7844);
--삭제
DELETE FROM EMP_TEMP2
 WHERE EMPNO IN (SELECT E.EMPNO FROM EMP_TEMP2 E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                  AND S.GRADE = 3
                  AND DEPTNO = 30);
SELECT * FROM EMP_TEMP2;

--문제
SELECT * FROM EMP_TEMP;
--확인
SELECT * FROM EMP_TEMP WHERE SAL >= 3000;
--삭제
DELETE FROM EMP_TEMP
 WHERE SAL >= 3000;
SELECT * FROM EMP_TEMP;
--
ROLLBACK;

--문제1
CREATE TABLE CHAP10HW_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10HW_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10HW_SALGRADE AS SELECT * FROM SALGRADE;
--열 지정 INSERT
SELECT * FROM CHAP10HW_DEPT;
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (80, 'DML', 'BUNDANG');
SELECT * FROM CHAP10HW_DEPT;
ROLLBACK;
--열 생략 INSERT = 모든 열에 INSERT 할 때는 생략 가능
--열 지정 생략 INSERT
SELECT * FROM CHAP10HW_DEPT;
INSERT INTO CHAP10HW_DEPT VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10HW_DEPT VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT VALUES (80, 'DML', 'BUNDANG');
SELECT * FROM CHAP10HW_DEPT;
--다중 INSERT
ROLLBACK;
SELECT * FROM CHAP10HW_DEPT;
--열 지정 INSERT
INSERT ALL
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(50,'ORACLE','BUSAN')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(60,'SQL','ILSAN')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(70,'SELECT','INCHEON')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(80,'DML','BUNDANG')
SELECT * FROM DUAL;
SELECT * FROM CHAP10HW_DEPT;
ROLLBACK;
--열 지정 생략 INSERT
INSERT ALL
 INTO CHAP10HW_DEPT VALUES (50, 'ORACLE', 'BUSAN')
 INTO CHAP10HW_DEPT VALUES (60, 'SQL', 'ILSAN')
 INTO CHAP10HW_DEPT VALUES (70, 'SELECT', 'INCHEON')
 INTO CHAP10HW_DEPT VALUES (80, 'DML', 'BUNDANG')
 SELECT * FROM DUAL;
SELECT * FROM CHAP10HW_DEPT;

ROLLBACK;

-- 

--문제2
--개별 INSERT
SELECT * FROM CHAP10HW_EMP;
INSERT INTO CHAP10HW_EMP VALUES(7201,'TEST_USER1','MANAGER',7788,TO_DATE('2016-01-02','YYYY-MM-DD'),4500,NULL,50);
INSERT INTO CHAP10HW_EMP VALUES(7202,'TEST_USER2','CLERK',7201,TO_DATE('2016-02-21','YYYY-MM-DD'),1800,NULL,50);
INSERT INTO CHAP10HW_EMP VALUES(7203,'TEST_USER3','ANALYST',7201,TO_DATE('2016-04-11','YYYY-MM-DD'),3400,NULL,60);
INSERT INTO CHAP10HW_EMP VALUES(7204,'TEST_USER4','SALESMAN',7201,TO_DATE('2016-05-31','YYYY-MM-DD'),2700,300,60);
INSERT INTO CHAP10HW_EMP VALUES(7205,'TEST_USER5','CLERK',7201,TO_DATE('2016-07-20','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO CHAP10HW_EMP VALUES(7206,'TEST_USER6','CLERK',7201,TO_DATE('2016-09-08','YYYY-MM-DD'),2600,NULL,70);
INSERT INTO CHAP10HW_EMP VALUES(7207,'TEST_USER7','LECTURER',7201,TO_DATE('2016-10-28','YYYY-MM-DD'),2300,NULL,80);
INSERT INTO CHAP10HW_EMP VALUES(7208,'TEST_USER8','STUDENT',7201,TO_DATE('2018-03-09','YYYY-MM-DD'),1200,NULL,80);
SELECT * FROM CHAP10HW_EMP;
--다중 INSERT
ROLLBACK;
INSERT ALL
 INTO CHAP10HW_EMP VALUES(7201,'TEST_USER1','MANAGER',7788,TO_DATE('2016-01-02','YYYY-MM-DD'),4500,NULL,50)
 INTO CHAP10HW_EMP VALUES(7202,'TEST_USER2','CLERK',7201,TO_DATE('2016-02-21','YYYY-MM-DD'),1800,NULL,50)
 INTO CHAP10HW_EMP VALUES(7203,'TEST_USER3','ANALYST',7201,TO_DATE('2016-04-11','YYYY-MM-DD'),3400,NULL,60)
 INTO CHAP10HW_EMP VALUES(7204,'TEST_USER4','SALESMAN',7201,TO_DATE('2016-05-31','YYYY-MM-DD'),2700,300,60)
 INTO CHAP10HW_EMP VALUES(7205,'TEST_USER5','CLERK',7201,TO_DATE('2016-07-20','YYYY-MM-DD'),2600,NULL,70)
 INTO CHAP10HW_EMP VALUES(7206,'TEST_USER6','CLERK',7201,TO_DATE('2016-09-08','YYYY-MM-DD'),2600,NULL,70)
 INTO CHAP10HW_EMP VALUES(7207,'TEST_USER7','LECTURER',7201,TO_DATE('2016-10-28','YYYY-MM-DD'),2300,NULL,80)
 INTO CHAP10HW_EMP VALUES(7208,'TEST_USER8','STUDENT',7201,TO_DATE('2018-03-09','YYYY-MM-DD'),1200,NULL,80)
 SELECT * FROM DUAL;
SELECT * FROM CHAP10HW_EMP;

--
ROLLBACK;

CREATE TABLE CHAP10HW_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10HW_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10HW_SALGRADE AS SELECT * FROM SALGRADE;
SELECT * FROM CHAP10HW_EMP;

UPDATE CHAP10HW_EMP 
SET DEPTNO = 70 
WHERE SAL >= (SELECT AVG(SAL) 
              FROM CHAP10HW_EMP 
              WHERE DEPTNO = 50);
              
SELECT * FROM CHAP10HW_EMP ORDER BY DEPTNO;
ROLLBACK;
--문제3
--서브쿼리
SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50;
--확인
SELECT * FROM CHAP10HW_EMP WHERE SAL > (SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
--변경
UPDATE CHAP10HW_EMP
   SET DEPTNO = 70
  WHERE SAL > (SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
SELECT * FROM CHAP10HW_EMP;
--문제4
--서브쿼리
SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60;
--확인
SELECT * FROM CHAP10HW_EMP WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60);
--변경
UPDATE CHAP10HW_EMP
   SET SAL = SAL*1.1,
       DEPTNO = 80
   WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60);
SELECT * FROM CHAP10HW_EMP;
--문제5
--서브쿼리
SELECT E.EMPNO FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5;
--확인
SELECT * FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5;
--삭제
DELETE FROM CHAP10HW_EMP
  WHERE EMPNO IN (SELECT E.EMPNO FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5);
SELECT * FROM CHAP10HW_EMP;
--

--트랜잭션 제어 언어(Transaction Control Language, TCL)
--부서 테이블 복사
CREATE TABLE DEPT_TCL
    AS SELECT *
         FROM DEPT;
SELECT * FROM DEPT_TCL;
--취소
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_TCL;
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL;
ROLLBACK;
SELECT * FROM DEPT_TCL;

--최종변경
INSERT INTO DEPT_TCL VALUES(50, 'NETWORK', 'SEOUL');
SELECT * FROM DEPT_TCL;
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 20;
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 40;
SELECT * FROM DEPT_TCL;
COMMIT;
SELECT * FROM DEPT_TCL;
--

--읽기 일관성
--sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;
--sqldeveloper
DELETE FROM DEPT_TCL
 WHERE DEPTNO = 50;
 
--sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;

--sqldeveloper
COMMIT;

--sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;
--

--수정 중인 데이터 접근 막는 LOCK
--sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;

--sqldeveloper
UPDATE DEPT_TCL SET LOC='SEOUL'
 WHERE DEPTNO = 30;
 
  --sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;

--SQLPLUS
UPDATE DEPT_TCL SET DNAME='DATABASE'
 WHERE DEPTNO = 30;
 
 --sqldeveloper
COMMIT;
--sqldeveloper, SQLPLUS 각자
SELECT * FROM DEPT_TCL;

--문제1
CREATE TABLE DEPT_HW
  AS SELECT * FROM DEPT;
SELECT * FROM DEPT_HW;
--세션A
UPDATE DEPT_HW
  SET DNAME = 'DATABASE',
      LOC = 'SEOUL'
  WHERE DEPTNO = 30;
  --세션A, B 순서대로 각자
SELECT * FROM DEPT_HW;
--세션B
UPDATE DEPT_HW
  SET DNAME = 'DATABASE',
      LOC = 'SEOUL'
  WHERE DEPTNO = 30;
  --세션A
ROLLBACK;
--세션A, B 순서대로 각자
SELECT * FROM DEPT_HW;


--데이터정의어 (Data Definition Language, DDL)
--자동으로 COMMIT 됨
--자료형을 정의하여 테이블 생성
CREATE TABLE EMP_DDL(
   EMPNO      NUMBER(4),
   ENAME      VARCHAR2(10),
   JOB        VARCHAR2(9),
   MGR        NUMBER(4),
   HIREDATE   DATE,
   SAL        NUMBER(7,2), --5자리는 정수, 2자리는 소수임 (총 길이가 7)
   COMM       NUMBER(7,2),
   DEPTNO     NUMBER(2)
);
DESC EMP_DDL;
SELECT * FROM EMP_DDL;

--기존 테이블의 열과 행을 복사하여 테이블 생성
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
DESC DEPT_DDL;
SELECT * FROM DEPT_DDL;
--기존 테이블의 열과 일부 행을 복사하여 테이블 생성
CREATE TABLE EMP_DDL_30
    AS SELECT *
         FROM EMP
        WHERE DEPTNO = 30;
SELECT * FROM EMP_DDL_30;
--기존 테이블의 열만 복사하여 테이블 생성
CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE,
              E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
         FROM EMP E, DEPT D
        WHERE 1 != 1;
SELECT * FROM EMPDEPT_DDL;
--

--테이블 변경
--사원정보 테이블 복사
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
SELECT * FROM EMP_ALTER;
--테이블 열 추가
ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);
SELECT * FROM EMP_ALTER;
--테이블 열 이름 변경
ALTER TABLE EMP_ALTER
RENAME COLUMN HP TO TEL;
SELECT * FROM EMP_ALTER;
--테이블 열의 데이터 타입 변경
DESC EMP_ALTER;
ALTER TABLE EMP_ALTER
  MODIFY EMPNO NUMBER(5);
DESC EMP_ALTER;
--테이블 열 삭제
ALTER TABLE EMP_ALTER
 DROP COLUMN TEL;
SELECT * FROM EMP_ALTER;
--
--테이블 이름 변경
RENAME EMP_ALTER TO EMP_RENAME;
DESC EMP_ALTER;
SELECT * FROM EMP_ALTER;
DESC EMP_RENAME;
SELECT * FROM EMP_RENAME;
--테이블 비우기(행 = 데이터 삭제)
TRUNCATE TABLE EMP_RENAME;
SELECT * FROM EMP_RENAME;
--이 결과는 DELETE문으로 가능하지만, 자동 COMMIT이 되지 않음
--
--테이블 삭제
SELECT * FROM EMP_RENAME;
DROP TABLE EMP_RENAME;
DESC EMP_RENAME;
SELECT * FROM EMP_RENAME;
--
--문제1
CREATE TABLE EMP_HW(
   EMPNO NUMBER(4),
   ENAME VARCHAR2(10),
   JOB VARCHAR2(9),
   MGR NUMBER(4),
   HIREDATE DATE,
   SAL NUMBER(7,2),
   COMM NUMBER(7,2),
   DEPTNO NUMBER(2)
   );
DESC EMP_HW;
SELECT * FROM EMP_HW;

--문제2
ALTER TABLE EMP_HW
  ADD BIGO VARCHAR2(20);
DESC EMP_HW;
--문제3
ALTER TABLE EMP_HW
  MODIFY BIGO VARCHAR2(30);
DESC EMP_HW;
--문제4
ALTER TABLE EMP_HW
  RENAME COLUMN BIGO TO REMARK;
SELECT * FROM EMP_HW;

--문제5
SELECT * FROM EMP_HW;
--서브쿼리
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL FROM EMP;
--INSERT
INSERT INTO EMP_HW
 SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL FROM EMP;
SELECT * FROM EMP_HW;
--문제6
DROP TABLE EMP_HW;
DESC EMP_HW;
SELECT * FROM EMP_HW;


--객체 종류
--데이터 사전
--현재 계정에서 사용 가능한 데이터 사전 보기(결과는 둘다 같음)
SELECT * FROM DICT;
SELECT * FROM DICTIONARY;
--현재 계정 사용자가 소유한 객체(테이블) 보기
SELECT TABLE_NAME FROM USER_TABLES;

--모든 사용자가 소유한 객체(테이블) 보기
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

--데이터베이스 관리 권한을 가진 사용자만 볼 수 있음
SELECT * FROM DBA_TABLES;

--SYSTEM 계정으로 보기
SELECT * FROM DBA_TABLES;
--SCOTT 계정 사용자 정보 보기
SELECT *
  FROM DBA_USERS
 WHERE USERNAME = 'SCOTT';
 
 --인덱스
--SCOTT계정으로 보기
--인덱스 정보 보기
SELECT * FROM USER_INDEXES;
--인덱스 열 정보 보기
SELECT * FROM USER_IND_COLUMNS;
--인덱스 생성
CREATE INDEX IDX_EMP_SAL
    ON EMP(SAL);
--생성된 인덱스 보기
SELECT * FROM USER_IND_COLUMNS;
--인덱스 삭제
DROP INDEX IDX_EMP_SAL;
--삭제되었는지 확인
SELECT * FROM USER_IND_COLUMNS;
--
--sqldeveloper에서 SCOTT계정으로 뷰 생성
CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP
         WHERE DEPTNO = 20);
--뷰 생성 확인
SELECT * FROM USER_VIEWS;
--뷰 생성 확인(SQLPLUS에서 SCOTT계정으로)
sqlplus scott/tiger
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
  FROM USER_VIEWS;
--뷰에 저장된 SQL문
SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP
         WHERE DEPTNO = 20;
--생성한 뷰 보기
SELECT * FROM VW_EMP20;

----문제
--뷰 생성
CREATE VIEW VW_EMP30ALL
  AS (SELECT * FROM EMP
       WHERE DEPTNO = 30);
--뷰 생성 확인
SELECT * FROM USER_VIEWS;
--생성한 뷰 보기
SELECT * FROM VW_EMP30ALL;
----뷰 삭제
DROP VIEW VW_EMP20;
--삭제된 뷰 확인
SELECT * FROM USER_VIEWS;
--삭제된 뷰 보기
SELECT * FROM VW_EMP20;
--