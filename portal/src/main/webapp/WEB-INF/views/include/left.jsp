<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <nav class="left_nav_wrap">
            <ul class="left_nav">
                <li class="nav_title">마이페이지</li>
                <c:if test="${sessionScope.userInfo.admin eq 'Y'}">
                <li><a href="${httpCtxPath}/mypage/portalCustList.action" target="_self">고객관리</a></li>
                <li><a href="${httpCtxPath}/mypage/productPaymentList.action" target="_self">결제현황</a></li>
                <li><a href="${httpCtxPath}/mypage/boardList.action?board_gubun=P" target="_self">공지사항관리</a></li>
                </c:if>
                <c:if test="${sessionScope.userInfo.admin eq 'N'}">
                <li><a href="${httpCtxPath}/mypage/dashBoard.action" target="_self">대시보드</a></li>
                <li><a href="${httpCtxPath}/mypage/info.action" target="_self">회원정보</a></li>
                <li><a href="${httpCtxPath}/mypage/productPaymentList.action" target="_self">결제현황</a></li>
                <li><a href="#" target="_self">호텔셋팅</a></li>
                <li class="sub_m_bg sub_gr sub_h_setting"><a href="${httpCtxPath}/mypage/hotelInfo.action" target="_self">호텔정보</a></li>
                <li class="sub_m_bg sub_h_setting"><a href="${httpCtxPath}/mypage/hotelRoomList.action" target="_self">호텔객실관리</a></li>
                <li class="n_click"><a href="#" target="_self">게시판</a></li>
                <li class="sub_m_bg sub_gr sub_h_board"><a href="${httpCtxPath}/mypage/boardList.action?board_gubun=H" target="_self">공지사항</a></li>
                <li class="sub_m_bg sub_h_board"><a href="${httpCtxPath}/mypage/boardList.action?board_gubun=E" target="_self">이벤트게시판</a></li>
                <li><a href="${httpCtxPath}/mypage/serviceComp.action" target="_self">서비스 구성관리</a></li>
                <li><a href="${httpCtxPath}/mypage/serviceState.action" target="_self">서비스 이용현황</a></li>
                </c:if>

            </ul>
        </nav>
