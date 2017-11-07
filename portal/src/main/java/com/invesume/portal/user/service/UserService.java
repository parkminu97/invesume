package com.invesume.portal.user.service;

import java.util.List;
import java.util.Map;

public interface UserService {
	Map<String, Object> adminUserInfo(Map<String, Object> params);
    List<Map<String, Object>> portalUserInfo(Map<String, Object> params);
    void portalUserInsert(Map<String, Object> params);
    void portalUserUpdate(Map<String, Object> params);
    void portalUserPasswordUpdate(Map<String, Object> params);
    List<Map<String, Object>> hotelUserInfo(Map<String, Object> params);
    void hotelUserInsert(Map<String, Object> params);
    void hotelUserUpdate(Map<String, Object> params);
    void hotelUserDelete(Map<String, Object> params);
    void portalCustList(Map<String, Object> params);
    
    void portalUserDelete(Map<String, Object> params);
}