package com.invesume.portal.main.service;

import java.util.List;
import java.util.Map;

public interface PayService {
	void productPayment(Map<String, Object> params);
	List<Map<String, Object>> useProductList(Map<String, Object> params);
	void productPaymentList(Map<String, Object> params);
	void serviceEndUpdate(Map<String, Object> params);
	
}
