CREATE TABLE FF_ATTACH_FILE (
	SEQ					INT(12)			AUTO_INCREMENT	UNIQUE		COMMENT '파일 마스터 SEQ',
	FILE_ID				VARCHAR(20)		PRIMARY KEY					COMMENT '파일 ID',
	USE_YN				CHAR(1)			DEFAULT 'N'					COMMENT '사용여부(Y : 사용, N : 미사용)',
	REG_USER        	VARCHAR(100)                             	COMMENT '등록자 ID',
	REG_DATE			VARCHAR(14)									COMMENT '등록일자',
  	UPD_USER        	VARCHAR(100)                             	COMMENT '수정자 ID',
	UPD_DATE		  	VARCHAR(14)									COMMENT '수정일자'
) COMMENT='ATTACHFILE MASTER TABLE';