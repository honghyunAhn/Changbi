-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_REPORT (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '성적 평가 ID',
	LEARN_APP_ID		INT(12)			NOT NULL					COMMENT '수강신청ID',
	CARDINAL_ID			VARCHAR(12)		NOT NULL					COMMENT '기수 ID',
	COURSE_ID			VARCHAR(12)		NOT NULL					COMMENT '과정 ID',
	QUIZ_ID				VARCHAR(20)		NOT NULL					COMMENT '시험 ID',
	USER_ID				VARCHAR(20)		NOT NULL					COMMENT '평가대상 ID',
	QUIZ_TYPE			CHAR(1)			DEFAULT '2'					COMMENT '시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)',
	EXAM_SPOT_ID		VARCHAR(3)									COMMENT '출석시험 시 고사장ID(3자리로 고정)',
	EXAM_NUM			VARCHAR(8)									COMMENT '출석시험 수험번호(고사장코드(3)+교시(1)+일련번호(4) : 총 8자리)',
	ANSWER				VARCHAR(200)								COMMENT '출석시험 문제답안(답안OX : OOOXOOOOXOXXXXOOOOOOXXXOXOO 또는 1O2X3O4O5X6X7X8O)',
	USER_FILE_ID		VARCHAR(20) 								COMMENT '출석시험 증명사진',
	FILE_ID				VARCHAR(20)									COMMENT '온라인과제 답안 파일ID(과제의 정답을 파일로 제출한 경우 저장)',
	CORRECT				TEXT										COMMENT '온라인과제 첨삭강사가 첨삭을 넣을 수 있음',
	SCORE				INT(3)			DEFAULT 0					COMMENT '시험 종류별 점수',
	MARK_YN				CHAR(1)			DEFAULT 'N'					COMMENT '채점여부(Y/N)',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험 문제 성적 평가 테이블';