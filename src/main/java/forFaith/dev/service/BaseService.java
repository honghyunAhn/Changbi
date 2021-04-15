package forFaith.dev.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import forFaith.dev.dao.BaseDAO;
import forFaith.dev.vo.CodeGroupVO;
import forFaith.dev.vo.CodeVO;
import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

@Service(value="forFaith.baseService")
public class BaseService {

	@Autowired
	private BaseDAO baseDao;

	// 멤버 리스트 조회
	public MemberVO actionLogin(MemberVO member) throws Exception {
		return baseDao.actionLogin(member);
	}

	// 멤버 리스트 조회
	public List<MemberVO> memberList(MemberVO member) throws Exception {
		return baseDao.memberList(member);
	}

	// 멤버 리스트 총 갯수
	public int memberTotalCnt(MemberVO member) throws Exception {
		return baseDao.memberTotalCnt(member);
	}

	// 멤버 조회
	public MemberVO memberInfo(MemberVO member) throws Exception {
		return baseDao.memberInfo(member);
	}

	// 멤버 등록
	public void memberReg(MemberVO member) throws Exception {
		// 먼저 ID 중복 체크를 먼저 진행한다.
	    baseDao.memberReg(member);

        if(StringUtil.isEmpty(member.getId())) {
            // 멤버 그룹을 모두 삭제 후 다시 insert
            baseDao.memberGroupDel(member);

            if(member.getMemberGroupList() != null) {
                baseDao.memberGroupReg(member);
            }
        }
	}

	// 멤버 사용 여부 변경
	public int memberUseChange(List<MemberVO> memberList) throws Exception {
		return baseDao.memberUseChange(memberList);
	}

	// 멤버 삭제
	public int memberDel(MemberVO member) throws Exception {
	    int result = baseDao.memberDel(member);

	    // 멤버 삭제 후 멤버 그룹 삭제
	    if(result > 0) {
	        baseDao.memberGroupDel(member);
	    }

	    return result;
	}

	// 관리자 ID 중복 체크
	public int memberIdCheck(MemberVO member) throws Exception {
		return baseDao.memberIdCheck(member);
	}

	// 관리자 로그인 업데이트
	public int memberLoginUpd(MemberVO member) throws Exception {
		return baseDao.memberLoginUpd(member);
	}
	
	// 관리자 로그인 히스토리 저장
	public void memberLoginHistory(MemberVO member) throws Exception {
		baseDao.memberLoginHistory(member);
	}
	
	// 코드분류 그룹리스트
    public List<CodeGroupVO> codeGroupList(CodeGroupVO codeGroup) throws Exception {
        return baseDao.codeGroupList(codeGroup);
    }

    // 코드 조건에 해당하는 코드 분류 그룹 리스트 토탈 갯수
    public int codeGroupTotalCnt(CodeGroupVO codeGroup) throws Exception {
        return baseDao.codeGroupTotalCnt(codeGroup);
    }

    // 코드 분류 그룹 정보 조회
    public CodeGroupVO codeGroupInfo(CodeGroupVO codeGroup) throws Exception {
        return baseDao.codeGroupInfo(codeGroup);
    }
    
    // 코드 분류 그룹 등록
    public void codeGroupReg(CodeGroupVO codeGroup) throws Exception {
        // 실제 코드 적용
        baseDao.codeGroupReg(codeGroup);
    }
    
    // 코드 분류 그룹 삭제
    public int codeGroupDel(CodeGroupVO codeGroup) throws Exception {
        return baseDao.codeGroupDel(codeGroup);
    }

	// 코드 조건에 해당하는 코드 리스트 조회(자식 코드까지 전부 검색해서 가져간다)
    public List<CodeVO> codeList(CodeVO code) throws Exception {
        return baseDao.codeList(code);
    }

	// 대중소분류 코드 리스트 조회
    public List<CodeVO> cateCodeList() throws Exception {
        return baseDao.cateCodeList();
    }

    // 코드 조건에 해당하는 코드 리스트 토탈 갯수
    public int codeTotalCnt(CodeVO code) throws Exception {
        return baseDao.codeTotalCnt(code);
    }

    // 코드 정보 조회
    public CodeVO codeInfo(CodeVO code) throws Exception {
        return baseDao.codeInfo(code);
    }
    // 코드 정보 조회(String)
    public CodeVO codeInfoByString(String searchCode) throws Exception {
    	CodeVO result = baseDao.codeInfoByString(searchCode);
        return result;
    }

    // 코드 등록
    public void codeReg(CodeVO code) throws Exception {
        // 실제 코드 적용
        baseDao.codeReg(code);
    }
    
    // 대중소 코드 등록시 사용되는 시퀀스 생성
    public void makeCategorySequence() throws Exception {
        // 실제 코드 적용
        baseDao.makeCategorySequence();
    }
    
    // 대중소 코드 등록시 사용되는 시퀀스 검색
    public String selectCategorySequence() throws Exception {
        // 실제 코드 적용
        return baseDao.selectCategorySequence();
    }

    //대중소 사용여부
    public int codeYnUpt(HashMap<String,String> code) throws Exception{
    	return baseDao.codeYnUpt(code);
    }
    
    // 코드 삭제
    public int codeDel(CodeVO code) throws Exception {
        return baseDao.codeDel(code);
    }

    // 코드 사용 여부 변경(Y->N , N->Y)
    public int codeUseChange(List<CodeVO> codeList) throws Exception {
        return baseDao.codeUseChange(codeList);
    }
    //비밀번호 업데이트
	public int memberPwUpd(MemberVO member) throws Exception {
		return baseDao.memberPwUpd(member);
	}
}