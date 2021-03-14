-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_NOTE (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '쪽지 ID',
	FROM_USER_ID		VARCHAR(100)	NOT NULL					COMMENT '보낸사람(admin 인 경우 관리자)',
	TO_USER_ID			VARCHAR(100)	NOT NULL					COMMENT '받은사람(admin 인 경우 관리자)',
	TITLE				VARCHAR(100)	NOT NULL					COMMENT '제목',
	NOTE				TEXT										COMMENT '쪽지내용',
	SAVE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '보낸쪽지함에 저장??',
	PROC_YN				CHAR(1)			DEFAULT 'N'					COMMENT '처리상태(Y:읽음,N:안읽음)',
	FROM_USER_USE_YN	CHAR(1)			DEFAULT 'Y'					COMMENT '발송인쪽지사용여부(삭제여부)',
	TO_USER_USE_YN		CHAR(1)			DEFAULT 'Y'					COMMENT '수신인쪽지사용여부(삭제여부)',
	SEND_DATE			VARCHAR(14)									COMMENT '발신일시'
) COMMENT='쪽지함 관리 테이블';