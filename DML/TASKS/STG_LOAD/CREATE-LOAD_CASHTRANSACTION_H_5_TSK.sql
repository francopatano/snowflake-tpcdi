CREATE OR REPLACE TASK TPCDI_STG.PUBLIC.LOAD_CASHTRANSACTION_H_5_TSK
  WAREHOUSE = TPCDI_FILE_LOAD,
  SCHEDULE = '10 SECOND'
AS
CALL TPCDI_STG.PUBLIC.LOAD_CASHTRANSACTION_H_SP(5)
;
