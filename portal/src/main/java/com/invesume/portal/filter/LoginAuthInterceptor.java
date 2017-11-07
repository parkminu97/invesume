package com.invesume.portal.filter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

import com.invesume.portal.annotation.LoginAuth;

public class LoginAuthInterceptor extends WebContentInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException {
        //어노테이션이 컨트롤러에 사용되었는지 체크함
        LoginAuth usingAuth = ((HandlerMethod) handler).getMethodAnnotation(LoginAuth.class);

        boolean isLogin = false;
        if(usingAuth != null) {
            if (request.getSession().getAttribute("userInfo") == null) {
                isLogin = true;
            }
        }

        if(isLogin) {
            try {
                response.sendRedirect(request.getContextPath() + "/login.action");
            } catch (IOException e) {
                e.printStackTrace();
            }

            return false;
        }
        
        return true;
    }

}