ALTER TABLE BOGUN.T_SURVEY_CARDINAL
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_SURVEY_CARDINAL CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_SURVEY_CARDINAL
(
  SURVEY_ID    VARCHAR2(14 BYTE)                NOT NULL,
  CARDINAL_ID  NUMBER(12)  			            NOT NULL
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

COMMENT ON TABLE BOGUN.T_SURVEY_CARDINAL IS '설문 기수 매핑 TABLE';

COMMENT ON COLUMN BOGUN.T_SURVEY_CARDINAL.SURVEY_ID IS '설문 ID';

COMMENT ON COLUMN BOGUN.T_SURVEY_CARDINAL.CARDINAL_ID IS '기수 관리 ID';


--  There is no statement for index BOGUN.SYS_C0010488.
--  The object is created when the parent object is created.

--  There is no statement for index BOGUN.SYS_C0010489.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_SURVEY_CARDINAL ADD (
  PRIMARY KEY
  (SURVEY_ID, CARDINAL_ID)
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