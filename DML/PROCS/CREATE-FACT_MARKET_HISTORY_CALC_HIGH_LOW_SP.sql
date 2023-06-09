CREATE OR REPLACE PROCEDURE TPCDI_WH.PUBLIC.FACT_MARKET_HISTORY_CALC_HIGH_LOW_SP()
  returns string
  language javascript
  as
  $$
  // Process Fact Table
  var hilo_stmt = snowflake.createStatement(
      {sqlText: "UPDATE TPCDI_WH.PUBLIC.FACT_MARKET_HISTORY SET FACT_MARKET_HISTORY.FIFTY_TWO_WEEK_HIGH = DAILY_MARKET_HIGH_LOW_STG.YEAR_HIGH, FACT_MARKET_HISTORY.SK_FIFTY_TWO_WEEK_HIGH_DATE = DAILY_MARKET_HIGH_LOW_STG.EARLIEST_HIGH_DATE, FACT_MARKET_HISTORY.FIFTY_TWO_WEEK_LOW = DAILY_MARKET_HIGH_LOW_STG.YEAR_LOW, FACT_MARKET_HISTORY.SK_FIFTY_TWO_WEEK_LOW_DATE = DAILY_MARKET_HIGH_LOW_STG.EARLIEST_LOW_DATE FROM TPCDI_STG.PUBLIC.DAILY_MARKET_HIGH_LOW_STG, TPCDI_WH.PUBLIC.DIM_SECURITY WHERE FACT_MARKET_HISTORY.SK_SECURITY_ID = DIM_SECURITY.SK_SECURITY_ID AND FACT_MARKET_HISTORY.SK_DATE_ID = DAILY_MARKET_HIGH_LOW_STG.DATE AND DAILY_MARKET_HIGH_LOW_STG.SYMBOL = DIM_SECURITY.SYMBOL"}
    );
  hilo_stmt.execute();
  // Log audit record
  var audit_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.AUDIT SELECT 'FACT_MARKET_HISTORY_CALC_HIGH_LOW_SP', LOCALTIMESTAMP(), (SELECT MAX(BATCH_ID) FROM TPCDI_WH.PUBLIC.CTRL_BATCH), 0, $1 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))"}
    );
  audit_stmt.execute();
  return 'High Low calculated.';
  $$
;
