# taxdatabase-sql-tableau
This repository showcases an end-to-end process for building an SQL Azure Database, performing data analysis, and visualizing insights. It includes SQL scripts for database architecture, table creation, initial data inserts, and deployment setup for the taxdatabase on Azure SQL. Additionally, it features data visualization and dashboard creation in Tableau.

The project defines a relational database schema (Tax- Expense Schema) to efficiently manage tax-related expenses. Expenses are categorized into dimensions such as courses, conferences, and travel, with calculated columns for automated data handling. The goal is to extract actionable insights that help optimize budgets, track financial trends, and support strategic decision-making.

---
![on delate cascade](https://github.com/user-attachments/assets/085f7ae0-8c4b-435c-bcd9-6fb2669bcf76)


## 🔸 Tools used:
- SQL Server on Azure: Database hosting and management.
- Azure Data Studio: Query development and data exploration.
- Tableau: Visualization of insights and reporting.
- Notepad++: Writing and editing SQL code.
- Lucidchart: Designing the database schema and entity relationships.

## 🔸 Skills Demonstrated
As a data scientist, I applied the following skills:
- Data Modeling: Designing a relational database for structured storage of expense data.
- Data Development form scratch.
- Database Management.
- Data Wrangling: Writing SQL queries to clean, transform, and prepare data for analysis.
- Data Retrieval + Analysis: Extracting meaningful patterns and trends from large datasets.
- Reporting and Visualization: Presenting results with dynamic dashboards.

## 🔸 Workflow
1. Designed Entity-Relationship Diagram (ERD), defining tables, establishing relationships, and normalizing data to ensure consistency, accuracy, and scalability.
2. Database Setup:
- Designed a database schema to manage expenses with tables for travels, conferences, meetings, and more.
- Deployed the database on SQL Server (Azure).
3. Data Exploration:
- Populated the database with sample data for business travel and related expenses.
- Wrote SQL queries to calculate total expenses, tips, and other key metrics.
4. Data Retrieval and Analysis:
- Performed cost analysis based on event type, location, and year.
- Identified high-cost trends and potential areas for savings.
5. Data Visualization:
- Migrated the data to Tableau to create dashboards with insights such as:
- Year-over-year expense comparisons
- Breakdown of costs by location and event type.
- Trends in business vs. personal travel costs.

## Entity-Relationship Diagram (ERD)
---
🔴  [SCAN HERE THE QR CODE TO VIEW THE DATABASE ARCHITECTURE](https://github.com/user-attachments/assets/d2f7c661-5379-4546-b50c-7b19b6b1c74c) ![code i yoytube (1)](https://github.com/user-attachments/assets/d2f7c661-5379-4546-b50c-7b19b6b1c74c)


## 🔸 Database Creation and Code Development
The database was implemented from scratch using SQL scripts that were initially written and tested in Notepad++. 

This approach allowed me to:

➡️ Ensure Data Integrity
➡️ Facilitate Code Versioning and Edits
➡️ Prevent Data Loss

Below is an example of the SQL code I wrote, showing how I structured and populated the database.


### Table Example
```sql
CREATE TABLE dbo.DimTravel (
    TravelID INT IDENTITY(1,1) PRIMARY KEY,
    TaxYear INT NOT NULL,
    TravelCity NVARCHAR(100) NOT NULL,
    TravelCountry NVARCHAR(5) NOT NULL,
    TravelYear INT NOT NULL,
    TravelMonth NVARCHAR(50) NOT NULL CHECK (TravelMonth IN (
        'January', 'February', 'March', 'April', 'May', 'June', 
        'July', 'August','September', 'Oktober' 'November', 'December'
    )),
    TotalExpenseEUR DECIMAL(10,2) AS (HotelExpense + ISNULL(HotelTip, 0.00)) PERSISTED
);
```

### Sample Query 1
```sql
SELECT 
    TravelMonth,
    SUM(TotalExpenseEUR) AS TotalMonthlyExpenses
FROM dbo.DimTravel
GROUP BY TravelMonth
ORDER BY TotalMonthlyExpenses DESC;
```

### Sample Query 2

```sql
SELECT
    te.EventCity AS Destination, -- City of travel (basic travel information)
    te.TaxYear AS TaxYear, -- Tax year associated with the travel expenses
    te.ExpenseAmountEUR AS TravelExpenseAmountEUR, -- Main travel cost in EUR (e.g., hotel)
    SUM(COALESCE(ate.ExpenseAmountEUR, 0)) AS TotalAdditionalExpenseAmountEUR, -- Total additional costs associated with the trip
    te.ExpenseAmountEUR + SUM(COALESCE(ate.ExpenseAmountEUR, 0)) AS TotalTravelExpenses, -- Total travel costs (main + additional)
    COALESCE(ce.ConferenceName, 'N/A') AS ConferenceName -- Name of the associated conference or "N/A" (if no association exists)
FROM 
    dbo.DimTravelExpenses AS te -- Main table containing travel information
LEFT JOIN 
    dbo.DimAdditionalTravelExpenses AS ate -- Join with the table of additional travel costs
ON 
    te.TravelID = ate.TravelID -- Linking additional expenses to the main trip using TravelID
LEFT JOIN 
    dbo.DimTravelPurposeMapping AS tp -- Join with the table of travel purposes
ON 
    te.TravelID = tp.TravelID AND tp.PurposeType = 'Conference' -- Filtering travel purpose as "Conference"
LEFT JOIN 
    dbo.DimConferencesExpenses AS ce -- Join with the conferences table
ON 
    tp.ConferenceID = ce.ConferenceID -- Linking the conference by its ID
GROUP BY 
    te.EventCity, -- Grouping results by the city of travel
    te.TaxYear, -- Grouping results by the tax year
    te.HotelName, -- Grouping by hotel name (if available)
    te.ExpenseAmountEUR, -- Grouping by main travel expenses
    ce.ConferenceName; -- Grouping by conference name (if available)
```

![github prezent](https://github.com/user-attachments/assets/c3372657-ea3a-442d-ba43-8561987e4b7a)


## 🔸 Taxdatabase Features 
- Multiple dimensional tables (e.g., `DimCourses`, `DimConferences`, `DimTravel`).
- Calculated fields for total expenses, tips, and travel distance.
- Foreign key constraints to ensure referential integrity.
- Cascading deletes for dependent data cleanup.

## 🔸 Database Deployment and Data Population: How I Set Up the Database
After carefully writing and refining the SQL scripts in Notepad++, I deployed the entire database on Microsoft Azure and managed it using Azure Data Studio. 

The process involved:

➡️ Migrating SQL Code
➡️ Populating the Database

## 🔸 Turning Data into Insights 

Once the database was set up and populated, I wrote SQL queries to extract meaningful insights from the data. 

This included: Retrieving Data for Analysis:

✅ Calculating total travel expenses (including additional costs).
✅ Generating reports on conference and meeting costs.
✅ Analyzing expenses across years, locations, and event types.


Below, you can see me performing live data analysis, showcasing my workflow and technical skills in action. The recording highlights:

➡️ Real-Time Analysis & Coding
​​​​​​​➡️ Demonstratin of: how I approach tasks, troubleshoot and refine queries.

[ 🔴 EXPLORE MY LIVE DATA ANALYSIS IN YOUTUBE HERE](https://github.com/user-attachments/assets/d2f7c661-5379-4546-b50c-7b19b6b1c74c)

---
## 🔸 Visualizing Insights: Migrating and Analyzing Data from Azure to Tableau
The final step of the project was to analyze the data and present it visually. To achieve this, I migrated the database from the Microsoft Azure server to Tableau. This required preparing the data source by connecting to the database, selecting the necessary tables, and configuring joins to define the logical relationships between the data entities. I ensured the joins were optimized to maintain query performance and avoid redundant data retrieval.

Additionally, I implemented calculated fields and filters within Tableau to refine the data for specific analyses and visualizations. This allowed for the creation of dynamic dashboards and detailed visual representations that effectively showcased the results of the entire analysis. 
The combination of technical precision and visual clarity ensured the insights were both actionable and easy to interpret for stakeholders. 

The final stage results are showcased below in GIFs for a clearer view of the project.

---
🔴 Setting Logical Relationships in Tableau ⬇️

![Copy of Copy of cover UX FTI (35)](https://github.com/user-attachments/assets/4c845a93-7973-4d6a-942a-0df4e45cf9a5)

![join](https://github.com/user-attachments/assets/23ca7a02-785a-44ff-91db-e07871bf4237)

🔴 Below is an example of the Tableau dashboard showcasing:

![wykres](https://github.com/user-attachments/assets/c9fc5643-09d8-4dac-9377-ee8871c0c5bc)

Total expenses by year and event type.
Interactive filters for country, event type, and date.

## 🔸 Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss your ideas.

## 🔸 LICENSE
This project is licensed under the MIT License. See the LICENSE file for more details.

## 🔸 How to Use
1. Clone the repository.
2. Open the SQL script [Taxdatabase Script](./database_script.sql) in your preferred SQL environment, such as:
- Azure Data Studio
- SQL Server Management Studio (SSMS)
3. Execute the scripts to:
- Create the database schema: Set up all tables, constraints, and relationships.
- Populate the tables with sample data (you can use: [Taxdatabase Seed Data Example](./seed_data.sql))
4. Analyze the data:
- Use the provided SQL queries (above: "Sample Query 2") or write your own to:
- Retrieve insights (e.g., travel expenses by month).
- Perform advanced analysis for reporting purposes.
5. Connect to SQL using Python [Establish Connection SQL-PY](./establish_connection_sql.py)

Clone this repository:
   ```bash
   git clone https://github.com/ninryt/taxdatabase-sql-tableau.git
 ```

