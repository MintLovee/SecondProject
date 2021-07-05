<%@ page import="javaBean.review.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	ReviewBean article = (ReviewBean)request.getAttribute("article");
	String nowPage = (String) request.getAttribute("page");
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
  text-align: center;
  line-height: 1.5;
}
thead th {
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
  background: #f3f6f7;
}
tbody td {
  width: 200px;
  padding: 10px;
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody td.td_left {font-weight: bold;}

#NOTICE_CONTENT{height: 350px; resize: none;}
#button{text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
<br><br>
<div class="container">

	<section class="top">
	<h2>이용후기</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>

	<section id = "writeForm">
		<form action="reviewModifyPro.camp" method="post" name = "modifyform">
			<input type="hidden" name="page" value="<%=nowPage%>"/>
			<input type="hidden" name="REV_NUM" value = "<%=article.getREV_NUM()%>"/>
			<input type="hidden" name="REV_ID" value="${authUser.MEM_ID}" />
			<input type="hidden" name="REV_NAME" id="REV_NAME" value="${authUser.MEM_NICKNAME}" readonly>
			<table>
			<tr>
				<td class="td_left" style="width: 20%;"><label for="REV_NAME">이름</label></td>
				<td class="td_right" colspan="3" align="left">${authUser.MEM_NICKNAME}</td>
			</tr>
			<tr>
				<td class="td_left" style="width: 20%;"><label for = "REV_OPTION">상품선택</label></td>
				<td class="td_right" colspan="3" align="left">${article.getREV_OPTION()}</td>
			</tr>
			<tr>
				<td class="td_left" style="width: 20%;"><label for = "REV_SUBJECT">제 목</label></td>
				<td class="td_right" colspan="3" align="left"><input name="REV_SUBJECT" style="width: 90%" type="text" id="REV_SUBJECT" value="<%=article.getREV_SUBJECT()%>"/></td>
			</tr>
			<tr><td class="td_left" style="width: 20%;"><label for = "REV_CONTENT">내 용</label></td>
				<td class="td_right" colspan="3" align="left"><textarea id = "REV_CONTENT" class="form-control" style="width: 90%" rows="10" name="REV_CONTENT" cols="40" rows="15"><%=article.getREV_CONTENT()%></textarea></td>
			</tr>
			</table><br>
				
			<div id="button">
				<button type="button" class="btn btn-outline-dark" onclick="history.go(-1);">뒤로가기</button>&nbsp;&nbsp;
				<input type="submit" class="btn btn-dark" value="수정완료">
			</div>
		</form>
	</section>
</div>
<br>
 <jsp:include page="footer.jsp" flush="true"/>
</body>
</html>