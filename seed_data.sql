--SEED DATA FOR TESTING THE TAX_DATABASE

-- Section: Inserting Example Conferences Expenses 2023
-- Stambul Conference 2023
INSERT INTO dbo.DimConferences(
    TaxYear,                     -- Tax year when payment was done
    EventCity,                   -- City where the event was held
    EventCountry,                -- Country of the event
    EventType,                   -- Type of event
    EventName,                   -- Name of the event
    EventYear,                   -- Year when the event occurred
    EventMonth,                  -- Month of the event
    EventDays,                   -- Duration of the event in days
    EventMode,                   -- Mode of the event: 'Online', 'In-Person', or 'Hybrid'
    EventCompany,                -- Organizer's name
    EventPlatform,               -- Platform used for the event (if applicable)
    ExpenseEUR,                  -- Full expense amount in EUR
    ExpenseOriginal,             -- Full expense amount in the original currency
    ExpenseCurrency,             -- Payment currency
    CurrencyConversionDate,      -- Date of currency conversion
    InvoiceAvailable,            -- Invoice status
    InvoiceNumber,               -- Invoice number, if available
    InvoiceDate,                 -- Date of the invoice
    PaymentMethod,               -- Payment method
    PaymentType,                 -- Payment type
    PaymentDate                  -- Payment date
)
VALUES(
    2023,                        -- Tax year when payment was done
    'Istanbul',                  -- City where the event was held
    'TR',                        -- Country of the event (Turkey)
    'Conference',                -- Type of event
    '10th International Conference on Education', -- Name of the event
    2023,                        -- Year when the event occurred
    'January',                   -- Month of the event
    3,                           -- Duration of the event in days
    'In-Person',                 -- Mode of the event
    'International Organisation Center of Academic Research, Stambul', -- Organizer's name
    NULL,                        -- Platform used for the event (not specified)
    0.00,                        -- Full expense amount in EUR
    NULL,                        -- Full expense amount in the original currency, use NULL if EUR or not specified
    NULL,                        -- Payment currency (not specified), use NULL if no payment
    NULL,                        -- Date of currency conversion, use NULL if EUR or not specified
    1,                           -- Invoice status (Yes -> 1)
    '202301148',                 -- Invoice number
    NULL,                        -- Date of the invoice (not available)
    NULL,                        -- Payment method (not specified)
    NULL,                        -- Payment type (not specified)
    NULL                         -- Payment date (not specified)
);


-- Section: Inserting Example Business Meeting Expenses 2023
-- Business Meeting Bali 2023
INSERT INTO dbo.DimBusinessMeetings(
    TaxYear,                 -- Tax year when payment was made
    EventCity,               -- City where the event took place
    EventCountry,            -- Country where the event took place
    EventType,               -- Type of event
    EventName,               -- Name of the event
    EventYear,               -- Year of the event
    EventMonth,              -- Month of the event
    EventDays,               -- Duration of the event in days
    EventVenue,              -- Place/Hotel's Name where the meeting was held
    NumberOfGuests,          -- Number of guests attending
    GuestsNames,             -- Names of guests
    ExpenseEUR,              -- Expense amount in EUR
    TipEUR,                  -- Tip amount in EUR
    ExpenseOriginal,         -- Expense amount in original currency
    ExpenseCurrency,         -- Currency used for payment
    CurrencyConversionDate,  -- Date of currency conversion
    InvoiceAvailable,        -- Invoice availability status (0/1)
    InvoiceNumber,           -- Invoice number, if available
    InvoiceDate,             -- Date of the invoice
    PaymentMethod,           -- Payment method
    PaymentType,             -- Type of payment
    PaymentDate              -- Date of payment
)
VALUES(
    2023,                     -- Tax year
    'Bali',                   -- Event city
    'IDN',                    -- Event country (Indonesia)
    'BusinessMeeting',        -- Type of event
    'Job Interview',          -- Name of the event
    2023,                     -- Year of the event
    'February',               -- Month of the event
    1,                        -- Duration in days
    'Sundara',                -- Venue of the meeting
    1,                        -- Number of guests
    'Antony Sevkov',  -- Guests names
    113.00,                   -- Expense amount in EUR
    0.00,                     -- Tip amount
    1827100.00,               -- Expense amount in original currency
    'IDR',                    -- Payment currency
    '2023-02-27',             -- Currency conversion date
    1,                        -- Invoice available (Yes -> 1)
    '10261865',               -- Invoice number
    '2023-02-27',             -- Invoice date
    'Cash',                   -- Payment method
    'In-PersonPayment',       -- Payment type
    '2023-02-27'              -- Payment date
);


	-- Section: Inserting Example Travel Expenses 2023
-- Istanbul Travel 2023
INSERT INTO dbo.DimTravel(
    TaxYear,                 -- in which tax year payment was done
    TravelCity,              -- City of travel
    TravelCountry,           -- Country of travel
    TravelYear,              -- when event was happening
    TravelMonth,             -- Month of travel
    DepartureDate,           -- Departure date
    ReturnDate,              -- Return date
    BusinessDays,            -- Number of business days
    HotelName,               -- Name of the hotel (include 'Hotel' in naming, i.e., 'Hotel...Zamek Kliczkow')
    ExpenseEUR,              -- Full expense amount in EUR
    TipEUR,                  -- Tip amount in EUR
    ExpenseOriginal,         -- Full expense amount in the original currency
    ExpenseCurrency,         -- in which currency was paid
    CurrencyConversionDate,  -- Currency conversion date
    InvoiceAvailable,        -- Is the invoice available?
    InvoiceNumber,           -- Invoice number
    InvoiceDate,             -- Invoice date
    PaymentMethod,           -- Payment method
    PaymentType,             -- Payment type
    PaymentDate,             -- Payment date
    StartOdometer,           -- Starting odometer reading
    EndOdometer              -- Ending odometer reading
)
VALUES(
    2023,                   -- Tax year
    'Istanbul',             -- City of travel
    'TR',                   -- Country of travel
    2023,                   -- Year of travel
    'January',              -- Month of travel
    '2023-01-20',           -- Departure date
    '2023-01-29',           -- Return date
    3,                      -- Number of business days
    'N/A',      -- Hotel name
    0.00,                   -- No expense in EUR
    0.00,                   -- No tip amount in EUR
    NULL,                   -- No expense in original currency
    NULL,                   -- No payment currency
    NULL,                   -- No currency conversion date
    0,                      -- Invoice not available (0)
    NULL,                   -- No invoice number
    NULL,                   -- No invoice date
    NULL,                   -- No payment method
    NULL,                   -- No payment type
    NULL,                   -- No payment date
    NULL,                   -- Starting odometer not recorded
    NULL                    -- Ending odometer not recorded
);


  -- Inserting Example Travel Extra Costs 
-- Istanbul Extra Costs 2023
INSERT INTO dbo.DimTravelExtraCosts(
    TaxYear,                                         -- Tax year when the expense was done
    TravelMonth,                                     -- Month of the additional expense
    TravelYear,                                      -- Year of the additional expense
    ExtraCostName,                                   -- Name/Description of the additional expense
    ExpenseEUR,                                      -- Full expense amount in EUR
    TipEUR,                                          -- Tip amount in EUR
    ExpenseOriginal,                                 -- Full expense amount in the original currency
    ExpenseCurrency,                                 -- Currency used for payment (e.g., EUR, PLN)
    CurrencyConversionDate,                          -- Date of currency conversion
    InvoiceAvailable,                                -- Invoice status (0 = No, 1 = Yes)
    InvoiceNumber,                                   -- Invoice number, if available
    InvoiceDate,                                     -- Date of the invoice
    PaymentMethod,                                   -- Payment method
    PaymentType,                                     -- Payment type
    PaymentDate,                                     -- Payment date
    TravelID                                         -- Foreign key linking to `DimTravel`
)
VALUES(
    2023,                                           -- Tax year
    'January',                                      -- Month of the additional expense
    2023,                                           -- Year of the additional expense
    'Flight Ticket BER-IST + IST-BER',             -- Name/Description of the additional expense
    287.19,                                        -- Full expense amount in EUR
    0.00,                                             -- Tip amount in EUR
    NULL,                                          -- Full expense amount in the original currency
    'EUR',                                         -- Payment currency
    NULL,                                          -- Currency conversion date
    1,                                             -- Invoice available (Yes -> 1)
    '2352129687476',                               -- Invoice number
    '2023-01-11',                                  -- Invoice date
    'Other',                                       -- Payment method
    'OnlinePayment',                               -- Payment type
    '2023-01-11',                                  -- Payment date
    1                                              -- TravelID (Foreign key)
);


 --Inserting Example Travel Purpose Mapping 2023
 -- Istanbul Conference Mapping
INSERT INTO dbo.DimTravelPurposeMapping (
    TravelID,
    PurposeType,
    ConferenceID
)
VALUES (
    1,                     -- TravelID for Istanbul
    'Conference',          -- Purpose type
    1                      -- ConferenceID for Istanbul
);


-- Bali Conference Mapping
INSERT INTO dbo.DimTravelPurposeMapping (
    TravelID,
    PurposeType,
    ConferenceID
)
VALUES (
    2,                     -- TravelID for Bali
    'Conference',          -- Purpose type
    2                      -- ConferenceID for Bali
);


-- Karpacz Conference Mapping
INSERT INTO dbo.DimTravelPurposeMapping (
    TravelID,
    PurposeType,
    ConferenceID
)
VALUES (
    3,                     -- TravelID for Karpacz
    'Conference',          -- Purpose type
    3                      -- ConferenceID for Karpacz
);



-- Bali Business Meeting Mapping
INSERT INTO dbo.DimTravelPurposeMapping (
    TravelID,
    PurposeType,
    MeetingID
)
VALUES (
    4,                     -- TravelID for Bali Business Meeting
    'BusinessMeeting',     -- Purpose type
    1                      -- MeetingID for Bali Business Meeting
);