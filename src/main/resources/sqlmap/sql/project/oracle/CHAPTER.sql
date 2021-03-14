DROP TABLE BOGUN.T_CHAPTER CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_CHAPTER
(
  ID            NUMBER(12)                      NOT NULL,
  COURSE_ID     VARCHAR2(12 BYTE)               DEFAULT NULL,
  NAME          VARCHAR2(100 BYTE)              DEFAULT NULL,
  STUDY         NUMBER(2)                       DEFAULT '0',
  CHK           NUMBER(2)                       DEFAULT '0',
  MAIN_URL      VARCHAR2(500 BYTE)              DEFAULT NULL,
  MOBILE_URL 	VARCHAR2(500 BYTE)              DEFAULT NULL,
  TEACHER       VARCHAR2(50 BYTE)               DEFAULT NULL,
  FILE_INFO     VARCHAR2(500 BYTE)              DEFAULT NULL,
  SERVICE_TYPE  CHAR(1 BYTE)                    DEFAULT 'P',
  PAGE_CNT		NUMBER(3)						DEFAULT '1',
  ORDER_NUM     NUMBER(3)                       DEFAULT '1'
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

COMMENT ON TABLE BOGUN.T_CHAPTER IS '연수과정 차시 관리 테이블';

COMMENT ON COLUMN BOGUN.T_CHAPTER.ID IS '연수과정 차시 ID';

COMMENT ON COLUMN BOGUN.T_CHAPTER.COURSE_ID IS '연수과정 ID';

COMMENT ON COLUMN BOGUN.T_CHAPTER.NAME IS '챕터명';

COMMENT ON COLUMN BOGUN.T_CHAPTER.STUDY IS '교육시간(분)';

COMMENT ON COLUMN BOGUN.T_CHAPTER.CHK IS '체크(분)';

COMMENT ON COLUMN BOGUN.T_CHAPTER.MAIN_URL IS 'PC URL';

COMMENT ON COLUMN BOGUN.T_CHAPTER.MOBILE_URL IS '모바일 URL';

COMMENT ON COLUMN BOGUN.T_CHAPTER.TEACHER IS '강사명';

COMMENT ON COLUMN BOGUN.T_CHAPTER.FILE_INFO IS '강사파일';

COMMENT ON COLUMN BOGUN.T_CHAPTER.SERVICE_TYPE IS 'PC 모바일 구분(P : PC, M : MOBILE)';

COMMENT ON COLUMN BOGUN.T_CHAPTER.PAGE_CNT IS '차시의 페이지 갯수(한 차시 마다 여러개의 페이지로 구성)';

COMMENT ON COLUMN BOGUN.T_CHAPTER.ORDER_NUM IS '순서(필요없음)';


--  There is no statement for index BOGUN.SYS_C0010390.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_CHAPTER ADD (
  UNIQUE (ID)
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
  
  DROP SEQUENCE SEQ_CHAPTER;
  
  CREATE SEQUENCE SEQ_CHAPTER INCREMENT BY 1 START WITH 1;