import pyodbc
from time import sleep
from dotenv import load_dotenv
import os
from random import randrange
import insert_queries

load_dotenv(verbose=True)


server = "localhost"
database = os.getenv('database')
username = os.getenv('SQL_username')
password = os.getenv('SQL_password')

cnxn = pyodbc.connect(
    """Driver={ODBC Driver 17 for SQL Server};
    Server="""+server+""";
    Database="""+database+""";
    Trusted_Connection=No;
    UID="""+username+""";
    PWD="""+password+""";
    ConnectRetryCount=2;
    ConnectRetryInterval=3;""")

def run_query(cursor, query):
    try:
        cursor.execute(query)
        cursor.commit()
        # print("SQL query execution successful")
    except pyodbc.Error as e:
        raise e
    

# Random int in range 1-5 and then execute one of the queries
# Wait 10 sec (to check what is average distance between transactions in Summit)
    
def execute(num_reruns = 0, sleep_secs = 10):
    if num_reruns <= 0 or num_reruns > 1000:
        num_reruns = 1000
    cursor = cnxn.cursor()
    run = 1
    while run <= num_reruns:
        query_no = randrange(1,4)
        query_name = f"insert_query_{query_no}"
        query = getattr(insert_queries, query_name)
        run_query(cursor, query)
        print(f"Query \"{query_name}\" runned. Waiting {sleep_secs} sec(s) for next query execution if awaiting.")
        sleep(sleep_secs)
        run += 1
    
if __name__ == "__main__":
    execute(num_reruns=2, sleep_secs=10)