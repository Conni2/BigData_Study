--�׷�ȭ�� ���õ� �Լ� (GROUPBY)
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
--���� ���� + 1��ŭ ��� ��� (ROLLUP)
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY ROLLUP(DEPTNO, JOB);
    
    --2�� ���� ���� ������ŭ ��� ��� (CUBE)
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY CUBE(DEPTNO, JOB)
    ORDER BY DEPTNO, JOB;
    
--ù��° �� �׷�ȭ�Ͽ� �κ��� (ROLLUP �� ���Ǵ� ���� �κ����� ������ ����)
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY DEPTNO, ROLLUP(JOB);
--��� �̹��� ROLLUP�ȿ��� DEPTNO�� �����ϱ� DEPTNO�� �κ����� ������ �ʾҰ� JOB�� ������
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY JOB, ROLLUP(DEPTNO);
    
--���� ���� �׷�ȭ�Ͽ� ���
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY GROUPING SETS(DEPTNO, JOB)
    ORDER BY DEPTNO, JOB;
    
--GROUPING
--�׷�ȭ ���� �˷���(�׷�ȭ�� ���� 0)
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- CUBE�� ����� GROUPING �� DECODE������ �Ἥ �����غ���
--CUBE�� ����� GROUPING�Լ� �̿��Ͽ� DECODE������ ����
SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO, 
       DECODE(GROUPING(JOB), 1, 'ALL_JOB', JOB) AS JOB, --DECODE���Ǿ��ٸ� JOB�� �״��
       COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

--�׷�ȭ ���� �˷���(0, 1�� ����)
SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB),
       GROUPING_ID(DEPTNO, JOB)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;
--

--PIVOT: ���� ���� �ٲ�
SELECT DEPTNO, JOB, MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
--DEPTNO�� �࿡�� ����
SELECT *
    FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
    PIVOT(MAX(SAL)
          FOR DEPTNO IN (10,20, 30)) --������ ���̾��µ� �̰� ���� ��
    ORDER BY JOB;
--JOB�� �࿡�� ����
SELECT *
    FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
    PIVOT(MAX(SAL)
          FOR JOB IN ('CLERK' AS CLERK,
                      'MANAGER' AS MANAGER,
                      'PRESIDENT' AS PRESIDENT,
                      'ANALYST' AS ANALYST,
                      'SALESMAN' AS SALESMAN))
    ORDER BY DEPTNO;
--DECODE �� PIVOT -> PIVOT�� DECODE�ε� �� �� ����
SELECT DEPTNO,
       MAX(DECODE(JOB, 'CLERK', SAL)) AS CLERK,
       MAX(DECODE(JOB, 'SALESMAN', SAL)) AS SALESMAN,
       MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS PRESIDENT,
       MAX(DECODE(JOB, 'MANAGER', SAL)) AS MANAGER,
       MAX(DECODE(JOB, 'ANALYST', SAL)) AS ANALYST
  FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--UNPIVOT: ���� ������ �ٲ�
SELECT *
  FROM(SELECT DEPTNO,
              MAX(DECODE(JOB, 'CLERK' , SAL)) AS "CLERK",
              MAX(DECODE(JOB, 'SALESMAN' , SAL)) AS "SALESMAN",
              MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
              MAX(DECODE(JOB, 'MANAGER' , SAL)) AS "MANAGER",
              MAX(DECODE(JOB, 'ANALYST' , SAL)) AS "ANALYST"
         FROM EMP
       GROUP BY DEPTNO
       ORDER BY DEPTNO)
UNPIVOT(
   SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
ORDER BY DEPTNO, JOB;
--

-- ��������
--����1
SELECT DEPTNO,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
    FROM EMP
   GROUP BY DEPTNO;
--����2
SELECT JOB, COUNT(*)
    FROM EMP
   GROUP BY JOB
   HAVING COUNT(*) >= 3;
--����3
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       DEPTNO,
       COUNT(*) AS CNT
    FROM EMP
   GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
--����4
SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM,
       COUNT(*) AS CNT
    FROM EMP
   GROUP BY NVL2(COMM, 'O', 'X');
--����5
SELECT DEPTNO,
       TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       COUNT(*) AS CNT,
       MAX(SAL) AS MAX_SAL,
       SUM(SAL) AS SUM_SAL,
       AVG(SAL) AS AVG_SAL
    FROM EMP
   GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
--
--���� ���̺��� �ϳ��� ���̺�ó�� ����ϴ� ����
--14 rows
SELECT *
  FROM EMP
 ORDER BY EMPNO;
--4 rows
SELECT *
  FROM DEPT
 ORDER BY DEPTNO;
--14*4=56 rows -> �� ������ ��� ������ ����� : �̸� DEPTNO_1�� ���� �͸� JOIN �ؾ��Ѵٴ� ������ �ʿ���
SELECT *
  FROM EMP, DEPT
 ORDER BY EMPNO;
 
--�������� = ����� = �ܼ�����
--���� ���ϴ� ������ ��쿡 �ش���
SELECT *
  FROM EMP, DEPT
 WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;
--���̺� ��Ī ���
SELECT *
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;
--���� ��ü������ ���
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO,
       D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;
--

--���ÿ� ���� ���� ������ �ִ� ���
SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
--���� ��ó�� ��ü������ ����ؾ� ��
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
--���� �߰�
--������ �ݵ�� �ּ� ���̺� ���� - 1�� ��ŭ �ʿ���
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND SAL >= 3000;
--����
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND SAL <= 2500
   AND EMPNO <= 9999;
--

--������ = ����� �̿��� ���� ���
SELECT *
    FROM EMP;
SELECT *
    FROM SALGRADE;
--
SELECT *
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
 
--��ü ���� = ���� ���̺��� ����
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
 WHERE E1.MGR = E2.EMPNO;
 
 --�ܺ�����
--LEFT OUTER JOIN
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
 WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;
--���ӻ���� ���� ����� ����
--RIGHT OUTER JOIN
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1, EMP E2
 WHERE E1.MGR(+) = E2.EMPNO
ORDER BY E1.EMPNO;
--���������� ���� ����� ����

--JOIN ~ ON
--������ ���� ���� �����ؾ� �� = ���ٴ� ��������
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
  FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
 WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

--LEFT OUTER JOIN ON
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1 JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;

--OUTER JOIN ON
--LEFT OUTER JOIN ON
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;
--RIGHT OUTER JOIN ON
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;
--FULL OUTER JOIN ON
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
  FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;
--���ӻ���� ���� ��� + ���������� ���� ���
--

--����1
--SQL-99 ���� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
    FROM DEPT D, EMP E
   WHERE D.DEPTNO = E.DEPTNO
     AND E.SAL > 2000
   ORDER BY D.DEPTNO;
   
--SQL-99 ���
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
  FROM EMP E NATURAL JOIN DEPT D
 WHERE E.SAL > 2000
 ORDER BY DEPTNO;
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
  FROM EMP E JOIN DEPT D USING(DEPTNO)
 WHERE E.SAL > 2000
 ORDER BY DEPTNO;
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
    FROM DEPT D JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
   WHERE E.SAL > 2000
   ORDER BY D.DEPTNO;

--����2
--SQL-99 ���� ���
SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
    FROM DEPT D, EMP E
   WHERE D.DEPTNO = E.DEPTNO
  GROUP BY D.DEPTNO, D.DNAME;
  
--SQL-99 ���
SELECT DEPTNO, D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  FROM EMP E NATURAL JOIN DEPT D
 GROUP BY DEPTNO, D.DNAME;
SELECT DEPTNO, D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  FROM EMP E JOIN DEPT D USING(DEPTNO)
 GROUP BY DEPTNO, D.DNAME;
SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
    FROM DEPT D JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
   GROUP BY D.DEPTNO, D.DNAME;
   
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
        FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO);
        
--����3
--SQL-99 ���� ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
     FROM DEPT D, EMP E
    WHERE D.DEPTNO = E.DEPTNO(+)
   ORDER BY D.DEPTNO, E.ENAME;
--SQL-99 ���
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
     FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
    ORDER BY D.DEPTNO, E.ENAME;

--����4
--SQL-99 ���� ���
SELECT D.DEPTNO, D.DNAME,
       E1.EMPNO, E1.ENAME, E1.MGR, E1.SAL, E1.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
    FROM DEPT D, EMP E1, SALGRADE S, EMP E2
   WHERE D.DEPTNO = E1.DEPTNO(+)
     AND E1.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
     AND E1.MGR = E2.EMPNO(+)
   ORDER BY D.DEPTNO, E1.EMPNO;
--SQL-99 ���
SELECT D.DEPTNO, D.DNAME,
       E1.EMPNO, E1.ENAME, E1.MGR, E1.SAL, E1.DEPTNO,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
    FROM DEPT D LEFT OUTER JOIN EMP E1 ON (D.DEPTNO = E1.DEPTNO)
                LEFT OUTER JOIN SALGRADE S ON (E1.SAL BETWEEN S.LOSAL AND S.HISAL)
                LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
   ORDER BY D.DEPTNO, E1.EMPNO;

--WHERE�� �ڿ��� ����ϴ� ���� ����
--�����༭������
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
--
SELECT *
  FROM EMP
 WHERE SAL > 2975;
--
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');
 
 --�����༭������ & ��¥�� ������
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE
                     FROM EMP
                    WHERE ENAME = 'SCOTT');
                    
--�����༭������
--������ ������ IN
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
--�μ� �� ���� ���� �޴� ���
SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                 FROM EMP
               GROUP BY DEPTNO);
--���ٴ� OR ���� ���� ���� ����   
--������ ������ ANY
SELECT *
  FROM EMP
 WHERE SAL = ANY (SELECT MAX(SAL)
                    FROM EMP
                  GROUP BY DEPTNO);
--������ ������ SOME
SELECT *
  FROM EMP
 WHERE SAL = SOME (SELECT MAX(SAL)
                     FROM EMP
                   GROUP BY DEPTNO);
--
--< ANY/SOME
--����� �ִ밪���� ���� �Ͱ� ����.
--950 1250 1500 1600 2850
SELECT *
  FROM EMP
 WHERE SAL < ANY (SELECT SAL --ANY�� �ϳ��� �����ص� �Ǵ� ���̱� ������ ���� ���� �߿��� 2850���� ������ ������ �� Ŀ���Ǵϱ� �ִ񰪺��� ���������� ������ �൵ ��
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;
-- SOME�� ANY�� �Ȱ���
SELECT *
  FROM EMP
 WHERE SAL < SOME (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;
--�����༭�������� ��ü -> �׳� �ִ뺸�� ������ �ȴٷ� ���������� �ָ� ��
SELECT *
  FROM EMP
 WHERE SAL < (SELECT MAX(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;
                  
--> ANY/SOME
--����� �ּҰ����� ū �Ͱ� ����.
--950 1250 1500 1600 2850
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;
SELECT *
  FROM EMP
 WHERE SAL > SOME (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;
--�����༭�������� ��ü
SELECT *
  FROM EMP
 WHERE SAL > (SELECT MIN(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30)
                  ORDER BY SAL, EMPNO;

--ALL ������ ������
--< ALL
--����� �ּҰ����� ���� �Ͱ� ����.
--950 1250 1500 1600 2850
SELECT *
  FROM EMP
 WHERE SAL < ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
--�����༭�������� ��ü
SELECT *
  FROM EMP
 WHERE SAL < (SELECT MIN(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30);
                   
--> ALL
--����� �ִ밪���� ū �Ͱ� ����.
--950 1250 1500 1600 2850
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
--�����༭�������� ��ü
SELECT *
  FROM EMP
 WHERE SAL > (SELECT MAX(SAL)
                    FROM EMP
                   WHERE DEPTNO = 30);
--
--EXISTS ������ ������
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 10);
--
SELECT *
  FROM EMP
 WHERE EXISTS (SELECT DNAME
                 FROM DEPT
                WHERE DEPTNO = 50);
--���߿� �������� = ������ ��������
--���� ���� ���� ���ϴ� ���� �ǹ����� �� ���� ����ϹǷ� ����صα�
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                         GROUP BY DEPTNO);
--
--FROM�� �ڿ��� ����ϴ� �������� = �ζ��κ�
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
       (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
--�ζ��κ䰡 ���� ���� WITH���� ���� ��Ī���� �����ؼ� ����ϸ� �������� ����.
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;
--
--SELECT������ ����ϴ� �������� = ��Į�� ��������
SELECT GRADE
          FROM EMP E, SALGRADE S
         WHERE E.SAL BETWEEN LOSAL AND HISAL;
SELECT DNAME
         FROM EMP E, DEPT
        WHERE E.DEPTNO = DEPT.DEPTNO;
--EMP E �� FROM ���� �����Ƿ� �������� �������� EMP ���̺��� ���� �ʾƵ� ��Ī E ��� ����
--�������� ����� �ٸ� ������ ������ ���� ������ �����ؾ� ��
SELECT EMPNO, ENAME, JOB, SAL,
       (SELECT GRADE
          FROM SALGRADE
         WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
       DEPTNO,
      (SELECT DNAME
         FROM DEPT
        WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;

SELECT *
  FROM EMP
 WHERE SAL IN (SELECT MAX(SAL)
                 FROM EMP
               GROUP BY DEPTNO);
               
SELECT *
  FROM EMP
 WHERE SAL = ANY (SELECT MAX(SAL)
                    FROM EMP
                  GROUP BY DEPTNO);
                  
-- IN�� ����� ����
SELECT *
FROM EMP
WHERE SAL > ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
-- ANY�� ����� ����
SELECT *
FROM EMP
WHERE SAL > ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);