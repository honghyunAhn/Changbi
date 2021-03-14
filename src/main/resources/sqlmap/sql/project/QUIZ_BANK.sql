-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_QUIZ_BANK (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '문제 뱅크 ID',
	COURSE_ID			VARCHAR(12)		NOT NULL					COMMENT '과정 ID',
	QUIZ_TYPE			CHAR(1)			DEFAULT '2'					COMMENT '시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)',
	CLASS_TYPE			CHAR(1)										COMMENT '문제유형(A:A형, B:B형, C:C형)',
	TITLE				VARCHAR(2000)	NOT NULL					COMMENT '문제명',
	OS_TYPE				CHAR(1)			DEFAULT 'O'					COMMENT '문항종류(O:객관식, S:주관식)',
	EXAM_TYPE			CHAR(1)			DEFAULT '1'					COMMENT '객관식 유형(1:4지선다, 2:5지선다)',
	EXAM1				VARCHAR(2000)								COMMENT '객관식 1번 보기',
	EXAM2				VARCHAR(2000)								COMMENT '객관식 2번 보기',
	EXAM3				VARCHAR(2000)								COMMENT '객관식 3번 보기',
	EXAM4				VARCHAR(2000)								COMMENT '객관식 4번 보기',
	EXAM5				VARCHAR(2000)								COMMENT '객관식 5번 보기',
	CATEGORY			VARCHAR(10)									COMMENT '문항척도분류코드',
	CATE_NAME			VARCHAR(50)									COMMENT '문항척도분류명',
	COMMENT				TEXT										COMMENT '보충해설',
	QUIZ_LEVEL			INT(1)			DEFAULT 1					COMMENT '퀴즈 난이도(1:하, 2:중, 3:상)',
	O_ANSWER			INT(1)			DEFAULT 1					COMMENT '객관식 정답',
	S_ANSWER			TEXT										COMMENT '주관식 정답',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험 문제 뱅크 관리 테이블';