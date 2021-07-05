<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.reservation.*"%>
<%@ page import="service.reservation.RezMgtListService" %>
<%@ page import="java.util.*"%>
<%@ page import="util.MyCalendar"%>
<%@ page import="util.PageInfo"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="javaBean.product.ProductBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
 ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");

%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
h2{text-align: center;}
#rezListButton form{display: inline;}
#rezListButton{text-align: right;}
	
.rezListTable {
  width: 100%;
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
}
.rezListTable th {
  padding: 9px;
  font-weight: bold;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
  background: #f3f6f7;
}
.rezListTable td {
  padding: 9px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}

.rezInfo{cursor: pointer;}
.clearfix{clear: both;}
#rezPage{margin: auto; width: 70%; text-align: center;}
#emptyArea{margin: auto; width: 70%; text-align: center;}
</style>



<script>
$(function() {
	if (window.location.pathname != "/gaia/managePagePro.camp") {
		location.href="managePagePro.camp";
	}
	$('.rezInfo').click(function() {
		$('.rezInfo').css("background-color", "transparent");
		selectTr = $(this);
		selectTd = selectTr.children();
		rezNum = selectTd.eq(0).text();
		$('#rezNumA').val(rezNum);
		$('#rezNumB').val(rezNum);
		$('#'+rezNum).css("background-color", "#FFFFDE");
	});
});
function check() {
	if ($('#rezNumB').val() == "") {
		alert("삭제할 항목을 선택해주세요.");
		return false;
	} else if($('#rezNumB').val() != "") {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			alert("삭제 완료되었습니다.");
		} else {
			return false;
 		}
	}
}
function lcSubmit() {
	if ($('#rezNumB').val() == "") {
		alert("수정할 항목을 선택해주세요.");
		return false;
	}
  }
</script>

<title>예약관리</title>
</head>

<body>

<div class="container">
	
	<section class="rezList" class="col-xs-12">
	<h2>상품 관리</h2><br>
	
	<div id="rezListButton">
		<button type="button" class="btn btn-dark" onClick="location.href='productForm.camp'">상품추가</button>
		<form action="/gaia/productUpdateForm.camp" method="POST" onsubmit="return lcSubmit();">
		<input type="hidden" id="rezNumA" name="P_NUM"/>
		<input type="submit" class="btn btn-dark" id="mgtUpdateBt" value="상품수정"/>
		</form>
		<form action="/gaia/productDelete.camp" method="POST" onsubmit="return check();">
		<input type="hidden" id="rezNumB" name="P_NUM"/>
		<input type="submit" class="btn btn-dark" id="P_NUM" value="상품삭제"/>
		</form>
	</div>
	<div class="clearfix"></div><br>
	
	<div id="rezListTable">
		<table class="rezListTable">
		<tr id="tr_top">
		<th scope="col">번 호</th>
		<th scope="col" width=6%>이 름</th>
		<th scope="col" width=9%>가 격</th>
		<th scope="col">인 원</th>
		<th scope="col">특이사항 및 물품</th>
		<th scope="col">공 지</th>
		<th scope="col" style="width: 10%;">메인사진</th>
		</tr>
		
		<% for (int i = 0; i <productList.size() ; i++) {%>
		<tr id=<%=productList.get(i).getP_NUM()%> class="rezInfo">
		<td style="width: 4.5%;"><%=productList.get(i).getP_NUM() %></td>
		<td><%=productList.get(i).getP_NAME() %></td>
		<c:set var="price" value="<%= productList.get(i).getP_PRICE()%>"/>
		<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${price}"/>원</td>
		<td><%=productList.get(i).getP_SERVICE() %></td>
		<td><%=productList.get(i).getP_NOTES() %></td>
		<td><%=productList.get(i).getP_MORE_INFO()%></td>
		<td><img title="사이트 사진" alt="캠핑카장 사이트 메인 사진" class="img-responsive" src="<%= productList.get(i).getP_IMG() %>" width="80%"></td>
		</tr>
		<% }%>
		</table>
	</div><br>
</div>

</body>
</html>