-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_QUIZ_REPLY (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '답안지 ID',
	REPORT_ID			INT(12)			NOT NULL					COMMENT '평가 ID',
	QUIZ_BANK_ID		INT(12)			NOT NULL					COMMENT '문제 은행 ID',
	QUIZ_ITEM_ID		INT(12)			NOT NULL					COMMENT '시험문제 ID',
	OS_TYPE				CHAR(1)			DEFAULT 'O'					COMMENT '문항종류(O:객관식, S:주관식)',
	TITLE				VARCHAR(2000)								COMMENT '문제명',				
	COMMENT				TEXT										COMMENT '보충해설',
	O_ANSWER			INT(1)			DEFAULT 1					COMMENT '객관식 정답',
	S_ANSWER			TEXT										COMMENT '주관식 정답',
	O_REPLY				INT(1)			DEFAULT 1					COMMENT '객관식 본인 답',
	S_REPLY				TEXT										COMMENT '주관식 본인 답',
	P_SCORE				INT(3)			DEFAULT 0					COMMENT '문제 개별 점수(QUIZ 의 SCORE 를 문제수로 나눈 점수)',
	T_SCORE				INT(3)			DEFAULT 0					COMMENT '문제 개별 득점점수',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '문제순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험 문제 답안지 테이블';