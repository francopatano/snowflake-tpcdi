-- CREATE SEQUENCE STATEMENT

CREATE OR REPLACE SEQUENCE TPCDI_WH.PUBLIC.CTRL_BATCH_SEQ   START WITH = 1   INCREMENT = 1   COMMENT = 'DATABASE SEQUENCE TO SOURCE THE BATCH_ID FOR THE BATCH CONTROL TABLE.' ; 

-- CREATE TABLE STATEMENT

CREATE OR REPLACE TABLE TPCDI_WH.PUBLIC.CTRL_BATCH ( BATCH_ID NUMBER(11) NOT NULL COMMENT 'BATCH NUMBER', BATCH_TS TIMESTAMP_LTZ NOT NULL COMMENT 'THE TIMESTAMP THE BATCH STARTED' ) ;

