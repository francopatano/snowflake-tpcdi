-- CREATE TABLE STATEMENT
-- MOVED TO BEING A VIEW INSTEAD OF A TABLE

CREATE OR REPLACE TABLE TPCDI_STG.PUBLIC.FINWIRE_SEC_STG 
(
  PTS TIMESTAMP_NTZ NOT NULL COMMENT 'POSTING DATE & TIME AS YYYYMMDD-HHMMSS',
  REC_TYPE VARCHAR(3) NOT NULL COMMENT '“SEC”',
  SYMBOL VARCHAR(15) NOT NULL COMMENT 'SECURITY SYMBOL',
  ISSUE_TYPE VARCHAR(6) NOT NULL COMMENT 'ISSUE TYPE',
  STATUS VARCHAR(4) NOT NULL COMMENT 'ACTV FOR ACTIVE SECURITY, INAC FOR INACTIVE',
  NAME VARCHAR(70) NOT NULL COMMENT 'SECURITY NAME',
  EX_ID VARCHAR(6) NOT NULL COMMENT 'ID OF THE EXCHANGE THE SECURITY IS TRADED ON',
  SH_OUT NUMBER(13,0) NOT NULL COMMENT 'NUMBER OF SHARES OUTSTANDING',
  FIRST_TRADE_DATE DATE NOT NULL COMMENT 'DATE OF FIRST TRADE AS YYYYMMDD',
  FIRST_TRADE_EXCHG DATE NOT NULL COMMENT 'DATE OF FIRST TRADE ON EXCHANGE AS YYYYMMDD',
  DIVIDEND NUMBER(10,2) NOT NULL COMMENT 'DIVIDEND AS VALUE_T',
  CO_NAME_OR_CIK VARCHAR(60) NOT NULL COMMENT 'COMPANY CIK NUMBER (IF ONLY DIGITS, 10 CHARS) OR NAME (IF NOT ONLY DIGITS, 60 CHARS)'
)
;