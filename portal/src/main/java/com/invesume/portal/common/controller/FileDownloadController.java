package com.invesume.portal.common.controller;


import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.invesume.portal.common.util.CommonUtil;

@RequestMapping("webFile")
@Controller
public class FileDownloadController implements ApplicationContextAware {
    private Logger log = LoggerFactory.getLogger(getClass());
    
    @Autowired(required = false)
    private WebApplicationContext context = null;

    public void setApplicationContext(ApplicationContext arg0)
            throws BeansException {
        this.context = (WebApplicationContext)arg0;
    }

    @RequestMapping("downloadFile.action")
    public ModelAndView downloadFile(ModelMap map, HttpServletRequest request, @RequestParam Map<String,Object> params) throws Exception {
        return new ModelAndView("fileDownloadView", "downloadFile" , CommonUtil.isNull(params.get("file")));
    }

    @RequestMapping("imgFileView.action")
    public ResponseEntity<byte[]>  imgFileView(@RequestParam("path")String path) throws Exception {
        log.info("method name is {}", "imgFileView");
        log.info("params is {} = {}", "path", path);
        
        FileInputStream fin = new FileInputStream(new File(path));
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity<byte[]>(IOUtils.toByteArray(fin), headers, HttpStatus.CREATED);
    }
    
}
