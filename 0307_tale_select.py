# 라이브러리 불러오기
import cx_Oracle as oci
# 디비 연결
# "ID/PW@localhost:1521/orcl"
con = oci.connect("scott/tiger@localhost:1521/orcl")
# 커서 생성
cur = con.cursor()
# sql 실행
sql = "SELECT ID, NAME FROM TEST"
cur.execute(sql)
print(" ID        이름")
print("-"*15) #하이픈을 넣어서 조금 더 가독성을 좋게 만듬
#
while True:
    row = cur.fetchone()
    if row is None:
        break
    data1 = row[0]
    data2 = row[1]
    print("%3s %10s" % (data1, data2))
# 디비 연결 종료
con.close()