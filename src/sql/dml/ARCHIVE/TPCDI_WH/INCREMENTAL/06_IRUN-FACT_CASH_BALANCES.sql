-- INCREMENTAL LOAD

-- ALTER SESSION TO SET PARAMETER TO ALLOW MULTIPLE INSTANCES OF SAME BUSINESS ID FOR UPDATES IN STAGE
ALTER SESSION SET ERROR_ON_NONDETERMINISTIC_MERGE = FALSE;

-- MERGE RECORDS FROM STAGE
MERGE INTO TPCDI_WH.PUBLIC.FACT_CASH_BALANCES USING
    (
  SELECT
       COALESCE(DIM_ACCOUNT.SK_CUSTOMER_ID,0) SK_CUSTOMER_ID
     , COALESCE(DIM_ACCOUNT.SK_ACCOUNT_ID,0) SK_ACCOUNT_ID 
     , COALESCE(DIM_DATE.DATE_ID,0) SK_DATE_ID 
     , SUM(CT_AMT) CASH
     , TO_NUMBER(1) BATCH_ID
  FROM TPCDI_STG.PUBLIC.CASHTRANSACTION_STG
LEFT JOIN TPCDI_WH.PUBLIC.DIM_ACCOUNT ON
      CASHTRANSACTION_STG.CT_CA_ID = DIM_ACCOUNT.ACCOUNT_ID
LEFT JOIN TPCDI_WH.PUBLIC.DIM_DATE ON
      TO_DATE(CASHTRANSACTION_STG.CT_DTS) = TO_DATE(DIM_DATE.DATE_VALUE)
GROUP BY 
       COALESCE(DIM_ACCOUNT.SK_CUSTOMER_ID,0)
     , COALESCE(DIM_ACCOUNT.SK_ACCOUNT_ID,0)
     , COALESCE(DIM_DATE.DATE_ID,0)
    ) CASH_BALANCES_UPDATES ON FACT_CASH_BALANCES.SK_ACCOUNT_ID = CASH_BALANCES_UPDATES.SK_ACCOUNT_ID AND FACT_CASH_BALANCES.SK_DATE_ID = CASH_BALANCES_UPDATES.SK_DATE_ID
WHEN MATCHED THEN UPDATE SET
    FACT_CASH_BALANCES.SK_CUSTOMER_ID = COALESCE(CASH_BALANCES_UPDATES.SK_CUSTOMER_ID,FACT_CASH_BALANCES.SK_CUSTOMER_ID),
    FACT_CASH_BALANCES.SK_ACCOUNT_ID = COALESCE(CASH_BALANCES_UPDATES.SK_ACCOUNT_ID,FACT_CASH_BALANCES.SK_ACCOUNT_ID),
    FACT_CASH_BALANCES.SK_DATE_ID = COALESCE(CASH_BALANCES_UPDATES.SK_DATE_ID,FACT_CASH_BALANCES.SK_DATE_ID),
    FACT_CASH_BALANCES.BATCH_ID = COALESCE(CASH_BALANCES_UPDATES.BATCH_ID,FACT_CASH_BALANCES.BATCH_ID)
WHEN NOT MATCHED THEN INSERT
    ( SK_CUSTOMER_ID,
      SK_ACCOUNT_ID,
      SK_DATE_ID,
      CASH,
      BATCH_ID )
VALUES
    ( CASH_BALANCES_UPDATES.SK_CUSTOMER_ID,
      CASH_BALANCES_UPDATES.SK_ACCOUNT_ID,
      CASH_BALANCES_UPDATES.SK_DATE_ID,
      CASH_BALANCES_UPDATES.CASH,
      CASH_BALANCES_UPDATES.BATCH_ID
    )
;