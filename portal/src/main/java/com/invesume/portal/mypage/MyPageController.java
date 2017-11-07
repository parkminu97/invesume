package com.invesume.portal.mypage;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.invesume.portal.annotation.LoginAuth;
import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.EncodingUtil;
import com.invesume.portal.main.service.PayService;
import com.invesume.portal.mypage.service.BoardService;
import com.invesume.portal.mypage.service.HotelService;
import com.invesume.portal.user.service.UserService;

@Controller
@RequestMapping(value="mypage")
public class MyPageController {
    private Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private PayService payService;

    @Autowired
    private HotelService hotelService;

    @Autowired
    private BoardService boardService;

    @Value("#{message['file.root.dir']}")
    public String fileRootDir;

    @RequestMapping(value="dashBoard.action")
    @LoginAuth
    public String dashBoard(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        log.info("마이페이지 DashBoard 화면 시작");
        
        Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
        params.put("uNo", userInfo.get("user_no"));
        params.put("currentPage", "1");
        params.put("pageRow", "5");
        params.put("board_gubun", "H");
    	boardService.boardList(params);
    	
        map.put("listInfo", params.get("pagingList"));
        map.put("guestUserCount", hotelService.guestUserCount(params));
        map.put("custReservationCount", "10");
        //map.put("custReservationCount", hotelService.custReservationCount(params));
        log.info("마이페이지 DashBoard 화면 종료");
        return "/mypage/dashBoard";
    }

    @RequestMapping(value="info.action")
    @LoginAuth
    public String info(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        log.info("마이페이지 회원 정보 화면 시작");
        
        Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
        params.put("userId", userInfo.get("user_id"));

        List<Map<String, Object>> portalUserList = userService.portalUserInfo(params);
        map.put("portalUserInfo", portalUserList.get(0));
        
        params.put("uNo", userInfo.get("user_no"));
        List<Map<String, Object>> hotelUserList = userService.hotelUserInfo(params);
        map.put("hotelUserList", hotelUserList);

        log.info("마이페이지 회원 정보 화면 종료");
        return "/mypage/info";
    }

    @RequestMapping(value="portalUserUpdate.action")
    @LoginAuth
    public String portalUserUpdate(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/portalUserUpdate";
    }

    @RequestMapping(value="portalUserUpdateProcess.action")
    @LoginAuth
    @ResponseBody
    public String portalUserUpdateProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("no", userInfo.get("user_no"));

            String pwd = CommonUtil.isNull(params.get("pwd"));
    		EncodingUtil eu = new EncodingUtil();
    		params.put("pwd", eu.encrypt(pwd));
    		
           	userService.portalUserUpdate(params);
            result = "1";
        } catch(Exception e) {
            log.error("포털 사용자 정보 수정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="portalUserPasswordUpdate.action")
    @LoginAuth
    public String portalUserPasswordUpdate(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/portalUserPasswordUpdate";
    }

    @RequestMapping(value="portalUserPasswordUpdateProcess.action")
    @LoginAuth
    @ResponseBody
    public String portalUserPasswordUpdateProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "";
        
        try {
        	EncodingUtil eu = new EncodingUtil();
        	Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("no", userInfo.get("user_no"));
            params.put("userId", userInfo.get("user_id"));
            
            List<Map<String, Object>> portalUserList = userService.portalUserInfo(params);
            String currentPwd = eu.decrypt(CommonUtil.isNull(portalUserList.get(0).get("user_pwd")));
            String paramCurrentPwd = CommonUtil.isNull(params.get("currPwd"));
            
            if(!currentPwd.equals(paramCurrentPwd)) {
            	result = "2";
            } else {
            	String pwd = CommonUtil.isNull(params.get("newPwd"));
        		params.put("pwd", eu.encrypt(pwd));            	
            	userService.portalUserPasswordUpdate(params);
            	result = "1";
            }
        } catch(Exception e) {
            log.error("포털 사용자 비밀번호 변경 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelUserInsert.action")
    @LoginAuth
    public String hotelUserInsert(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/hotelUserInsert";
    }

    @RequestMapping(value="hotelUserInsertProcess.action")
    @LoginAuth
    @ResponseBody
    public String hotelUserInsertProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
            
            List<Map<String, Object>> hotelUserList = userService.hotelUserInfo(params);
    		for (Map<String, Object> data : hotelUserList) {
				if(CommonUtil.isNull(data.get("user_id")).equals(CommonUtil.isNull(params.get("id")))) {
					result = "2";
					break;
				}
			}

    		if(!result.equals("2")) {
    			String pwd = CommonUtil.isNull(params.get("pwd"));
    			EncodingUtil eu = new EncodingUtil();
    			params.put("pwd", eu.encrypt(pwd));
    			userService.hotelUserInsert(params);
    			result = "1";
    		}
        } catch(Exception e) {
            log.error("호텔 사용자 정보 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelUserDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelUserDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
           	userService.hotelUserDelete(params);
            result = "1";
        } catch(Exception e) {
            log.error("호텔 사용자 정보 삭제 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="productPaymentList.action")
    @LoginAuth
    public String productPaymentList(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		params.put("admin", userInfo.get("admin"));
           	payService.productPaymentList(params);
        } catch(Exception e) {
            log.error("마이페이지 결제 현황 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        map.put("params", params);
        map.put("listInfo", params.get("pagingList"));
        
        return "/mypage/productPaymentList";
    }

    @RequestMapping(value="hotelInfo.action")
    @LoginAuth
    public String hotelInfo(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        log.info("마이페이지 호텔 정보 화면 시작");
        Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
        params.put("uNo", userInfo.get("user_no"));
        
        String type = "I";
        String typeDesc = "등록";
        
        Map<String, Object> hotelInfo = hotelService.hotelInfo(params);
        if(hotelInfo != null) {
        	type = "U";
        	typeDesc = "수정";
        }
        
        map.put("hotelInfo", hotelInfo);
        map.put("type", type);
        map.put("typeDesc", typeDesc);
        log.info("마이페이지 호텔 정보 화면 종료");
        return "/mypage/hotelInfo";
    }

    @RequestMapping(value="hotelInfoProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelInfoProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            if(CommonUtil.isNull(params.get("type")).equals("I")) hotelService.hotelInfoInsert(params);
            else hotelService.hotelInfoUpdate(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 정보 저장 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelRepImgUpload.action")
    @LoginAuth
    public String hotelRepImgUpload(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/hotelRepImgUpload";
    }

    @RequestMapping(value="hotelRepImgUploadProcess.action")
    @LoginAuth
    public String hotelRepImgUploadProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params, MultipartHttpServletRequest mRequest) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

        	String filePath = fileRootDir + "/" + CommonUtil.isNull(params.get("uNo")) + "/info/";

        	File dir = new File(filePath);
	        if(!dir.exists()) dir.mkdirs();
	
	    	Iterator<String> iterator = mRequest.getFileNames();
	        while(iterator.hasNext()){
	        	MultipartFile mFile = mRequest.getFile(iterator.next());
	            if(mFile.isEmpty() == false) {
	            	 byte[] b = mFile.getBytes();
	            	 String fileName = filePath + mFile.getOriginalFilename();
	            	 FileOutputStream fos = null;
	            	 try {
	            		 File file = new File(fileName);
	            		 fos = new FileOutputStream(file);
	            		 fos.write(b);
	            	 } catch(Exception e) {
	            		 e.printStackTrace();
	            	 } finally {
	            		 fos.close(); 
	            	 }
	                 
	                 params.put("repImg", fileName);
	                 hotelService.hotelRepImgUpdate(params);
	            }
	        }
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 대표 이미지 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        map.put("result", result);
        return "/mypage/imgUploadProcess";
    }

    @RequestMapping(value="hotelRepImgDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelRepImgDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
            hotelService.hotelRepImgUpdate(params);
            File file = new File(CommonUtil.isNull(params.get("rep_img")).replaceAll("//", "/"));
            if(file.exists()) {
            	file.delete();
            }
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 대표 이미지 삭제 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }
    
    @RequestMapping(value="hotelRoomList.action")
    @LoginAuth
    public String hotelRoomList(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
           	hotelService.hotelRoomList(params);
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 목록 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        map.put("params", params);
        map.put("listInfo", params.get("pagingList"));
        
        return "/mypage/hotelRoomList";
    }

    @RequestMapping(value="hotelRoomInsert.action")
    @LoginAuth
    public String hotelRoomInsert(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        log.info("마이페이지 호텔 객실 관리 등록 화면 시작");
        log.info("마이페이지 호텔 객실 관리 등록 화면 종료");
        return "/mypage/hotelRoomInsert";
    }

    @RequestMapping(value="hotelRoomInsertProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelRoomInsertProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
            hotelService.hotelRoomInsert(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelRoomView.action")
    @LoginAuth
    public String hotelRoomView(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
            Map<String, Object> hotelRoomInfo = hotelService.hotelRoomView(params);
           	map.put("hotelRoomInfo", hotelRoomInfo);
           	
           	params.put("riNo", CommonUtil.isNull(hotelRoomInfo.get("no")));
           	map.put("hotelRoomImgList", hotelService.hotelRoomImgList(params));
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 상세 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        map.put("params", params);
        return "/mypage/hotelRoomView";
    }

    @RequestMapping(value="hotelRoomUpdate.action")
    @LoginAuth
    public String hotelRoomUpdate(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
           	map.put("hotelRoomInfo", hotelService.hotelRoomView(params));
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 수정 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        map.put("params", params);
        return "/mypage/hotelRoomUpdate";
    }

    @RequestMapping(value="hotelRoomUpdateProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelRoomUpdateProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            hotelService.hotelRoomUpdate(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 수정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelRoomDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelRoomDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            hotelService.hotelRoomDelete(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 관리 수정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelRoomImgUpload.action")
    @LoginAuth
    public String hotelRoomImgUpload(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/hotelRoomImgUpload";
    }

    @RequestMapping(value="hotelRoomImgUploadProcess.action")
    @LoginAuth
    public String hotelRoomImgUploadProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params, MultipartHttpServletRequest mRequest) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

        	String filePath = fileRootDir + "/" + CommonUtil.isNull(params.get("uNo")) + "/room/" + CommonUtil.isNull(params.get("riNo")) + "/";

        	File dir = new File(filePath);
	        if(!dir.exists()) dir.mkdirs();
	
	    	Iterator<String> iterator = mRequest.getFileNames();
	        while(iterator.hasNext()){
	        	MultipartFile mFile = mRequest.getFile(iterator.next());
	            if(mFile.isEmpty() == false) {
	            	 byte[] b = mFile.getBytes();
	            	 String fileName = filePath + mFile.getOriginalFilename();
	            	 FileOutputStream fos = null;
	            	 try {
	            		 File file = new File(fileName);
	            		 fos = new FileOutputStream(file);
	            		 fos.write(b);
	            	 } catch(Exception e) {
	            		 e.printStackTrace();
	            	 } finally {
	            		 fos.close(); 
	            	 }
	                 
	                 params.put("roomImg", fileName);
	                 hotelService.hotelRoomImgInsert(params);
	            }
	        }
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 이미지 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        map.put("result", result);
        return "/mypage/imgUploadProcess";
    }

    @RequestMapping(value="hotelRoomImgDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String hotelRoomImgDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            hotelService.hotelRoomImgDelete(params);
            File file = new File(CommonUtil.isNull(params.get("room_img")).replaceAll("//", "/"));
            if(file.exists()) {
            	file.delete();
            }
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 이미지 삭제 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="hotelRoomRepImgUpdate.action")
    @ResponseBody
    @LoginAuth
    public String hotelRoomRepImgUpdate(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            hotelService.hotelRoomRepImgUpdate(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 호텔 객실 대표 이미지 수정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="portalCustList.action")
    @LoginAuth
    public String portalCustList(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
           	userService.portalCustList(params);
        } catch(Exception e) {
            log.error("마이페이지 고객 관리 목록 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        map.put("params", params);
        map.put("listInfo", params.get("pagingList"));
        
        return "/mypage/portalCustList";
    }

    @RequestMapping(value="serviceState.action")
    @LoginAuth
    public String serviceState(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/serviceState";
    }

    @RequestMapping(value="serviceComp.action")
    @LoginAuth
    public String serviceComp(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
        	map.put("params", params);
        	map.put("menuList", hotelService.hotelMenuList(params));
        	map.put("hotelInfo", hotelService.hotelInfo(params));
        } catch(Exception e) {
            log.error("마이페이지 서비스 구성관리 목록 Error : 에러메세지 = {}", e.getMessage());
        }

        return "/mypage/serviceComp";
    }

    @RequestMapping(value="serviceCompProcess.action")
    @ResponseBody
    @LoginAuth
    public String serviceCompProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        String result = "";
        
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));
    		
            hotelService.hotelMenuUpdate(params);
            result = "1";
        } catch(Exception e) {
            log.error("마이페이지 서비스 구성관리 설정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="boardList.action")
    @LoginAuth
    public String boardList(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

            map.put("params", params);
	    	boardService.boardList(params);
	        map.put("listInfo", params.get("pagingList"));
	        String boardTitle = "공지사항";
	        if(CommonUtil.isNull(params.get("board_gubun")).equals("E")) {
	        	boardTitle = "이벤트게시판";
	        }
	        map.put("boardTitle", boardTitle);
        } catch(Exception e) {
            log.error("마이페이지 공지사항 목록 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        return "/mypage/boardList";
    }

    @RequestMapping(value="boardInsert.action")
    @LoginAuth
    public String boardInsert(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	map.put("params", params);
        String boardTitle = "공지사항";
        if(CommonUtil.isNull(params.get("board_gubun")).equals("E")) {
        	boardTitle = "이벤트게시판";
        }
        map.put("boardTitle", boardTitle);
        return "/mypage/boardInsert";
    }

    @RequestMapping(value="boardInsertProcess.action")
    @ResponseBody
    @LoginAuth
    public String boardInsertProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

            boardService.boardInsert(params);
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 공지사항 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        
        return result;
    }

    @RequestMapping(value="boardUpdate.action")
    @LoginAuth
    public String boardUpdate(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

            map.put("params", params);
            map.put("boardInfo", boardService.boardView(params));
            String boardTitle = "공지사항";
            if(CommonUtil.isNull(params.get("board_gubun")).equals("E")) {
            	boardTitle = "이벤트게시판";
            }
            map.put("boardTitle", boardTitle);
        } catch(Exception e) {
            log.error("마이페이지 공지사항 상세 화면 Error : 에러메세지 = {}", e.getMessage());
        }
        return "/mypage/boardUpdate";
    }

    @RequestMapping(value="boardUpdateProcess.action")
    @ResponseBody
    @LoginAuth
    public String boardUpdateProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

            boardService.boardUpdate(params);
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 공지사항 수정 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        
        return result;
    }

    @RequestMapping(value="boardDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String boardDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("uNo", userInfo.get("user_no"));

        	boardService.boardDelete(params);
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 공지사항 삭제 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        
        return result;
    }

    @RequestMapping(value="portalUserDelete.action")
    @LoginAuth
    public String portalUserDelete(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/mypage/portalUserDelete";
    }

    @RequestMapping(value="portalUserDeleteProcess.action")
    @ResponseBody
    @LoginAuth
    public String portalUserDeleteProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
    	String result = "";
        try {
            Map<String, Object> userInfo = (Map<String, Object>) request.getSession().getAttribute("userInfo");
            params.put("no", userInfo.get("user_no"));

            userService.portalUserDelete(params);
            request.getSession().invalidate();
	        result = "1";
        } catch(Exception e) {
            log.error("마이페이지 탈퇴 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }
        
        return result;
    }

}