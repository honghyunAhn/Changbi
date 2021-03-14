package forFaith.dev.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import forFaith.dev.vo.MemberVO;
import forFaith.util.StringUtil;

/**
 * @Class Name : LoginHelper.java
 * @Description : 로그인 관련 헬퍼
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

public class LoginHelper {

		/**
		 * 인증된 사용자객체를 VO형식으로 저장한다.
		 * @return Object - 사용자 ValueObject
		 */
		public static void setLoginInfo(MemberVO loginUser) {
			if(loginUser != null && !StringUtil.isEmpty(loginUser.getId())) {
				RequestContextHolder.getRequestAttributes().setAttribute("loginUser", loginUser, RequestAttributes.SCOPE_SESSION);
			}
		}

		/**
		 * 인증된 사용자객체를 VO형식으로 가져온다.
		 * @return Object - 사용자 ValueObject
		 */
		public static Object getLoginInfo() {
			return (MemberVO)RequestContextHolder.getRequestAttributes().getAttribute("loginUser", RequestAttributes.SCOPE_SESSION) == null ?
					new MemberVO() : (MemberVO) RequestContextHolder.getRequestAttributes().getAttribute("loginUser", RequestAttributes.SCOPE_SESSION);
		}

		/**
		 * 인증된 사용자객체를 제거한다.
		 * @return Object - 사용자 ValueObject
		 */
		public static void setLogOut() {
			RequestContextHolder.getRequestAttributes().removeAttribute("loginUser", RequestAttributes.SCOPE_SESSION);
		}

		/**
		 * 인증된 사용자의 권한 정보를 가져온다.
		 * 예) [ROLE_ADMIN, ROLE_USER, ROLE_A, ROLE_B, ROLE_RESTRICTED, IS_AUTHENTICATED_FULLY, IS_AUTHENTICATED_REMEMBERED, IS_AUTHENTICATED_ANONYMOUSLY]
		 * @return List - 사용자 권한정보 목록
		 */
		public static List<String> getAuth() {
			List<String> listAuth = new ArrayList<String>();

			if (RequestContextHolder.getRequestAttributes().getAttribute("loginUser", RequestAttributes.SCOPE_SESSION) == null) {
				// log.debug("## authentication object is null!!");
				return null;
			}

			return listAuth;
		}

		/**
		 * 인증된 사용자 여부를 체크한다.
		 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)
		 */
		public static Boolean isAuth() {
			if (RequestContextHolder.getRequestAttributes().getAttribute("loginUser", RequestAttributes.SCOPE_SESSION) == null) {
				// log.debug("## authentication object is null!!");
				return Boolean.FALSE;
			}

			return Boolean.TRUE;
		}
}
