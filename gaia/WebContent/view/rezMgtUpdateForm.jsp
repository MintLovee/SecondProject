<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.reservation.ReservationListBean"%>
<%@ page import="javaBean.product.ProductBean"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	ReservationListBean rezListOne = (ReservationListBean)request.getAttribute("rezListOne");
    ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");
    String pNumPrice = (String)request.getAttribute("pNumPrice");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function() {
	$("#rez_pNum").val("<%=pNumPrice%>");
	$('#rez_pNum').change(function(){
		$('#rez_price').val((this.options[this.selectedIndex].value).substr(4));
		pro = this.options[this.selectedIndex].text;
		pNum = pro.substr(0,3);
		$('#pNum').val(pNum);
	});
});
</script>
<style>
  h2 {text-align: center;}
  table{margin: auto;}
  tr{text-align: center;}
  #button{text-align: center;}
</style>
<title>예약 수정</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>

<form action="rezMgtUpdateSuccess.camp" name="updateForm" method="POST"">
	<div class="container">
	
	<section class="top">
	<h2>예약 정보 수정</h2>
	</section><br>
	<hr><br>
	
	<section class="modifyForm">
	<table>
		<tr><td class="td_left"><label for="rez_num"></label>예&nbsp;약&nbsp;번&nbsp;호</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="rez_num" id="rez_num" value="<%=rezListOne.getREZ_NUM()%>" disabled></td></tr>
		<tr><td class="td_left"><label for="rez_id"></label>아&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;디</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="rez_id" id="rez_id" value="<%=rezListOne.getREZ_ID()%>" disabled></td></tr>
		<tr><td class="td_left"><label for="rez_name"></label>예&nbsp;약&nbsp;자&nbsp;명</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="rez_name" id="rez_name" value="<%=rezListOne.getREZ_NAME()%>" disabled></td></tr>
		<tr><td class="td_left"><label for="rez_tel"></label>연&nbsp;&nbsp;&nbsp;락&nbsp;&nbsp;&nbsp;처</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="rez_tel" id="rez_tel" value="<%=rezListOne.getREZ_TEL()%>"></td></tr>
		<tr><td class="td_left"><label for="rez_pNum"></label>예&nbsp;약&nbsp;구&nbsp;역</td>
			<c:if test="${!empty productList}" >
			<td class="td_right">&nbsp;&nbsp;&nbsp;
				<select name="rez_pNum" id="rez_pNum" style="width:185px;">
	      		<% for (int i = 0; i < productList.size(); i++) { %>
					<option value="<%=productList.get(i).getP_NUM()%>,<%=productList.get(i).getP_PRICE()%>"><%=productList.get(i).getP_NUM()%>(<%=productList.get(i).getP_NAME()%>)</option>
	      		<% } %>
			</select></td>
			</c:if></tr>
		<tr><td class="td_left"><label for="rez_inDate"></label>입&nbsp;&nbsp;&nbsp;실&nbsp;&nbsp;&nbsp;일</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="rez_inDate" id="rez_inDate" value="<%=rezListOne.getREZ_INDATE()%>"></td></tr>
		<tr><td class="td_left"><label for="rez_outDate"></label>퇴&nbsp;&nbsp;&nbsp;실&nbsp;&nbsp;&nbsp;일</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="rez_outDate" id="rez_outDate" value="<%=rezListOne.getREZ_OUTDATE()%>"></td></tr>
		<tr><td class="td_left"><label for="rez_price"></label>금&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;액</td>
			<td class="td_right">&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="rez_price" id="rez_price" value="<%= rezListOne.getREZ_PRICE()%>" disabled></td></tr>		
	</table><br>
	
	<div id="button">
	<input type="hidden" name="pNum" id="pNum" value="">
	<input type="hidden" name="rezNum" value="<%= rezListOne.getREZ_NUM()%>"/>
	<input type="submit" class="btn btn-dark" value="수정하기"/>
	<input type="button" class="btn btn-dark" value="뒤로가기" onclick="location.href='managePageRez.camp'"/>
	</div>
	</section>
	
	</div>
</form>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>