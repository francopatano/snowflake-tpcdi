-- CREATE TABLE STATEMENT

CREATE OR REPLACE TABLE TPCDI_STG.PUBLIC.CUSTOMER_MGMT_STG ( XML VARIANT COMMENT 'XML STRING' ) ;

CREATE OR REPLACE STREAM TPCDI_STG.PUBLIC.CUSTOMER_MGMT_STG_STM
ON TABLE TPCDI_STG.PUBLIC.CUSTOMER_MGMT_STG
;