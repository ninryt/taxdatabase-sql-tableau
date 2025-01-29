

-- Courses Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimCourses')
BEGIN
    CREATE TABLE dbo.DimCourses(
        CourseID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each course expense
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        EventCity NVARCHAR(100) NOT NULL, -- City where the course took place
        EventCountry NVARCHAR(5) NOT NULL, -- Country where the course took place (e.g., PL, DE)
        EventType NVARCHAR(50) NOT NULL CHECK(EventType IN ('Conference', 'BusinessMeeting', 'Course', 'RemoteWork', 'Other')), -- Type of event
        EventName NVARCHAR(100) NOT NULL, -- Name of the course
        EventYear INT NOT NULL, -- Year when the course occurred
        EventMonth NVARCHAR(50) NOT NULL CHECK(EventMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the course
        EventDays INT NOT NULL, -- Duration of the course in days
        EventMode NVARCHAR(50) CHECK(EventMode IN ('Online', 'In-Person', 'Hybrid')), -- Mode of the course: online, in-person, or hybrid
        EventCompany NVARCHAR(100) NOT NULL, -- Organizer of the course
        EventPlatform NVARCHAR(50), -- Platform where the course was conducted (if applicable)
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or nor specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method used for payment
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of the payment
    );
END

ALTER TABLE dbo.DimCourses
ADD TipEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00;

ALTER TABLE dbo.DimCourses
ADD TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED;



-- Conferences Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimConferences')
BEGIN
    CREATE TABLE dbo.DimConferences(
        ConferenceID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each conference expense
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        EventCity NVARCHAR(100) NOT NULL, -- City where the conference took place
        EventCountry NVARCHAR(5) NOT NULL, -- Country where the conference took place (e.g., PL, DE)
        EventType NVARCHAR(50) NOT NULL CHECK(EventType IN ('Conference', 'BusinessMeeting', 'Course', 'RemoteWork', 'Other')), -- Type of event
        EventName NVARCHAR(100) NOT NULL, -- Name of the conference
        EventYear INT NOT NULL, -- Year when the conference occurred
        EventMonth NVARCHAR(50) NOT NULL CHECK(EventMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July','September', 'October', 'August', 'November', 'December')), -- Month of the conference
        EventDays INT NOT NULL, -- Duration of the conference in days
        EventMode NVARCHAR(50) CHECK(EventMode IN ('Online', 'In-Person', 'Hybrid')), -- Mode of the conference: online, in-person, or hybrid
        EventCompany NVARCHAR(100) NOT NULL, -- Organizer of the conference
        EventPlatform NVARCHAR(50), -- Platform where the conference was conducted (if applicable)
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method used for payment
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of the payment
    );
END

ALTER TABLE dbo.DimConferences
ADD TipEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00;

ALTER TABLE dbo.DimConferences
ADD TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED;



-- Business Meetings Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimBusinessMeetings')
BEGIN
    CREATE TABLE dbo.DimBusinessMeetings(
        BusinessMeetingID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each business meeting expense
        TaxYear INT NOT NULL, -- Tax year when the payment was made
        EventCity NVARCHAR(100) NOT NULL, -- City where the meeting was held
        EventCountry NVARCHAR(5) NOT NULL, -- Country (e.g., PL, DE)
        EventType NVARCHAR(50) NOT NULL CHECK(EventType IN ('Conference', 'BusinessMeeting', 'Course', 'RemoteWork', 'Other')), -- Type of event
        EventName NVARCHAR(100) NOT NULL, -- Name of the event
        EventYear INT NOT NULL, -- Year of the event
        EventMonth NVARCHAR(50) NOT NULL CHECK(EventMonth IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the event
        EventDays INT NOT NULL, -- Duration of the meeting in days
        EventVenue NVARCHAR(200) NOT NULL, -- Place/Hotel's name where the meeting was held
        NumberOfGuests INT NOT NULL, -- Number of guests attending the meeting
        GuestsNames NVARCHAR(500) NOT NULL, -- Names of the guests
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Expense amount in EUR
        TipEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Tip amount in EUR
        TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED, -- Total expense in EUR (calculated column)
        ExpenseOriginal DECIMAL(10,2), -- Expense amount in original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK(InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal', 'CreditCard', 'DebitCard', 'MasterCard', 'Cash', 'Other')), -- Payment method used
        PaymentType NVARCHAR(50) CHECK(PaymentType IN ('OnlinePayment', 'BankTransfer', 'CardPayment', 'In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;


-- Remote Work Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimRemoteWork')
BEGIN
    CREATE TABLE dbo.DimRemoteWork(
        RemoteWorkID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each remote work expense
        TaxYear INT NOT NULL, -- Tax year when the payment was made
        EventCity NVARCHAR(100) NOT NULL, -- City where the remote work was conducted
        EventCountry NVARCHAR(5) NOT NULL, -- Country (e.g., PL, DE)
        EventType NVARCHAR(50) NOT NULL CHECK(EventType IN ('Conference', 'BusinessMeeting', 'Course', 'RemoteWork', 'Other')), -- Type of event
        EventName NVARCHAR(100) NOT NULL, -- Name of the remote work event
        EventYear INT NOT NULL, -- Year when the remote work took place
        EventMonth NVARCHAR(50) NOT NULL CHECK(EventMonth IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the remote work
        EventDays INT NOT NULL, -- Duration of the remote work in days
        EventCompany NVARCHAR(100) NOT NULL, -- Company associated with the remote work
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency,use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK(InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method used
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;

ALTER TABLE dbo.DimRemoteWork
ADD TipEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00;

ALTER TABLE dbo.DimRemoteWork
ADD TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED;




-- DimTravel Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimTravel')
BEGIN
    CREATE TABLE dbo.DimTravel(
        TravelID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each travel expense
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        TravelCity NVARCHAR(100) NOT NULL, -- City visited during the travel
        TravelCountry NVARCHAR(5) NOT NULL, -- Country visited during the travel (e.g., PL, DE)
        TravelYear INT NOT NULL, -- Year of the travel event
        TravelMonth NVARCHAR(50) NOT NULL CHECK(TravelMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the travel
        DepartureDate DATE NOT NULL, -- Date of departure
        ReturnDate DATE NOT NULL, -- Date of return
        BusinessDays INT NOT NULL, -- Number of business days during the travel
        PersonalDays AS ((DATEDIFF(DAY, DepartureDate, ReturnDate) + 1) - BusinessDays) PERSISTED, -- Personal days calculated dynamically
        HotelName NVARCHAR(100) NOT NULL, -- Name of the hotel used during the travel
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        TipEUR DECIMAL(10,2) DEFAULT 0.00, -- Tip amount in EUR
        TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED, -- Total expense in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method used
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE, -- Date of payment
        StartOdometer INT, -- Starting odometer reading for the trip (if applicable)
        EndOdometer INT, -- Ending odometer reading for the trip (if applicable)
        TotalDistance AS (EndOdometer - StartOdometer) PERSISTED, -- Distance traveled (calculated)
        CHECK (ReturnDate >= DepartureDate) -- Ensures return date is not earlier than the departure date
    );
END;

-- Renaming the column ExpenseEUR to HotelExpense
EXEC sp_rename 'dbo.DimTravel.ExpenseEUR', 'HotelExpense', 'COLUMN';

-- Renaming the column TipEUR to HotelTip
EXEC sp_rename 'dbo.DimTravel.TipEUR', 'HotelTip', 'COLUMN';

-- Updating the TotalExpenseEUR column to use the new names
ALTER TABLE dbo.DimTravel
DROP COLUMN TotalExpenseEUR;

ALTER TABLE dbo.DimTravel
ADD TotalExpenseEUR AS (HotelExpense + ISNULL(HotelTip, 0.00)) PERSISTED;



-- DimTravelExtraCosts Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimTravelExtraCosts')
BEGIN
    CREATE TABLE dbo.DimTravelExtraCosts(
        TravelExtraCostID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each additional travel expense
        TaxYear INT NOT NULL, -- Tax year when the additional expense was made
        TravelMonth NVARCHAR(50) NOT NULL CHECK(TravelMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October','November', 'December')), -- Month of the additional expense
        TravelYear INT NOT NULL, -- Year of the additional expense
        ExtraCostName NVARCHAR(200) NOT NULL, -- Description or name of the additional travel expense
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        TipEUR DECIMAL(10,2) DEFAULT 0.00, -- Tip amount in EUR
        TotalExpenseEUR AS (ExpenseEUR + ISNULL(TipEUR, 0.00)) PERSISTED, -- Total expense in EUR (calculated column)
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal', 'CreditCard', 'DebitCard', 'MasterCard', 'Cash', 'Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment', 'In-PersonPayment')), -- Payment type
        PaymentDate DATE, -- Date of payment
        TravelID INT NOT NULL, -- Foreign key linking to `DimTravel`
        FOREIGN KEY (TravelID) REFERENCES dbo.DimTravel(TravelID) ON DELETE CASCADE -- Cascade delete
    );
END;



-- Travel Purpose Mapping Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimTravelPurposeMapping')
BEGIN
    CREATE TABLE dbo.DimTravelPurposeMapping(
        MappingID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for the mapping
        TravelID INT NOT NULL, -- Foreign key to DimTravel table
        PurposeType NVARCHAR(100) NOT NULL CHECK (PurposeType IN ('Conference', 'BusinessMeeting', 'Course', 'RemoteWork', 'Other')), -- Purpose of the travel
        CourseID INT NULL, -- Foreign key to DimCourses table
        ConferenceID INT NULL, -- Foreign key to DimConferences table
        MeetingID INT NULL, -- Foreign key to DimBusinessMeetings table
        RemoteWorkID INT NULL, -- Foreign key to DimRemoteWork table
        FOREIGN KEY (TravelID) REFERENCES dbo.DimTravel(TravelID) ON DELETE CASCADE, -- Cascade delete for travel
        FOREIGN KEY (CourseID) REFERENCES dbo.DimCourses(CourseID) ON DELETE CASCADE, -- Cascade delete for courses
        FOREIGN KEY (ConferenceID) REFERENCES dbo.DimConferences(ConferenceID) ON DELETE CASCADE, -- Cascade delete for conferences
        FOREIGN KEY (MeetingID) REFERENCES dbo.DimBusinessMeetings(BusinessMeetingID) ON DELETE CASCADE, -- Cascade delete for meetings
        FOREIGN KEY (RemoteWorkID) REFERENCES dbo.DimRemoteWork(RemoteWorkID) ON DELETE CASCADE, -- Cascade delete for remote work
        CHECK (
            (CourseID IS NOT NULL AND MeetingID IS NULL AND ConferenceID IS NULL AND RemoteWorkID IS NULL AND PurposeType = 'Course')
            OR (CourseID IS NULL AND MeetingID IS NOT NULL AND ConferenceID IS NULL AND RemoteWorkID IS NULL AND PurposeType = 'BusinessMeeting')
            OR (CourseID IS NULL AND MeetingID IS NULL AND ConferenceID IS NOT NULL AND RemoteWorkID IS NULL AND PurposeType = 'Conference')
            OR (CourseID IS NULL AND MeetingID IS NULL AND ConferenceID IS NULL AND RemoteWorkID IS NOT NULL AND PurposeType = 'RemoteWork')
            OR (CourseID IS NULL AND MeetingID IS NULL AND ConferenceID IS NULL AND RemoteWorkID IS NULL AND PurposeType = 'Other')
        ) -- Logical constraint to ensure that only one purpose is specified
    );
END;



-- Insurance Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimInsurance')
BEGIN
    CREATE TABLE dbo.DimInsurance(
        InsuranceID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each insurance expense
        TaxYear INT NOT NULL, -- Tax year in which the insurance payment was made
        InsuranceMonth NVARCHAR(50) NOT NULL CHECK(InsuranceMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October','November', 'December')), -- Month of the insurance payment
        InsuranceYear INT NOT NULL, -- Year of the insurance payment
        CompanyName NVARCHAR(100), -- Name of the insurance company
        InsurancePurpose NVARCHAR(100) NOT NULL CHECK (InsurancePurpose IN ('Legal Protection Insurance', 'Travel Insurance', 'Health Insurance', 'Other')), -- Purpose of the insurance
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal', 'CreditCard', 'DebitCard', 'MasterCard', 'Cash', 'Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN ('OnlinePayment', 'BankTransfer', 'CardPayment', 'In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;



-- Work Space Expenses Table (Cost for an office space)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimWorkSpace')
BEGIN
    CREATE TABLE dbo.DimWorkSpace(
        WorkSpaceID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each workspace expense
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        WorkSpaceMonth NVARCHAR(50) NOT NULL CHECK(WorkSpaceMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',  'September', 'October','November', 'December')), -- Month of workspace payment
        WorkSpaceYear INT NOT NULL, -- Year of workspace payment
        WorkSpaceName NVARCHAR(100) NOT NULL CHECK (WorkSpaceName IN ('BerlinFlat', 'KolbergFlat', 'Other')), -- Name of the workspace
        WorkSpaceCountry NVARCHAR(100) NOT NULL CHECK (WorkSpaceCountry IN ('DE', 'PL', 'Other')), -- Country where the workspace is located
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;



-- Office Supplies Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimOfficeSupplies')
BEGIN
    CREATE TABLE dbo.DimOfficeSupplies(
        SupplyID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each office supply expense
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        SupplyMonth NVARCHAR(50) NOT NULL CHECK(SupplyMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the office supply payment
        SupplyYear INT NOT NULL, -- Year of the office supply payment
        SupplyName NVARCHAR(100) NOT NULL, -- Name of the office supply
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;



-- Tax Prepayment Expenses Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimTaxPrepayment')
BEGIN
    CREATE TABLE dbo.DimTaxPrepayment(
        TaxPrepaymentID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each tax prepayment
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        TaxPrepaymentMonth NVARCHAR(50) NOT NULL CHECK(TaxPrepaymentMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the tax prepayment
        TaxPrepaymentYear INT NOT NULL, -- Year of the tax prepayment
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE -- Date of payment
    );
END;



-- Overdue Payment Fees Table (1:1 relationship for selected columns)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimOverduePaymentFees')
BEGIN
    CREATE TABLE dbo.DimOverduePaymentFees(
        FeeID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each overdue payment fee
        TaxYear INT NOT NULL, -- Tax year in which the payment was made
        FeeMonth NVARCHAR(50) NOT NULL CHECK(FeeMonth IN('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')), -- Month of the overdue payment fee
        FeeYear INT NOT NULL, -- Year of the overdue payment fee
        CompanyName NVARCHAR(100) NOT NULL, -- Name of the company for which the fee was paid
        ExpenseEUR DECIMAL(10,2) NOT NULL DEFAULT 0.00, -- Full expense amount in EUR
        ExpenseOriginal DECIMAL(10,2), -- Full expense amount in the original currency, use NULL if EUR or not specified
        ExpenseCurrency NVARCHAR(10), -- Currency used for payment, use NULL if no payment
        CurrencyConversionDate DATE, -- Date of currency conversion, use NULL if EUR or not specified
        InvoiceAvailable BIT NOT NULL CHECK (InvoiceAvailable IN (0,1)), -- Invoice availability (0 = No, 1 = Yes)
        InvoiceNumber NVARCHAR(100), -- Invoice number (if available)
        InvoiceDate DATE, -- Date of the invoice
        PaymentMethod NVARCHAR(50) CHECK(PaymentMethod IN ('Paypal','CreditCard', 'DebitCard','MasterCard','Cash','Other')), -- Payment method
        PaymentType NVARCHAR(50) CHECK(PaymentType IN('OnlinePayment', 'BankTransfer', 'CardPayment','In-PersonPayment')), -- Type of payment
        PaymentDate DATE, -- Date of payment
        TaxPrepaymentID INT UNIQUE, -- One-to-one relationship with Tax Prepayment
        InsuranceID INT UNIQUE, -- One-to-one relationship with Insurance
        WorkSpaceID INT UNIQUE, -- One-to-one relationship with Workspace
        RemoteWorkID INT UNIQUE, -- One-to-one relationship with Remote Work
        BusinessMeetingID INT UNIQUE, -- One-to-one relationship with Business Meetings
        SupplyID INT UNIQUE, -- One-to-one relationship with Office Supplies
        ConferenceID INT UNIQUE, -- One-to-one relationship with Conferences
        CourseID INT UNIQUE, -- One-to-one relationship with Courses
        AdditionalExpenseID INT, -- Foreign key to DimTravelExtraCosts for additional expenses
        TravelID INT, -- Foreign key to DimTravel for travel-related expenses
        FOREIGN KEY (TaxPrepaymentID) REFERENCES dbo.DimTaxPrepayment(TaxPrepaymentID) ON DELETE CASCADE,
        FOREIGN KEY (InsuranceID) REFERENCES dbo.DimInsurance(InsuranceID) ON DELETE CASCADE,
        FOREIGN KEY (BusinessMeetingID) REFERENCES dbo.DimBusinessMeetings(BusinessMeetingID) ON DELETE CASCADE,
        FOREIGN KEY (WorkSpaceID) REFERENCES dbo.DimWorkSpace(WorkSpaceID) ON DELETE CASCADE,
        FOREIGN KEY (SupplyID) REFERENCES dbo.DimOfficeSupplies(SupplyID) ON DELETE CASCADE,
        FOREIGN KEY (RemoteWorkID) REFERENCES dbo.DimRemoteWork(RemoteWorkID) ON DELETE CASCADE,
        FOREIGN KEY (ConferenceID) REFERENCES dbo.DimConferences(ConferenceID) ON DELETE CASCADE,
        FOREIGN KEY (CourseID) REFERENCES dbo.DimCourses(CourseID) ON DELETE CASCADE,
        FOREIGN KEY (AdditionalExpenseID) REFERENCES dbo.DimTravelExtraCosts(TravelExtraCostID) ON DELETE CASCADE,
        FOREIGN KEY (TravelID) REFERENCES dbo.DimTravel(TravelID), -- Foreign key to Travel
        CHECK (
            CourseID IS NOT NULL
            OR ConferenceID IS NOT NULL
            OR BusinessMeetingID IS NOT NULL
            OR RemoteWorkID IS NOT NULL
            OR InsuranceID IS NOT NULL
            OR WorkSpaceID IS NOT NULL
            OR SupplyID IS NOT NULL
            OR TaxPrepaymentID IS NOT NULL
        ) -- Logical constraint to ensure at least one association
    );
END;



-- General Tax Fact Table without direct link to AdditionalExpenseID
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'FactTaxExpenses')
BEGIN
    CREATE TABLE dbo.FactTaxExpenses(
        FactTaxID INT IDENTITY(1,1) PRIMARY KEY, -- Unique identifier for each tax expense fact record
        TravelID INT, -- Links to a trip, which indirectly connects additional expenses
        CourseID INT, -- Link to a course expense
        ConferenceID INT, -- Link to a conference expense
        BusinessMeetingID INT, -- Link to a business meeting expense
        RemoteWorkID INT,  -- Link to a remote work expense
        InsuranceID INT, -- Link to insurance
        WorkSpaceID INT, -- Link to a workspace expense
        SupplyID INT, -- Link to an office supply expense
        TaxPrepaymentID INT, -- Link to a tax prepayment expense
        OverduePaymentFeeID INT, -- Link to an overdue payment fee
        TotalExpenses DECIMAL(10,2) NOT NULL, -- Total expenses recorded in this fact entry
        TotalBusinessDays INT NOT NULL, -- Total business days relevant to this expense
        TotalDepartureCity NVARCHAR(200) NOT NULL, -- Departure city for travel-related expenses
        TotalDistance INT NOT NULL, -- Total travel distance relevant to this expense
        OverduePaymentAmount DECIMAL(10, 2) NOT NULL, -- Amount for overdue payments in this entry
        PaymentYear INT NOT NULL, -- Year in which payment was made
        FOREIGN KEY (TravelID) REFERENCES dbo.DimTravel(TravelID) ON DELETE CASCADE,
        FOREIGN KEY (CourseID) REFERENCES dbo.DimCourses(CourseID) ON DELETE CASCADE,
        FOREIGN KEY (ConferenceID) REFERENCES dbo.DimConferences(ConferenceID) ON DELETE CASCADE,
        FOREIGN KEY (BusinessMeetingID) REFERENCES dbo.DimBusinessMeetings(BusinessMeetingID) ON DELETE CASCADE,
        FOREIGN KEY (RemoteWorkID) REFERENCES dbo.DimRemoteWork(RemoteWorkID) ON DELETE NO ACTION,
        FOREIGN KEY (InsuranceID) REFERENCES dbo.DimInsurance(InsuranceID) ON DELETE NO ACTION,
        FOREIGN KEY (WorkSpaceID) REFERENCES dbo.DimWorkSpace(WorkSpaceID) ON DELETE NO ACTION,
        FOREIGN KEY (SupplyID) REFERENCES dbo.DimOfficeSupplies(SupplyID) ON DELETE NO ACTION,
        FOREIGN KEY (TaxPrepaymentID) REFERENCES dbo.DimTaxPrepayment(TaxPrepaymentID) ON DELETE NO ACTION,
        FOREIGN KEY (OverduePaymentFeeID) REFERENCES dbo.DimOverduePaymentFees(FeeID) ON DELETE NO ACTION
    );
END;

