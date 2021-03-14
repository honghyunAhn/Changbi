ALTER TABLE BOGUN.T_SURVEY
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_SURVEY CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_SURVEY
(
  ID         VARCHAR2(14 BYTE)                  NOT NULL,
  TITLE      VARCHAR2(255 BYTE)                 NOT NULL,
  A_LEAD     VARCHAR2(2000 BYTE)                DEFAULT NULL,
  ORDER_NUM  NUMBER(3)                          DEFAULT '1',
  USE_YN     CHAR(1 BYTE)                       DEFAULT 'Y',
  REG_USER   VARCHAR2(100 BYTE)                 DEFAULT NULL,
  REG_DATE   VARCHAR2(14 BYTE)                  DEFAULT NULL,
  UPD_USER   VARCHAR2(100 BYTE)                 DEFAULT NULL,
  UPD_DATE   VARCHAR2(14 BYTE)                  DEFAULT NULL
)
TABLESPACE BOGUN
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;

COMMENT ON TABLE BOGUN.T_SURVEY IS '설문 MASTER TABLE';

COMMENT ON COLUMN BOGUN.T_SURVEY.ID IS '설문 마스터 ID(YYYYMMDDHHMISS)형태';

COMMENT ON COLUMN BOGUN.T_SURVEY.TITLE IS '설문 제목';

COMMENT ON COLUMN BOGUN.T_SURVEY.A_LEAD IS '안내머리글';

COMMENT ON COLUMN BOGUN.T_SURVEY.ORDER_NUM IS 'DISPLAY순서';

COMMENT ON COLUMN BOGUN.T_SURVEY.USE_YN IS '게시상태(Y : 서비스, N : 보류)';

COMMENT ON COLUMN BOGUN.T_SURVEY.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_SURVEY.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_SURVEY.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_SURVEY.UPD_DATE IS '수정일자';


--  There is no statement for index BOGUN.SYS_C0010483.
--  The object is created when the parent object is created.

--  There is no statement for index BOGUN.SYS_C0010484.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_SURVEY ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE BOGUN
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);