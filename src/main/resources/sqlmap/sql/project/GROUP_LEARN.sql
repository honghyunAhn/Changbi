-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_GROUP_LEARN (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '단체연수관리 ID',
	NAME				VARCHAR(100)								COMMENT '단체연수명',
	START_DATE			VARCHAR(10)									COMMENT '노출기간(시작일)',
	END_DATE			VARCHAR(10)									COMMENT '노출기간(종료일)',
	REGION_CODE			VARCHAR(12)									COMMENT '지역 시도 교육청 분류 코드',
	JURISDICTION		VARCHAR(50)									COMMENT '교육지원청(관할교육청??)',
	PAYMENT_TYPE		CHAR(1)			DEFAULT 'G'					COMMENT '수강료납입(G : 단체일괄납부, S : 개인개별납부)',
	TARGETS				VARCHAR(50)									COMMENT '접수대상(유,초,중,고,특,전문,일반인)-다중',
	BANNER_FILE			VARCHAR(20)									COMMENT '배너이미지',
	CONTENTS			TEXT										COMMENT '컨텐츠 내용',
	PROC_CNT			INT(4)			DEFAULT 0					COMMENT '진행횟수',
	ORDER_NUM			INT(3)			DEFAULT 1					COMMENT '순서(필요없음)',
	USE_YN				CHAR(1)			DEFAULT 'Y'					COMMENT '사용여부(Y : 공개, N : 비공개)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='단체연수관리 TABLE';
