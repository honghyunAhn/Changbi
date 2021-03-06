-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_MAN_COURSE (
	MAN_ID				VARCHAR(100)								COMMENT '관리자 ID',
	COURSE_ID			VARCHAR(12)									COMMENT '과정 ID',
	PERSONS				INT(4)			DEFAULT 0					COMMENT '배당인원',
	PRIMARY KEY(MAN_ID, COURSE_ID)
) COMMENT='관리자 담당 과정 지정 TABLE';