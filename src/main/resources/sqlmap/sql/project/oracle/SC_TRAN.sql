ALTER TABLE BOGUN.SC_TRAN
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.SC_TRAN CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.SC_TRAN
(
  TR_NUM           NUMBER(12)                   NOT NULL,
  TR_SENDDATE      DATE                         DEFAULT NULL,
  TR_ID            VARCHAR2(16 BYTE)            DEFAULT NULL,
  TR_SENDSTAT      VARCHAR2(1 BYTE)             DEFAULT '0'                   NOT NULL,
  TR_RSLTSTAT      VARCHAR2(2 BYTE)             DEFAULT '00',
  TR_MSGTYPE       VARCHAR2(1 BYTE)             DEFAULT '0'                   NOT NULL,
  TR_PHONE         VARCHAR2(20 BYTE)            DEFAULT ''                    NOT NULL,
  TR_CALLBACK      VARCHAR2(20 BYTE)            DEFAULT NULL,
  TR_RSLTDATE      DATE                         DEFAULT NULL,
  TR_MODIFIED      DATE                         DEFAULT NULL,
  TR_MSG           VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_NET           VARCHAR2(4 BYTE)             DEFAULT NULL,
  TR_ETC1          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ETC2          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ETC3          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ETC4          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ETC5          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ETC6          VARCHAR2(160 BYTE)           DEFAULT NULL,
  TR_ROUTEID       VARCHAR2(20 BYTE)            DEFAULT NULL,
  TR_REALSENDDATE  DATE                         DEFAULT NULL
)
TABLESPACE BOGUN
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


--  There is no statement for index BOGUN.SYS_C0010530.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.SC_TRAN ADD (
  PRIMARY KEY
  (TR_NUM)
  USING INDEX
    TABLESPACE BOGUN
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);
  
  DROP SEQUENCE SEQ_SC_TRAN;
  
  CREATE SEQUENCE SEQ_SC_TRAN INCREMENT BY 1 START WITH 1;