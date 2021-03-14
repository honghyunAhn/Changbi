package forFaith.dev.rest;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import forFaith.dev.vo.MemberVO;

@XmlRootElement(name="result")
@SuppressWarnings("serial")
public class MemberResult extends CommonResult {

	private List<MemberVO> itemList = new ArrayList<MemberVO>();

	public void addItem(MemberVO item) {
		this.itemList.add(item);
	}

	@XmlElement(name="itemList")
	public List<MemberVO> getItemList() {
		return itemList;
	}

	public void setItemList(List<MemberVO> itemList) {
		this.itemList = itemList;
	}
}
