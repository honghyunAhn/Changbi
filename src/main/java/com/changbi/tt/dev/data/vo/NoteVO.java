package com.changbi.tt.dev.data.vo;

import forFaith.dev.vo.CommonVO;

@SuppressWarnings("serial")
public class NoteVO extends CommonVO {
	// 검색조건
    private NoteVO search;
    
    private int id; // 쪽지 ID
    private String fromUserId; // 보낸사람(admin 인 경우 관리자)
    private String toUserId; // 받은사람(admin 인 경우 관리자)
    private String title; // 제목
    private String note; // 쪽지내용
    private String saveYn = "N"; // 보낸쪽지함에 저장??
    private String procYn = "N"; // 처리상태(Y:읽음,N:안읽음)
    private String fromUserUseYn = "Y"; // 발송인쪽지사용여부(삭제여부)
    private String toUserUseYn = "Y"; // 수신인쪽지사용여부(삭제여부)
    private String sendDate; // 발신일시

    private String[] toUserIds;
    
	public NoteVO getSearch() {
		return search;
	}
	public void setSearch(NoteVO search) {
		this.search = search;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFromUserId() {
		return fromUserId;
	}
	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId;
	}
	public String getToUserId() {
		return toUserId;
	}
	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getSaveYn() {
		return saveYn;
	}
	public void setSaveYn(String saveYn) {
		this.saveYn = saveYn;
	}
	public String getProcYn() {
		return procYn;
	}
	public void setProcYn(String procYn) {
		this.procYn = procYn;
	}
	public String getFromUserUseYn() {
		return fromUserUseYn;
	}
	public void setFromUserUseYn(String fromUserUseYn) {
		this.fromUserUseYn = fromUserUseYn;
	}
	public String getToUserUseYn() {
		return toUserUseYn;
	}
	public void setToUserUseYn(String toUserUseYn) {
		this.toUserUseYn = toUserUseYn;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String[] getToUserIds() {
		return toUserIds;
	}
	public void setToUserIds(String[] toUserIds) {
		this.toUserIds = toUserIds;
	}
	
	/*public List<UserVO> getUserList() {
		List<UserVO> result = new ArrayList<UserVO>();
		
		if(!StringUtil.isEmpty(this.userIds)) {
			String[] memIdArr = this.userIds.split(",");
			
			for(int i=0; i<memIdArr.length; ++i) {
				String memId = memIdArr[i];
				UserVO temp = new UserVO();
				
				temp.setId(memId);
				
				result.add(temp);
			}
		}
		
		return result;
	}*/
}
