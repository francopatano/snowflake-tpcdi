CREATE OR REPLACE VIEW TPCDI_WH.PUBLIC.DIM_SECURITY_NOW AS
WITH CURRENT_SK_IDS AS
(SELECT DISTINCT LAST_VALUE(SK_SECURITY_ID) OVER (PARTITION BY SYMBOL ORDER BY SK_SECURITY_ID) AS SK_SECURITY_ID_LAST
FROM TPCDI_WH.PUBLIC.DIM_SECURITY)
SELECT * FROM TPCDI_WH.PUBLIC.DIM_SECURITY
JOIN CURRENT_SK_IDS ON CURRENT_SK_IDS.SK_SECURITY_ID_LAST = DIM_SECURITY.SK_SECURITY_ID
;
