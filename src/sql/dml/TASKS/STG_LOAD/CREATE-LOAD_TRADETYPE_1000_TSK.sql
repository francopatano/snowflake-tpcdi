CREATE OR REPLACE TASK TPCDI_STG.PUBLIC.LOAD_TRADETYPE_1000_TSK
  WAREHOUSE = TPCDI_FILE_LOAD
  
AS
CALL TPCDI_STG.PUBLIC.LOAD_TRADETYPE_SP(1000)
;
