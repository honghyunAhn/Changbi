CREATE TABLE FF_CODE_GROUP (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '코드 그룹 관리 SEQ',
	ID					VARCHAR(20)		PRIMARY KEY					COMMENT 'CODE 그룹 ID',
	NAME				VARCHAR(255)	NOT NULL					COMMENT 'CODE 그룹 명',
	COMMENT				VARCHAR(255)								COMMENT 'CODE 그룹 설명',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '분류 그룹 별 순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='CODE GROUP TABLE(분류 코드 관리)';

-- 회원 그룹 코드 그룹
INSERT INTO FF_CODE_GROUP (ID, NAME, COMMENT) VALUES ('member', '사용자 분류', '멤버 코드 그룹');

-- 부서 코드 그룹
INSERT INTO FF_CODE_GROUP (ID, NAME, COMMENT) VALUES ('department', '부서 분류', '부서 코드 그룹');

-- 게시판 유형 코드 그룹
INSERT INTO FF_CODE_GROUP (ID, NAME, COMMENT) VALUES ('board', '게시판 분류', '게시판 유형 코드 그룹');

-- 게시물 구분 코드
INSERT INTO FF_CODE_GROUP (ID, NAME, COMMENT) VALUES ('notice', '게시물 분류', '게시물 구분 코드 그룹');

-- 지역 코드 그룹
INSERT INTO FF_CODE_GROUP (ID, NAME, COMMENT) VALUES ('region', '지역 분류', '지역 코드 그룹');