-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_COUPON (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT 'COUPON ID',
	COUPON_NUM			VARCHAR(20)		UNIQUE						COMMENT '쿠폰번호',
	USER_ID				VARCHAR(100)								COMMENT '수강자ID',
	COURSE_ID			VARCHAR(12)									COMMENT '적용과정ID',
	COND				INT(5)			DEFAULT 0					COMMENT '쿠폰조건(50000원 이상 신청 시)',
	COUPON				INT(5)			DEFAULT 0					COMMENT '신청금액 또는 신청 %',
	COUPON_TYPE			CHAR(1)			DEFAULT '1'					COMMENT '적용 단위(1:원 할인, 2:% 할인)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용유무(Y : 사용가능, N : 이미사용)',
	USE_DATE			VARCHAR(10)									COMMENT '사용일자',
	EXP_DATE			VARCHAR(10)									COMMENT '만료기간',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자'
) COMMENT='쿠폰 관리 테이블';