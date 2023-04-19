-- CREATE TABLE STATEMENT COMMENT

CREATE OR REPLACE TABLE TPCDI_STG.PUBLIC.TRADETYPE_STG ( TT_ID CHAR(3) NOT NULL COMMENT 'TRADE TYPE CODE', TT_NAME CHAR(12) NOT NULL COMMENT 'TRADE TYPE DESCRIPTION', TT_IS_SELL INT NOT NULL COMMENT 'FLAG INDICATING A SALE', TT_IS_MRKT INT NOT NULL COMMENT 'FLAG INDICATING A MARKET ORDER' ) ;

CREATE OR REPLACE STREAM TPCDI_STG.PUBLIC.TRADETYPE_STG_STM
ON TABLE TPCDI_STG.PUBLIC.TRADETYPE_STG
;