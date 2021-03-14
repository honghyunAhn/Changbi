-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_SURVEY_ITEM (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '설문 문항 ID',
	SURVEY_ID			VARCHAR(14)		NOT NULL					COMMENT '설문 마스터 ID',
	ITEM_TYPE			CHAR(1)			DEFAULT '1'					COMMENT '문항유형(1:객관식, 2:주관식, 3:객관+주관식)',
	SURVEY_CODE			VARCHAR(12)									COMMENT '문항분류코드(기초관리>설문분류)',
	TITLE				VARCHAR(500)								COMMENT '설문문항질문명',
	EXAM1				VARCHAR(200)								COMMENT '객관식 1번 보기',
	EXAM2				VARCHAR(200)								COMMENT '객관식 2번 보기',
	EXAM3				VARCHAR(200)								COMMENT '객관식 3번 보기',
	EXAM4				VARCHAR(200)								COMMENT '객관식 4번 보기',
	EXAM5				VARCHAR(200)								COMMENT '객관식 5번 보기',
	EXAM6				VARCHAR(200)								COMMENT '객관식 6번 보기',
	EXAM7				VARCHAR(200)								COMMENT '객관식 7번 보기',
	EXAM1_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 1번 주관식 처리',
	EXAM2_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 2번 주관식 처리',
	EXAM3_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 3번 주관식 처리',
	EXAM4_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 4번 주관식 처리',
	EXAM5_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 5번 주관식 처리',
	EXAM6_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 6번 주관식 처리',
	EXAM7_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 7번 주관식 처리',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '문항번호',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y/N)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='설문 문항 TABLE';