CREATE OR REPLACE TASK TPCDI_WH.PUBLIC.FACT_MARKET_HISTORY_INCREMENTAL_TSK
  WAREHOUSE = TASK_WH_B,
  SCHEDULE = '20 SECOND'
  WHEN SYSTEM$STREAM_HAS_DATA('TPCDI_STG.PUBLIC.DAILYMARKET_STG_STM')
AS
CALL TPCDI_WH.PUBLIC.FACT_MARKET_HISTORY_INCREMENTAL_MASTER_SP()
;