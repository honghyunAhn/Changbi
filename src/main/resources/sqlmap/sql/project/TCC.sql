-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_TCC (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT 'TCC ID(삭제 시 사용)',
	TEACHER_ID			VARCHAR(100)								COMMENT '강사ID',
	TITLE				VARCHAR(100)								COMMENT '영상제목',
	URL					VARCHAR(500)								COMMENT '영상파일URL',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT 'DISPLAY순서(게시판 기준으로 ORDER)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '게시유무(Y : 게시함, N : 게시안함)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='강사 TCC 관리 테이블';