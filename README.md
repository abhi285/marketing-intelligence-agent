
**Retail Marketing Intelligence Agent**

This repository contains all artifacts needed to build a fully operational Retail Marketing Intelligence Agent using Snowflake Cortex Analyst, Cortex Search Service, custom tools, and a marketing-optimized semantic layer.
It includes the SQL scripts, notebooks, documentation, and sample data required to reproduce the entire demo end-to-end from loading raw datasets to deploying a Snowflake-native agent that answers marketing questions with both structured and unstructured data


**Repository Structure**

  * **/data**
  
  Contains all CSV files (/data/demo_Data/) used to populate the retail marketing star schema (campaigns, channels, accounts, opportunities, contacts, and supporting dimensions).
  These files are uploaded to an internal Snowflake stage and bulk-loaded into tables during environment setup.
  It also have the pdf files under: /data/unstructured_docs/marketing/ for cortex service
  
  * **/docs**
  
  Documentation related to the project, including the full end-to-end runbook describing setup steps, architecture explanation, semantic model design, agent configuration, and governance considerations.
  
  * **/notebooks**
  
  Python or Snowflake Notebooks used for walkthroughs, validation, or additional exploration.
  Notebooks demonstrate intermediate steps, troubleshooting, or optional enhancements outside the main SQL setup.

  * **/next_Steps**
  
  Guidance on how to extend the Marketing Intelligence Agent with your own data, predictive features, and custom tools.
  Includes recommended enhancements, architecture considerations, and sample code to accelerate adoption.
  
  * **/sql**
  
  environment_setup.sql – Create the Snowflake Intelligence database, roles, warehouses, and base configuration.
  create_file_format.sql – Define CSV file formats and internal stages.
  marketing_star_schema.sql – Create the marketing star schema (facts + dimensions).
  load_data_to_tables.sql – COPY statements for loading structured marketing data.
  marketing_semantic_view.sql – Semantic view powering Cortex Analyst queries.
  cortex_search_service.sql – Scripts for parsing PDFs and creating Search Services.
  utility_procedures.sql – Stored procedures for email sending and generating pre-signed URLs.
  email_notification_integration.sql – Enable email notifications for tool execution.
  cortex_agent.sql – Full agent creation script combining Cortex Analyst, Search Services, and custom tools.

**Getting Started**

Upload the contents of /data to an internal Snowflake stage.
Run the scripts in the notebook in /notebooks folder in the recommended order.
Follow the runbook in /docs for semantic view creation, search service setup, and agent deployment.

