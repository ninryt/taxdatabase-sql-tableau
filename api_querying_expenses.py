from flask import Flask, request, jsonify
import pyodbc
import pandas as pd

app = Flask(__name__)

# Database connection setup
DB_CONNECTION_STRING = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=<your_server>;DATABASE=taxdatabase;UID=sqladmin;PWD=<your_password>"

def execute_query(query, params=None):
    """Helper function to execute SQL queries."""
    conn = pyodbc.connect(DB_CONNECTION_STRING)
    cursor = conn.cursor()
    cursor.execute(query, params or [])
    columns = [column[0] for column in cursor.description]
    data = [dict(zip(columns, row)) for row in cursor.fetchall()]
    conn.close()
    return data

@app.route("/expenses", methods=["GET"])
def get_expenses():
    """Fetch expenses dynamically based on parameters (e.g., year, category)."""
    tax_year = request.args.get("tax_year")
    event_type = request.args.get("event_type")

    query = "SELECT * FROM dbo.FactTaxExpenses WHERE 1=1"
    params = []

    if tax_year:
        query += " AND PaymentYear = ?"
        params.append(tax_year)

    if event_type:
        query += " AND EXISTS (SELECT 1 FROM dbo.DimTravelPurposeMapping WHERE FactTaxExpenses.TravelID = DimTravelPurposeMapping.TravelID AND PurposeType = ?)"
        params.append(event_type)

    results = execute_query(query, params)
    return jsonify(results)

if __name__ == "__main__":
    app.run(debug=True)
