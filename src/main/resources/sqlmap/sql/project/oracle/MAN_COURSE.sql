ALTER TABLE BOGUN.T_MAN_COURSE
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_MAN_COURSE CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_MAN_COURSE
(
  MAN_ID     VARCHAR2(100 BYTE)                 NOT NULL,
  COURSE_ID  VARCHAR2(10 BYTE)                  NOT NULL,
  PERSONS    NUMBER(4)                          DEFAULT '0'
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

COMMENT ON TABLE BOGUN.T_MAN_COURSE IS '관리자 담당 과정 지정 TABLE';

COMMENT ON COLUMN BOGUN.T_MAN_COURSE.MAN_ID IS '관리자 ID';

COMMENT ON COLUMN BOGUN.T_MAN_COURSE.COURSE_ID IS '과정 ID';

COMMENT ON COLUMN BOGUN.T_MAN_COURSE.PERSONS IS '배당인원';


--  There is no statement for index BOGUN.SYS_C0010430.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_MAN_COURSE ADD (
  PRIMARY KEY
  (MAN_ID, COURSE_ID)
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