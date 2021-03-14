ALTER TABLE BOGUN.T_CODE
 DROP PRIMARY KEY CASCADE;

DROP TABLE BOGUN.T_CODE CASCADE CONSTRAINTS;

CREATE TABLE BOGUN.T_CODE
(
  CODE         VARCHAR2(12 BYTE)                NOT NULL,
  GROUP_ID     VARCHAR2(20 BYTE)                NOT NULL,
  PARENT_CODE  VARCHAR2(12 BYTE)                DEFAULT NULL,
  DEPTH        NUMBER(3)                        DEFAULT '1',
  NAME         VARCHAR2(255 BYTE)               DEFAULT NULL,
  INPUT_TYPE   VARCHAR2(20 BYTE)                DEFAULT NULL,
  BG_COLOR     VARCHAR2(20 BYTE)                DEFAULT NULL,
  ORDER_NUM    NUMBER(3)                        DEFAULT '1',
  USE_YN       CHAR(1 BYTE)                     DEFAULT 'Y',
  REG_USER     VARCHAR2(100 BYTE)               DEFAULT NULL,
  REG_DATE     VARCHAR2(14 BYTE)                DEFAULT NULL,
  UPD_USER     VARCHAR2(100 BYTE)               DEFAULT NULL,
  UPD_DATE     VARCHAR2(14 BYTE)                DEFAULT NULL
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

COMMENT ON TABLE BOGUN.T_CODE IS 'CODE TABLE';

COMMENT ON COLUMN BOGUN.T_CODE.CODE IS 'CODE 값(최대 5뎁스까지)';

COMMENT ON COLUMN BOGUN.T_CODE.GROUP_ID IS 'CODE 그룹 ID(CODE_GROUP_0001)';

COMMENT ON COLUMN BOGUN.T_CODE.PARENT_CODE IS '부모 CODE ID';

COMMENT ON COLUMN BOGUN.T_CODE.DEPTH IS '분류 DEPTH(1 : 최상위 개념)';

COMMENT ON COLUMN BOGUN.T_CODE.NAME IS '코드명';

COMMENT ON COLUMN BOGUN.T_CODE.INPUT_TYPE IS '화면에 체크박스(checkbox) 또는 라디오(radio)로 보여줌 부모 타입에만 적용';

COMMENT ON COLUMN BOGUN.T_CODE.BG_COLOR IS '화면에 보여줄때 코드별로 배경색 지정 가능';

COMMENT ON COLUMN BOGUN.T_CODE.ORDER_NUM IS '그룹 코드 별 DEPTH 별 순서';

COMMENT ON COLUMN BOGUN.T_CODE.USE_YN IS '사용여부(Y : 사용, N : 미사용)';

COMMENT ON COLUMN BOGUN.T_CODE.REG_USER IS '등록자 ID';

COMMENT ON COLUMN BOGUN.T_CODE.REG_DATE IS '등록일자';

COMMENT ON COLUMN BOGUN.T_CODE.UPD_USER IS '수정자 ID';

COMMENT ON COLUMN BOGUN.T_CODE.UPD_DATE IS '수정일자';


--  There is no statement for index BOGUN.SYS_C0010511.
--  The object is created when the parent object is created.

--  There is no statement for index BOGUN.SYS_C0010512.
--  The object is created when the parent object is created.

ALTER TABLE BOGUN.T_CODE ADD (
  PRIMARY KEY
  (CODE)
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