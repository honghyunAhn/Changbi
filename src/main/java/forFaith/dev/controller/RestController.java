package forFaith.dev.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import forFaith.dev.rest.CommonResult;
import forFaith.dev.service.RestService;
import forFaith.dev.util.RestResultCode;
import forFaith.dev.vo.MemberVO;

@Controller(value="forFaith.restController")
@RequestMapping("/forFaith/rest")
public class RestController {

	private static final Logger logger = LoggerFactory.getLogger(RestController.class);

	@Autowired
	private RestService restService;

	@RequestMapping(value="/member")
	@ResponseBody
	public CommonResult member(MemberVO member) throws Exception {
		return restService.member(member);
	}

	/**
	 * Exception
	 * @param Exception
	 * @return ModelAndView
	 * @author : KJS (2015-06-03)
	 */
	@ExceptionHandler(Exception.class)
	@ResponseBody
	public CommonResult exceptionHandler(Exception e) {
		logger.info(e.getMessage());
		CommonResult response = new CommonResult();
		response.setResultCode(RestResultCode.EXCEPTION);
		response.setResultMsg(e.getMessage());

		return response;
		//return new ModelAndView("/rest/error/exception").addObject("msg", e.getMessage());
	}
}
