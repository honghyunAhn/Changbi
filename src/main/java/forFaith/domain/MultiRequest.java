package forFaith.domain;

import java.util.List;

/**
 * @Class Name : MultiRequest.java
 * @Description : 동일한 객체를 서버에 List형태로 보낼때 스프링 컨트롤러에서는 List로 받아줄수 없기 때문에 객체 내에 List를 만들어서 사용
 *                Object는 넘겨받는 객체로 변환 됨.
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

@SuppressWarnings("hiding")
public class MultiRequest<Object> {
	private List<Object> list;

	public List<Object> getList() {
		return list;
	}

	public void setList(List<Object> list) {
		this.list = list;
	}
}
