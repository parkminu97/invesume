package com.invesume.portal.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PayDAO extends SqlSessionDaoSupport {
    @Autowired
    @Resource(name="sqlSessionTemplate")
    private SqlSession sqlSessionTemplate;
    
    public void productPayment(Map<String, Object> params) {
    	sqlSessionTemplate.selectOne("pay.productPayment", params);
    }

    public List<Map<String, Object>> useProductList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("pay.useProductList", params);
    }

    public List<Map<String, Object>> productPaymentList(Map<String, Object> params) {
    	return sqlSessionTemplate.selectList("pay.productPaymentList", params);
    }

    public int productPaymentListCount(Map<String, Object> params) {
    	return sqlSessionTemplate.selectOne("pay.productPaymentListCount", params);
    }
    
    public void serviceEndUpdate(Map<String, Object> params) {
    	sqlSessionTemplate.selectOne("pay.serviceEndUpdate", params);
    }
}
