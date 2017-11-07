package com.invesume.portal.mail;


import java.io.File;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.invesume.portal.common.util.CommonUtil;

@Component("sendMail")
public class SendMail {
  @Autowired 
  private JavaMailSender mailSender;

  private Logger log = LoggerFactory.getLogger(getClass());
  
  public void sendMail(String subject, String content, String fromUser, String fromUserName, String[] toUser) {
      sendMail(subject, content, fromUser, fromUserName, toUser, null);
  }
  
  public void sendMail(String subject, String content, String fromUser, String fromUserName, String[] toUser, String[] toCC) {
      sendMail(subject, content, fromUser, fromUserName, toUser, toCC, null, null);
  }

  public void sendMail(String subject, String content, String fromUser, String fromUserName, String[] toUser, String[] toCC, String fileName, String filePath) {
      MimeMessage message = mailSender.createMimeMessage();
      log.info("> Send Mail Info");
      log.info("> Send Mail From User Name = {}", fromUserName);
      log.info("> Send Mail Subject = {}", subject);

      try {
          boolean isSend = true;
          if(CommonUtil.isNull(fromUser).equals("")) {
              log.info("> Send Mail Fail - 보내는 사람 이메일 주소 없음");
              isSend = false;
          }
          
          if(toUser == null) {
              log.info("> Send Mail Fail - 받는 사람 정보 없음");
              isSend = false;
          } else {
              for(int i = 0; i < toUser.length; i++) {
                  if(CommonUtil.isNull(toUser[i]).equals("")) {
                      log.info("> Send Mail Fail - 받는 사람 이메일 주소 없음");
                      isSend = false;
                      break;
                  }
              }
          }
          
          if(isSend) {
              MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
              messageHelper.setSubject(subject);
              if(fileName != null) messageHelper.addAttachment(fileName, new File(filePath));
              if(fromUserName.equals("")) messageHelper.setFrom(fromUser);
              else messageHelper.setFrom(fromUser, fromUserName);
              messageHelper.setTo(toUser);
              if(toCC != null) messageHelper.setCc(toCC);
              messageHelper.setText(content, true);
              mailSender.send(message);
              log.info("> Send Mail Success");
          }
      } catch (Exception e) {
          e.printStackTrace();
          //throw new RuntimeException("SendMail Fail");
      }
  }
}