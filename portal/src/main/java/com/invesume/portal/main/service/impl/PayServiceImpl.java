package com.invesume.portal.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.invesume.portal.common.util.CommonUtil;
import com.invesume.portal.common.util.PagingUtil;
import com.invesume.portal.main.service.PayService;

@Service
public class PayServiceImpl implements PayService{
    @Autowired
    private PayDAO payDao;

	@Override
	public void productPayment(Map<String, Object> params) {
		payDao.productPayment(params);
	}

	@Override
	public List<Map<String, Object>> useProductList(Map<String, Object> params) {
		return payDao.useProductList(params);
	}

	@Override
	public void productPaymentList(Map<String, Object> params) {
		PagingUtil pagingUtil = new PagingUtil(Integer.parseInt(CommonUtil.isNull(params.get("currentPage"), "1")), Integer.parseInt(CommonUtil.isNull(params.get("pageRow"), "10")));
        pagingUtil.setTotalCount(payDao.productPaymentListCount(params));
        
        params.put("pageRow", pagingUtil.getPageRow());
        params.put("currentPage", pagingUtil.getCurrentPage());
        pagingUtil.setList(payDao.productPaymentList(params));
        
        params.put("pagingList", pagingUtil);
	}

	@Override
	public void serviceEndUpdate(Map<String, Object> params) {
		payDao.serviceEndUpdate(params);
	}

	
}
