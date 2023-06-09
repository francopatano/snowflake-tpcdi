CREATE OR REPLACE PROCEDURE TPCDI_WH.PUBLIC.DIM_FINANCIAL_SP()
  returns string
  language javascript
  as
  $$
  // Process ODS Table
  var ods_stmt = snowflake.createStatement(
      {sqlText: "CALL TPCDI_WH.PUBLIC.FINWIRE_FIN_ODS_SP()"}
      );
  ods_stmt.execute();
  // Process Dimension Table
  var dim_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.DIM_FINANCIAL SELECT COALESCE(ID.SK_COMPANY_ID,NAME.SK_COMPANY_ID), FINWIRE_FIN_ODS_STM.YEAR, FINWIRE_FIN_ODS_STM.QUARTER, FINWIRE_FIN_ODS_STM.QTR_START_DATE, FINWIRE_FIN_ODS_STM.REVENUE, FINWIRE_FIN_ODS_STM.EARNINGS, FINWIRE_FIN_ODS_STM.EPS, FINWIRE_FIN_ODS_STM.DILUTED_EPS, FINWIRE_FIN_ODS_STM.MARGIN, FINWIRE_FIN_ODS_STM.INVENTORY, FINWIRE_FIN_ODS_STM.ASSETS, FINWIRE_FIN_ODS_STM.LIABILITIES, FINWIRE_FIN_ODS_STM.SH_OUT, FINWIRE_FIN_ODS_STM.DILUTED_SH_OUT, LOCALTIMESTAMP() FROM TPCDI_ODS.PUBLIC.FINWIRE_FIN_ODS_STM LEFT OUTER JOIN TPCDI_WH.PUBLIC.DIM_COMPANY_NOW ID ON IFF(LTRIM(FINWIRE_FIN_ODS_STM.CO_NAME_OR_CIK,'0')='','0',LTRIM(FINWIRE_FIN_ODS_STM.CO_NAME_OR_CIK,'0')) = ID.COMPANY_ID::STRING LEFT OUTER JOIN TPCDI_WH.PUBLIC.DIM_COMPANY_NOW NAME ON FINWIRE_FIN_ODS_STM.CO_NAME_OR_CIK = NAME.NAME WHERE FINWIRE_FIN_ODS_STM.METADATA$ACTION = 'INSERT'"}
      );
  dim_stmt.execute();
  // Log audit record
  var audit_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.AUDIT SELECT 'DIM_FINANCIAL_SP', LOCALTIMESTAMP(), (SELECT MAX(BATCH_ID) FROM TPCDI_WH.PUBLIC.CTRL_BATCH), $1, 0 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))"}
      );
  audit_stmt.execute();
  return 'Dim Financial records processed.';
  $$
;
