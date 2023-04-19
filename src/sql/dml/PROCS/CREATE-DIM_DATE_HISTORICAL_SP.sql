CREATE OR REPLACE PROCEDURE TPCDI_WH.PUBLIC.DIM_DATE_HISTORICAL_SP()
  returns string
  language javascript
  as
  $$
  // Process Dimension Table Updates
  var dim_stmt = snowflake.createStatement(
      {sqlText: "MERGE INTO TPCDI_WH.PUBLIC.DIM_DATE USING ( SELECT SK_DATEID ,DATEVALUE ,DATEDESC ,CALENDARYEARID ,CALENDARYEARDESC ,CALENDARQTRID ,CALENDARQTRDESC ,CALENDARMONTHID ,CALENDARMONTHDESC ,CALENDARWEEKID ,CALENDARWEEKDESC ,DAYOFWEEKNUM ,DAYOFWEEKDESC ,FISCALYEARID ,FISCALYEARDESC ,FISCALQTRID ,FISCALQTRDESC ,HOLIDAYFLAG ,METADATA$ACTION ,METADATA$ISUPDATE FROM TPCDI_STG.PUBLIC.DATE_STG_STM ) DATE_STG ON TPCDI_WH.PUBLIC.DIM_DATE.DATE_ID = DATE_STG.SK_DATEID WHEN MATCHED AND DATE_STG.METADATA$ACTION = 'INSERT' AND DATE_STG.METADATA$ISUPDATE = 'TRUE' THEN UPDATE SET DIM_DATE.DATE_VALUE = DATE_STG.DATEVALUE ,DIM_DATE.DATE_DESC = DATE_STG.DATEDESC ,DIM_DATE.CALENDAR_YEAR_ID = DATE_STG.CALENDARYEARID ,DIM_DATE.CALENDAR_YEAR_DESC = DATE_STG.CALENDARYEARDESC ,DIM_DATE.CALENDAR_QTR_ID = DATE_STG.CALENDARQTRID ,DIM_DATE.CALENDAR_QTR_DESC = DATE_STG.CALENDARQTRDESC ,DIM_DATE.CALENDAR_MONTH_ID = DATE_STG.CALENDARMONTHID ,DIM_DATE.CALENDAR_MONTH_DESC = DATE_STG.CALENDARMONTHDESC ,DIM_DATE.CALENDAR_WEEK_ID = DATE_STG.CALENDARWEEKID ,DIM_DATE.CALENDAR_WEEK_DESC = DATE_STG.CALENDARWEEKDESC ,DIM_DATE.DAY_OF_WEEK_NUM = DATE_STG.DAYOFWEEKNUM ,DIM_DATE.DAY_OF_WEEK_DESC = DATE_STG.DAYOFWEEKDESC ,DIM_DATE.FISCAL_YEAR_ID = DATE_STG.FISCALYEARID ,DIM_DATE.FISCAL_YEAR_DESC = DATE_STG.FISCALYEARDESC ,DIM_DATE.FISCAL_QTR_ID = DATE_STG.FISCALQTRID ,DIM_DATE.FISCAL_QTR_DESC = DATE_STG.FISCALQTRDESC ,DIM_DATE.HOLIDAY_FLAG = DATE_STG.HOLIDAYFLAG WHEN NOT MATCHED AND DATE_STG.METADATA$ACTION = 'INSERT' AND DATE_STG.METADATA$ISUPDATE = 'FALSE' THEN INSERT (   DATE_ID   ,DATE_VALUE   ,DATE_DESC   ,CALENDAR_YEAR_ID   ,CALENDAR_YEAR_DESC   ,CALENDAR_QTR_ID   ,CALENDAR_QTR_DESC   ,CALENDAR_MONTH_ID   ,CALENDAR_MONTH_DESC   ,CALENDAR_WEEK_ID   ,CALENDAR_WEEK_DESC   ,DAY_OF_WEEK_NUM   ,DAY_OF_WEEK_DESC   ,FISCAL_YEAR_ID   ,FISCAL_YEAR_DESC   ,FISCAL_QTR_ID   ,FISCAL_QTR_DESC   ,HOLIDAY_FLAG ) VALUES (   DATE_STG.SK_DATEID   ,DATE_STG.DATEVALUE   ,DATE_STG.DATEDESC   ,DATE_STG.CALENDARYEARID   ,DATE_STG.CALENDARYEARDESC   ,DATE_STG.CALENDARQTRID   ,DATE_STG.CALENDARQTRDESC   ,DATE_STG.CALENDARMONTHID   ,DATE_STG.CALENDARMONTHDESC   ,DATE_STG.CALENDARWEEKID   ,DATE_STG.CALENDARWEEKDESC   ,DATE_STG.DAYOFWEEKNUM   ,DATE_STG.DAYOFWEEKDESC   ,DATE_STG.FISCALYEARID   ,DATE_STG.FISCALYEARDESC   ,DATE_STG.FISCALQTRID   ,DATE_STG.FISCALQTRDESC   ,DATE_STG.HOLIDAYFLAG )"}
    );
  dim_stmt.execute();
  // Log audit record
  var audit_stmt = snowflake.createStatement(
      {sqlText: "INSERT INTO TPCDI_WH.PUBLIC.AUDIT SELECT 'DIM_DATE_HISTORICAL_SP', LOCALTIMESTAMP(), (SELECT MAX(BATCH_ID) FROM TPCDI_WH.PUBLIC.CTRL_BATCH), $1, $2 FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))"}
    );
  audit_stmt.execute();
  return "Dimension loaded.";
  $$
;