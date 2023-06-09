-- HISTORICAL LOAD

-- TRUNCATE TABLE
  TRUNCATE TABLE TPCDI_WH.PUBLIC.FACT_HOLDINGS;
  COMMIT;
  
-- LOAD TABLE
  INSERT INTO TPCDI_WH.PUBLIC.FACT_HOLDINGS
  SELECT
       HH_H_T_ID TRADE_ID
     , HH_T_ID CURRENT_TRADE_ID
     , DIM_TRADE.SK_CUSTOMER_ID SK_CUSTOMER_ID
     , DIM_TRADE.SK_ACCOUNT_ID SK_ACCOUNT_ID
     , DIM_TRADE.SK_SECURITY_ID SK_SECURITY_ID
     , DIM_TRADE.SK_COMPANY_ID SK_COMPANY_ID
     , DIM_TRADE.SK_CLOSE_DATE_ID SK_DATE_ID
     , DIM_TRADE.SK_CLOSE_TIME_ID SK_TIME_ID
     , DIM_TRADE.TRADE_PRICE CURRENT_PRICE
     , HH_AFTER_QTY CURRENT_HOLDING
     , TO_NUMBER(1) BATCH_ID
  FROM TPCDI_STG.PUBLIC.HOLDINGHISTORY_STG_STM
  INNER JOIN TPCDI_WH.PUBLIC.DIM_TRADE ON
      HOLDINGHISTORY_STG.HH_T_ID = DIM_TRADE.TRADE_ID
;