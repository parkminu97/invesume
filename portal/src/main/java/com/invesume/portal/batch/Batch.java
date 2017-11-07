package com.invesume.portal.batch;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.invesume.portal.common.util.DateUtil;
import com.invesume.portal.main.service.PayService;

@Component
public class Batch {
    private Logger log = LoggerFactory.getLogger(getClass());
    
    @Autowired
    private PayService payService;

    public void serviceStatusCheck() throws Exception {
        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> serviceStatusCheck Method Start {}", DateUtil.getCurrentDateTime());

        Map<String,Object> params = new HashMap<String, Object>();
        payService.serviceEndUpdate(params);

        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> serviceStatusCheck Method End {}", DateUtil.getCurrentDateTime());
    }
}