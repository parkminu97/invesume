package com.invesume.portal.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.PagingUtil;
import com.invesume.portal.user.service.UserService;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDAO userDao;

    @Override
    public Map<String, Object> adminUserInfo(Map<String, Object> params) {
        return userDao.adminUserInfo(params);
    }

    @Override
    public List<Map<String, Object>> portalUserInfo(Map<String, Object> params) {
        return userDao.portalUserInfo(params);
    }

	@Override
	public void portalUserInsert(Map<String, Object> params) {
		userDao.portalUserInsert(params);
	}

	@Override
	public void portalUserUpdate(Map<String, Object> params) {
		userDao.portalUserUpdate(params);
	}

	@Override
	public void portalUserPasswordUpdate(Map<String, Object> params) {
		userDao.portalUserPasswordUpdate(params);
	}

	@Override
	public List<Map<String, Object>> hotelUserInfo(Map<String, Object> params) {
		return userDao.hotelUserInfo(params);
	}

	@Override
	public void hotelUserInsert(Map<String, Object> params) {
		userDao.hotelUserInsert(params);
	}

	@Override
	public void hotelUserUpdate(Map<String, Object> params) {
		userDao.hotelUserUpdate(params);
	}

	@Override
	public void hotelUserDelete(Map<String, Object> params) {
		userDao.hotelUserDelete(params);
	}

	@Override
	public void portalCustList(Map<String, Object> params) {
		PagingUtil pagingUtil = new PagingUtil(Integer.parseInt(CommonUtil.isNull(params.get("currentPage"), "1")), Integer.parseInt(CommonUtil.isNull(params.get("pageRow"), "10")));
        pagingUtil.setTotalCount(userDao.portalUserListCount(params));
        
        params.put("pageRow", pagingUtil.getPageRow());
        params.put("currentPage", pagingUtil.getCurrentPage());
        pagingUtil.setList(userDao.portalUserList(params));
        
        params.put("pagingList", pagingUtil);
	}

	@Override
	public void portalUserDelete(Map<String, Object> params) {
		userDao.portalUserDelete(params);
	}
}