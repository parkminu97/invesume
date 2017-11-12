<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <header>
        <div class="top_menu">
            <h1><a href="javascript:fn_home();" target="_self"><img src="${httpCtxPath}/resources/img/top_logo_w.png" alt="hotel click to call"></a></h1>
            <ul class="main_menu">
                <li><a href="${httpCtxPath}/intro.action" target="_self">호텔클릭투콜 소개</a></li>
                <li><a href="${httpCtxPath}/boardList.action?board_gubun=P" target="_self">공지사항</a></li>
                <li><a href="${httpCtxPath}/custCenter.action" target="_self">고객센터</a></li>
            </ul>
            <ul class="user_menu">
                <c:if test="${sessionScope.userInfo eq null}">
                <li><a href="${httpCtxPath}/portalUserInsert.action" target="_self">회원가입</a></li>
                <li><a href="${httpCtxPath}/login.action" target="_self">로그인</a></li>
                <li><a href="${httpCtxPath}/payTest.action" target="_self">결제테스트</a></li>
                </c:if>
                <c:if test="${sessionScope.userInfo ne null}">
                <c:if test="${sessionScope.userInfo.admin eq 'Y'}">
                <li><a href="${httpCtxPath}/mypage/portalCustList.action" target="_self">마이페이지</a></li>
                </c:if>
                <c:if test="${sessionScope.userInfo.admin ne 'Y'}">
                <li><a href="${httpCtxPath}/mypage/dashBoard.action" target="_self">마이페이지</a></li>
                </c:if>
                <li><a href="javascript:fn_logout();" target="_self">로그아웃</a></li>
                </c:if>
            </ul>
        </div>
    </header>