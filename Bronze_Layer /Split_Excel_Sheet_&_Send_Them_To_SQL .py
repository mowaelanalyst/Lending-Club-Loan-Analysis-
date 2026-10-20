
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
