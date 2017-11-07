package com.invesume.portal.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.invesume.portal.common.util.CommonUtil;

public class FileDownloadView extends AbstractView {

    public FileDownloadView(){
        setContentType("application/octet-stream; charset=utf-8");
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        File file = (File)model.get("downloadFile");
        String fileName = file.getName();
        
        OutputStream os = null;
        FileInputStream fis = null;
        try {
            response.reset() ;
            response.setContentType("application/octet-stream; charset=utf-8");
            String client = CommonUtil.isNull(request.getHeader("User-Agent"), "MSIE");

            logger.info("FileDownload Client is " + client);

            if(client.indexOf("MSIE") > -1 || client.indexOf("Trident") > -1) {
                fileName = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
            } else {
                fileName = new String(fileName.getBytes("utf-8"),"iso-8859-1");
            }  
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.setHeader ("Content-Length", ""+file.length() );
            response.setHeader("Pragma", "");
            os = response.getOutputStream();
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, os);
        } catch(Exception e) {
            logger.error("FileDownloadView Exception" , e);
        } finally {
            fis.close();
            os.close();
            if(file.exists()) {
              file.delete();
          }
        }
        os.flush();
    }
}