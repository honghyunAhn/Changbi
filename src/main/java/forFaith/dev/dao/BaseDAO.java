package forFaith.dev.dao;

import java.util.HashMap;
import java.util.List;

import forFaith.dev.vo.CodeGroupVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;

public interface BaseDAO {

	// 로그인 조회
    MemberVO actionLogin(MemberVO member) throws Exception;

	// 멤버 리스트 조회
	List<MemberVO> memberList(MemberVO member) throws Exception;

	// 멤버 리스트 총 갯수
	int memberTotalCnt(MemberVO member) throws Exception;

	// 멤버 조회
	MemberVO memberInfo(MemberVO member) throws Exception;

	// 멤버 등록
    void memberReg(MemberVO member) throws Exception;

    // 멤버 그룹 등록
    int memberGroupReg(MemberVO member) throws Exception;

	// 멤버 삭제
	int memberDel(MemberVO member) throws Exception;

	// 멤버 그룹 삭제
    int memberGroupDel(MemberVO member) throws Exception;

	// 멤버 사용여부 변경
	int memberUseChange(List<MemberVO> memberList) throws Exception;

	// 멤버 ID 중복 체크
	int memberIdCheck(MemberVO member) throws Exception;

	// 멤버 로그인 업데이트
	int memberLoginUpd(MemberVO member) throws Exception;
	
	// 관리자 로그인 히스토리 저장
	void memberLoginHistory(MemberVO member) throws Exception;

	// 코드분류 그룹리스트
    List<CodeGroupVO> codeGroupList(CodeGroupVO codeGroup) throws Exception;

    // 코드 조건에 해당하는 코드 분류 그룹 리스트 토탈 갯수
    int codeGroupTotalCnt(CodeGroupVO codeGroup) throws Exception;

    // 코드 분류 그룹 정보 조회
    CodeGroupVO codeGroupInfo(CodeGroupVO codeGroup) throws Exception;
    
    // 코드 분류 그룹 등록
    void codeGroupReg(CodeGroupVO codeGroup) throws Exception;
    
    // 코드 분류 그룹 삭제
    int codeGroupDel(CodeGroupVO codeGroup) throws Exception;

	// 코드 조건에 해당하는 코드 리스트 조회(자식 코드까지 전부 검색해서 가져간다)
    List<CodeVO> codeList(CodeVO code) throws Exception;
    
	// 대중소분류 코드 리스트 조회
    List<CodeVO> cateCodeList() throws Exception;

    // 코드 조건에 해당하는 코드 리스트 총 갯수
    int codeTotalCnt(CodeVO code) throws Exception;

    // 코드 ID에 해당하는 코드 정보 조회
    CodeVO codeInfo(CodeVO code) throws Exception;
    
    // 코드 ID에 해당하는 코드 정보 조회(String)
    CodeVO codeInfoByString(String searchCode) throws Exception;

    // 코드 등록
    void codeReg(CodeVO code) throws Exception;
   
    // 대중소 코드 등록시 사용되는 시퀀스 생성
    void makeCategorySequence() throws Exception;
    
    // 대중소 코드 등록시 사용되는 시퀀스 검색
    String selectCategorySequence() throws Exception;

    int codeYnUpt(HashMap<String,String> code) throws Exception;
    
    // 코드 삭제
    int codeDel(CodeVO code) throws Exception;

    // 코드 사용 유무 변경
    int codeUseChange(List<CodeVO> codeList) throws Exception;
}