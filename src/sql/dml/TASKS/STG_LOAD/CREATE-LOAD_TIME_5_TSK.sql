CREATE OR REPLACE TASK TPCDI_STG.PUBLIC.LOAD_TIME_5_TSK
  WAREHOUSE = TPCDI_FILE_LOAD
  
AS
CALL TPCDI_STG.PUBLIC.LOAD_TIME_SP(5)
;
