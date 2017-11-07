<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/tagLib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/views/include/head.jsp" %>
<link href="${httpCtxPath}/resources/css/payment.css" rel="stylesheet" type="text/css"/>
<script>
$(window).load(function(){
});

function fn_pay() {
    if(!confirm("결제 하시겠습니까?")) return;
    var type = "${params.type}";
    var typeDesc = "";
    if(type == "2") typeDesc = "Basic";
    else if(type == "3") typeDesc = "Premium";
    
	var params = {"type" : type};

    $.ajax({
        url : "${httpCtxPath}/productPayment.action",
        type : "POST",
        dataType : "json",
        data : params,
        async : false,
        success : function(response, status, request) {
            if(response == "1") {
                alert("정상적으로 " +typeDesc+" 서비스가 등록 되었습니다.");
                location.href = "${httpCtxPath}/mypage/info.action";
            } else if(response == "2") {
            	alert("현재 이용중인 서비스가 존재합니다.\n이용중인 서비스 종료 후 사용하시기 바랍니다.");
            } else {
                alert(typeDesc + "서비스 등록 처리 중 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
            }
        },
        error : function(request,status,error) {
            alert("시스템 오류가 발생하였습니다.\n관리자에게 문의하시기 바랍니다.");
        }
    });

}
</script>
</head>
<body>
    <%@include file="/WEB-INF/views/include/top.jsp" %>
    <div class="section_wrap">
        <section>
            <div class="pay_wrap">
                <div class="pay_left"><!--결제방법선택과 카드결제내용-->
                    <div class="content_title">
                        <h2 style="float:left;">상품결제</h2>
                    </div>
                    <div class="pay_left_top">
                        <label class="pay_radio">
                            <input id="q_filetype" name="q_filetype" value="" checked="checked" type="radio">카드결제
                        </label>
                        <label class="pay_radio">
                            <input id="q_filetype" name="q_filetype" value="DOC" type="radio">실시간 계좌이체
                        </label>
                        <label class="pay_radio">
                            <input id="q_filetype" name="q_filetype" value="IMG" type="radio">무통장 입금
                        </label>
                        <label class="pay_radio">
                            <input id="q_filetype" name="q_filetype" value="VID" type="radio">휴대폰결제
                        </label>
                    </div>
                    <table>
                        <tr>
                            <th>카드결제</th>
                            <td>
                                <select>
                                    <option value="10">선택해주세요.</option>
                                    <option value="20">우리은행</option>
                                    <option value="30">국민은행</option>
                                    <option value="50">기업은행</option>
                                    <option value="100">농협은행</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>할부기간</th>
                            <td>
                                <select>
                                    <option value="10">3개월</option>
                                    <option value="20">6개월</option>
                                    <option value="30">12개월</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>결제안내</th>
                            <td>
                                <button id="" class="btn_1" type="button">공인인증서 발급안내</button>
                                <button id="" class="btn_2" type="button">안심클릭 안내</button>
                                <button id="" class="btn_3" type="button">안전결제(ISP) 안내</button>
                            </td>
                        </tr>
                    </table>
                    <div class="pay_check">
                        <label>
                            <input value="" label="" checked="checked" type="checkbox">결제대행서비스 약관에 모두 동의합니다.
                        </label>
                    </div>
                    <div class="pay_t">
                        <div class="pay_t_title">청약철회방침</div>
                        <div class="pay_t_wrap">
                            <div class="pay_t_text">
                                <p>친구의 이야기를 다 들었을 때 나에게는, 친구의 의도와 상관 없이, 거대한 암흑의 이미지가 떠올라 있었다. 다른 친구들은 그 친구의 이야기를 거의 듣지 않은 듯싶었다. 왜냐하면 토요일 오후였기 때문이다. 그러나 나에게는 친구의 이야기가 화창한 토요일 오후와 대비되어 더욱 강렬하게 다가왔었다. 무엇보다도 친구의 들뜨고 밝은 표정이 깊은 인상을 남겼다.친구에게 그 이야기를 재차 확인하고 싶었지만 어쩐지 입이 떨어지지 않았다. 자동차로 한두 시간 거리에 그토록 어둠에 찬 곳이 있다는 사실이 우선 믿기지 않았다. 그리고 그런 곳에 사는 것이 왜 그리 즐겁고 들뜬 일인지 짐작할 수조차 없었다.</p>
                            </div>
                            <label>
                                <input value="" checked="checked" type="checkbox">동의함
                            </label>
                        </div><!--pay_t_wrap end-->

                    </div>

                    <p class="pay_n"><a href="#" target="_self" >상품결제취소</a></p>
                    <img src="${httpCtxPath}/resources/img/pay_refund.jpg" alt="환불규정" style="margin-bottom:30px;">
                </div><!-- pay_left end -->
                <div class="pay_right">
                    <h3>호텔클릭투콜 3개월 이용권</h3>
                    <table>
                        <tr>
                            <th>이용기간</th>
                            <td>2017.3.1~2017.6.2</td>
                        </tr>
                        <tr>
                            <th>이용금액</th>
                            <td>120,000원</td>
                        </tr>
                        <tr>
                            <th>할인적용</th>
                            <td>할인적용없음</td>
                        </tr>
                    </table>
                    <p class="pay_f">
                        최종결제금액<br><span>120,000원</span>
                    </p>
                    <p class="pay_y"><a href="javascript:fn_pay();" target="_self" >결제하기</a></p>
                </div>
            </div>

        </section>
    </div>

    <%@include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html> 