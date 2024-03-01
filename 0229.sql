--
--������ ����, ���Ű� �̷����� ���� �۱� ������ sysdate(����) - hiredate(�Ի���:����)
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
       MONTHS_BETWEEN(HIREDATE, SYSDATE),
       MONTHS_BETWEEN(SYSDATE, HIREDATE),
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE))
    FROM EMP;
--���ƿ��� ������ ��¥
--�ش� ���� ������ ��¥
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���'), LAST_DAY(SYSDATE) FROM DUAL;

--

--��¥ �ݿø�
SELECT SYSDATE,
       ROUND(SYSDATE, 'CC'),
       ROUND(SYSDATE, 'YYYY'),
       ROUND(SYSDATE, 'Q'),
       ROUND(SYSDATE, 'DDD'),
       ROUND(SYSDATE, 'HH')
    FROM DUAL;
--��¥ ������
SELECT SYSDATE,
       TRUNC(SYSDATE, 'CC'),
       TRUNC(SYSDATE, 'YYYY'),
       TRUNC(SYSDATE, 'Q'),
       TRUNC(SYSDATE, 'DDD'),
       TRUNC(SYSDATE, 'HH')
    FROM DUAL;
--
--����ȯ�Լ�
SELECT EMPNO, ENAME, EMPNO + '500' FROM EMP WHERE ENAME = 'SCOTT';
--���ڵ����͸� ����ǥ�� �����ָ� ���ڵ�����
--���� ������ 500�� ���ڷ� �ν��ؼ� �ڵ����� ���ڷ� �ٲ㼭 ���� = �ڵ�����ȯ, �Ͻ�������ȯ
SELECT 'ABC' + EMPNO, EMPNO FROM EMP WHERE ENAME = 'SCOTT';
--���� ���� �������̱� ������ �ڵ�����ȯ�� �ȵ�
--���������ȯ
--��������ȯ
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
--���Ͽ���
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DY'),
       TO_CHAR(SYSDATE, 'DAY')
    FROM DUAL;
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS K,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS J,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS E,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS K,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS J,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS E
    FROM DUAL;
-- ǥ�� �� �ٲٱ�
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') AS K,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS J,
       TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS E,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN') AS K,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS J,
       TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS E
    FROM DUAL;
--��������
SELECT SAL,
       TO_CHAR(SAL, '$999,999') AS SAL_$,
       TO_CHAR(SAL, 'L999,999') AS SAL_L,
       TO_CHAR(SAL, '999,999.00') AS SAL_1,
       TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
       TO_CHAR(SAL, '000999999.99') AS SAL_3,
       TO_CHAR(SAL, '999,999,00') AS SAL_4
    FROM EMP;
--
--��������ȯ
SELECT 1300 - '1500', '1300' + 1500 FROM DUAL;
--1000 ������ ���ڰ� �����ִٰ� �˷���߸� ��ǥ�� ����
SELECT '1,300' - '1,500' FROM DUAL;
-- ���� �Ʒ�ó�� ���� �ִ� ����! ��� �˷������
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999') FROM DUAL;
--

--��¥����ȯ
SELECT TO_DATE('2018-07-14', 'YYYY-MM-DD') AS DATE1,
       TO_DATE('20180714', 'YYYY-MM-DD') AS DATE2
    FROM DUAL;
--��¥ �� = 1981�� 6�� 1�� ���Ŀ� �Ի��� ��� (����= �̷� = 6/1���� �� Ŀ����)
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');
--��¥ �� = 1981�� 6�� 1�� ������ �Ի��� ���
SELECT * FROM EMP WHERE HIREDATE < TO_DATE('1981/06/01', 'YYYY/MM/DD');
--RR 1950~2049
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS Y1,
       TO_DATE('49/12/10', 'RR/MM/DD') AS Y2,
       TO_DATE('50/12/10', 'YY/MM/DD') AS Y3,
       TO_DATE('50/12/10', 'RR/MM/DD') AS Y4,
       TO_DATE('51/12/10', 'YY/MM/DD') AS Y5,
       TO_DATE('51/12/10', 'RR/MM/DD') AS Y6
    FROM DUAL;
--NULL ó�� �Լ�
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, NVL(COMM, 0), SAL+NVL(COMM, 0) FROM EMP;
--
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, 'O', 'X'), NVL2(COMM, SAL*12+COMM, SAL*12) FROM EMP;
--

--��Ȳ�� ���� �ٸ� ������ ��ȯ
--DECODE = ���ٴ� ���Ǹ� ��� ����
SELECT EMPNO, ENAME, JOB, SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN', SAL*1.05,
              'ANALYST', SAL,
              SAL*1.03) AS UPSAL
    FROM EMP;
--CASE = ���ٴ� ���� ���� �ٸ� ���� ��� ����
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
  FROM EMP;
--
SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '�ش���� ����'
        WHEN COMM = 0 THEN '���� ����'
        WHEN COMM > 0 THEN '����: ' || COMM
    END AS COMM_TXT
  FROM EMP;
--

--����1
SELECT EMPNO,
       RPAD(SUBSTR(EMPNO,1,2),4,'*') AS MASKING_EMPNO,
       ENAME,
       RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_ENAME
    FROM EMP
   WHERE LENGTH(ENAME) >= 5
     AND LENGTH(ENAME) < 6;
--����2
SELECT EMPNO, ENAME, SAL,
       TRUNC(SAL/21.5,2) AS DAY_PAY,
       ROUND(SAL/21.5/8,1) AS TIME_PAY
    FROM EMP;
--����3
SELECT EMPNO, ENAME, HIREDATE, 
        TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'������'),'YYYY-MM-DD') AS R_JOB, 
        NVL(TO_CHAR(COMM),'N/A') AS COMM
    FROM EMP;
--����4
SELECT EMPNO, ENAME, MGR,
    CASE
       WHEN MGR IS NULL THEN '0000'
       WHEN SUBSTR(MGR,1,2) = '75' THEN '5555'
       WHEN SUBSTR(MGR,1,2) = '76' THEN '6666'
       WHEN SUBSTR(MGR,1,2) = '77' THEN '7777'
       WHEN SUBSTR(MGR,1,2) = '78' THEN '8888'
       ELSE TO_CHAR(MGR)
    END AS CHG_MGR
    FROM EMP;
--

--�������Լ� - �ϳ��� ������ ���
--�հ�
SELECT SAL FROM EMP;
SELECT SUM(SAL) FROM EMP;
-- ��� ���� ������ �ϳ��� �������̰�(SUM) �������� ���� ���Ƽ� �پ ����� ���� ����!!!
SELECT ENAME, SUM(SAL) FROM EMP;

--NULL �� �����ϰ� ����
SELECT SUM(COMM) FROM EMP;
-- �ߺ��� �����ϰ� ���غ���
SELECT SUM(DISTINCT SAL),
       SUM(ALL SAL),
       SUM(SAL)
    FROM EMP;
--���� ������ �ϳ����̱� ������ ���� �� ����
SELECT SUM(SAL), SUM(COMM) FROM EMP;
--

-- COUNT
SELECT COUNT(COMM) FROM EMP;
SELECT COUNT(COMM) FROM EMP WHERE COMM IS NOT NULL;
--�ִ밪
SELECT MAX(SAL) FROM EMP;
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 20;
SELECT MAX(HIREDATE) FROM EMP;
--�ּҰ�
SELECT MIN(SAL) FROM EMP;
SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30;
SELECT MIN(HIREDATE) FROM EMP;
--���
SELECT AVG(SAL) FROM EMP;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10; --10�� �μ� �ٹ��� ����鸸 �̾Ƽ� ���
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20; --20�� �μ����� �ٹ��� ����鸸 �̾Ƽ� ���
SELECT AVG(DISTINCT SAL) FROM EMP WHERE DEPTNO = 20; -- DISTINCT�� �� �� ����
SELECT AVG(COMM) FROM EMP;
SELECT AVG(COMM) FROM EMP WHERE DEPTNO = 30;
--
--�׷캰�� ������ �ϳ��� �� ã�Ƽ�
SELECT DISTINCT DEPTNO FROM EMP;
SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP WHERE DEPTNO = 20;
SELECT * FROM EMP WHERE DEPTNO = 30;
-- ���⿡ �־ UNION ALL�� ���� ������� (����)
SELECT AVG(SAL), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;
--������ GROUP BY�� �Ἥ �ʹ� ����!! �� �� ����
SELECT AVG(SAL), DEPTNO FROM EMP GROUP BY DEPTNO;
SELECT AVG(SAL), DEPTNO FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
--�� �ٸ� ����: DEPTNO�� JOB�� �Բ� ��� �ϳ��� �׷��̵� (����: 10�� CLERK)
SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY DEPTNO, JOB;
-- ���� ���� �Ʒ��� ���� GROUP BY �� �� �� ����
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
--�μ���ȣ�� ��� ��հ� ���� -> 30�� COMM ������
SELECT DEPTNO, AVG(COMM) FROM EMP GROUP BY DEPTNO;
--GROUP BY �� SELECT ������ �Ȱ��� ����� -> ����� ���� SELECT�� DEPTNO���� ENAME�� ������
SELECT ENAME, DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO;

--GROUP BY HAVING ����
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP GROUP BY DEPTNO, JOB ORDER BY DEPTNO, JOB;
-- GROUPȭ �� ������� ������ �ɾ ���� ���� �͸� ������� ��
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
-- GROUP BY ����Ǳ� ���� WHERE�� ����Ǳ� ������ WHERE�� ���� ������ �Ǿ����
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
    WHERE AVG(SAL) >= 2000
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
-- ���� ���� ��ġ��,
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
    WHERE SAL <= 3000
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
--

--����Ʈ�� ��ġ��
SELECT ENAME FROM EMP WHERE DEPTNO = 10;
SELECT DEPTNO, ENAME FROM EMP GROUP BY DEPTNO, ENAME ORDER BY DEPTNO, ENAME;
SELECT DEPTNO,
       LISTAGG(ENAME, ', ') -- ���̽� JOINó�� �� �̸��� �����ڷ� ������
       WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES --�� �׷� �ȿ���~ WITHIN (ORDER BY -> ��������!) : �׷� �ȿ��� �޿� ����� �̸��� ��������
    FROM EMP
    GROUP BY DEPTNO;
SELECT DEPTNO,
       LISTAGG(ENAME, ', ')
       WITHIN GROUP(ORDER BY ENAME) AS ENAMES -- �ٸ� ������ ������ ORDER �غ���
    FROM EMP
    GROUP BY DEPTNO;
--
SELECT LISTAGG(ENAME, ', ') -- �̰Ŵ� �׷����� ���� LISTAGG�Ѱ� �ƴ϶� ��ü �̸��� �� LISTAGG �ϰڴٴ� ��
       WITHIN GROUP(ORDER BY ENAME) AS ENAMES 
    FROM EMP;