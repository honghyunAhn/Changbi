-- DATETIME에 DEFAULT CURRENT_TIMESTAMP 는 mysql 5.6버전 이상부터 가능
-- AUTO_INCREMENT 와 DEFAULT 는 5버전 이상부터는 같이 사용 불가
CREATE TABLE CB_SCHOOL (
	ID					INT(12)			AUTO_INCREMENT	PRIMARY KEY	COMMENT '학교 관리 ID',
	S_TYPE				CHAR(1)										COMMENT '학교구분(1:초등, 2:중학교, 3:고등학교, 4:유치원, 5:특수학교, 6:기관)',
	E_TYPE				CHAR(1)										COMMENT '설립구분(1:국립, 2:공립, 3:사립)',
	NAME				VARCHAR(100)								COMMENT '학교(기관)명',
	REGION_CODE			VARCHAR(12)									COMMENT '지역 시도 교육청 분류 코드',
	JURISDICTION		VARCHAR(20)									COMMENT '관할',
	TEL					VARCHAR(50)									COMMENT '연락처',
	FAX					VARCHAR(50)									COMMENT '팩스',
  	POST_CODE 			VARCHAR(8) 									COMMENT '우편번호(신:5자리, 구:6자리)',
  	ADDR1 				VARCHAR(200)								COMMENT '주소1: 우편번호에 연결된 주소',
  	ADDR2 				VARCHAR(200) 								COMMENT '주소2: 상세주소 (사용자 입력)'
) COMMENT='학교 관리 테이블';