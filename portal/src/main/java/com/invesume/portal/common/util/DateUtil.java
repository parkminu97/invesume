package com.invesume.portal.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class DateUtil {
    /**
     * @Method Name : getAddDay
     * @Method Desc : 특정날짜에 일자를 더한 값 
     * @param date
     * @param plusDay
     * @return
     */
    public static String getAddDay(String date, int plusDay) {
        return getAddDay(date, plusDay, "");
    }
    
    /**
     * @Method Name : getAddDay
     * @Method Desc : 특정날짜에 일자를 더한 값 
     * @param date
     * @param plusDay
     * @param format
     * @return
     */
    public static String getAddDay(String date, int plusDay, String format) {
        
        if (date == null)
            return "";
        
        if (date.equals("99991231")) {
            return "99991231";
        }
        
        int y = Integer.parseInt(date.substring(0, 4));
        int m = Integer.parseInt(date.substring(4, 6));
        int d = Integer.parseInt(date.substring(6, 8));
        
        java.util.GregorianCalendar sToday = new java.util.GregorianCalendar();
        sToday.set(y, m - 1, d);
        sToday.add(GregorianCalendar.DAY_OF_MONTH, plusDay);
        
        int day = sToday.get(GregorianCalendar.DAY_OF_MONTH);
        int month = sToday.get(GregorianCalendar.MONTH) + 1;
        int year = sToday.get(GregorianCalendar.YEAR);
        
        String sNowyear = String.valueOf(year);
        String sNowmonth = "";
        String sNowday = "";
        
        if (month < 10)
            sNowmonth = "0" + String.valueOf(month);
        else
            sNowmonth = String.valueOf(month);
        
        if (day < 10)
            sNowday = "0" + String.valueOf(day);
        else
            sNowday = String.valueOf(day);
        
        return sNowyear + format + sNowmonth + format + sNowday;
        
    }

    /**
     * @Method Name : getAddMonth
     * @Method Desc : 특정날짜에 달을 더한 값
     * @param date
     * @param plusMonth
     * @return
     */
    public static String getAddMonth(String date, int plusMonth) {
        return getAddMonth(date, plusMonth, "");
    }
    
    /**
     * @Method Name : getAddMonth
     * @Method Desc : 특정날짜에 달을 더한 값
     * @param date
     * @param plusMonth
     * @param format
     * @return
     */
    public static String getAddMonth(String date, int plusMonth, String format) {
        
        if (date == null)
            return "";
        
        if (date.equals("99991231")) {
            return "99991231";
        }
        
        int y = Integer.parseInt(date.substring(0, 4));
        int m = Integer.parseInt(date.substring(4, 6));
        int d = Integer.parseInt(date.substring(6, 8));
        
        java.util.GregorianCalendar sToday = new java.util.GregorianCalendar();
        sToday.set(y, m - 1, d);
        sToday.add(GregorianCalendar.MONTH, plusMonth);
        
        int day = sToday.get(GregorianCalendar.DAY_OF_MONTH);
        int month = sToday.get(GregorianCalendar.MONTH) + 1;
        int year = sToday.get(GregorianCalendar.YEAR);
        
        String sNowyear = String.valueOf(year);
        String sNowmonth = "";
        String sNowday = "";
        
        if (month < 10)
            sNowmonth = "0" + String.valueOf(month);
        else
            sNowmonth = String.valueOf(month);
        
        if (day < 10)
            sNowday = "0" + String.valueOf(day);
        else
            sNowday = String.valueOf(day);
        
        return sNowyear + format + sNowmonth + format + sNowday;
        
    }
    
    /**
     * 년도 1900 - 9999, 월 01 - 12, 일 01 - 31, 시 00 - 23, 분 00 - 59, 초 00 - 59
     * 
     * @param param
     *            검사 문자열
     * 
     * @return 검사결과
     */
    public static boolean isDate(String param) {
        if (param == null || param.length() != 8)
            return false;
        
        try {
            int year = Integer.parseInt(param.substring(0, 4));
            int month = Integer.parseInt(param.substring(4, 6));
            int day = Integer.parseInt(param.substring(6, 8));
            
            if (year < 1900 || year > 9999)
                return false;
            if (month < 1 || month > 12)
                return false;
            if (day < 1 || day > 31)
                return false;
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * 년도 1900 - 9999, 월 01 - 12, 일 01 - 31, 시 00 - 23, 분 00 - 59, 초 00 - 59
     * 
     * @param param
     *            검사 문자열
     * 
     * @return 검사결과
     */
    public static boolean isTime(String param) {
        if (param == null || param.length() != 6)
            return false;
        
        try {
            int hour = Integer.parseInt(param.substring(0, 2));
            int min = Integer.parseInt(param.substring(2, 4));
            int sec = Integer.parseInt(param.substring(4, 6));
            
            if (hour < 0 || hour > 23)
                return false;
            if (min < 0 || min > 59)
                return false;
            if (sec < 0 || sec > 59)
                return false;
            
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * 현재년월에서 다음 한달후 년월을 불러온다.
     * 
     * @param month
     *            YYYYMM 타입으로 년월
     * @return 년월을 String으로 리턴한다.
     */
    public static String getNextMonth(String month) {
        return getNextMonth(month, "");
    }
    
    public static String getNextMonth(String month, String format) {
        String lsYear = null;
        String lsMonth = null;
        
        int liYear = Integer.parseInt(month.substring(0, 4));
        int liMonth = Integer.parseInt(month.substring(4, 6));
        
        if (liMonth == 12) {
            liMonth = 1;
            liYear++;
        } else
            liMonth++;
        
        lsYear = liYear + "";
        
        if (liMonth < 10)
            lsMonth = "0" + liMonth;
        else
            lsMonth = "" + liMonth;
        
        return lsYear + format + lsMonth;
    }
    
    /**
     * 현재년월에서 이전 한달전 년월을 불러온다.
     * 
     * @param Month
     *            YYYYMM 타입으로 년월
     * @return 년월을 String으로 리턴한다.
     */
    public static String getPrevMonth(String Month) {
        return getPrevMonth(Month, "");
    }
    
    public static String getPrevMonth(String Month, String format) {
        String lsYear = null;
        String lsMonth = null;
        
        int liYear = Integer.parseInt(Month.substring(0, 4));
        int liMonth = Integer.parseInt(Month.substring(4, 6));
        
        if (liMonth == 1) {
            liMonth = 12;
            liYear--;
        } else
            liMonth--;
        
        lsYear = liYear + "";
        
        if (liMonth < 10)
            lsMonth = "0" + liMonth;
        else
            lsMonth = liMonth + "";
        
        return lsYear + format + lsMonth;
        
    }
    
    /**
     * @Method Name : getCurrentYear
     * @Method Desc : 현재 년도 표시
     * @return
     */
    public static String getCurrentYear() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("yyyy",
                Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format(currentTime);
        
        return mTime;
    }
    
    /**
     * @Method Name : getCurrentMonth
     * @Method Desc : 현재 월 표시
     * @return
     */
    public static String getCurrentMonth() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("MM",
                Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format(currentTime);
        
        return mTime;
    }
    
    /**
     * @Method Name : getCurrentDay
     * @Method Desc : 현재 일 표시
     * @return
     */
    public static String getCurrentDay() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("dd",
                Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format(currentTime);
        
        return mTime;
    }
    
    /**
     * @Method Name : getCurrentDate
     * @Method Desc : 현재 년도월일 표시
     * @return
     */
    public static String getCurrentDate() {
        return getCurrentDate("");
    }
    
    /**
     * @Method Name : getCurrentDate
     * @Method Desc : 현재 년도 + str + 월 + str + 일 표시
     * @param str
     * @return
     */
    public static String getCurrentDate(String str) {
        String pattern = "yyyy" + str + "MM" + str + "dd";
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat(pattern,
                Locale.KOREA);
        Date currentDate = new Date();
        String mDate = mSimpleDateFormat.format(currentDate);
        
        return mDate;
    }
    
    /**
     * @Method Name : getCurrentTime
     * @Method Desc : 현재 시분초 표시
     * @return
     */
    public static String getCurrentTime() {
        return getCurrentTime("");
    }
    
    /**
     * @Method Name : getCurrentTime
     * @Method Desc : 현재 시 + str + 분 + str + 초 표시
     * @param str
     * @return
     */
    public static String getCurrentTime(String str) {
        String pattern = "HH" + str + "mm" + str + "ss";
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat(pattern,
                Locale.KOREA);
        Date currentDate = new Date();
        String mDate = mSimpleDateFormat.format(currentDate);
        
        return mDate;
    }
    
    /**
     * @Method Name : getCurrentHH
     * @Method Desc : 현재 시간 표시
     * @return
     */
    public static String getCurrentHH() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("HH",
                Locale.KOREA);
        Date currentDate = new Date();
        String mDate = mSimpleDateFormat.format(currentDate);
        
        return mDate;
    }
    
    /**
     * @Method Name : getCurrentMM
     * @Method Desc : 현재 분 표시
     * @return
     */
    public static String getCurrentMM() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("mm",
                Locale.KOREA);
        Date currentDate = new Date();
        String mDate = mSimpleDateFormat.format(currentDate);
        
        return mDate;
    }
    
    /**
     * @Method Name : getCurrentSS
     * @Method Desc : 현재 시 표시
     * @return
     */
    public static String getCurrentSS() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("ss",
                Locale.KOREA);
        Date currentDate = new Date();
        String mDate = mSimpleDateFormat.format(currentDate);
        
        return mDate;
    }
    
    /**
     * @Method Name : getCurrentDateTime
     * @Method Desc : 현재 년월일시분초 표시
     * @return
     */
    public static String getCurrentDateTime() {
        return getCurrentDateTime("");
    }
    
    /**
     * @Method Name : getCurrentDateTime
     * @Method Desc : 현재 년 + str + 월 + str + 일시분초 표시
     * @param str
     * @return
     */
    public static String getCurrentDateTime(String str) {
        return getCurrentDateTime(str, "");
    }
    
    /**
     * @Method Name : getCurrentDateTime
     * @Method Desc : 현재 년 + str1 + 월 + str1 + 일 + str2 + 시분초 표시
     * @param str1
     * @param str2
     * @return
     */
    public static String getCurrentDateTime(String str1, String str2) {
        return getCurrentDateTime(str1, str2, "");
    }
    
    /**
     * @Method Name : getCurrentDateTime
     * @Method Desc : 현재 년 + str1 + 월 + str1 + 일 + str2 + 시 + str3 + 분 + str3 +
     *         초 표시
     * @param str1
     * @param str2
     * @param str3
     * @return
     */
    public static String getCurrentDateTime(String str1, String str2,
            String str3) {
        String pattern = "yyyy" + str1 + "MM" + str1 + "dd" + str2 + "HH"
                + str3 + "mm" + str3 + "ss";
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat(pattern,
                Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format(currentTime);
        
        return mTime;
    }
    
    /**
     * @Method Name : getCurrentDuplDateTime
     * @Method Desc : 현재 년월일시분초 표시 (시를 더 상세하게)
     * @return
     */
    public static String getCurrentDuplDateTime() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat(
                "yyyyMMddHHmmssSSS", Locale.KOREA);
        Date currentTime = new Date();
        String mTime = mSimpleDateFormat.format(currentTime);
        
        return mTime;
    }
}