package forFaith.util.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Class Name : WebCookie.java
 * @Description : 쿠키 처리 Util
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

public class WebCookie {

	private Cookie[] cookies;
	private String path = "/";
	private String delimiter = "_";
	private int maxCountByName = 5;
	private boolean maxExceed = true;

	public WebCookie() {}

	public WebCookie(HttpServletRequest request) {
		this.cookies = request.getCookies();
	}

	public WebCookie(HttpServletRequest request, String path) {
		this.cookies = request.getCookies();
		this.path = path;
	}

	public void setCookies(HttpServletRequest request) {
		this.cookies = request.getCookies();
	}

	public Cookie[] getCookies() {
		return this.cookies;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getPath() {
		return this.path;
	}

	public void setMaxCountByName(int maxCountByName) {
		this.maxCountByName = maxCountByName;
	}

	public void setMaxExceed(boolean maxExceed) {
		this.maxExceed = maxExceed;
	}

	public int size() {
		return this.cookies != null ? this.cookies.length : 0;
	}

	public int size(String name) {
		int size = 0;

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				++size;
			}
		}

		return size;
	}

	public List<String> getNames() {
		List<String> names = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			names.add(this.cookies[i].getName());
		}

		return names;
	}

	public List<String> getNames(String name) {
		List<String> names = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				names.add(this.cookies[i].getName());
			}
		}

		return names;
	}

	public String getName(int idx) {
		return this.cookies != null && this.cookies.length > idx ? this.cookies[idx].getName() : "";
	}

	public String getName(String name, int idx) {
		List<String> names = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				names.add(this.cookies[i].getName());
			}
		}

		return names.size() > idx ? names.get(idx) : "";
	}

	public List<String> getValues() {
		List<String> values = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			values.add(this.cookies[i].getValue());
		}

		return values;
	}

	public List<String> getValues(String name) {
		List<String> values = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				values.add(this.cookies[i].getValue());
			}
		}

		return values;
	}

	public String getValue(int idx) {
		return this.cookies != null && this.cookies.length > idx ? this.cookies[idx].getValue() : "";
	}

	public String getValue(String name) {
		return getValue(name, 0);
	}

	public String getValue(String name, int idx) {
		List<String> values = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				values.add(this.cookies[i].getValue());
			}
		}

		return values.size() > idx ? values.get(idx) : "";
	}

	public List<Cookie> getCookies(String name) {
		List<Cookie> cookies = new ArrayList<Cookie>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				cookies.add(this.cookies[i]);
			}
		}

		return cookies;
	}

	public Cookie getCookie(String name, int idx) {
		List<Cookie> cookies = new ArrayList<Cookie>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				cookies.add(this.cookies[i]);
			}
		}

		return cookies.size() > idx ? cookies.get(idx) : null;
	}

	public boolean checkValue(String value) {
		List<String> values = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			values.add(this.cookies[i].getValue());
		}

		return values.contains(value);
	}

	public boolean checkValue(String name, String value) {
		List<String> values = new ArrayList<String>();

		for(int i=0; i<this.size(); ++i) {
			if(this.cookies[i].getName().startsWith(name)) {
				values.add(this.cookies[i].getValue());
			}
		}

		return values.contains(value);
	}

	public void addCookie(HttpServletResponse response, Cookie cookie) {
		cookie.setPath(this.path);
		response.addCookie(cookie);
	}

	public int addCookie(HttpServletResponse response, String name, String value) {
		return this.addCookie(response, name, value, true);
	}

	public int addCookie(HttpServletResponse response, String name, String value, boolean isNameDup) {
		int count = 0;

		if(!this.checkValue(name, value)) {
			// name_1, name_2 ...
			if(isNameDup) {
				List<Cookie> cookies = this.getCookies(name);

				if(this.maxCountByName <= cookies.size()) {
					if(this.maxExceed) {
						for(int i=1; i<this.maxCountByName; ++i) {
							this.addCookie(response, new Cookie(name+this.delimiter+i, cookies.get(i).getValue()));
						}

						this.addCookie(response, new Cookie(name+this.delimiter+this.maxCountByName, value));
						++count;
					}
				} else {
					this.addCookie(response, new Cookie(name+this.delimiter+(cookies.size()+1), value));
					++count;
				}
			} else {
				this.addCookie(response, new Cookie(name, value));
				++count;
			}
		}

		return count;
	}

	public void removeCookie(HttpServletResponse response, Cookie cookie) {
		cookie.setMaxAge(0);
		cookie.setPath(this.path);

		response.addCookie(cookie);
	}

	public int removeCookie(HttpServletResponse response, String name) {
		return this.removeCookie(response, name, true);
	}

	public int removeCookie(HttpServletResponse response, String name, boolean isNameDup) {
		int count = 0;

		// name_1, name_2 ...
		if(isNameDup) {
			List<String> names = this.getNames(name);

			for(int i=0; i<names.size(); ++i) {
				Cookie cookie = new Cookie(names.get(i), "");
				this.removeCookie(response, cookie);

				++count;
			}
		} else {
			Cookie cookie = new Cookie(name, "");
			this.removeCookie(response, cookie);

			++count;
		}

		return count;
	}

	public int removeCookie(HttpServletResponse response, String name, String value) {
		List<Cookie> cookies = this.getCookies(name);
		List<Cookie> remainCookies = new ArrayList<Cookie>();
		int count = 0;

		for(int i=0; i<cookies.size(); ++i) {
			if(!cookies.get(i).getValue().equals(value)) {
				remainCookies.add(new Cookie(name+this.delimiter+(remainCookies.size()+1), cookies.get(i).getValue()));
			}
		}

		for(int i=0; i<cookies.size(); ++i) {
			if(remainCookies.size() > i) {
				this.addCookie(response, remainCookies.get(i));
			} else {
				this.removeCookie(response, new Cookie(name+this.delimiter+(i+1),""));
				++count;
			}
		}

		return count;
	}
}
