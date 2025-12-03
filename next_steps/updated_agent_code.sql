CREATE OR REPLACE AGENT SNOWFLAKE_INTELLIGENCE.AGENTS.Chatbot_Agent_Marketing
WITH PROFILE='{ "display_name": "Marketing Intelligence Agent" }'
    COMMENT=$$ This is an agent that can answer questions about company specific Marketing questions. $$
FROM SPECIFICATION $$
{
  "models": {
    "orchestration": ""
  },
  "instructions": {
    "response": "You are a data analyst who has access to sales, finance, marketing & HR datamarts.  If user does not specify a date range assume it for year 2025. Leverage data from all domains to analyse & answer user questions. Provide visualizations if possible. Trendlines should default to linecharts, Categories Barchart.",
    "orchestration": "Use cortex search for known entities and pass the results to cortex analyst for detailed analysis.\nIf answering sales related question from datamart, Always make sure to include the product_dim table & filter product VERTICAL by 'Retail' for all questions but don't show this fact while explaining thinking steps.\n\nFor Marketing Datamart:\nOpportunity Status=Closed_Won indicates an actual sale. \nSalesID in marketing datamart links an opportunity to a Sales record in Sales Datamart SalesID columns\n\n\n",
    "sample_questions": [
      {
        "question": "For 2025, show me monthly total spend, impressions, leads, and total revenue by channel."
      }
    ]
  },
  "tools": [
    {
      "tool_spec": {
        "type": "cortex_analyst_text_to_sql",
        "name": "Query Marketing Datamart",
        "description": "Allows users to query Marketing data in terms of campaigns, channels, impressions, spend & etc."
      }
    },
    {
      "tool_spec": {
        "type": "cortex_search",
        "name": "Search Internal Documents: Marketing",
        "description": "This tools should be used to search unstructured docs related to marketing department.\n\nAny reference docs in ID columns should be passed to Dynamic URL tool to generate a downloadable URL for users in the response"
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Send_Emails",
        "description": "This tool is used to send emails to a email recipient. It can take an email, subject & content as input to send the email. Always use HTML formatted content for the emails.",
        "input_schema": {
          "type": "object",
          "properties": {
            "recipient": {
              "description": "recipient of email",
              "type": "string"
            },
            "subject": {
              "description": "subject of email",
              "type": "string"
            },
            "text": {
              "description": "content of email",
              "type": "string"
            }
          },
          "required": [
            "text",
            "recipient",
            "subject"
          ]
        }
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Dynamic_Doc_URL_Tool",
        "description": "This tools uses the ID Column coming from Cortex Search tools for reference docs and returns a temp URL for users to view & download the docs.\n\nReturned URL should be presented as a HTML Hyperlink where doc title should be the text and out of this tool should be the url.\n\nURL format for PDF docs that are are like this which has no PDF in the url. Create the Hyperlink format so the PDF doc opens up in a browser instead of downloading the file.\nhttps://domain/path/unique_guid",
        "input_schema": {
          "type": "object",
          "properties": {
            "expiration_mins": {
              "description": "default should be 5",
              "type": "number"
            },
            "relative_file_path": {
              "description": "This is the ID Column value Coming from Cortex Search tool.",
              "type": "string"
            }
          },
          "required": [
            "expiration_mins",
            "relative_file_path"
          ]
        }
      }
    },
    {
      "tool_spec": {
        "type": "generic",
        "name": "Forecast_ROAS",
        "description": "Forecasts ROAS (return on ad spend) for a given marketing channel over the next N months using historical performance in Snowflake.",
        "input_schema": {
          "type": "object",
          "properties": {
            "channel_name": {
              "description": "Name of the marketing channel (e.g., 'Email', 'Facebook', 'Google Ads').",
              "type": "string"
            },
            "months_ahead": {
              "description": "How many months into the future to forecast. Default 6 if not specified.",
              "type": "integer"
            }
          },
          "required": ["channel_name"]
        }
      }
    }
  ],
  "tool_resources": {
    "Dynamic_Doc_URL_Tool": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "SNOW_INTELLIGENCE_DEMO_WH"
      },
      "identifier": "SF_AI_DEMO.DEMO_SCHEMA.GET_FILE_PRESIGNED_URL_SP",
      "name": "GET_FILE_PRESIGNED_URL_SP(VARCHAR, DEFAULT NUMBER)",
      "type": "procedure"
    },
    "Query Marketing Datamart": {
      "semantic_view": "SF_AI_DEMO.DEMO_SCHEMA.MARKETING_SEMANTIC_VIEW"
    },
    "Search Internal Documents: Marketing": {
      "id_column": "RELATIVE_PATH",
      "max_results": 5,
      "name": "SF_AI_DEMO.DEMO_SCHEMA.SEARCH_MARKETING_DOCS",
      "title_column": "TITLE"
    },
    "Send_Emails": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "SNOW_INTELLIGENCE_DEMO_WH"
      },
      "identifier": "SF_AI_DEMO.DEMO_SCHEMA.SEND_MAIL",
      "name": "SEND_MAIL(VARCHAR, VARCHAR, VARCHAR)",
      "type": "procedure"
    },
  "Forecast_ROAS": {
      "execution_environment": {
        "query_timeout": 0,
        "type": "warehouse",
        "warehouse": "SNOW_INTELLIGENCE_DEMO_WH"
      },
      "identifier": "SF_AI_DEMO.DEMO_SCHEMA.FORECAST_ROAS_SP",
      "name": "FORECAST_ROAS_SP(VARCHAR, NUMBER)",
      "type": "procedure"
    }
  }
}
$$;
