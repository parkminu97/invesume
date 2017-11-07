package com.invesume.portal.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.invesume.portal.annotation.LoginAuth;
import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.DateUtil;
import com.invesume.portal.main.service.PayService;
import com.invesume.portal.mypage.service.BoardService;

@Controller
public class MainController {
    private Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private PayService payService;

    @Autowired
    private BoardService boardService;

	@RequestMapping(value="main.action")
    public String main(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/main/main";
    }
    
    @RequestMapping(value="intro.action")
    public String intro(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/main/intro";
    }

    @RequestMapping(value="custCenter.action")
    public String custCenter(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/main/custCenter";
    }

    @RequestMapping(value="payInfo.action")
    @LoginAuth
    public String payInfo(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	map.put("params", params);
        return "/main/payInfo";
    }

    @RequestMapping(value="productPayment.action")
    @LoginAuth
    @ResponseBody
    public String productPayment(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
        	
	    	String type = CommonUtil.isNull(params.get("type"));
	    	String money = "";
	    	String endDate = "";
	    	String utilServiceName = "";
	    	if(type.equals("2")) {
	    		endDate = DateUtil.getAddDay(DateUtil.getCurrentDate(), 30, ".");
	    		money = "30000";
	    		utilServiceName ="Basic";
	    	} else if(type.equals("3")) {
	    		endDate = DateUtil.getAddDay(DateUtil.getCurrentDate(), 365, ".");
	    		money = "365000";
	    		utilServiceName ="Premium";
	    	} else {
	    		endDate = DateUtil.getAddDay(DateUtil.getCurrentDate(), 15, ".");
	    		money = "0";
	    		utilServiceName ="Demo";
	    	}
	    	params.put("utilService", type);
	    	params.put("utilServiceName", utilServiceName);
	    	params.put("payType", CommonUtil.isNull(params.get("payType"), "0"));
	    	params.put("payMoney", money);
	    	params.put("useStartDate", DateUtil.getCurrentDate("."));
	    	params.put("useEndDate", endDate);

	    	List<Map<String, Object>> useProductList = payService.useProductList(params);
	    	String utilService = "";
	    	for (Map<String, Object> data : useProductList) {
				utilService = CommonUtil.isNull(data.get("util_service"));
			}
	    	
	    	if(!utilService.equals("")) result = "2";
	    	
	    	if(result.equals("")) {
	    		payService.productPayment(params);
	    		result = "1";
	    	}
        } catch(Exception e) {
            log.error("결재 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="boardList.action")
    public String boardList(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	map.put("params", params);
    	boardService.boardList(params);
        map.put("listInfo", params.get("pagingList"));
        return "/main/boardList";
    }

    @RequestMapping(value="boardView.action")
    public String boardView(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	map.put("params", params);
    	map.put("boardInfo", boardService.boardView(params));
    	boardService.boardReadHitUpdate(params);
        return "/main/boardView";
    }

}