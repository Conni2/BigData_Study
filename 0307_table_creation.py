# 라이브러리 불러오기
import cx_Oracle as oci
# 디비 연결
con = oci.connect("scott/tiger@localhost:1521/orcl")
# 커서 생성
cur = con.cursor()
# create table
# sql 실행 - DDL = 자동 커밋
sql = "CREATE TABLE TEST (ID NUMBER(2), NAME VARCHAR2(10))"
cur.execute(sql)
print(cur.execute("SELECT * FROM TEST").fetchall())
# 디비 연결 종료
con.close()