# 한 줄 실행 = shift + enter
import cx_Oracle as oci

# db connection
con = oci.connect("scott/tiger@localhost:1521/orcl")
# cursor
cur = con.cursor()