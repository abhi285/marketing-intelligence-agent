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
