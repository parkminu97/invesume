package com.invesume.portal.mypage.service;

import java.util.List;
import java.util.Map;

public interface HotelService {
	Map<String, Object> hotelInfo(Map<String, Object> params);
	void hotelInfoInsert(Map<String, Object> params);
	void hotelInfoUpdate(Map<String, Object> params);
	
	void hotelRoomList(Map<String, Object> params);
	Map<String, Object> hotelRoomView(Map<String, Object> params);
	void hotelRoomInsert(Map<String, Object> params);
	void hotelRoomUpdate(Map<String, Object> params);
	void hotelRoomDelete(Map<String, Object> params);	
	
	List<Map<String, Object>> hotelRoomImgList(Map<String, Object> params);
	void hotelRoomImgInsert(Map<String, Object> params);
	void hotelRoomImgDelete(Map<String, Object> params);
	void hotelRoomRepImgUpdate(Map<String, Object> params);
	
	void hotelRepImgUpdate(Map<String, Object> params);

	List<Map<String, Object>> hotelMenuList(Map<String, Object> params);
	void hotelMenuUpdate(Map<String, Object> params);
	int guestUserCount(Map<String, Object> params);
	int custReservationCount(Map<String, Object> params);
}
