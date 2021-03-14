-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_QUIZ (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '시험 SEQ',
	ID					VARCHAR(20)		PRIMARY KEY					COMMENT '시험 마스터 ID',
	CARDINAL_ID			VARCHAR(12)		NOT NULL					COMMENT '기수 ID',
	COURSE_ID			VARCHAR(12)		NOT NULL					COMMENT '과정 ID',
	QUIZ_POOL_ID		INT(12)			NOT NULL					COMMENT '시험지 풀 ID',
	TITLE				VARCHAR(100)	NOT NULL					COMMENT '시험지 명',
	QUIZ_TYPE			CHAR(1)			DEFAULT '2'					COMMENT '시험 종류(1:출석고사, 2:온라인평가, 3:온라인과제)',
	START_DATE			VARCHAR(10)									COMMENT '시험기간 시작 일자',
	END_DATE			VARCHAR(10)									COMMENT '시험기간 종료 일자',
	EXAM_TIME			INT(3)			DEFAULT 100					COMMENT '시험시간(분)',
	SCORE				INT(3)			DEFAULT 100					COMMENT '만점 점수(총문제수로 나누면 문제당 점수가 나옴)',
	GUIDE				TEXT										COMMENT '시험안내글',
	RETRY				INT(1)			DEFAULT 0					COMMENT '재응시 횟수',
	LIMITS				VARCHAR(20)									COMMENT '제한기능 복수선택(1:시간제한사용, 2:재응시허용, 3:타PC작업제한)',
	LIMIT_KEYS			VARCHAR(20)									COMMENT '제한 키 복수선택(1:CTRL+C, 2:CTRL+P, 3:CTRL-V, 4:우마우스클릭)',
	OPEN_YN				CHAR(1)			DEFAULT 'N'					COMMENT '답안공개여부(Y/N)',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서(필요없음)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '시험상태(Y : 응시, N : 미응시)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	DATETIME		DEFAULT CURRENT_TIMESTAMP()	COMMENT '수정일자'
) COMMENT='시험 관리 테이블';