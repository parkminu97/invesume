<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<c:if test="${sessionScope.userInfo.admin eq 'N'}">
<c:set var="userCheck" value="true"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
<script>
$(window).load(function(){
});

function fn_free_pay() {
    <c:if test="${userCheck ne 'true'}">
    alert("로그인을 하신 후 이용하시기 바랍니다.");
    return;
    </c:if>

	if(!confirm("15일간 Demo 서비스를 이용하시겠습니까?")) return;
    
	var params = {"type" : "1"};

    $.ajax({
        url : "${httpCtxPath}/productPayment.action",
        type : "POST",
        dataType : "json",
        data : params,
        async : false,
        success : function(response, status, request) {
            if(response == "1") {
                alert("정상적으로 Demo 서비스가 등록 되었습니다.");
                location.href = "${httpCtxPath}/mypage/info.action";
            } else if(response == "2") {
            	alert("현재 이용중인 서비스가 존재합니다.\n이용중인 서비스 종료 후 사용하시기 바랍니다.");
            } else {
                alert("Demo 서비스 등록 처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        },
        error : function(request,status,error) {
            alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
        }
    });

}

function fn_pay(type) {
    <c:if test="${userCheck ne 'true'}">
    alert("로그인을 하신 후 이용하시기 바랍니다.");
    return;
    </c:if>

	location.href = "${httpCtxPath}/payInfo.action?type="+type;
}
</script>
</head>
<body>
    <%@include file="/WEB-INF/views/include/top.jsp" %>
    <div class="titleimg_wrap">
        <img src="${httpCtxPath}/resources/img/titleimg_products.jpg" alt="products">
    </div><!--메뉴 대표이미지 끝 -->
    <div class="section_wrap">
        <section>
            <div class="content_title">
                <h2 style="float:left;">호텔클릭투콜 소개</h2>
                <p style="float:right;">HOME &gt; 호텔클릭투콜 소개</p>
            </div>
            <img src="${httpCtxPath}/resources/img/products_img1.jpg" alt="hotel click to call">
            <article class="article_inpo1">
                  <h3>Hotel Front page</h3>
                  <p>
                        고객에게 제공하는 서비스를 제어할 수 있는 프론트 페이지입니다.
                        클릭투콜의 대표적인 서비스로 영상채팅과 텍스트채팅, 픽드랍서비스와 체크인/아웃서비스를
                        함께 이용해 보실 수 있습니다.
                        영상채팅과 텍스트채팅을 번역시스템으로 보다 편리하게 고객과 대화가 가능합니다.

                  </p>
            </article>
            <article class="article_inpo2">
                  <h3>Mobile page</h3>
                  <p>고객에게 제공하는 서비스를 제어할 수 있는 프론트 페이지입니다.
                        클릭투콜의 대표적인 서비스로 영상채팅과 텍스트채팅, 픽드랍서비스와 체크인/아웃서비스를
                        함께 이용해 보실 수 있습니다.
                        영상채팅과 텍스트채팅을 번역시스템으로 보다 편리하게 고객과 대화가 가능합니다.</p>
            </article>
            <div class="content_title">
                <h2 style="float:left;">호텔클릭투콜 서비스</h2>
            </div>
            <ul class="service_inpo">
                <li>
                    <p>객실 체크인/아웃<br>
                    <span>Check IN/OUT</span></p>
                </li>
                <li>
                    <p>화상 통화하기<br>
                    <span>Face Chat</span></p>
                </li>
                <li>
                    <p>메세지 보내기<br>
                    <span>Message Chat</span></p>
                </li>
                <li>
                    <p>픽업/픽드랍 서비스<br>
                    <span>Pick up/Pick drop service</span></p>
                </li>
            </ul>
            <div class="content_title">
                <h2 style="float:left;">호텔클릭투콜 상품</h2>
            </div>
            <ul class="product_list">
                <li class="product"><h3 class="product_title">Demo<span>Free</span></h3>
                    <ul class="product_icon">
                        <li class="p_icon_d">1회 무료 15일 체험권</li>
                        <li class="p_icon_c">화상채팅 서비스</li>
                        <li class="p_icon_c2">텍스트채팅 서비스</li>
                    </ul>
                    <p class="product_text">
                        체험판 버전의 상품으로 유료 상품을 구매하기 전 체험을 위한 상품입니다. 
                    </p>    
                    <button class="product_payment" type="submit" onclick="fn_free_pay('1');">결제하기</button>
                </li>
                <li class="product"><h3 class="product_title">Basic<span>Free</span></h3>
                    <ul class="product_icon">
                        <li class="p_icon_d">30일 서비스 이용권</li>
                        <li class="p_icon_c">번역 페이스채팅 서비스</li>
                        <li class="p_icon_c2">번역 텍스트채팅 서비스</li>
                        <li class="p_icon_p">픽업/픽드랍 서비스</li>
                        <li class="p_icon_check">체크인/아웃 서비스</li>
                    </ul>
                    <p class="product_text">
                        일반 버전의 상품으로 개인 사용자를 위한 상품입니다.
                    </p>    
                    <button class="product_payment" type="submit" onclick="fn_pay('2');">결제하기</button>
                </li>
                <li class="product"><h3 class="product_title">Premium<span>Free</span></h3>
                    <ul class="product_icon">
                        <li class="p_icon_d">90일 서비스 이용권</li>
                        <li class="p_icon_c">번역 페이스채팅 서비스</li>
                        <li class="p_icon_c2">번역 텍스트채팅 서비스</li>
                        <li class="p_icon_p">픽업/픽드랍 서비스</li>
                        <li class="p_icon_check">체크인/아웃 서비스</li>
                    </ul>
                    <p class="product_text">
                        프리미엄 버전의 상품으로 그룹형 사용자를 위한 상품입니다.
                    </p>    
                    <button class="product_payment" type="submit" onclick="fn_pay('3');">결제하기</button>
                </li>
            </ul>
        </section>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html> 