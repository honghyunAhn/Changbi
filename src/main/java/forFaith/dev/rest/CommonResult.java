package forFaith.dev.rest;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import forFaith.dev.util.RestResultCode;
import forFaith.domain.Paging;

@XmlRootElement(name="result")
@XmlType(propOrder={"resultCode","resultMsg"})
@SuppressWarnings("serial")
public class CommonResult extends Paging {

	private String resultCode  = RestResultCode.SUCCESS;
	private String resultMsg   = "OK";

	@XmlElement(name="resultCode")
	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	@XmlElement(name="resultMsg")
	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
}
