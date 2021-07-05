<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.product.ProductBean"%>     
<%@ page import="javaBean.reservation.ReservationBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	ProductBean productInfo = (ProductBean)request.getAttribute("productInfo");
	ReservationBean reservationInfo = (ReservationBean)request.getAttribute("reservationInfo");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}

table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
}
thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
}
tbody th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
  background: #f3f6f7;
}
td {
  width: 350px;
  padding: 10px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}

#button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
<div class="wrap">
<div class="container">
	
	<section class="top">
	<h2>예약 내용 확인</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br>

	<section class="middle">
	<div id="rezInfo">
		<table class="resInfo">
		<thead>
		<tr><th scope="row" colspan="2">예약 완료</th></tr>
		</thead>
		<tbody>
		<tr><th scope="row">예약 번호</th><td><%=reservationInfo.getREZ_NUM()%></td></tr>
		<tr><th scope="row">예약자 명</th><td><%=reservationInfo.getREZ_NICKNAME()%></td></tr>
		<tr><th scope="row">연락처</th><td><%=reservationInfo.getREZ_TEL()%></td></tr>		
		<tr><th scope="row">선택 구역</th><td><%=request.getParameter("p_name")%>(<%=reservationInfo.getREZ_PNUM()%>)</td></tr>
		<tr><th scope="row">이용 기간</th><td><%=reservationInfo.getREZ_INDATE()%> ~ <%=reservationInfo.getREZ_OUTDATE()%> (<%=request.getParameter("diff")%>)</td></tr>
		<c:set var="total" value="<%=reservationInfo.getREZ_TOTAL()%>"/>
		<tr><th scope="row">결제 금액</th><td><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}"/>원</td></tr>
		</tbody>
		</table>
	</div>
	</section><br>
</div>
	
	<div id="button">
		<button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}'">메인으로</button>&nbsp;&nbsp;
		<button type="button" class="btn btn-dark" onclick="location.href='myPage.camp'">예약확인</button>
	</div>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>