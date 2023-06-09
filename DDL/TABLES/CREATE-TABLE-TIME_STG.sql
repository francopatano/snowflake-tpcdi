-- CREATE TABLE STATEMENT

CREATE OR REPLACE TABLE TPCDI_STG.PUBLIC.TIME_STG ( SK_TIMEID INT NOT NULL COMMENT 'SURROGATE KEY FOR THE TIME' , TIMEVALUE CHAR(20) NOT NULL COMMENT 'THE TIME AS TEXT, E.G. “01:23:45”' , HOURID NUMBER(2) NOT NULL COMMENT 'HOUR NUMBER AS A NUMBER, E.G. 01' , HOURDESC CHAR(20) NOT NULL COMMENT 'HOUR NUMBER AS TEXT, E.G. “01”' , MINUTEID NUMBER(2) NOT NULL COMMENT 'MINUTE AS A NUMBER, E.G. 23' , MINUTEDESC CHAR(20) NOT NULL COMMENT 'MINUTE AS TEXT, E.G. “01:23”' , SECONDID NUMBER(2) NOT NULL COMMENT 'SECOND AS A NUMBER, E.G. 45' , SECONDDESC CHAR(20) NOT NULL COMMENT 'SECOND AS TEXT, E.G. “01:23:45”' , MARKETHOURSFLAG BOOLEAN COMMENT 'INDICATES A TIME DURING MARKET HOURS' , OFFICEHOURSFLAG BOOLEAN COMMENT 'INDICATES A TIME DURING OFFICE HOURS' ) ;

CREATE OR REPLACE STREAM TPCDI_STG.PUBLIC.TIME_STG_STM
ON TABLE TPCDI_STG.PUBLIC.TIME_STG
;
