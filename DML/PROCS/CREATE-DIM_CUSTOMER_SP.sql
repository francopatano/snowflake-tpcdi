CREATE OR REPLACE PROCEDURE TPCDI_WH.PUBLIC.DIM_CUSTOMER_SP()
  returns string
  language javascript
  as
  $$
  // Process Dimension Table
  var dim_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.DIM_CUSTOMER SELECT TPCDI_WH.PUBLIC.DIM_CUSTOMER_SEQ.NEXTVAL AS SK_CUSTOMER_ID, CNS.C_ID, CNS.C_TAX_ID, CNS.C_ST_ID, CNS.C_L_NAME, CNS.C_F_NAME, CNS.C_M_NAME, CASE WHEN CNS.C_GNDR = 'M' OR CNS.C_GNDR = 'F' THEN UPPER(CNS.C_GNDR) ELSE 'U' END AS GENDER, CNS.C_TIER, CNS.C_DOB, CNS.C_ADLINE1, CNS.C_ADLINE2, CNS.C_ZIPCODE, CNS.C_CITY, CNS.C_STATE_PROV, CNS.C_CTRY, CASE WHEN CNS.C_CTRY_1 != '' AND CNS.C_AREA_1 != '' AND CNS.C_LOCAL_1 != '' THEN CNS.C_CTRY_1 || '-' || CNS.C_AREA_1 || '-' || CNS.C_LOCAL_1 WHEN CNS.C_CTRY_1 = '' AND CNS.C_AREA_1 != '' AND CNS.C_LOCAL_1 != '' THEN CNS.C_AREA_1 || '-' || CNS.C_LOCAL_1 WHEN CNS.C_CTRY_1 = '' AND CNS.C_AREA_1 = '' AND CNS.C_LOCAL_1 != '' THEN CNS.C_LOCAL_1 ELSE NULL END AS PHONE1, CASE WHEN CNS.C_CTRY_2 != '' AND CNS.C_AREA_2 != '' AND CNS.C_LOCAL_2 != '' THEN CNS.C_CTRY_2 || '-' || CNS.C_AREA_2 || '-' || CNS.C_LOCAL_2 WHEN CNS.C_CTRY_2 = '' AND CNS.C_AREA_2 != '' AND CNS.C_LOCAL_2 != '' THEN CNS.C_AREA_2 || '-' || CNS.C_LOCAL_2 WHEN CNS.C_CTRY_2 = '' AND CNS.C_AREA_2 = '' AND CNS.C_LOCAL_2 != '' THEN CNS.C_LOCAL_2 ELSE NULL END AS PHONE2, CASE WHEN CNS.C_CTRY_3 != '' AND CNS.C_AREA_3 != '' AND CNS.C_LOCAL_3 != '' THEN CNS.C_CTRY_3 || '-' || CNS.C_AREA_3 || '-' || CNS.C_LOCAL_3 WHEN CNS.C_CTRY_3 = '' AND CNS.C_AREA_3 != '' AND CNS.C_LOCAL_3 != '' THEN CNS.C_AREA_3 || '-' || CNS.C_LOCAL_3 WHEN CNS.C_CTRY_3 = '' AND CNS.C_AREA_3 = '' AND CNS.C_LOCAL_3 != '' THEN CNS.C_LOCAL_3 ELSE NULL END AS PHONE3, CNS.C_EMAIL_1, CNS.C_EMAIL_2, NAT_TAX_RATE.TX_NAME AS NATIONAL_TAX_RATE_DESC, NAT_TAX_RATE.TX_RATE AS NATIONAL_TAX_RATE, LOC_TAX_RATE.TX_NAME AS LOCAL_TAX_RATE_DESC, LOC_TAX_RATE.TX_RATE AS LOCAL_TAX_RATE, NULL AS AGENCY_ID, NULL AS CREDIT_RATING, NULL AS NET_WORTH, NULL AS MARKETING_NAMEPLATE, (SELECT MAX(BATCH_ID) FROM TPCDI_WH.PUBLIC.CTRL_BATCH) AS BATCH_ID, LOCALTIMESTAMP() AS EFFECTIVE_DATE FROM TPCDI_ODS.PUBLIC.CUSTOMER_ODS_STM CNS INNER JOIN TPCDI_WH.PUBLIC.DIM_TAX_RATE NAT_TAX_RATE ON CNS.C_NAT_TX_ID = NAT_TAX_RATE.TX_ID INNER JOIN TPCDI_WH.PUBLIC.DIM_TAX_RATE LOC_TAX_RATE ON CNS.C_LCL_TX_ID = LOC_TAX_RATE.TX_ID WHERE CNS.METADATA$ACTION = 'INSERT'"}
    );
  dim_stmt.execute();
  // Log audit record
  var audit_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.AUDIT SELECT 'DIM_CUSTOMER_SP', LOCALTIMESTAMP(), (SELECT MAX(BATCH_ID) FROM TPCDI_WH.PUBLIC.CTRL_BATCH), $1, 0 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))"}
    );
  audit_stmt.execute();
  return 'Dim Customer records processed.';
  $$
;
