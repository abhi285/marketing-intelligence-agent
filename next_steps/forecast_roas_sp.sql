USE ROLE SF_Intelligence_Demo;
USE DATABASE SF_AI_DEMO;
USE SCHEMA DEMO_SCHEMA;

CREATE OR REPLACE PROCEDURE FORECAST_ROAS_SP(
    CHANNEL_NAME STRING,
    MONTHS_AHEAD INTEGER
)
RETURNS TABLE (
    FORECAST_TIMESTAMP TIMESTAMP_NTZ,
    FORECAST_VALUE FLOAT,
    LOWER_BOUND FLOAT,
    UPPER_BOUND FLOAT
)
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
    -- 1. Build a monthly ROAS time series per channel
    WITH monthly_roas AS (
        SELECT
            DATE_TRUNC('month', c.date) AS month,
            SUM(
                CASE 
                    WHEN o.stage_name = 'Closed Won' 
                    THEN o.amount 
                    ELSE 0 
                END
            ) / NULLIF(SUM(c.spend), 0) AS roas
        FROM sf_ai_demo.demo_schema.marketing_campaign_fact c
        JOIN sf_ai_demo.demo_schema.channel_dim ch
          ON c.channel_key = ch.channel_key
        LEFT JOIN sf_ai_demo.demo_schema.sf_opportunities o
          ON c.campaign_fact_id = o.campaign_id
        WHERE ch.channel_name = CHANNEL_NAME
        GROUP BY 1
        ORDER BY 1
    )
    -- 2. Call a forecasting function on the time series
    SELECT
        forecast_timestamp,
        forecast_value,
        lower_bound,
        upper_bound
    FROM TABLE(
        CORTEX_FORECAST(
            INPUT_DATA => (
                SELECT month AS ts, roas AS target
                FROM monthly_roas
            ),
            TIME_COL => 'TS',
            TARGET_COL => 'TARGET',
            PREDICTION_LENGTH => MONTHS_AHEAD
        )
    );
$$;
