<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <link href="${httpCtxPath}/resources/css/products.css" rel="stylesheet" type="text/css"/>
    <link href="${httpCtxPath}/resources/css/my_room.css" rel="stylesheet" type="text/css"/>
    <style>
		.clearfix:after { content: "."; display: block; clear: both; visibility: hidden; line-height: 0; height: 0;}
		.clearfix { display: inline-block; }
		
		html[xmlns] .clearfix { display: block; }
		.mt10 { margin-top: 10px;}
		
		.left_box { position: relative;}
		.client {width: 200px; height: 201px; background-color: #333333; float: left;}
		.client > p:nth-child(1) { height: 55px; padding-top: 5px;}
		.client > p:nth-child(2) { color: #fff; font-size: 30px;text-align: right;padding-right: 10px;padding-top:70px;}
		.reserv {width: 200px; height: 201px; background-color: #333333; float: left; margin-left: 3px;}
		.reserv > p:nth-child(1) { height: 55px; padding-top: 5px;}
		.reserv > p:nth-child(2) { color: #fff; font-size: 30px;text-align: right;padding-right: 10px;padding-top:70px;}
		
		.right_box { margin-left: 7px;}
		
		.both_box { position: relative; }
		.moblie { background-color: #3e596e; width: 142px; height: 60px;}
		
		.form_table{border:1px solid #d9dadc;}
		.form_table th,.form_table td{text-align:left;}
		.form_table th{background-color: #3c586d;}
		.form_table td {background-image: url(${httpCtxPath}/resources/img/t_bg.jpg);padding-left:10px;}
		.submit{text-align:right;margin-top:10px;}
    </style>
    <script>
    $(window).load(function() {
    });
    
    function fn_view(no) {
        popUp("${httpCtxPath}/boardView.action?board_gubun=H&no="+no, "PortalDashBoardPopup", "700", "500");
    }

    </script>
</head>
<body>
<form id="listForm" name="listForm" method="post">
    <%@include file="/WEB-INF/views/include/top.jsp" %>

    <div class="my_page">
        <%@include file="/WEB-INF/views/include/left.jsp" %>
        <div class="my_contents">
            <div class="content_title">
                <h2 style="float:left;">대시보드</h2>
                <p style="float:right;">HOME &gt; 마이페이지 &gt; 대시보드</p>
            </div>

            <table>
            <tr>
                <td width="50%" valign="top">
		            <div class="left_box clearfix">
		                <div class="client">
		                    <p><img src="${httpCtxPath}/resources/img/t_img.jpg"></p>
		                    <p>${guestUserCount} 명</p>
		                </div>
		                <div class="reserv">
		                    <p><img src="${httpCtxPath}/resources/img/t_img02.jpg"></p>
		                    <p>${custReservationCount} 건</p>
		                </div>
		            </div>
                </td>
                <td style="vertical-align: top; padding-left:20px">
	                <table class="r_table">
	                    <thead>
	                        <tr>
	                            <th colspan="2">공지사항</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach items="${listInfo.list}" var="data" varStatus="status">
	                        <tr>
	                            <td style="text-align:left;padding-left:10px;width:70%;height:31px"><a href="javascript:fn_view('${data.no}');">${data.subject}</a></td>
	                            <td style="height:31px">${data.insert_dt}</td>
	                        </tr>
	                        </c:forEach>
	                        <c:forEach begin="${listInfo.totalCount+1}" end="5" step="1">
	                        <tr>
	                           <td colspan="2" style="height:31px">&nbsp;</td>
	                        </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
                </td>
            </tr>
            </table>

	        <div class="both_box">
	            <table class="form_table" style="width: 805px;">
                    <colgroup>
                        <col width="201px" />
                        <col width="*" />
                    </colgroup>
	                <tbody>
	                    <tr>
	                        <th><img src="${httpCtxPath}/resources/img/m.jpg"></th>
	                        <td><a href="https://hcall.io:8098/?hn=${sessionScope.userInfo.user_no}" target="_blank">https://hcall.io:8098/?hn=${sessionScope.userInfo.user_no}</a></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	        
	        <div class="both_box mt10">
                <table class="form_table" style="width: 805px;">
                    <colgroup>
                        <col width="201px" />
	                    <col width="*" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th><img src="${httpCtxPath}/resources/img/m02.jpg"></th>
                            <td><a href="https://hcall.io:8078/?hn=${sessionScope.userInfo.user_no}​" target="_blank">https://hcall.io:8078/?hn=${sessionScope.userInfo.user_no}</a></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
        </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</form>
</body>
</html>
