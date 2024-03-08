--Data Manipulation Language (DML) ���۾�
--TCL (TRANSACTION CONTROL LANGUAGE) : COMMIT(��������) / ROLLBACK(���)�� �Բ� ����
--�ǽ������� ���� ����
--Data Definition Language (DDL) ���Ǿ�
--������ �ϸ� �ڵ����� COMMIT
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;
--
SELECT * FROM DEPT_TEMP;
--DROP TABLE DEPT_TEMP;
--����
CREATE TABLE EMP_TEMP10
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP10;
--
SELECT * FROM DEPT_TEMP; --������ �߰����� �� Ȯ��
--������ �߰� INSERT
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'DATABASE', 'SEOUL'); -- ���� ���� �� ������� ���� �־��ָ� ��
--
SELECT * FROM DEPT_TEMP;
--������ Ÿ�� Ȯ���ϱ�
DESC DEPT_TEMP;

--INSERT�� ���� �߻��� ���
--1) �� ������ ������ ���� ����ġ
COMMIT;
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK');
--���� ����
INSERT INTO DEPT_TEMP (DEPTNO, DNAME)
VALUES (60, 'NETWORK');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN', 'WRONG');
--���� ����
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--2) ������Ÿ�� ����ġ
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES ('WRONG', 'NETWORK', 'BUSAN');
--���� ����
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
ROLLBACK;
--3) ������ �Է� ���� ���
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (6, 'NETWORK', 'BUSAN');
--���� ����
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
--���̺� ��ü���� �߰��� ���� �� ���� ���� �Է� ����
ROLLBACK;
INSERT INTO DEPT_TEMP
VALUES (60 , 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
--

--NULL ������ �߰��ϱ�
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (70 , 'WEB', NULL);
SELECT * FROM DEPT_TEMP;
--BLANK ������ �߰��ϱ�
INSERT INTO DEPT_TEMP (DEPTNO, DNAME , LOC)
               VALUES (80 , 'MOBILE', '');
SELECT * FROM DEPT_TEMP;
--�ǹ����� Ư�� �����ڿ� ������ ���� BLANK���� NULL�� �̿��ϴ� ���� ����ִ� ���̶�� �ǹ̰� �� ��Ȯ��
--NULL ���� �Է��� ���� �����ϰ� ������ �߰��ϱ�(�Ͻ��� �Է�)
INSERT INTO DEPT_TEMP (DEPTNO, LOC)
               VALUES (90 , 'INCHEON');
SELECT * FROM DEPT_TEMP;
--

--�Ȱ��� ���� ������ ���̺� �����ϱ� : ������ ���� ������ ���� -> �׻� ������ �������� SELECT
CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
       WHERE 1 != 1; --�׻� ������ ����!!! 1�� 1��
SELECT * FROM EMP_TEMP;
--
--��¥ ������ �Է��ϱ�
--YYYY/MM/DD
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
               VALUES (9999, 'ȫ�浿', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);
SELECT * FROM EMP_TEMP;
--YYYY-MM-DD
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
               VALUES (1111, '������', 'MANAGER', 9999, '2001-01-05', 4000, NULL, 20);
SELECT * FROM EMP_TEMP;
--
--DD/MM/YYYY
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR , HIREDATE, SAL , COMM, DEPTNO)
              VALUES (2111, '�̼���', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);
--���� ����: TO_DATE �Լ��� �̿��Ͽ� ��¥ ǥ�� ������ ����� ��
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (2111, '�̼���', 'MANAGER', 9999,
        TO_DATE('07/01/2001', 'DD/MM/YYYY'), 4000, NULL, 20);
SELECT * FROM EMP_TEMP;
--

--���� ��¥ �Է� SYSDATE
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (3111, '��û��', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM EMP_TEMP;

--���������� �̿��Ͽ� �ѹ��� �Է��ϱ�
--������ ��: VALUES ����, ���� ������ ������Ÿ�� ��ġ�ؾ� ��
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL --������
   AND S.GRADE = 1; --������ �ϳ� �� �߰� �Ǿ���! �޿� ����� 1�� �ֵ���
SELECT * FROM EMP_TEMP;
--

--������ �����ϱ� UPDATE
--�μ� ���̺� ����
CREATE TABLE DEPT_TEMP2
    AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP2;
--�ϰ������� ����
UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL';
SELECT * FROM DEPT_TEMP2;
--���
ROLLBACK;
SELECT * FROM DEPT_TEMP2;
--

--�������� �Ϻκ� ����
--���� ������ �´��� Ȯ��
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = 40;
--����
UPDATE DEPT_TEMP2
   SET DNAME = 'DATABASE',
       LOC = 'SEOUL'
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;
ROLLBACK;
--����
SELECT * FROM EMP_TEMP;
--���� ������ �´��� Ȯ��
SELECT * FROM EMP_TEMP WHERE SAL <= 2500;
--����
UPDATE EMP_TEMP
  SET COMM = 50
 WHERE SAL <= 2500;
SELECT * FROM EMP_TEMP;
--

--���������� �̿��Ͽ� ����
--��������
SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40;
--���� ������ �´��� Ȯ��
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = 40;
--����
UPDATE DEPT_TEMP2
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;
ROLLBACK;
--���� ���� ���� ����������, �ݺ� �ۼ����� ��ȿ������
UPDATE DEPT_TEMP2
   SET DNAME = (SELECT DNAME FROM DEPT WHERE DEPTNO = 40),
       LOC = (SELECT LOC FROM DEPT WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
--

--���������� �������� ����Ͽ� ����
--��������
SELECT DEPTNO FROM DEPT_TEMP2 WHERE DNAME='OPERATIONS';
--���� ������ �´��� Ȯ��
SELECT * FROM DEPT_TEMP2 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT_TEMP2 WHERE DNAME='OPERATIONS');
--����
UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL'
 WHERE DEPTNO = (SELECT DEPTNO
                   FROM DEPT_TEMP2
                  WHERE DNAME='OPERATIONS');
SELECT * FROM DEPT_TEMP2;
--
ROLLBACK;

--������ �����ϱ� DELETE
--EMP ���̺� ����
CREATE TABLE EMP_TEMP2
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;
--������ �Ϻ� ����
--Ȯ��
SELECT * FROM EMP_TEMP2 WHERE JOB = 'MANAGER';
--����
DELETE FROM EMP_TEMP2
 WHERE JOB = 'MANAGER';
SELECT * FROM EMP_TEMP2;
--

--���������� �̿��Ͽ� ������ �Ϻ� ����
--Ȯ��
SELECT E.EMPNO
  FROM EMP_TEMP2 E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 3 AND DEPTNO = 30;
SELECT * FROM EMP_TEMP2 WHERE EMPNO IN (7499,7844);
--����
DELETE FROM EMP_TEMP2
 WHERE EMPNO IN (SELECT E.EMPNO FROM EMP_TEMP2 E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                  AND S.GRADE = 3
                  AND DEPTNO = 30);
SELECT * FROM EMP_TEMP2;

--����
SELECT * FROM EMP_TEMP;
--Ȯ��
SELECT * FROM EMP_TEMP WHERE SAL >= 3000;
--����
DELETE FROM EMP_TEMP
 WHERE SAL >= 3000;
SELECT * FROM EMP_TEMP;
--
ROLLBACK;

--����1
CREATE TABLE CHAP10HW_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10HW_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10HW_SALGRADE AS SELECT * FROM SALGRADE;
--�� ���� INSERT
SELECT * FROM CHAP10HW_DEPT;
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT (DEPTNO, DNAME, LOC) VALUES (80, 'DML', 'BUNDANG');
SELECT * FROM CHAP10HW_DEPT;
ROLLBACK;
--�� ���� INSERT = ��� ���� INSERT �� ���� ���� ����
--�� ���� ���� INSERT
SELECT * FROM CHAP10HW_DEPT;
INSERT INTO CHAP10HW_DEPT VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10HW_DEPT VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10HW_DEPT VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10HW_DEPT VALUES (80, 'DML', 'BUNDANG');
SELECT * FROM CHAP10HW_DEPT;
--���� INSERT
ROLLBACK;
SELECT * FROM CHAP10HW_DEPT;
--�� ���� INSERT
INSERT ALL
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(50,'ORACLE','BUSAN')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(60,'SQL','ILSAN')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(70,'SELECT','INCHEON')
 INTO CHAP10HW_DEPT(DEPTNO, DNAME, LOC) VALUES(80,'DML','BUNDANG')
SELECT * FROM DUAL;
SELECT * FROM CHAP10HW_DEPT;
ROLLBACK;
--�� ���� ���� INSERT
INSERT ALL
 INTO CHAP10HW_DEPT VALUES (50, 'ORACLE', 'BUSAN')
 INTO CHAP10HW_DEPT VALUES (60, 'SQL', 'ILSAN')
 INTO CHAP10HW_DEPT VALUES (70, 'SELECT', 'INCHEON')
 INTO CHAP10HW_DEPT VALUES (80, 'DML', 'BUNDANG')
 SELECT * FROM DUAL;
SELECT * FROM CHAP10HW_DEPT;

ROLLBACK;

-- 

--����2
--���� INSERT
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
--���� INSERT
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
--����3
--��������
SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50;
--Ȯ��
SELECT * FROM CHAP10HW_EMP WHERE SAL > (SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
--����
UPDATE CHAP10HW_EMP
   SET DEPTNO = 70
  WHERE SAL > (SELECT AVG(SAL) FROM CHAP10HW_EMP WHERE DEPTNO = 50);
SELECT * FROM CHAP10HW_EMP;
--����4
--��������
SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60;
--Ȯ��
SELECT * FROM CHAP10HW_EMP WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60);
--����
UPDATE CHAP10HW_EMP
   SET SAL = SAL*1.1,
       DEPTNO = 80
   WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60);
SELECT * FROM CHAP10HW_EMP;
--����5
--��������
SELECT E.EMPNO FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5;
--Ȯ��
SELECT * FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5;
--����
DELETE FROM CHAP10HW_EMP
  WHERE EMPNO IN (SELECT E.EMPNO FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
      AND S.GRADE = 5);
SELECT * FROM CHAP10HW_EMP;
--

--Ʈ����� ���� ���(Transaction Control Language, TCL)
--�μ� ���̺� ����
CREATE TABLE DEPT_TCL
    AS SELECT *
         FROM DEPT;
SELECT * FROM DEPT_TCL;
--���
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_TCL;
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL;
ROLLBACK;
SELECT * FROM DEPT_TCL;

--��������
INSERT INTO DEPT_TCL VALUES(50, 'NETWORK', 'SEOUL');
SELECT * FROM DEPT_TCL;
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 20;
SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 40;
SELECT * FROM DEPT_TCL;
COMMIT;
SELECT * FROM DEPT_TCL;
--

--�б� �ϰ���
--sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;
--sqldeveloper
DELETE FROM DEPT_TCL
 WHERE DEPTNO = 50;
 
--sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;

--sqldeveloper
COMMIT;

--sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;
--

--���� ���� ������ ���� ���� LOCK
--sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;

--sqldeveloper
UPDATE DEPT_TCL SET LOC='SEOUL'
 WHERE DEPTNO = 30;
 
  --sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;

--SQLPLUS
UPDATE DEPT_TCL SET DNAME='DATABASE'
 WHERE DEPTNO = 30;
 
 --sqldeveloper
COMMIT;
--sqldeveloper, SQLPLUS ����
SELECT * FROM DEPT_TCL;

--����1
CREATE TABLE DEPT_HW
  AS SELECT * FROM DEPT;
SELECT * FROM DEPT_HW;
--����A
UPDATE DEPT_HW
  SET DNAME = 'DATABASE',
      LOC = 'SEOUL'
  WHERE DEPTNO = 30;
  --����A, B ������� ����
SELECT * FROM DEPT_HW;
--����B
UPDATE DEPT_HW
  SET DNAME = 'DATABASE',
      LOC = 'SEOUL'
  WHERE DEPTNO = 30;
  --����A
ROLLBACK;
--����A, B ������� ����
SELECT * FROM DEPT_HW;


--���������Ǿ� (Data Definition Language, DDL)
--�ڵ����� COMMIT ��
--�ڷ����� �����Ͽ� ���̺� ����
CREATE TABLE EMP_DDL(
   EMPNO      NUMBER(4),
   ENAME      VARCHAR2(10),
   JOB        VARCHAR2(9),
   MGR        NUMBER(4),
   HIREDATE   DATE,
   SAL        NUMBER(7,2), --5�ڸ��� ����, 2�ڸ��� �Ҽ��� (�� ���̰� 7)
   COMM       NUMBER(7,2),
   DEPTNO     NUMBER(2)
);
DESC EMP_DDL;
SELECT * FROM EMP_DDL;

--���� ���̺��� ���� ���� �����Ͽ� ���̺� ����
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
DESC DEPT_DDL;
SELECT * FROM DEPT_DDL;
--���� ���̺��� ���� �Ϻ� ���� �����Ͽ� ���̺� ����
CREATE TABLE EMP_DDL_30
    AS SELECT *
         FROM EMP
        WHERE DEPTNO = 30;
SELECT * FROM EMP_DDL_30;
--���� ���̺��� ���� �����Ͽ� ���̺� ����
CREATE TABLE EMPDEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE,
              E.SAL, E.COMM, D.DEPTNO, D.DNAME, D.LOC
         FROM EMP E, DEPT D
        WHERE 1 != 1;
SELECT * FROM EMPDEPT_DDL;
--

--���̺� ����
--������� ���̺� ����
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
SELECT * FROM EMP_ALTER;
--���̺� �� �߰�
ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);
SELECT * FROM EMP_ALTER;
--���̺� �� �̸� ����
ALTER TABLE EMP_ALTER
RENAME COLUMN HP TO TEL;
SELECT * FROM EMP_ALTER;
--���̺� ���� ������ Ÿ�� ����
DESC EMP_ALTER;
ALTER TABLE EMP_ALTER
  MODIFY EMPNO NUMBER(5);
DESC EMP_ALTER;
--���̺� �� ����
ALTER TABLE EMP_ALTER
 DROP COLUMN TEL;
SELECT * FROM EMP_ALTER;
--
--���̺� �̸� ����
RENAME EMP_ALTER TO EMP_RENAME;
DESC EMP_ALTER;
SELECT * FROM EMP_ALTER;
DESC EMP_RENAME;
SELECT * FROM EMP_RENAME;
--���̺� ����(�� = ������ ����)
TRUNCATE TABLE EMP_RENAME;
SELECT * FROM EMP_RENAME;
--�� ����� DELETE������ ����������, �ڵ� COMMIT�� ���� ����
--
--���̺� ����
SELECT * FROM EMP_RENAME;
DROP TABLE EMP_RENAME;
DESC EMP_RENAME;
SELECT * FROM EMP_RENAME;
--
--����1
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

--����2
ALTER TABLE EMP_HW
  ADD BIGO VARCHAR2(20);
DESC EMP_HW;
--����3
ALTER TABLE EMP_HW
  MODIFY BIGO VARCHAR2(30);
DESC EMP_HW;
--����4
ALTER TABLE EMP_HW
  RENAME COLUMN BIGO TO REMARK;
SELECT * FROM EMP_HW;

--����5
SELECT * FROM EMP_HW;
--��������
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL FROM EMP;
--INSERT
INSERT INTO EMP_HW
 SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL FROM EMP;
SELECT * FROM EMP_HW;
--����6
DROP TABLE EMP_HW;
DESC EMP_HW;
SELECT * FROM EMP_HW;


--��ü ����
--������ ����
--���� �������� ��� ������ ������ ���� ����(����� �Ѵ� ����)
SELECT * FROM DICT;
SELECT * FROM DICTIONARY;
--���� ���� ����ڰ� ������ ��ü(���̺�) ����
SELECT TABLE_NAME FROM USER_TABLES;

--��� ����ڰ� ������ ��ü(���̺�) ����
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

--�����ͺ��̽� ���� ������ ���� ����ڸ� �� �� ����
SELECT * FROM DBA_TABLES;

--SYSTEM �������� ����
SELECT * FROM DBA_TABLES;
--SCOTT ���� ����� ���� ����
SELECT *
  FROM DBA_USERS
 WHERE USERNAME = 'SCOTT';
 
 --�ε���
--SCOTT�������� ����
--�ε��� ���� ����
SELECT * FROM USER_INDEXES;
--�ε��� �� ���� ����
SELECT * FROM USER_IND_COLUMNS;
--�ε��� ����
CREATE INDEX IDX_EMP_SAL
    ON EMP(SAL);
--������ �ε��� ����
SELECT * FROM USER_IND_COLUMNS;
--�ε��� ����
DROP INDEX IDX_EMP_SAL;
--�����Ǿ����� Ȯ��
SELECT * FROM USER_IND_COLUMNS;
--
--sqldeveloper���� SCOTT�������� �� ����
CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP
         WHERE DEPTNO = 20);
--�� ���� Ȯ��
SELECT * FROM USER_VIEWS;
--�� ���� Ȯ��(SQLPLUS���� SCOTT��������)
sqlplus scott/tiger
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
  FROM USER_VIEWS;
--�信 ����� SQL��
SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP
         WHERE DEPTNO = 20;
--������ �� ����
SELECT * FROM VW_EMP20;

----����
--�� ����
CREATE VIEW VW_EMP30ALL
  AS (SELECT * FROM EMP
       WHERE DEPTNO = 30);
--�� ���� Ȯ��
SELECT * FROM USER_VIEWS;
--������ �� ����
SELECT * FROM VW_EMP30ALL;
----�� ����
DROP VIEW VW_EMP20;
--������ �� Ȯ��
SELECT * FROM USER_VIEWS;
--������ �� ����
SELECT * FROM VW_EMP20;
--