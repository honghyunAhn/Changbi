ALTER TABLE BOGUN.T_QUIZ_REPLY
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_QUIZ_REPLY CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_QUIZ_REPLY
(
  ID            NUMBER(12)                      NOT NULL,
  REPORT_ID     NUMBER(12)                      NOT NULL,
  QUIZ_BANK_ID  NUMBER(12)                      NOT NULL,
  QUIZ_ITEM_ID  NUMBER(12)                      NOT NULL,
  OS_TYPE       CHAR(1 BYTE)                    DEFAULT 'O',
  TITLE         VARCHAR2(2000 BYTE)             DEFAULT NULL,
  CMNT          VARCHAR2(4000 BYTE),
  O_ANSWER      NUMBER(3)                       DEFAULT '1',
  S_ANSWER      VARCHAR2(4000 BYTE),
  O_REPLY       NUMBER(3)                       DEFAULT '1',
  S_REPLY       VARCHAR2(4000 BYTE),
  P_SCORE       NUMBER(3)                       DEFAULT '0',
  T_SCORE       NUMBER(3)                       DEFAULT '0',
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
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;

COMMENT ON TABLE BOGUN.T_QUIZ_REPLY IS '시험 문제 답안지 테이블';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.ID IS '답안지 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.REPORT_ID IS '평가 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.QUIZ_BANK_ID IS '문제 은행 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.QUIZ_ITEM_ID IS '시험문제 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.OS_TYPE IS '문항종류(O:객관식, S:주관식)';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.TITLE IS '문제명';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.CMNT IS '보충해설';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.O_ANSWER IS '객관식 정답';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.S_ANSWER IS '주관식 정답';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.O_REPLY IS '객관식 본인 답';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.S_REPLY IS '주관식 본인 답';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.P_SCORE IS '문제 개별 점수(QUIZ 의 SCORE 를 문제수로 나눈 점수)';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.T_SCORE IS '문제 개별 득점점수';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.ORDER_NUM IS '문제순서';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.USE_YN IS '사용여부(Y : 사용, N : 미사용)';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ_REPLY.UPD_DATE IS '수정일자';


--  There is no statement for index BOGUN.SYS_C0010470.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_QUIZ_REPLY ADD (
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
  
  DROP SEQUENCE SEQ_QUIZ_REPLY;
  
  CREATE SEQUENCE SEQ_QUIZ_REPLY INCREMENT BY 1 START WITH 1;