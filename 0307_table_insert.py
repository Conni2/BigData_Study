# 라이브러리 불러오기
import cx_Oracle as oci
# 디비 연결
# "ID/PW@localhost:1521/orcl"
con = oci.connect("scott/tiger@localhost:1521/orcl")
# 커서 생성
cur = con.cursor()
#
# insert
while True:
    data1 = input("ID 를 입력하세요(정수)> ")
    if data1 == "":
        break
    data2 = input("이름을 입력하세요(한글 5글자, 영어 10글자)> ")
    sql = "INSERT INTO TEST VALUES('" + data1 + "','" + data2 + "')"
    cur.execute(sql)
# COMMIT
con.commit()
# 디비 연결 종료
con.close()