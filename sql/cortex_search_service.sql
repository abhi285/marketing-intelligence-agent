-- ========================================================================
    -- UNSTRUCTURED DATA
    -- ========================================================================
create or replace table parsed_content as 
select 
  
    relative_path, 
    BUILD_STAGE_FILE_URL('@SF_AI_DEMO.DEMO_SCHEMA.INTERNAL_DATA_STAGE', relative_path) as file_url,
    TO_File(BUILD_STAGE_FILE_URL('@SF_AI_DEMO.DEMO_SCHEMA.INTERNAL_DATA_STAGE', relative_path) ) file_object,
        SNOWFLAKE.CORTEX.PARSE_DOCUMENT(
                                    @SF_AI_DEMO.DEMO_SCHEMA.INTERNAL_DATA_STAGE,
                                    relative_path,
                                    {'mode':'LAYOUT'}
                                    ):content::string as Content

    
    from directory(@SF_AI_DEMO.DEMO_SCHEMA.INTERNAL_DATA_STAGE) 
where relative_path ilike 'unstructured_docs/%.pdf' ;

--select *, GET_PATH(PARSE_JSON(content), 'content')::string as extracted_content from parsed_content;


-- Switch to admin role for remaining operations
USE ROLE SF_Intelligence_Demo;
-- This enables semantic search over marketing-related content
CREATE OR REPLACE CORTEX SEARCH SERVICE Search_marketing_docs
    ON content
    ATTRIBUTES relative_path, file_url, title
    WAREHOUSE = SNOW_INTELLIGENCE_DEMO_WH
    TARGET_LAG = '30 day'
    EMBEDDING_MODEL = 'snowflake-arctic-embed-l-v2.0'
    AS (
        SELECT
            relative_path,
            file_url,
            REGEXP_SUBSTR(relative_path, '[^/]+$') as title,
            content
        FROM parsed_content
        WHERE relative_path ilike '%/marketing/%'
    );
