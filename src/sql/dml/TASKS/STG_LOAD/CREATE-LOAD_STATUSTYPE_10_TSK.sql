CREATE OR REPLACE TASK TPCDI_STG.PUBLIC.LOAD_STATUSTYPE_10_TSK
  WAREHOUSE = TPCDI_FILE_LOAD
  
AS
CALL TPCDI_STG.PUBLIC.LOAD_STATUSTYPE_SP(10)
;
