ALTER TABLE BOGUN.T_BOARD
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_BOARD CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_BOARD
(
  ID            NUMBER(12)                      NOT NULL,
  LANG          CHAR(2 BYTE)                    DEFAULT 'ko'                  NOT NULL,
  BOARD_TYPE    CHAR(1 BYTE)                    DEFAULT '1',
  NOTICE_TYPE   CHAR(1 BYTE)                    DEFAULT '1',
  FAQ_CODE      VARCHAR2(12 BYTE)               DEFAULT NULL,
  CARDINAL_ID   NUMBER(12) 			            DEFAULT NULL,
  COURSE_ID     VARCHAR2(12 BYTE)               DEFAULT NULL,
  TEACHER_ID    VARCHAR2(100 BYTE)              DEFAULT NULL,
  USER_ID       VARCHAR2(100 BYTE)              DEFAULT NULL,
  ATTACH1_FILE  VARCHAR2(20 BYTE)               DEFAULT NULL,
  ATTACH2_FILE  VARCHAR2(20 BYTE)               DEFAULT NULL,
  ICON          CHAR(1 BYTE)                    DEFAULT NULL,
  TOP_YN        CHAR(1 BYTE)                    DEFAULT 'N',
  SECRET_YN     CHAR(1 BYTE)                    DEFAULT 'N',
  TITLE         VARCHAR2(255 BYTE)              DEFAULT NULL,
  CMNT          CLOB,
  HITS          NUMBER(8)                       DEFAULT '0',
  RECOMMEND     NUMBER(8)                       DEFAULT '0',
  NONRECOMMEND  NUMBER(8)                       DEFAULT '0',
  SHARED        NUMBER(8)                       DEFAULT '0',
  ORDER_NUM     NUMBER(3)                       DEFAULT '1',
  USE_YN        CHAR(1 BYTE)                    DEFAULT 'Y',
  REG_USER      VARCHAR2(100 BYTE)              DEFAULT NULL,
  REG_DATE      VARCHAR2(14 BYTE)               DEFAULT NULL,
  UPD_USER      VARCHAR2(100 BYTE)              DEFAULT NULL,
  UPD_DATE      VARCHAR2(14 BYTE)               DEFAULT NULL
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

COMMENT ON TABLE BOGUN.T_BOARD IS 'BOARD MASTER TABLE';

COMMENT ON COLUMN BOGUN.T_BOARD.ID IS '????????? ????????? ID(SEQ??? ID??????)';

COMMENT ON COLUMN BOGUN.T_BOARD.LANG IS '????????? ??????(ko:?????????, en:??????, zh:?????????, ja:?????????)';

COMMENT ON COLUMN BOGUN.T_BOARD.BOARD_TYPE IS '????????? ??????(1:????????????, 2:?????????, 3:FAQ, 4:1:1??????, 5:????????????, 6:????????????)';

COMMENT ON COLUMN BOGUN.T_BOARD.NOTICE_TYPE IS '????????????(1:??????, 2:??????, 3:??????, 4:??????, 5:??????, 6:??????, 7:??????)';

COMMENT ON COLUMN BOGUN.T_BOARD.FAQ_CODE IS 'FAQ??? ?????? ????????????';

COMMENT ON COLUMN BOGUN.T_BOARD.CARDINAL_ID IS '??????ID';

COMMENT ON COLUMN BOGUN.T_BOARD.COURSE_ID IS '??????ID';

COMMENT ON COLUMN BOGUN.T_BOARD.TEACHER_ID IS '??????ID';

COMMENT ON COLUMN BOGUN.T_BOARD.USER_ID IS '????????? USER ID';

COMMENT ON COLUMN BOGUN.T_BOARD.ATTACH1_FILE IS '?????? #1 ??????';

COMMENT ON COLUMN BOGUN.T_BOARD.ATTACH2_FILE IS '?????? #2 ??????';

COMMENT ON COLUMN BOGUN.T_BOARD.ICON IS '?????????(1:New, 2:Hot)';

COMMENT ON COLUMN BOGUN.T_BOARD.TOP_YN IS '??? ?????? YN';

COMMENT ON COLUMN BOGUN.T_BOARD.SECRET_YN IS '????????? ??????(Y/N)';

COMMENT ON COLUMN BOGUN.T_BOARD.TITLE IS '????????? ??????';

COMMENT ON COLUMN BOGUN.T_BOARD.CMNT IS '????????? ??????';

COMMENT ON COLUMN BOGUN.T_BOARD.HITS IS '?????????';

COMMENT ON COLUMN BOGUN.T_BOARD.RECOMMEND IS '?????????';

COMMENT ON COLUMN BOGUN.T_BOARD.NONRECOMMEND IS '????????????';

COMMENT ON COLUMN BOGUN.T_BOARD.SHARED IS '????????????';

COMMENT ON COLUMN BOGUN.T_BOARD.ORDER_NUM IS 'DISPLAY??????(????????? ???????????? ORDER)';

COMMENT ON COLUMN BOGUN.T_BOARD.USE_YN IS '????????????(Y : ??????, N : ?????????)';

COMMENT ON COLUMN BOGUN.T_BOARD.REG_USER IS '????????? ID';

COMMENT ON COLUMN BOGUN.T_BOARD.REG_DATE IS '????????????';

COMMENT ON COLUMN BOGUN.T_BOARD.UPD_USER IS '????????? ID';

COMMENT ON COLUMN BOGUN.T_BOARD.UPD_DATE IS '????????????';


--  There is no statement for index BOGUN.SYS_C0010378.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_BOARD ADD (
  PRIMARY KEY
  (ID)
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
  
  DROP SEQUENCE SEQ_BOARD;
  
  CREATE SEQUENCE SEQ_BOARD INCREMENT BY 1 START WITH 1;