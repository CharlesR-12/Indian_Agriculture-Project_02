# Indian_Agriculture-Project_02
Indian Agriculture
AgriData Explorer: Understanding Indian Agriculture with EDA
1: Project Overview
2: Problem Statement
3: Business Use Cases
4: Project Stages Overview
5: Database Setup (MySQL)
5: Objective: Set up a relational database to store agricultural data.
6: Database Creation: Create the Project2_Agri_India database.
7: Table Definition:
8: Sample Data Insertion: Insert initial sample data into all tables for testing and setup.
9: Stage 2: Data Collection and Cleaning (Python Script)
10: Objective: Load raw CSV data and prepare it for database insertion.
11: Database Population (Python Script)
12: Objective: Insert cleaned data into the MySQL database.
13: Connect to MySQL: Establish an active connection.
14: Insert Master Data: Extract and insert unique states, districts, crops, and years into their respective master tables.
15: Insert Agricultural Production Data: Iterate through the DataFrame, inserting each row's values into the agri_production table, handling missing values (fillna(0)) and preventing duplicates (INSERT IGNORE).
16: Close Database Connection: Properly close the connection.
17: Exploratory Data Analysis (EDA) & Analytical Queries
18: Key Python Visualizations (EDA):
19: Power BI Integration and Visualization
20: Project Deliverables & Results
