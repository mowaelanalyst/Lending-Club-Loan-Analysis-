from airflow import DAG
from datetime import datetime
from airflow.providers.microsoft.mssql.operators.mssql import MsSqlOperator
from airflow.operators.python import PythonOperator


import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

def load_sheets():
    connection_url = URL.create(
        "mssql+pyodbc",
        username="airflow_user",
        password="airflow_user",
        host="host.docker.internal",
        database="Leding_club_loan_dataset",
        query={
            "driver": "ODBC Driver 18 for SQL Server",
            "TrustServerCertificate": "yes",
        }
    )

    engine = create_engine(connection_url)

    # Test connection first
    with engine.connect() as conn:
        print("SQL Server connected successfully!")

    # Load Excel sheets
    excel_file = pd.ExcelFile("/opt/airflow/dags/LCDataDictionary.xlsx")

    for sheet in excel_file.sheet_names:
        df = pd.read_excel(excel_file, sheet_name=sheet)

        df.to_sql(
            name=sheet,
            con=engine,
            if_exists="replace",
            index=False,
            method="multi"
        )

        print(f"{sheet} loaded successfully!")



with DAG(
    dag_id="Loan_Dataset_ETL",
    start_date=datetime(2026, 9, 8),
    schedule="@daily",
    catchup=False,
) as dag:

    load_excel = PythonOperator(
        task_id="load_excel_to_sql",
        python_callable=load_sheets,
    )
    load_data_to_bronze = MsSqlOperator(
        task_id="Bronze",
        mssql_conn_id="sql_loan_dataset",
        sql="EXEC Insert_data_to_bronze_layr"
    )
    load_data_to_silver = MsSqlOperator(
        task_id="silver",
        mssql_conn_id="sql_loan_dataset",
        sql="EXEC Load_silver_layr"
    )

load_excel >> load_data_to_bronze >> load_data_to_silver



