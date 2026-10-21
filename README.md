# End-to-End Automated Data Pipeline & BI Dashboard

A comprehensive data engineering and business intelligence project that automates the extraction, transformation, and visualization of business data using **Python**, **Apache Airflow**, **SQL**, and **Power BI**.

---

## 🚀 Project Overview
This project builds a robust, automated end-to-end data pipeline. It ingests multi-sheet Excel files, processes them through a **Medallion Architecture (Bronze, Silver, Gold)** inside a SQL database, orchestrates the entire workflow using **Apache Airflow**, and delivers actionable business insights through interactive **Power BI** dashboards.

---

## 🛠️ Tech Stack & Tools
* **Programming Language:** Python (Pandas, Openpyxl)
* **Workflow Orchestration:** Apache Airflow
* **Database & Architecture:** SQL Server  (Medallion Architecture: Bronze, Silver, Gold)
* **Data Visualization & BI:** Power BI (3 Interactive Dashboards)
* **Version Control:** Git & GitHub

---

## 🔄 Pipeline Architecture & Workflow

### 1. Ingestion & Extraction (Python)
* Read multi-sheet Excel files containing raw business data.
* Parsed and structured each sheet into separate, clean dataframes.
* Loaded the extracted data directly into the database.

### 2. Pipeline Automation (Apache Airflow)
* Developed custom Airflow DAGs to fully automate the data pipeline.

### 3. Data Modeling & Transformation (SQL - Medallion Architecture)
The data flows through three structured layers:
* **Bronze Layer (Raw Ingestion):** Stores raw data loaded directly from local sources and Python scripts with zero modifications.
* **Silver Layer (Data Cleaning & Quality):** Performed rigorous data cleaning, handled missing values, and improved overall data quality and consistency.
* **Gold Layer (Business-Ready):** Created optimized SQL views, applied segmentation, and performed data normalization to prepare analytical models ready for business consumption.

### 4. Business Intelligence & Reporting (Power BI)
* Connected Power BI directly to the processed SQL data models.
* Designed and developed **3 comprehensive interactive dashboards/reports** to track key performance metrics, trends, and business insights.

---

### 📺 Project Demo Video
Click the preview image below to watch the full walkthrough on YouTube:

[![Project Demo Video](https://img.youtube.com/vi/hMFKdeMEUTo/maxresdefault.jpg)](https://www.youtube.com/watch?v=hMFKdeMEUTo)
