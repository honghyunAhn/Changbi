-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE FF_NOTICE (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '게시글 마스터 ID(SEQ로 ID저장)',
	LANG				CHAR(2)			DEFAULT 'ko'	NOT NULL	COMMENT '다국어 코드(ko:한국어, en:영어, zh:중국어, ja:일본어)',
	BOARD_ID			VARCHAR(20)		NOT NULL					COMMENT	'게시판 관리 UNIQUE ID',
	UPLOAD_FILE			VARCHAR(20)									COMMENT '업로드 파일 ID',
	NOTICE_CODE			VARCHAR(20)									COMMENT '게시물 구분 코드 ID',
	INQUIRY_CODE		VARCHAR(20)									COMMENT '문의 구분 코드 ID',
	TITLE				VARCHAR(255)								COMMENT '게시물 제목',
	NAME				VARCHAR(50)									COMMENT '이름',
	PHONE				VARCHAR(20)									COMMENT '연락처',
	EMAIL				VARCHAR(100)								COMMENT '이메일주소',
	COMMENT				MEDIUMTEXT									COMMENT '게시물 내용',
	HITS				INT(8)			DEFAULT 0					COMMENT '조회수',
	RECOMMEND			INT(8)			DEFAULT 0					COMMENT '추천수',
	NONRECOMMEND		INT(8)			DEFAULT 0					COMMENT '비추천수',
	SHARE				INT(8)			DEFAULT 0					COMMENT '공유횟수',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT 'DISPLAY순서(게시판 기준으로 ORDER)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='NOTICE MASTER TABLE';