CREATE TABLE CB_SEQUENCE
(
	SEQ_NAME 	varchar(30) 	NOT NULL COMMENT '시퀀스명',
	SEQ 		int DEFAULT 1 	NOT NULL COMMENT '시퀀스',
	UPD_YMD 	varchar(8) 		NOT NULL COMMENT '갱신일(YYYYMMDD)',
	PRIMARY KEY (SEQ_NAME)
) ENGINE = InnoDB COMMENT = '테이블기반시퀀스';
