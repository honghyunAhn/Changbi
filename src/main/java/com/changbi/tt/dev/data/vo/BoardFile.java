package com.changbi.tt.dev.data.vo;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;


public class BoardFile {
	/**
	 * 공통 게시판 게시물 파일 시퀀스
	 */
	private int board_file_seq;

	/**
	 * 공통 게시판 게시물 시퀀스 ( BoardContent 클래스의 board_content_seq 참조 )
	 */
	private int board_content_seq;

	/**
	 * 공통 게시판 게시물 파일 저장 이름
	 */
	private String board_file_saved;

	/**
	 * 공통 게시판 게시물 파일 원본 이름
	 */
	private String board_file_origin;

	/**
	 * 공통 게시판 게시물 파일 등록 일자
	 */
	private String board_ins_dt;

	/**
	 * 공통 게시판 게시물 파일 등록인
	 */
	private String board_ins_id;

	/**
	 * 공통 게시판 게시물 파일 수정 일자
	 */
	private String board_udt_dt;

	/**
	 * 공통 게시판 게시물 파일 수정인
	 */
	private String board_udt_id;

	/**
	 * 공통 게시판 첨부 파일
	 */
	private CommonsMultipartFile board_file;

	/**
	 * 공통 게시판 파일 리스트
	 */
	private List<BoardFile> boardFileList;

	/**
	 * @Desc :
	 */
	public BoardFile() {
		super();
	}

	/**
	 * @Desc :
	 * @param board_file_seq
	 * @param board_content_seq
	 * @param board_file_saved
	 * @param board_file_origin
	 * @param board_ins_dt
	 * @param board_ins_id
	 * @param board_udt_dt
	 * @param board_udt_id
	 * @param board_file
	 * @param boardFileList
	 */
	public BoardFile(int board_file_seq, int board_content_seq, String board_file_saved, String board_file_origin,
			String board_ins_dt, String board_ins_id, String board_udt_dt, String board_udt_id,
			CommonsMultipartFile board_file, List<BoardFile> boardFileList) {
		super();
		this.board_file_seq = board_file_seq;
		this.board_content_seq = board_content_seq;
		this.board_file_saved = board_file_saved;
		this.board_file_origin = board_file_origin;
		this.board_ins_dt = board_ins_dt;
		this.board_ins_id = board_ins_id;
		this.board_udt_dt = board_udt_dt;
		this.board_udt_id = board_udt_id;
		this.board_file = board_file;
		this.boardFileList = boardFileList;
	}

	public int getBoard_file_seq() {
		return board_file_seq;
	}

	public void setBoard_file_seq(int board_file_seq) {
		this.board_file_seq = board_file_seq;
	}

	public int getBoard_content_seq() {
		return board_content_seq;
	}

	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}

	public String getBoard_file_saved() {
		return board_file_saved;
	}

	public void setBoard_file_saved(String board_file_saved) {
		this.board_file_saved = board_file_saved;
	}

	public String getBoard_file_origin() {
		return board_file_origin;
	}

	public void setBoard_file_origin(String board_file_origin) {
		this.board_file_origin = board_file_origin;
	}

	public String getBoard_ins_dt() {
		return board_ins_dt;
	}

	public void setBoard_ins_dt(String board_ins_dt) {
		this.board_ins_dt = board_ins_dt;
	}

	public String getBoard_ins_id() {
		return board_ins_id;
	}

	public void setBoard_ins_id(String board_ins_id) {
		this.board_ins_id = board_ins_id;
	}

	public String getBoard_udt_dt() {
		return board_udt_dt;
	}

	public void setBoard_udt_dt(String board_udt_dt) {
		this.board_udt_dt = board_udt_dt;
	}

	public String getBoard_udt_id() {
		return board_udt_id;
	}

	public void setBoard_udt_id(String board_udt_id) {
		this.board_udt_id = board_udt_id;
	}

	public CommonsMultipartFile getBoard_file() {
		return board_file;
	}

	public void setBoard_file(CommonsMultipartFile board_file) {
		this.board_file = board_file;
	}

	public List<BoardFile> getBoardFileList() {
		return boardFileList;
	}

	public void setBoardFileList(List<BoardFile> boardFileList) {
		this.boardFileList = boardFileList;
	}

	@Override
	public String toString() {
		return "BoardFile [board_file_seq=" + board_file_seq + ", board_content_seq=" + board_content_seq
				+ ", board_file_saved=" + board_file_saved + ", board_file_origin=" + board_file_origin
				+ ", board_ins_dt=" + board_ins_dt + ", board_ins_id=" + board_ins_id + ", board_udt_dt=" + board_udt_dt
				+ ", board_udt_id=" + board_udt_id + ", board_file=" + board_file + ", boardFileList=" + boardFileList
				+ "]";
	}
}
