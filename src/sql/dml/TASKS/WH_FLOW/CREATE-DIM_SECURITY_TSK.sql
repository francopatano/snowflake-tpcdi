CREATE OR REPLACE TASK TPCDI_WH.PUBLIC.DIM_SECURITY_TSK
  WAREHOUSE = TASK_WH_B
AS
CALL TPCDI_WH.PUBLIC.DIM_SECURITY_SP()
;

ALTER TASK TPCDI_WH.PUBLIC.DIM_SECURITY_TSK RESUME;