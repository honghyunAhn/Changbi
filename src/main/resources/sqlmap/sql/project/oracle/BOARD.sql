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

COMMENT ON COLUMN BOGUN.T_BOARD.ID IS '게시글 마스터 ID(SEQ로 ID저장)';

COMMENT ON COLUMN BOGUN.T_BOARD.LANG IS '다국어 코드(ko:한국어, en:영어, zh:중국어, ja:일본어)';

COMMENT ON COLUMN BOGUN.T_BOARD.BOARD_TYPE IS '게시글 타입(1:공지사항, 2:자료실, 3:FAQ, 4:1:1상담, 5:연수후기, 6:질의응답)';

COMMENT ON COLUMN BOGUN.T_BOARD.NOTICE_TYPE IS '공지구분(1:모집, 2:환영, 3:신설, 4:필독, 5:일반, 6:평가, 7:공문)';

COMMENT ON COLUMN BOGUN.T_BOARD.FAQ_CODE IS 'FAQ인 경우 분류코드';

COMMENT ON COLUMN BOGUN.T_BOARD.CARDINAL_ID IS '기수ID';

COMMENT ON COLUMN BOGUN.T_BOARD.COURSE_ID IS '과정ID';

COMMENT ON COLUMN BOGUN.T_BOARD.TEACHER_ID IS '강사ID';

COMMENT ON COLUMN BOGUN.T_BOARD.USER_ID IS '작성자 USER ID';

COMMENT ON COLUMN BOGUN.T_BOARD.ATTACH1_FILE IS '첨부 #1 파일';

COMMENT ON COLUMN BOGUN.T_BOARD.ATTACH2_FILE IS '첨부 #2 파일';

COMMENT ON COLUMN BOGUN.T_BOARD.ICON IS '아이콘(1:New, 2:Hot)';

COMMENT ON COLUMN BOGUN.T_BOARD.TOP_YN IS '탑 고정 YN';

COMMENT ON COLUMN BOGUN.T_BOARD.SECRET_YN IS '비밀글 여부(Y/N)';

COMMENT ON COLUMN BOGUN.T_BOARD.TITLE IS '게시물 제목';

COMMENT ON COLUMN BOGUN.T_BOARD.CMNT IS '게시물 내용';

COMMENT ON COLUMN BOGUN.T_BOARD.HITS IS '조회수';

COMMENT ON COLUMN BOGUN.T_BOARD.RECOMMEND IS '추천수';

COMMENT ON COLUMN BOGUN.T_BOARD.NONRECOMMEND IS '비추천수';

COMMENT ON COLUMN BOGUN.T_BOARD.SHARED IS '공유횟수';

COMMENT ON COLUMN BOGUN.T_BOARD.ORDER_NUM IS 'DISPLAY순서(게시판 기준으로 ORDER)';

COMMENT ON COLUMN BOGUN.T_BOARD.USE_YN IS '사용여부(Y : 사용, N : 미사용)';

COMMENT ON COLUMN BOGUN.T_BOARD.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_BOARD.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_BOARD.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_BOARD.UPD_DATE IS '수정일자';


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