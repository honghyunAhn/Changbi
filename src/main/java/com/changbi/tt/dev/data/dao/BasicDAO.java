package com.changbi.tt.dev.data.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.changbi.tt.dev.data.vo.BannerVO;
import com.changbi.tt.dev.data.vo.ComCodeGroupVO;
import com.changbi.tt.dev.data.vo.ComCodeVO;
import com.changbi.tt.dev.data.vo.EventVO;
import com.changbi.tt.dev.data.vo.InfoVO;
import com.changbi.tt.dev.data.vo.IpAddressVO;
import com.changbi.tt.dev.data.vo.PolicyDelayCancelVO;
import com.changbi.tt.dev.data.vo.PolicyPointVO;
import com.changbi.tt.dev.data.vo.SchoolVO;

public interface BasicDAO {

	// 학교 정보 리스트
	List<SchoolVO> schoolList(SchoolVO school) throws Exception;
	
	// 학교 정보 리스트 총 갯수
	int schoolTotalCnt(SchoolVO school) throws Exception;
	
	// 학교 정보 상세
	SchoolVO schoolInfo(SchoolVO school) throws Exception;
	
	// 학교 정보 편집
	void schoolReg(SchoolVO school) throws Exception;
	
	// 학교 정보 삭제
	int schoolDel(SchoolVO school) throws Exception;

	// 연수자 IP 정보 리스트
	List<IpAddressVO> ipList(IpAddressVO ipAddress) throws Exception;
	
	// 연수자 IP 정보 리스트 총 갯수
	int ipTotalCnt(IpAddressVO ipAddress) throws Exception;
	
	// 연수자 IP 정보 상세 리스트
	List<IpAddressVO> ipInfoList(IpAddressVO ipAddress) throws Exception;
	
	// 연수자 IP 삭제
	int ipDel(IpAddressVO ipAddress) throws Exception;
	
	// 포인트 정책 정보
	PolicyPointVO policyPointInfo() throws Exception;
	
	// 포인트 정책 정보 등록(수정)
	void policyPointReg(PolicyPointVO policyPoint) throws Exception;
	
	// 수강 연기/취소 정책 정보
	PolicyDelayCancelVO policyDelayCancelInfo(PolicyDelayCancelVO policyDelayCancel) throws Exception;
	
	// 수강 연기/취소 정책 정보 등록(수정)
	void policyDelayCancelReg(PolicyDelayCancelVO policyDelayCancel) throws Exception;
	
	// 이벤트 정보 리스트
	List<EventVO> eventList(EventVO event) throws Exception;
	
	// 이벤트 정보 리스트 총 갯수
	int eventTotalCnt(EventVO event) throws Exception;
	
	// 이벤트 정보 상세
	EventVO eventInfo(EventVO event) throws Exception;
	
	// 이벤트 정보 편집
	void eventReg(EventVO event) throws Exception;
	
	// 이벤트 정보 삭제
	int eventDel(EventVO event) throws Exception;
	
	// 배너 정보 리스트
	List<BannerVO> bannerList(BannerVO banner) throws Exception;
	
	// 배너 정보 리스트 총 갯수
	int bannerTotalCnt(BannerVO banner);
	
	// 메인 배너 순서 리스트
	public ArrayList<Integer> bannerOdList() throws Exception;
	
	// 메인 배너 순서 변경
	public void bannerOdUpdate(HashMap<String, Object> map);
	
	// 배너 사용여부 변경
	int bannerState(BannerVO banner) throws Exception;
	
	// 배너 정보 상세
	BannerVO bannerInfo(BannerVO banner) throws Exception;
	
	// 배너 정보 등록
	void bannerReg(BannerVO banner) throws Exception;
	
	// 배너 정보 삭제
	int bannerDel(BannerVO banner) throws Exception;
	
	// 안내페이지 정보 리스트
	List<InfoVO> infoList(InfoVO info) throws Exception;
	
	// 안내페이지 정보 리스트 총 갯수
	int infoTotalCnt(InfoVO info) throws Exception;
	
	// 안내페이지 정보 상세
	InfoVO infoInfo(InfoVO info) throws Exception;
	
	// 안내페이지 정보 등록(수정)
	void infoReg(InfoVO info) throws Exception;
	
	// 안내페이지 정보 삭제
	int infoDel(InfoVO info) throws Exception;

	// 공통코드 리스트
	List<ComCodeGroupVO> comCodeList(ComCodeGroupVO vo) throws Exception;

	// 공통 그룹코드 추가
	int insertGroupCode(ComCodeGroupVO code);
	
	// 공통 그룹코드 수정
	int updateGroupCode(ComCodeGroupVO code);
	
	// 공통코드 수정
	int updateComCode(ComCodeVO code);
	
	// 공통코드 삭제
	int deleteComCode(ComCodeVO code);

	// 공통코드 추가
	int insertComCode(ComCodeVO code);

	ArrayList<String> bannerNames();
	
	// 배너 추가
	int bannerInsert(HashMap<String, Object> param);
}