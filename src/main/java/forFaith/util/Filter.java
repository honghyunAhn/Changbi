package forFaith.util;

import java.util.ArrayList;
import java.util.List;

/**
 * @Class Name : Filter.java
 * @Description : 홈페이지 필터 와 태그 필터
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

public class Filter {

	public static String homepageFilter(String homepage) {
		String newHomepage = "";

		if(homepage != null && homepage.indexOf("http://") >= 0) {
			if(homepage.indexOf("\"", homepage.indexOf("http://")) > 0) {
				newHomepage = homepage.substring(homepage.indexOf("http://"), homepage.indexOf("\"", homepage.indexOf("http://")));
			} else {
				newHomepage = homepage.substring(homepage.indexOf("http://"));
			}
		}

		return newHomepage;
	}

	public static String tagFilter(String content) {
		String newContent = "";

		if(content != null) {
			List<String> removeTag = new ArrayList<String>();
			int toffset = 0;

			while(true) {
				if(content.indexOf("<", toffset) >= 0) {
					removeTag.add(content.substring(content.indexOf("<", toffset), content.indexOf(">", content.indexOf("<", toffset))+1));
					toffset = content.indexOf(">", content.indexOf("<", toffset))+1;
				} else {
					break;
				}
			}

			for(int i=0; i<removeTag.size(); ++i) {
				newContent = content.replace(removeTag.get(i), "");
			}
		}

		return newContent;
	}
}
