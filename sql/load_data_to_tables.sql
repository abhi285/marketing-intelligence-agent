-- ========================================================================
-- LOAD DIMENSION DATA FROM INTERNAL STAGE
-- ========================================================================

-- Load Product Category Dimension
COPY INTO product_category_dim
FROM @INTERNAL_DATA_STAGE/demo_data/product_category_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Product Dimension
COPY INTO product_dim
FROM @INTERNAL_DATA_STAGE/demo_data/product_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Vendor Dimension
COPY INTO vendor_dim
FROM @INTERNAL_DATA_STAGE/demo_data/vendor_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Customer Dimension
COPY INTO customer_dim
FROM @INTERNAL_DATA_STAGE/demo_data/customer_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Account Dimension
COPY INTO account_dim
FROM @INTERNAL_DATA_STAGE/demo_data/account_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Department Dimension
COPY INTO department_dim
FROM @INTERNAL_DATA_STAGE/demo_data/department_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Region Dimension
COPY INTO region_dim
FROM @INTERNAL_DATA_STAGE/demo_data/region_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Sales Rep Dimension
COPY INTO sales_rep_dim
FROM @INTERNAL_DATA_STAGE/demo_data/sales_rep_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Campaign Dimension
COPY INTO campaign_dim
FROM @INTERNAL_DATA_STAGE/demo_data/campaign_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Channel Dimension
COPY INTO channel_dim
FROM @INTERNAL_DATA_STAGE/demo_data/channel_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Employee Dimension
COPY INTO employee_dim
FROM @INTERNAL_DATA_STAGE/demo_data/employee_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Job Dimension
COPY INTO job_dim
FROM @INTERNAL_DATA_STAGE/demo_data/job_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Location Dimension
COPY INTO location_dim
FROM @INTERNAL_DATA_STAGE/demo_data/location_dim.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- ========================================================================
-- LOAD FACT DATA FROM INTERNAL STAGE
-- ========================================================================

-- Load Sales Fact
COPY INTO sales_fact
FROM @INTERNAL_DATA_STAGE/demo_data/sales_fact.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Finance Transactions
COPY INTO finance_transactions
FROM @INTERNAL_DATA_STAGE/demo_data/finance_transactions.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Marketing Campaign Fact
COPY INTO marketing_campaign_fact
FROM @INTERNAL_DATA_STAGE/demo_data/marketing_campaign_fact.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load HR Employee Fact
COPY INTO hr_employee_fact
FROM @INTERNAL_DATA_STAGE/demo_data/hr_employee_fact.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- ========================================================================
-- LOAD SALESFORCE DATA FROM INTERNAL STAGE
-- ========================================================================

-- Load Salesforce Accounts
COPY INTO sf_accounts
FROM @INTERNAL_DATA_STAGE/demo_data/sf_accounts.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Salesforce Opportunities
COPY INTO sf_opportunities
FROM @INTERNAL_DATA_STAGE/demo_data/sf_opportunities.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';

-- Load Salesforce Contacts
COPY INTO sf_contacts
FROM @INTERNAL_DATA_STAGE/demo_data/sf_contacts.csv
FILE_FORMAT = CSV_FORMAT
ON_ERROR = 'CONTINUE';
