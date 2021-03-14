package forFaith.dev.vo;

/**
 * @Class Name : CodeGroupVO.java
 * @Description : 코드그룹 정보
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

@SuppressWarnings("serial")
public class CodeGroupVO extends CommonVO {

    /** 자기 자신의 검색 조건을 저장 */
	private CodeGroupVO search;

	/** 코드 ID(고유 ID로 코드값 써도 됨) */
	private String id;

	/** 코드 그룹 ID (코드 구성하는 그룹) */
	private String name;
	
	/** 하위 코드 구성 시 1뎁스 2뎁스 3뎁스 개념 */
	private String comment;

    public CodeGroupVO getSearch() {
        return search;
    }

    public void setSearch(CodeGroupVO search) {
        this.search = search;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "CodeGroupVO [search=" + search + ", id=" + id + ", name=" + name + ", comment=" + comment + "]";
	}
	
	
}