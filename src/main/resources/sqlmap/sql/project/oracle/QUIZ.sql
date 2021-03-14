ALTER TABLE BOGUN.T_QUIZ
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_QUIZ CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_QUIZ
(
  ID            VARCHAR2(20 BYTE)               NOT NULL,
  CARDINAL_ID   NUMBER(12) 		                NOT NULL,
  COURSE_ID     VARCHAR2(12 BYTE)               NOT NULL,
  QUIZ_POOL_ID  NUMBER(12)                      NOT NULL,
  TITLE         VARCHAR2(100 BYTE)              NOT NULL,
  QUIZ_TYPE     CHAR(1 BYTE)                    DEFAULT '2',
  START_DATE    VARCHAR2(10 BYTE)               DEFAULT NULL,
  END_DATE      VARCHAR2(10 BYTE)               DEFAULT NULL,
  EXAM_TIME     NUMBER(3)                       DEFAULT '100',
  SCORE         NUMBER(3)                       DEFAULT '100',
  GUIDE         VARCHAR2(4000 BYTE),
  RETRY         NUMBER(3)                       DEFAULT '0',
  LIMITS        VARCHAR2(20 BYTE)               DEFAULT NULL,
  LIMIT_KEYS    VARCHAR2(20 BYTE)               DEFAULT NULL,
  OPEN_YN       CHAR(1 BYTE)                    DEFAULT 'N',
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

COMMENT ON TABLE BOGUN.T_QUIZ IS '시험 관리 테이블';

COMMENT ON COLUMN BOGUN.T_QUIZ.ID IS '시험 마스터 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.CARDINAL_ID IS '기수 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.COURSE_ID IS '과정 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.QUIZ_POOL_ID IS '시험지 풀 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.TITLE IS '시험지 명';

COMMENT ON COLUMN BOGUN.T_QUIZ.QUIZ_TYPE IS '시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)';

COMMENT ON COLUMN BOGUN.T_QUIZ.START_DATE IS '시험기간 시작 일자';

COMMENT ON COLUMN BOGUN.T_QUIZ.END_DATE IS '시험기간 종료 일자';

COMMENT ON COLUMN BOGUN.T_QUIZ.EXAM_TIME IS '시험시간(분)';

COMMENT ON COLUMN BOGUN.T_QUIZ.SCORE IS '만점 점수(총문제수로 나누면 문제당 점수가 나옴)';

COMMENT ON COLUMN BOGUN.T_QUIZ.GUIDE IS '시험안내글';

COMMENT ON COLUMN BOGUN.T_QUIZ.RETRY IS '재응시 횟수';

COMMENT ON COLUMN BOGUN.T_QUIZ.LIMITS IS '제한기능 복수선택(1:시간제한사용, 2:재응시허용, 3:타PC작업제한)';

COMMENT ON COLUMN BOGUN.T_QUIZ.LIMIT_KEYS IS '제한 키 복수선택(1:CTRL+C, 2:CTRL+P, 3:CTRL-V, 4:우마우스클릭)';

COMMENT ON COLUMN BOGUN.T_QUIZ.OPEN_YN IS '답안공개여부(Y/N)';

COMMENT ON COLUMN BOGUN.T_QUIZ.ORDER_NUM IS '순서(필요없음)';

COMMENT ON COLUMN BOGUN.T_QUIZ.USE_YN IS '시험상태(Y : 응시, N : 미응시)';

COMMENT ON COLUMN BOGUN.T_QUIZ.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_QUIZ.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_QUIZ.UPD_DATE IS '수정일자';


--  There is no statement for index BOGUN.SYS_C0010452.
--  The object is created when the parent object is created.

--  There is no statement for index BOGUN.SYS_C0010453.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_QUIZ ADD (
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