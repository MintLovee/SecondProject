<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.member.MemberBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="javaBean.reservation.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
	MemberBean memberInfo = (MemberBean) request.getAttribute("memberInfo");
	ArrayList<ReservationListBean> rezList = (ArrayList<ReservationListBean>) request.getAttribute("rezList");
	int rezListCount = (Integer)request.getAttribute("rezListCount");
	int limit = 0;
	if (request.getParameter("limit") != null) {
		limit = Integer.parseInt(request.getParameter("limit"));
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

function addRezList() {
	<%if (request.getParameter("limit") == null) {%>
		location.href="?limit=6";
	<%} else {%>
	location.href="?limit=<%=Integer.parseInt(request.getParameter("limit"))+3%>";
	<%}%>
}

function check() {
	if (confirm("정말 예약을 취소하시겠습니까?") == true) {
	} else {
		return false;
	}
}
</script>
<script type="text/javascript">
	function changeForm(val) {
		if (val == "-1") {
			location.href = "index.jsp";
		} else if (val == "0") {
			location.href = "MainForm.jsp?contentPage=member/view/ModifyForm.jsp";
		} else if (val == "1") {
			location.href = "MainForm.jsp?contentPage=member/view/DeleteForm.jsp";
		}
	}
</script>

<style>
.top{text-align: center;}
.top p{font-size: 0.8em; color: gray;}
.middle p{font-weight: bold; color: #369;}
.middle p:after {
  content: "";
  display: block;
  width: 150px;
  border-bottom: 3.5px solid #036;
  margin: 10px 0px;
}
.bottom p{font-weight: bold; color: #369;}
.bottom p:after {
  content: "";
  display: block;
  width: 150px;
  border-bottom: 3.5px solid #036;
  margin: 10px 0px;
}

table{margin: auto;}
tr{text-align: center;}
.td_right input{width:392px;}

.rezListTable {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  line-height: 1.5;
  font-size: 0.8em;
}
.rezListTable td {
  width: 350px;
  padding: 10px;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
thead th {
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 1px solid #036;
  background: #f3f6f7;
}

form {display:inline}
#button {text-align: center;}
#addButton {text-align: center;}
#addListButton {text-align: center;}
#addListButton button {width: 300px;}
#emptyArea{margin: auto; width: 70%; text-align: center;}

</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
<div class="wrap">
	<div class="container">
	
		<section class="top">
		<h2>내 정보</h2>
		<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
		</section><br>
		<hr><br><br>
		
		<section class="middle">
		<div id="myInfo">
			
			<form action="modify.camp" name="myPage.camp" method="POST">
			
			<div style="max-width: 600px; margin: 0 auto;">
			<p>&nbsp;&nbsp;내 정보</p><br>
	  			<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label" >아이디</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" name="MEM_ID" id="ID" value="<%=memberInfo.getMEM_ID()%>" disabled>
    				</div>
  				</div>
   				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">이름</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder="" name="MEM_NAME" value="<%=memberInfo.getMEM_NAME()%>" disabled>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">생년월일</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder=""  value="<%=memberInfo.getMEM_JUMIN()%>" disabled>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">연락처</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder=""  value="<%=memberInfo.getMEM_TEL()%>" disabled>
    				</div>
  				</div>
  				<div class="form-group row">
    				<label for="colFormLabel" class="col-sm-2 col-form-label">주소</label>
    				<div class="col-sm-10">
      					<input type="text" class="form-control" id="colFormLabel" placeholder=""  value="<%=memberInfo.getMEM_ADDR()%>" disabled>
    				</div>
  				</div>
			</div>
			
	
				<br><br>
					
				<div id="button">
				<input type="submit" class="btn btn-dark" value="정보수정">&nbsp;
				<input type="button" class="btn btn-dark" value="내 문의현황" onclick="location.href='qnaList.camp?fieldName=qna_id&searchWord=${authUser.MEM_ID}'">&nbsp;
				<input type="button" class="btn btn-dark" value="회원탈퇴" onclick="location.href='memberUserDelete.camp'">
				</div>
			</form>
		</div><br><br>
		</section>
		<br><br>
		<section class="bottom">
		<div style="max-width: 600px; margin: 0 auto;">
			<p>&nbsp;&nbsp;내 예약정보</p><br>
			
			<% if (rezList != null && rezList.size() >0) { %>
			
			<% for (int i = 0; i < rezList.size(); i++) { %>
			<table class="table table-bordered">
				<tr>
					<th scope="row">예약번호</th>
					<td><%=rezList.get(i).getREZ_NUM()%></td>
				</tr>
				<tr>
					<th scope="row">상품번호</th>
					<td><%=rezList.get(i).getREZ_PNUM()%></td>
				</tr>
				<tr>
					<th scope="row">이용기간</th>
					<td><%=rezList.get(i).getREZ_INDATE()%> ~ <%=rezList.get(i).getREZ_OUTDATE()%></td>
				</tr>
				<tr>
					<th scope="row">이용일수</th>
					<td><%=rezList.get(i).getREZ_DIFFDAYS()%></td>
				</tr>
				<tr>
					<th scope="row">가격(일)</th>
					<c:set var="price" value="<%=rezList.get(i).getREZ_PRICE()%>" />
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${price}" /></td>
				</tr>
				<tr>
					<th scope="row">합계</th>
					<c:set var="total" value="<%=rezList.get(i).getREZ_TOTAL()%>" />
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}" /></td>
				</tr>
				
				<c:set var="today" value="<%=new java.util.Date()%>"/>
				<fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd"/>
				<fmt:parseDate var="nowD" value="${now}" pattern="yyyyMMdd"/>
				<fmt:parseNumber value="${nowD.time / (1000*60*60*24)}" integerOnly="true" var="numNow"></fmt:parseNumber>
				
				<c:set var="rezday" value="<%=rezList.get(i).getREZ_INDATE()%>"/>
				<fmt:formatDate var="rezDate" value="${rezday}" pattern="yyyyMMdd"/>
				<fmt:parseDate var="rezD" value="${rezDate}" pattern="yyyyMMdd"/>
				<fmt:parseNumber value="${rezD.time / (1000*60*60*24)}" integerOnly="true" var="numRezDate"></fmt:parseNumber>
				
				<c:if test="${numNow - numRezDate < 0}">
				<tr>
					<th scope="row">예약취소</th>
					<td><form action="/gaia/rezDelete.camp" name="rezDelete" method="POST" onsubmit="return check();">
					<input name="rez_num" type="hidden" value="<%=rezList.get(i).getREZ_NUM()%>"/>
					<input id="cancle" type="submit" class="btn btn-danger" value="예약취소"/>
				</form></td>
				</c:if>
				<%} %>
			</table>
			<br>
				<% if (rezListCount > limit && rezListCount > 3){ %>
				<div id="addListButton">
				<button type="button" class="btn btn-outline-dark" onclick="addRezList()">예약내역 더 보기</button>
				</div>
				<% } %>
			<% } else { %>
			<section id="emptyArea">예약 내역이 없습니다.</section><br>
			<div id="addButton">
			<button type="button" class="btn btn-outline-dark" onclick="location.href='rezList.camp'">지금 예약하러 가기</button>		
			</div>
			<% } %>
			
			
		</div>
		</section>
	</div>

<br>
<jsp:include page="footer.jsp" flush="true" />
</div>
</body>
</html>