package forFaith.dev.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import forFaith.dev.dao.BaseDAO;
import forFaith.dev.rest.CommonResult;
import forFaith.dev.rest.MemberResult;
import forFaith.dev.vo.MemberVO;

@Service(value="forFaith.restService")
public class RestService {

	//private static final Logger logger = LoggerFactory.getLogger(RestWebServiceImpl.class);

	@Autowired
	private BaseDAO baseDao;

	public CommonResult member(MemberVO member) throws Exception {
		MemberResult result = new MemberResult();

		List<MemberVO> list = baseDao.memberList(member);

		if(list != null && list.size() > 0) {
			result.setItemList(list);
			result.setTotalCount(list.size());
			result.setNumOfRows(list.size());
		} else {
			result.setTotalCount(0);
			result.setNumOfRows(0);
		}

		return result;
	}
}
