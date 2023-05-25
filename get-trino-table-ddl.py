#用途：获取已有的表的ddl,在另外的库下根据之前的ddl创建同样的表。

import trino
from trino.auth import BasicAuthentication
import os

# 连接trino
conn = trino.dbapi.connect(
    host='https://trino.xxx.com',
    port=443,
    user='admin_rw',
    auth=BasicAuthentication("admin_rw", "xxxxx"),
    catalog='test',
    schema='test_1',
)

# 获取指定表的DDL语句，并将语句存到本地文件
tables = ['app1', 'app2']

for table in tables:
    cursor = conn.cursor()
    cursor.execute(f"SHOW CREATE TABLE {table}")
    ddl = cursor.fetchone()[0]
    file_path = f"{table}.sql"
    with open(file_path, 'w') as f:
        f.write(ddl)
    # 根据已有的sql到指定的库创建表
    # os.system(f"trino --server your_trino_server --catalog your_catalog --schema iceberg.footprint < {file_path}")

