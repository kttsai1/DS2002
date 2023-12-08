import json
import requests
import requests.exceptions
import pandas as pd
import asyncio
from sqlalchemy import create_engine
import pymysql

query = []


async def fetch_data_from_api(url):
    response = requests.get(url)
    if response.status_code == requests.codes.ok:
        try:
            data = json.loads(response.text)
            data_entry = {
                'factor': data['factor'],
                'pi': data['pi'],
                'time': data['time']
            }
            query.append(data_entry)
        except json.JSONDecodeError:
            print("Error: Could not parse JSON response")
    else:
        print("Error:", response.status_code, response.text)


async def wait_60_seconds(url):
    for i in range(60):
        await asyncio.sleep(60)
        await fetch_data_from_api(url)


url = "https://4feaquhyai.execute-api.us-east-1.amazonaws.com/api/pi"
asyncio.run(wait_60_seconds(url))

df_pi = pd.DataFrame(query)
df_pi.insert(0, 'pi_key', df_pi.reset_index().index)
dst_dbname = 'final_project_db'


def set_dataframe(user_id, pwd, host_name, db_name, df, table_name, pk_column, db_operation):
    connection = pymysql.connect(host=host_name, user=user_id, password=pwd)
    cursor = connection.cursor()
    # Create the database if it doesn't exist
    create_database_query = f"CREATE DATABASE IF NOT EXISTS {db_name};"
    cursor.execute(create_database_query)
    use_database_query = f"USE {dst_dbname};"
    cursor.execute(use_database_query)
    if db_operation == "insert":
        # Use SQLAlchemy to insert DataFrame into MySQL
        engine = create_engine(f'mysql+pymysql://{user_id}:{pwd}@{host_name}/{db_name}')
        df.to_sql(table_name, con=engine, index=False, if_exists='replace')

        # Add primary key constraint
        add_pk_query = f"ALTER TABLE {table_name} ADD PRIMARY KEY ({pk_column});"
        cursor.execute(add_pk_query)
    elif db_operation == "update":
        # Use SQLAlchemy to update DataFrame in MySQL
        engine = create_engine(f'mysql+pymysql://{user_id}:{pwd}@{host_name}/{db_name}')
        df.to_sql(table_name, con=engine, index=False, if_exists='append')

    connection.close()


host_name = "localhost"
host_ip = "127.0.0.1"
port = "3306"
user_id = "root"
pwd = "Uva!1819"

connection = pymysql.connect(host=host_name, user=user_id, password=pwd)
cursor = connection.cursor()
db_operation = "insert"
set_dataframe(user_id, pwd, host_name, dst_dbname, df_pi, 'pi', 'pi_key', db_operation)


