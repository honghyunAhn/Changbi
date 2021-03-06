ALTER TABLE BOGUN.T_ATTACH_FILE
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_ATTACH_FILE CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_ATTACH_FILE
(
  FILE_ID   VARCHAR2(20 BYTE)                   NOT NULL,
  USE_YN    CHAR(1 BYTE)                        DEFAULT 'Y',
  REG_USER  VARCHAR2(100 BYTE)                  DEFAULT NULL,
  REG_DATE  VARCHAR2(14 BYTE)                   DEFAULT NULL,
  UPD_USER  VARCHAR2(100 BYTE)                  DEFAULT NULL,
  UPD_DATE  VARCHAR2(14 BYTE)                   DEFAULT NULL
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

COMMENT ON TABLE BOGUN.T_ATTACH_FILE IS 'ATTACHFILE MASTER TABLE';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.FILE_ID IS '파일 ID';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.USE_YN IS '사용여부(Y : 사용, N : 미사용)';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_ATTACH_FILE.UPD_DATE IS '수정일자';


--  There is no statement for index BOGUN.SYS_C0010499.
--  The object is created when the parent object is created.

--  There is no statement for index BOGUN.SYS_C0010500.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_ATTACH_FILE ADD (
  PRIMARY KEY
  (FILE_ID)
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