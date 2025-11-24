-- Switch to accountadmin role to create warehouse
USE ROLE accountadmin;

-- Enable Snowflake Intelligence by creating the Config DB & Schema
CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;

-- Allow anyone to see the agents in this schema
GRANT USAGE ON DATABASE snowflake_intelligence TO ROLE PUBLIC;
GRANT USAGE ON SCHEMA snowflake_intelligence.agents TO ROLE PUBLIC;

-- Create role
create or replace role SF_Intelligence_Demo;
SET current_user_name = CURRENT_USER();
    
-- Use the variable to grant the role
GRANT ROLE SF_Intelligence_Demo TO USER IDENTIFIER($current_user_name);
GRANT CREATE DATABASE ON ACCOUNT TO ROLE SF_Intelligence_Demo;

-- Create a dedicated warehouse for the demo with auto-suspend/resume
CREATE OR REPLACE WAREHOUSE Snow_Intelligence_demo_wh 
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE;


-- Grant usage on warehouse to admin role
GRANT USAGE ON WAREHOUSE SNOW_INTELLIGENCE_DEMO_WH TO ROLE SF_Intelligence_Demo;

-- Alter current user's default role and warehouse to the ones used here
ALTER USER IDENTIFIER($current_user_name) SET DEFAULT_ROLE = SF_Intelligence_Demo;
ALTER USER IDENTIFIER($current_user_name) SET DEFAULT_WAREHOUSE = Snow_Intelligence_demo_wh;
    

-- Switch to SF_Intelligence_Demo role to create demo objects
use role SF_Intelligence_Demo;

-- Create database and schema
CREATE OR REPLACE DATABASE SF_AI_DEMO;
USE DATABASE SF_AI_DEMO;
CREATE SCHEMA IF NOT EXISTS DEMO_SCHEMA;
USE SCHEMA DEMO_SCHEMA;
