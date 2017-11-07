package com.invesume.portal.user.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO extends SqlSessionDaoSupport {
    @Autowired
    @Resource(name="sqlSessionTemplate")
    private SqlSession sqlSessionTemplate;
    
    public Map<String, Object> adminUserInfo(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("user.adminUserInfo", params);
    }

    public List<Map<String, Object>> portalUserInfo(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("user.portalUserInfo", params);
    }

    public List<Map<String, Object>> portalUserList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("user.portalUserList", params);
    }

    public int portalUserListCount(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("user.portalUserListCount", params);
    }

    public void portalUserInsert(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.portalUserInsert", params);
    }

    public void portalUserUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.portalUserUpdate", params);
    }

    public void portalUserPasswordUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.portalUserPasswordUpdate", params);
    }

    public List<Map<String, Object>> hotelUserInfo(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("user.hotelUserInfo", params);
    }
    
    public void hotelUserInsert(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.hotelUserInsert", params);
    }

    public void hotelUserUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.hotelUserUpdate", params);
    }

    public void hotelUserDelete(Map<String, Object> params) {
    	sqlSessionTemplate.delete("user.hotelUserDelete", params);
    }
    
    public void portalUserDelete(Map<String, Object> params) {
    	sqlSessionTemplate.update("user.portalUserDelete", params);
    }

}