-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_SURVEY_REPLY (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '문항 ID',
	SURVEY_ID			VARCHAR(14)		NOT NULL					COMMENT '설문 마스터 ID',
	ITEM_ID				INT(12)			NOT NULL					COMMENT '설문 문항 ID',
	ITEM_TYPE			CHAR(1)			DEFAULT '1'					COMMENT '문항유형(1:객관식, 2:주관식, 3:객관+주관식)',
	EXAM1_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 1번 선택여부(Y/N)',
	EXAM2_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 2번 선택여부(Y/N)',
	EXAM3_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 3번 선택여부(Y/N)',
	EXAM4_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 4번 선택여부(Y/N)',
	EXAM5_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 5번 선택여부(Y/N)',
	EXAM6_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 6번 선택여부(Y/N)',
	EXAM7_YN			CHAR(1)			DEFAULT 'N'					COMMENT '객관식 또는 객관+주관식 일때 7번 선택여부(Y/N)',
	EXAM1				VARCHAR(500)								COMMENT '객관+주관식 1번 답변',
	EXAM2				VARCHAR(500)								COMMENT '객관+주관식 2번 답변',
	EXAM3				VARCHAR(500)								COMMENT '객관+주관식 3번 답변',
	EXAM4				VARCHAR(500)								COMMENT '객관+주관식 4번 답변',
	EXAM5				VARCHAR(500)								COMMENT '객관+주관식 5번 답변',
	EXAM6				VARCHAR(500)								COMMENT '객관+주관식 6번 답변',
	EXAM7				VARCHAR(500)								COMMENT '객관+주관식 7번 답변',
	ANSWER				VARCHAR(500)								COMMENT '주관식인 경우 답변',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '문항번호',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y/N)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='설문 문항 답변 TABLE';