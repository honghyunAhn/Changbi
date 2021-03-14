-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_BOARD_REPLY (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '답글 마스터 ID(SEQ로 ID저장)',
	BOARD_ID			INT(12)			NOT NULL					COMMENT '게시글 ID',
	PARENT_ID			INT(12)										COMMENT '부모 답글 ID(답글에 답글을 다는 경우)',
	USER_ID				VARCHAR(100)								COMMENT '작성자 USER ID(사용자가 답글 남긴 경우)',
	DEPTH				INT(1)			DEFAULT 1					COMMENT '답글 뎁스',
	ATTACH1_FILE		VARCHAR(20)									COMMENT '첨부 #1 파일',
	ATTACH2_FILE		VARCHAR(20)									COMMENT '첨부 #2 파일',
	TITLE				VARCHAR(255)								COMMENT '게시물 제목',
	COMMENT				MEDIUMTEXT									COMMENT '게시물 내용',
	HITS				INT(8)			DEFAULT 0					COMMENT '조회수',
	RECOMMEND			INT(8)			DEFAULT 0					COMMENT '추천수',
	NONRECOMMEND		INT(8)			DEFAULT 0					COMMENT '비추천수',
	SHARE				INT(8)			DEFAULT 0					COMMENT '공유횟수',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT 'DISPLAY순서(게시판 기준으로 ORDER)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '관리자 등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='BOARD REPLY TABLE';