package com.invesume.portal.mypage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HotelDAO extends SqlSessionDaoSupport {
    @Autowired
    @Resource(name="sqlSessionTemplate")
    private SqlSession sqlSessionTemplate;

    @Autowired
    @Resource(name="sqlSessionTemplate2")
    private SqlSession sqlSessionTemplate2;

    public Map<String, Object> hotelInfo(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("hotel.hotelInfo", params);
    }

    public void hotelInfoInsert(Map<String, Object> params) {
    	sqlSessionTemplate.insert("hotel.hotelInfoInsert", params);
    }

    public void hotelInfoUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("hotel.hotelInfoUpdate", params);
    }
    
    public List<Map<String, Object>> hotelRoomList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("hotel.hotelRoomList", params);
    }

    public int hotelRoomListCount(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("hotel.hotelRoomListCount", params);
    }

    public Map<String, Object> hotelRoomView(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("hotel.hotelRoomView", params);
    }

    public void hotelRoomInsert(Map<String, Object> params) {
    	sqlSessionTemplate.insert("hotel.hotelRoomInsert", params);
    }

    public void hotelRoomUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("hotel.hotelRoomUpdate", params);
    }

    public void hotelRoomDelete(Map<String, Object> params) {
    	sqlSessionTemplate.delete("hotel.hotelRoomDelete", params);
    }

    public List<Map<String, Object>> hotelRoomImgList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("hotel.hotelRoomImgList", params);
    }

    public void hotelRoomImgInsert(Map<String, Object> params) {
    	sqlSessionTemplate.insert("hotel.hotelRoomImgInsert", params);
    }

    public void hotelRoomImgDelete(Map<String, Object> params) {
    	sqlSessionTemplate.delete("hotel.hotelRoomImgDelete", params);
    }

    public void hotelRoomRepImgUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("hotel.hotelRoomRepImgUpdate", params);
    }

    public void hotelRepImgUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("hotel.hotelRepImgUpdate", params);
    }

    public List<Map<String, Object>> hotelMenuList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("hotel.hotelMenuList", params);
    }

    public void hotelMenuUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.update("hotel.hotelMenuUpdate", params);
    }

    public int guestUserCount(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("hotel.guestUserCount", params);
    }

    public int custReservationCount(Map<String, Object> params) {
    	return sqlSessionTemplate2.selectOne("hotel.custReservationCount", params);
    }

}