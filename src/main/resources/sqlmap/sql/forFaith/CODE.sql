-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
CREATE TABLE FF_CODE (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT 'CODE 관리 마스터 SEQ',
	CODE				VARCHAR(12)		PRIMARY KEY					COMMENT 'CODE 값(최대 5뎁스까지)',
	GROUP_ID			VARCHAR(20)		NOT NULL					COMMENT	'CODE 그룹 ID(CODE_GROUP_0001)',
	PARENT_CODE			VARCHAR(12)									COMMENT '부모 CODE ID',
	DEPTH				INT(1)			DEFAULT 1					COMMENT '분류 DEPTH(1 : 최상위 개념)',
	NAME				VARCHAR(255)								COMMENT '코드명',
	INPUT_TYPE			VARCHAR(20)									COMMENT '화면에 체크박스(checkbox) 또는 라디오(radio)로 보여줌 부모 타입에만 적용',
	BG_COLOR			VARCHAR(20)									COMMENT '화면에 보여줄때 코드별로 배경색 지정 가능',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '그룹 코드 별 DEPTH 별 순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='CODE TABLE';

INSERT INTO FF_CODE
	( CODE, GROUP_ID, NAME, REG_USER, REG_DATE, UPD_USER, UPD_DATE )
VALUES
	( 'M001', 'member', '관리자', 'admin', DATE_FORMAT(NOW(),'%Y%m%d%H%i%s'), 'admin', DATE_FORMAT(NOW(),'%Y%m%d%H%i%s') )