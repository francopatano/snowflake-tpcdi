CREATE OR REPLACE TASK TPCDI_STG.PUBLIC.LOAD_HOLDING_HISTORY_H_10_TSK
  WAREHOUSE = TPCDI_FILE_LOAD
  
AS
CALL TPCDI_STG.PUBLIC.LOAD_HOLDING_HISTORY_H_SP(10)
;
