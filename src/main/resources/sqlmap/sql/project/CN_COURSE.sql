-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_CN_COURSE (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '기수 과정 매핑 SEQ',
	CARDINAL_ID			VARCHAR(12)									COMMENT '기수 관리 ID',
	COURSE_ID			VARCHAR(12)									COMMENT '과정 관리 ID',
	PRIMARY KEY(CARDINAL_ID, COURSE_ID)
) COMMENT='기수별 과정 지정 테이블';