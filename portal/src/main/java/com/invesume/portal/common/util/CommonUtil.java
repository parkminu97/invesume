package com.invesume.portal.common.util;


import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class CommonUtil {
    /**
     * @Method Name : isNull
     * @Method Desc : param이 Null일 경우 공백으로 치환
     * @param param
     * @return
     */
    public static String isNull(Object param) {
        return isNull(param, "");
    }
    
    /**
     * @Method Name : isNull
     * @Method Desc : param이 Null일 경우 ref로 치환
     * @param param
     * @param ref
     * @return
     */
    public static String isNull(Object param, String ref) {
        String result = "";
        if (param == null || "".equals(param))
            result = ref;
        else
            result = String.valueOf(param);
        return result;
    }
    
    /**
     * @Method Name : isEmail
     * @Method Desc : 이메일 정합성 체크
     * @param email
     * @return
     */
    public static Boolean isEmail(String email) {
        String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
        Boolean b = email.matches(EMAIL_REGEX);
        return b;
    }
    
    /**
     * @Method Name : rmStringKor
     * @Method Desc : str길이가 limit보다 길 경우 ... 표시
     * @param Str
     * @param limit
     * @return
     */
    public static String rmStringKor(String Str, int limit) {
        int len = Str.length();
        int cnt = 0;
        int index = 0;
        
        while (index < len && cnt < limit) {
            if (Str.charAt(index++) < 256) {
                cnt++;
            } else {
                cnt += 2;
            }
        }
        if (index < len) {
            Str = Str.substring(0, index) + "...";
        }
        return Str;
    }
    
    /**
     * @Method Name : fillAddZero
     * @Method Desc : 숫자 앞 공백을 0으로 채우기
     * @param data
     * @param j
     * @return
     */
    public static String fillAddZero(int data, int j) {
        String s = "";
        String s1 = String.valueOf(data);
        for (int i = 0; i < j - s1.length(); i++)
            s = s + "0";
        
        s1 = s + s1;
        return s1;
    }
    
    /**
     * @Method Name : fillAddZero
     * @Method Desc : 문자열 앞 공백을 0으로 채우기
     * @param data
     * @param j
     * @return
     */
    public static String fillAddZero(String data, int j) {
        if (data == null) {
            data = "";
        } else if ("".equals(data)) {
            data = "";
        } else {
            String s = "";
            for (int i = 0; i < j - data.length(); i++)
                s = s + "0";
            
            data = s + data;
        }
        return data;
    }
    
    /**
     * @Method Name : getRandom
     * @Method Desc : 랜덤값 생성
     * @param gubun
     *            1: 숫자 , 2: 영문자 , 3: 숫자+영문자 조합
     * @param size
     * @return
     */
    public static String getRandom(String gubun, int size) {
        Random rnd = new Random();
        StringBuffer buf = new StringBuffer();
        
        for (int i = 0; i < size; i++) {
            if ("1".equals(gubun)) { // 숫자
                buf.append(rnd.nextInt(10));
            } else if ("2".equals(gubun)) { // 영문
                buf.append((char) ((int) (rnd.nextInt(26)) + 97));
            } else if ("3".equals(gubun)) { // 영문 + 숫자
                if (rnd.nextBoolean()) {
                    buf.append((char) ((int) (rnd.nextInt(26)) + 97));
                } else {
                    buf.append((rnd.nextInt(10)));
                }
            }
        }
        return buf.toString();
    }
    
    /**
     * @Method Name : getByteSize
     * @Method Desc : 문자열 길이 추출
     * @param str
     * @return
     */
    public static int getByteSize(String str) {
        if (str == null || str.length() == 0)
            return 0;
        byte[] byteArray = null;
        try {
            byteArray = str.getBytes("UTF-8");
        } catch (UnsupportedEncodingException ex) {
        }
        if (byteArray == null)
            return 0;
        return byteArray.length;
    }
    
    public static List<Map<String, Object>> distinctList(List<Map<String, Object>> list) {
        HashSet<Map<String, Object>> hs = new HashSet<Map<String, Object>>(list);
        return new ArrayList<Map<String, Object>>(hs);
    }
    
    public static void main(String[] args) throws Exception {
       
    }
    
}