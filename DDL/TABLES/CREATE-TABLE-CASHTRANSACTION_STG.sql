-- CREATE TABLE STATEMENT

CREATE OR REPLACE TABLE TPCDI_STG.PUBLIC.CASHTRANSACTION_STG ( CDC_FLAG CHAR(1) COMMENT 'I DENOTES INSERT', CDC_DSN INT COMMENT 'DATABASE SEQUENCE NUMBER', CT_CA_ID INT NOT NULL COMMENT 'CUSTOMER ACCOUNT IDENTIFIER', CT_DTS DATETIME NOT NULL COMMENT 'TIMESTAMP OF WHEN THE TRADE TOOK PLACE', CT_AMT NUMBER(10,2) NOT NULL COMMENT 'AMOUNT OF THE CASH TRANSACTION', CT_NAME CHAR(100) NOT NULL COMMENT 'TRANSACTION NAME OR DESCRIPTION: E.G. "CASH FROM SALE OF DUPONT STOCK".' ) ;

CREATE OR REPLACE STREAM TPCDI_STG.PUBLIC.CASHTRANSACTION_STG_STM
ON TABLE TPCDI_STG.PUBLIC.CASHTRANSACTION_STG
;
