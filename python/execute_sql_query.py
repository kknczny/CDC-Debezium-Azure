import pyodbc
from time import sleep, strftime
from dotenv import load_dotenv
import os
from random import randrange

load_dotenv(verbose=True)

server = "localhost"
database = os.getenv('database')
username = os.getenv('SQL_username')
password = os.getenv('SQL_password')

conn = pyodbc.connect(
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
    except pyodbc.Error as e:
        raise e
        
def execute(num_reruns = 0, sleep_secs = 10, script = 'neworder'):
    if num_reruns <= 0 or num_reruns > 1000:
        num_reruns = 1000
    
    if script.lower() == 'neworder':
        query_name = '02-create-new-sales-order.sql'
    elif script.lower() == 'modifystock':
        query_name = '03-modify-warehouse-stock.sql'
    else:
        raise ValueError(f"Incorrect \"script\" argument value \"{script}\".")  
    
    os.chdir("../sql")
    sqlfile = open(query_name, 'r')
    sqlfile.readline()  #First line use statement
    query = sqlfile.read()  #Rest of query
    query = query.replace("GO", "")
    
    cursor = conn.cursor()
    run = 1
    
    while run <= num_reruns:
        now = strftime("%H:%M:%S")
        run_query(cursor, query)
        print(f"{now} - Query \"{query_name}\" executed. Waiting {sleep_secs} sec(s) \
        for next query execution if awaiting ({run}/{num_reruns}).")
        sleep(sleep_secs)
        run += 1
    
    sqlfile.close()
    
if __name__ == "__main__":
    execute(num_reruns=1, sleep_secs=0, script='modifystock')