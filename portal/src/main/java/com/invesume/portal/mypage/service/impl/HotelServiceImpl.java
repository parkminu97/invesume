package com.invesume.portal.mypage.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.PagingUtil;
import com.invesume.portal.mypage.service.HotelService;

@Service
public class HotelServiceImpl implements HotelService {
	@Autowired
    private HotelDAO hotelDao;

	@Override
	public Map<String, Object> hotelInfo(Map<String, Object> params) {
		return hotelDao.hotelInfo(params);
	}

	@Override
	public void hotelInfoInsert(Map<String, Object> params) {
		hotelDao.hotelInfoInsert(params);
	}

	@Override
	public void hotelInfoUpdate(Map<String, Object> params) {
		hotelDao.hotelInfoUpdate(params);
	}

	@Override
	public void hotelRoomList(Map<String, Object> params) {
		PagingUtil pagingUtil = new PagingUtil(Integer.parseInt(CommonUtil.isNull(params.get("currentPage"), "1")), Integer.parseInt(CommonUtil.isNull(params.get("pageRow"), "10")));
        pagingUtil.setTotalCount(hotelDao.hotelRoomListCount(params));
        
        params.put("pageRow", pagingUtil.getPageRow());
        params.put("currentPage", pagingUtil.getCurrentPage());
        pagingUtil.setList(hotelDao.hotelRoomList(params));
        
        params.put("pagingList", pagingUtil);
	}

	@Override
	public Map<String, Object> hotelRoomView(Map<String, Object> params) {
		return hotelDao.hotelRoomView(params);
	}

	@Override
	public void hotelRoomInsert(Map<String, Object> params) {
		hotelDao.hotelRoomInsert(params);
	}

	@Override
	public void hotelRoomUpdate(Map<String, Object> params) {
		hotelDao.hotelRoomUpdate(params);
	}

	@Override
	public void hotelRoomDelete(Map<String, Object> params) {
		hotelDao.hotelRoomDelete(params);
	}

	@Override
	public List<Map<String, Object>> hotelRoomImgList(Map<String, Object> params) {
		return hotelDao.hotelRoomImgList(params);
	}

	@Override
	public void hotelRoomImgInsert(Map<String, Object> params) {
		hotelDao.hotelRoomImgInsert(params);
	}

	@Override
	public void hotelRoomImgDelete(Map<String, Object> params) {
		hotelDao.hotelRoomImgDelete(params);
	}

	@Override
	public void hotelRoomRepImgUpdate(Map<String, Object> params) {
		hotelDao.hotelRoomRepImgUpdate(params);
	}

	@Override
	public void hotelRepImgUpdate(Map<String, Object> params) {
		hotelDao.hotelRepImgUpdate(params);
	}

	@Override
	public List<Map<String, Object>> hotelMenuList(Map<String, Object> params) {
		return hotelDao.hotelMenuList(params);
	}

	@Override
	public void hotelMenuUpdate(Map<String, Object> params) {
		hotelDao.hotelMenuUpdate(params);
	}

	@Override
	public int guestUserCount(Map<String, Object> params) {
		return hotelDao.guestUserCount(params);
	}

	@Override
	public int custReservationCount(Map<String, Object> params) {
		return hotelDao.custReservationCount(params);
	}
}
