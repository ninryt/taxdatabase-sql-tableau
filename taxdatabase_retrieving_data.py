import pyodbc

# Connection details
server = 'servername'
database = 'databasename'
username = 'admin'
password = 'password'
driver = '{ODBC Driver 17 for SQL Server}'

try:
    # Connecting to the database
    print("Connecting to the database...")
    conn = pyodbc.connect(
        f"DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}"
    )
    print("Connection established!")

    # Creating a cursor object to execute queries
    cursor = conn.cursor()

    # SQL query to select data
    query = "SELECT TOP 5 * FROM DimTravel;"  # Example: Retrieve the first 5 rows from DimTravel
    cursor.execute(query)

    # Fetching the data
    rows = cursor.fetchall()

    # Printing the results
    print("Here are the results:")
    for row in rows:
        print(row)

    # Closing the connection
    conn.close()
    print("Connection closed.")

except Exception as e:
    print("An error occurred:", e)
