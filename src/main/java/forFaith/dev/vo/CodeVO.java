package forFaith.dev.vo;

import java.util.List;

/**
 * @Class Name : CodeVO.java
 * @Description : 코드 정보
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ ------- -------- --------------------------- @ 2017.03.21
 *   김준석 최초 생성
 *
 * @author kjs
 * @since 2017.03.21
 * @version 1.0
 * @see
 *
 */

@SuppressWarnings("serial")
public class CodeVO extends CommonVO {

	/** 자기 자신의 검색 조건을 저장 */
	private CodeVO search;

	/** 코드 ID(고유 ID로 코드값 써도 됨) */
	private String code;

	/** 하위 코드 구성 시 1뎁스 2뎁스 3뎁스 개념 */
	private int depth;

	/** 코드 타이틀(다국어인 경우 다국어 테이블을 만들고 다국어 ID를 가지고 있으면 된다) */
	private String name;

	/** 코드 별로 보여줄 타입 설정(radio : 라디오버튼, checkbox : 체크박스) */
	private String inputType;

	/** 코드 별로 배경 색 설정 */
	private String bgColor;

	/** 코드 그룹 ID (코드 구성하는 그룹) */
	private CodeGroupVO codeGroup = new CodeGroupVO();

	/** 부모 코드(2뎁스 인 경우 1뎁스 코드를 가짐) */
	private CodeVO parentCode;

	/** 자식 코드 리스트(1뎁스 인 경우 2뎁스 코드 리스트를 가짐) */
	private List<CodeVO> childCodeList;

	private String parentcode;

	public CodeVO getSearch() {
		return search;
	}

	public void setSearch(CodeVO search) {
		this.search = search;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInputType() {
		return inputType;
	}

	public void setInputType(String inputType) {
		this.inputType = inputType;
	}

	public String getBgColor() {
		return bgColor;
	}

	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}

	public CodeVO getParentCode() {
		return parentCode;
	}

	public void setParentCode(CodeVO parentCode) {
		this.parentCode = parentCode;
	}

	public List<CodeVO> getChildCodeList() {
		return childCodeList;
	}

	public void setChildCodeList(List<CodeVO> childCodeList) {
		this.childCodeList = childCodeList;
	}

	public CodeGroupVO getCodeGroup() {
		return codeGroup;
	}

	public void setCodeGroup(CodeGroupVO codeGroup) {
		this.codeGroup = codeGroup;
	}

	public String getParentcode() {
		return parentcode;
	}

	public void setParentcode(String parentcode) {
		this.parentcode = parentcode;
	}

	@Override
	public String toString() {
		return "CodeVO [search=" + search + ", code=" + code + ", depth=" + depth + ", name=" + name + ", inputType="
				+ inputType + ", bgColor=" + bgColor + ", codeGroup=" + codeGroup + ", parentCode=" + parentCode
				+ ", childCodeList=" + childCodeList + ", parent_code=" + parentcode + "]";
	}

}