-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE FF_BOARD (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '게시판 관리 마스터 SEQ',
	ID					VARCHAR(20)		PRIMARY KEY					COMMENT '게시판 관리 유니크 ID',
	BOARD_TYPE			CHAR(1)			DEFAULT 'N'					COMMENT	'게시판 유형(N:일반게시판, B:블로그, G:갤러리)',
	TITLE				VARCHAR(255)								COMMENT '게시판명',
	ANSWER_YN			CHAR(1)			DEFAULT 'N'					COMMENT '답변여부(Y/N)',
	COMMENT_YN			CHAR(1)			DEFAULT 'Y'					COMMENT '댓글여부(Y/N)',
	RECOMMEND_YN		CHAR(1)			DEFAULT 'N'					COMMENT '추천사용여부(Y/N)',
	NONRECOMMEND_YN		CHAR(1)			DEFAULT 'N'					COMMENT '비추천사용여부(Y/N)',
	SNS_YN				CHAR(1)			DEFAULT 'N'					COMMENT 'SNS 사용여부(Y/N)',
	LIST_AUTH			CHAR(1)			DEFAULT '1'					COMMENT '목록보기 권한(1:모두, 2:회원, 3:관리자)',
	READ_AUTH			CHAR(1)			DEFAULT '1'					COMMENT '글읽기 권한(1:모두, 2:회원, 3:관리자)',
	COMMENT_AUTH		CHAR(1)			DEFAULT '1'					COMMENT '댓글쓰기 권한(1:모두, 2:회원, 3:관리자)',
	WRITE_AUTH			CHAR(1)			DEFAULT '3'					COMMENT '글쓰기 권한(1:모두, 2:회원, 3:관리자)',
	FILE_CNT			INT(2)			DEFAULT 1					COMMENT '업로드 파일 개수',
	FILE_SIZE			INT(4)			DEFAULT 10					COMMENT '업로드 파일 용량(M)',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT 'DISPLAY순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='BOARD MASTER TABLE';