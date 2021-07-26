package com.changbi.tt.dev.data.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.changbi.tt.dev.data.dao.BasicDAO;
import com.changbi.tt.dev.data.vo.BannerVO;
import com.changbi.tt.dev.data.vo.ComCodeGroupVO;
import com.changbi.tt.dev.data.vo.ComCodeVO;
import com.changbi.tt.dev.data.vo.EventVO;
import com.changbi.tt.dev.data.vo.InfoVO;
import com.changbi.tt.dev.data.vo.IpAddressVO;
import com.changbi.tt.dev.data.vo.PolicyDelayCancelVO;
import com.changbi.tt.dev.data.vo.PolicyPointVO;
import com.changbi.tt.dev.data.vo.SchoolVO;

import forFaith.dev.dao.AttachFileDAO;
import forFaith.dev.vo.AttachFileVO;
import forFaith.util.StringUtil;

@Service(value="data.basicService")
public class BasicService {

	@Autowired
	private BasicDAO basicDao;
	
	@Autowired
    private AttachFileDAO fileDao;
	
	// 학교 리스트
	public List<SchoolVO> schoolList(SchoolVO school) throws Exception{
		return basicDao.schoolList(school);
	}

	// 학교 리스트 총 갯수
    public int schoolTotalCnt(SchoolVO school) throws Exception {
        return basicDao.schoolTotalCnt(school);
    }

	// 학교 상세
	public SchoolVO schoolInfo(SchoolVO school) throws Exception {
	    return basicDao.schoolInfo(school);
	}

	// 학교 등록
	public void schoolReg(SchoolVO school) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		basicDao.schoolReg(school);
	}

	// 학교 삭제
	public int schoolDel(SchoolVO school) throws Exception{
		return basicDao.schoolDel(school);
	}

	// 연수자 IP 정보 리스트
	public List<IpAddressVO> ipList(IpAddressVO ipAddress) throws Exception {
		return basicDao.ipList(ipAddress);
	}

	// 연수자 IP 정보 리스트 총 갯수
	public int ipTotalCnt(IpAddressVO ipAddress) throws Exception {
		return basicDao.ipTotalCnt(ipAddress);
	}
	
	// 연수자 IP 정보 상세 리스트
	public List<IpAddressVO> ipInfoList(IpAddressVO ipAddress) throws Exception {
		return basicDao.ipInfoList(ipAddress);
	}
	
	// 연수자 IP 삭제
	public int ipDel(IpAddressVO ipAddress) throws Exception {
		return basicDao.ipDel(ipAddress);
	}
	
	// 포인트 정책 정보 조회
	public PolicyPointVO policyPointInfo() throws Exception {
	    return basicDao.policyPointInfo();
	}
	
	// 포인트 정책 정보 등록(수정)
	public void policyPointReg(PolicyPointVO policyPoint) throws Exception {
		// ID 가 존재하지 않으면 저장 있으면 update
		basicDao.policyPointReg(policyPoint);
	}
	
	// 수강 연기/취소 정책 정보 조회
	public PolicyDelayCancelVO policyDelayCancelInfo(PolicyDelayCancelVO policyDelayCancel) throws Exception {
		return basicDao.policyDelayCancelInfo(policyDelayCancel);
	}
		
	// 수강 연기/취소 정책 정보 등록(수정)
	public void policyDelayCancelReg(PolicyDelayCancelVO policyDelayCancel) throws Exception {
		basicDao.policyDelayCancelReg(policyDelayCancel);
	}
	
	// 이벤트 정보 리스트
	public List<EventVO> eventList(EventVO event) throws Exception {
		return basicDao.eventList(event);
	}
	
	// 이벤트 정보 리스트 총 갯수
	public int eventTotalCnt(EventVO event) throws Exception {
		return basicDao.eventTotalCnt(event);
	}
	
	// 이벤트 정보 상세
	public EventVO eventInfo(EventVO event) throws Exception {
		return basicDao.eventInfo(event);
	}
	
	// 이벤트 정보 편집
	public void eventReg(EventVO event) throws Exception {
		basicDao.eventReg(event);
		
		if(event.getId() > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(event.getImg1() != null && !StringUtil.isEmpty(event.getImg1().getFileId())) {
 				attachFileList.add(event.getImg1());
 			}
            
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
	}
	
	// 이벤트 정보 삭제
	public int eventDel(EventVO event) throws Exception{
		return basicDao.eventDel(event);
	}
	
	// 배너 정보 리스트
	public List<BannerVO> bannerList(BannerVO banner) throws Exception {
		return basicDao.bannerList(banner);
	}
	
	// 배너 정보 리스트 총 갯수
	public int bannerTotalCnt(BannerVO banner) {
		return basicDao.bannerTotalCnt(banner);
	}
	
	// 메인 배너 순서 리스트
	public ArrayList<Integer> bannerOdList() throws Exception {
		return basicDao.bannerOdList();
	}
	
	// 메인 배너 순서 변경
	public void bannerOdUpdate(HashMap<String, Object> map){
		basicDao.bannerOdUpdate(map);
	}
	
	// 배너 사용여부, 순서 변경
	public int bannerState(BannerVO banner) throws Exception{
		return basicDao.bannerState(banner);
	}
	
	// 배너 정보 상세
	public BannerVO bannerInfo(BannerVO banner) throws Exception {
		return basicDao.bannerInfo(banner);
	}
	
	// 배너 정보 등록
	public void bannerReg(BannerVO banner) throws Exception {
		basicDao.bannerReg(banner);
		
		if(banner.getId() > 0) {
        	// 파일 사용 가능 상태로 변경 처리
            // useYn을 Y로 바꾼다.
            List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
            
 			if(banner.getImg1() != null && !StringUtil.isEmpty(banner.getImg1().getFileId())) {
 				attachFileList.add(banner.getImg1());
 			}
            
			// 파일 사용 가능 상태로 변경
			if(attachFileList.size() > 0) {
				fileDao.attachFileUse(attachFileList);
			}
        }
	}
	
	// 배너 정보 삭제
	public int bannerDel(BannerVO banner) throws Exception {
		return basicDao.bannerDel(banner);
	}
	
	// 안내페이지 정보 리스트
	public List<InfoVO> infoList(InfoVO info) throws Exception {
		return basicDao.infoList(info);
	}
	
	// 안내페이지 정보 리스트 총 갯수
	public int infoTotalCnt(InfoVO info) throws Exception {
		return basicDao.infoTotalCnt(info);
	}
	
	// 안내페이지 정보 상세
	public InfoVO infoInfo(InfoVO info) throws Exception {
		return basicDao.infoInfo(info);
	}
	
	// 안내페이지 정보 등록(수정)
	public void infoReg(InfoVO info) throws Exception {
		basicDao.infoReg(info);
	}
	
	// 안내페이지 정보 삭제
	public int infoDel(InfoVO info) throws Exception {
		return basicDao.infoDel(info);
	}

	// 공통코드 리스트
	public List<ComCodeGroupVO> comCodeList(ComCodeGroupVO vo) throws Exception {
		return basicDao.comCodeList(vo);
	}

	// 공통 그룹코드 추가
	public int insertGroupCode(ComCodeGroupVO code) {
		return basicDao.insertGroupCode(code);
	}
	
	// 공통 그룹코드 수정
	public int updateGroupCode(ComCodeGroupVO code) {
		return basicDao.updateGroupCode(code);
	}
	
	// 공통코드 수정
	public int updateComCode(ComCodeVO code) {
		return basicDao.updateComCode(code);
	}

	// 공통코드 삭제
	public int deleteComCode(ComCodeVO code) {
		return basicDao.deleteComCode(code);
	}
	
	// 공통코드 추가
	public int insertComCode(ComCodeVO code) {
		return basicDao.insertComCode(code);
	}

	public ArrayList<String> bannerNames() {
		return basicDao.bannerNames();
	}

	public int bannerInsert(HashMap<String, Object> param) {
		return basicDao.bannerInsert(param);
	}
}