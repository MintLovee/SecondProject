<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.product.ProductBean"%>
<%@ page import="javaBean.member.MemberBean" %>
<%@ page import="service.reservation.RezMgtInsertFormService" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   request.setCharacterEncoding("UTF-8");
   ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");
%>
<%
	int reCheck = 0;
	String reloadID = "";
	String reloadPnum = "";
	String reloadPrice = "";
	String reloadInDate = "";
	String reloadOutDate = "";
	String memName = "";
	String memTel = "";

	if (request.getAttribute("reloadID") != null && request.getAttribute("reloadID") != "") {
		reloadID = (String)request.getAttribute("reloadID");
		reloadPnum = (String)request.getAttribute("reloadPnum");
		reloadPrice = (String)request.getAttribute("reloadPrice");
		reloadInDate = (String)request.getAttribute("reloadInDate");
		reloadOutDate = (String)request.getAttribute("reloadOutDate");
		memName = (String)request.getAttribute("memName");
		memTel = (String)request.getAttribute("memTel");
		reCheck = 1;
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.0/themes/ui-lightness/jquery-ui.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/i18n/jquery-ui-i18n.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
$(function() {
	if (<%=reCheck%>==1) {
		$('#REZ_ID').val("<%=reloadID%>");
		$('#REZ_PNUM').val("<%=reloadPnum%>");
		$('#REZ_PRICE').val("<%=reloadPrice%>");
		$('#REZ_INDATE').val("<%=reloadInDate%>");
		$('#REZ_OUTDATE').val("<%=reloadOutDate%>");
		$('#REZ_NAME').val("<%=memName%>");
		$('#REZ_TEL').val("<%=memTel%>");
		$('#REZ_NAME2').val("<%=memName%>");
		$('#REZ_TEL2').val("<%=memTel%>");
	}
	var pNum = "";
	var inDate = "";
	var outDate = "";
	var pro = "";
	$('#REZ_PNUM').change(function(){
		$('#REZ_PRICE').val((this.options[this.selectedIndex].value).substr(4));
		$('#pSite').val(this.options[this.selectedIndex].value);
		pro = this.options[this.selectedIndex].text;
		pNum = pro.substr(0,3);
		$('#pNum').val(pNum);
	});
});
function idCheck(frm) {
	if ($('#REZ_ID').val() == "" || $('#REZ_ID').val() == null) {
		alert("아이디를 입력해주세요.");
		return false;
	} else {
		frm.action = "rezMgtInsertForm.camp";
		frm.submit();
		return true;
   	}
}
</script>

<style>
  h2 {text-align: center;}
  table{margin: auto;}
  tr{text-align: center;}
  #button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>

<form action="rezMgtInsert.camp" method="post" name="rezform">
   <div class="container">
   
   <section class="top">
   <h2>예약 정보 기재</h2>
   </section><br>
   <hr><br>
   
   <section class="writeForm">
   <table>
   <tr><td class="td_left"><label for="REZ_ID">아&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;디</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="REZ_ID" id="REZ_ID" required></td>
      <td>&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-outline-dark btn-sm" onclick="return idCheck(this.form);" value="아이디 체크"></td></tr>
   <tr>
      <td class="td_left"><label for="REZ_NAME">예&nbsp;약&nbsp;자&nbsp;명</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="REZ_NAME" id="REZ_NAME" required disabled></td></tr>
   <tr>
      <td class="td_left"><label for="REZ_TEL">연&nbsp;&nbsp;&nbsp;락&nbsp;&nbsp;&nbsp;처</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="REZ_TEL" id="REZ_TEL" required disabled></td></tr>
   <tr><c:if test="${!empty productList}" >
      <td class="td_left"><label for="REZ_PNUM">선&nbsp;택&nbsp;구&nbsp;역</label></td>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;<select name="REZ_PNUM" id="REZ_PNUM" style="width:185px;">
         <option value="">사이트 선택</option>
            <% for (int i = 0; i < productList.size(); i++) { %>
         <option value="<%=productList.get(i).getP_NUM()%>,<%=productList.get(i).getP_PRICE()%>"><%=productList.get(i).getP_NUM()%>(<%=productList.get(i).getP_NAME()%>)</option>
            <% } %>
         </select></td>
   </c:if></tr>
   <tr><td class="td_left"><label for="REZ_PRICE">금&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;액</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="REZ_PRICE" id="REZ_PRICE" required></td></tr>
   <tr><td class="td_left"><label for="REZ_INDATE">입&nbsp;&nbsp;&nbsp;실&nbsp;&nbsp;&nbsp;일</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="REZ_INDATE" id="REZ_INDATE" required></td>
   </tr>
   <tr><td class="td_left"><label for="REZ_OUTDATE">퇴&nbsp;&nbsp;&nbsp;실&nbsp;&nbsp;&nbsp;일</label></td>
      <td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="REZ_OUTDATE" id="REZ_OUTDATE" required></td>
   </tr></table><br><br>
   
   <div id="button">
	  <input type="hidden" name="pNum" id="pNum" value="">
	  <input type="hidden" name="pSite" id="pSite" value="">
	  <input type="hidden" name="REZ_NAME2" id="REZ_NAME2" value="">
	  <input type="hidden" name="REZ_TEL2" id="REZ_TEL2" value="">
      <button type="button" class="btn btn-dark pull-right" onclick="location.href='managePageRez.camp'">뒤로가기</button>&nbsp;&nbsp;
      <input type="submit" class="btn btn-dark" value="예약추가">
   </div>
   </section>
   
   </div>
</form>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>