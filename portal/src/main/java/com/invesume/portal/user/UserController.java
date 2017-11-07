package com.invesume.portal.user;


import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.EncodingUtil;
import com.invesume.portal.user.service.UserService;

@Controller
public class UserController {
    private Logger log = LoggerFactory.getLogger(getClass());
    
    @Autowired
    private UserService userService;

    @RequestMapping(value="portalUserInsert.action")
    public String portalUserInsert(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        return "/login/portalUserInsert";
    }

    @RequestMapping(value="portalUserInsertProcess.action")
    @ResponseBody
    public String portalUserInsertProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "";
        
        try {
            map.put("params", params);
            List<Map<String, Object>> portalUserInfo = userService.portalUserInfo(params);
    		for (Map<String, Object> data : portalUserInfo) {
				if(CommonUtil.isNull(data.get("user_id")).equals(CommonUtil.isNull(params.get("id")))) {
					result = "2";
					break;
				}
			}
    		if(!result.equals("2")) {
    			String pwd = CommonUtil.isNull(params.get("pwd"));
    			EncodingUtil eu = new EncodingUtil();
    			params.put("pwd", eu.encrypt(pwd));
    			userService.portalUserInsert(params);
    			result = "1";
    		}
        } catch(Exception e) {
            log.error("포털 회원가입 등록 처리 Error : 에러메세지 = {}", e.getMessage());
            result = "0";
        }

        return result;
    }

    @RequestMapping(value="login.action")
    public String login(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) {
        try {
            KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(1024);
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");

            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
            
            HttpSession session = request.getSession();
            
            session.setAttribute("__rsaPrivateKey__", privateKey);

            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);

            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
            
            map.put("publicKeyModulus", publicKeyModulus);
            map.put("publicKeyExponent", publicKeyExponent);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (InvalidKeySpecException e) {
            e.printStackTrace();
        }

        return "/login/login";
    }
    
    @RequestMapping(value="loginProcess.action")
    @ResponseBody
    public String loginProcess(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "";
        
        try {
            HttpSession session = request.getSession();
            PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
            if(request.getSession() != null) request.getSession().invalidate();
            
            if (privateKey == null) {
            	result = "2";
                throw new Exception("암호화 비밀키 정보를 찾을 수 없습니다.");
            }
            
            params.put("userId", decryptRsa(privateKey, CommonUtil.isNull(params.get("userId"))));
            String paramUserPassword = decryptRsa(privateKey, CommonUtil.isNull(params.get("userPassword"))).trim();

            boolean isUser = false;
            EncodingUtil eu = new EncodingUtil();
            Map<String, Object> adminUserInfoMap = userService.adminUserInfo(params);
            if(adminUserInfoMap != null) {
            	String adminUserPassword = eu.decrypt(CommonUtil.isNull(adminUserInfoMap.get("user_pwd"))).trim();
            	if(paramUserPassword.equals(adminUserPassword)) {
            		isUser = true;
            		adminUserInfoMap.put("admin", "Y");
                    adminUserInfoMap.remove("user_pwd");
                    request.getSession().setAttribute("userInfo", adminUserInfoMap);
                    result = "10";
            	} else {
            		result = "3";
            		throw new Exception("아이디 또는 비밀번호가 일치하지 않습니다.");
            	}
            }
            
            if(!isUser) {
            	List<Map<String, Object>> userInfoList = userService.portalUserInfo(params);
                if(userInfoList == null || userInfoList.size() == 0) {
                	result = "4";
                    throw new Exception("포털 가입 정보가 존재하지 않습니다.");
                }
                
                for (Map<String, Object> userInfoMap : userInfoList) {
                	String userPassword = eu.decrypt(CommonUtil.isNull(userInfoMap.get("user_pwd"))).trim();
                	if(paramUserPassword.equals(userPassword)) {
                		isUser = true;
                        
                        userInfoMap.put("admin", "N");
                        userInfoMap.remove("user_pwd");
                        request.getSession().setAttribute("userInfo", userInfoMap);
                        result = "1";
                        break;
                	}
                }
            }
            
            if(!isUser) {
            	result = "3";
            	throw new Exception("아이디 또는 비밀번호가 일치하지 않습니다.");
            }
            
        } catch(Exception e) {
            log.error("로그인 처리 Error : 에러메세지 = {}", e.getMessage());
        }
        
        return result;
    }
    
    @RequestMapping(value = "logout.action")
    @ResponseBody
    public String logout(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        String result = "0";
        
        try {
        	result = "1";
            request.getSession().invalidate();
        } catch(Exception e) {
            log.error("> 로그아웃 처리 Error : 에러메세지 = {}", e.getMessage());
        }
        return result;
    }

    private String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8");
        return decryptedValue;
    }
    
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
}