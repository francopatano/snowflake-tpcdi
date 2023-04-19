CREATE OR REPLACE VIEW TPCDI_STG.PUBLIC.CUSTOMER_INACT_STG AS
SELECT XML:"$"."@C_ID"::NUMBER AS C_ID 
FROM TPCDI_STG.PUBLIC.CUSTOMER_MGMT_STG
WHERE XML:"@ActionType"::STRING = 'INACT'
;