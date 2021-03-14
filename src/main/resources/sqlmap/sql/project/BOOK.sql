-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_BOOK (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '교재 마스터 ID',
	NAME				VARCHAR(100)								COMMENT '교재명',
	SUPPLY_CODE			VARCHAR(12)									COMMENT '교재업체 코드',
	MAIN_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '주교재 여부',
	PRICE				INT(10)			DEFAULT 0					COMMENT '교재가격',
	AUTHOR				VARCHAR(50)									COMMENT '저자',
	MEMO				TEXT										COMMENT '교재설명',
	IMG1_FILE			VARCHAR(20)									COMMENT '이미지1',
	IMG2_FILE			VARCHAR(20)									COMMENT '이미지2',
	STOCK				INT(10)			DEFAULT 0					COMMENT '재고수량',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서(필요없음)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='교재 관리 테이블';