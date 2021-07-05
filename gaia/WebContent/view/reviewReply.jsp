<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.review.ReviewBean"%>

<%
	ReviewBean article=(ReviewBean)request.getAttribute("article");
    String nowPage = (String)request.getAttribute("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MVC 게시판</title>
<script language="javascript">
	</script>
<style type="text/css">
#registForm {
	width: 500px;
	height: 610px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

table {
	margin: auto;
	width: 450px;
}

.td_left {
	width: 150px;
	background: #C0C0C0;
}

.td_right {
	width: 300px;
	background: #C0C0C0;
}

#commandCell {
	text-align: center;
}
</style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

	<section id="writeForm">
		<h2>후기글등록<%=article.getREV_NUM() %><%=article.getREV_RE_NUM() %></h2>
		<form action="reviewReplyPro.camp" method="post" name="boardform">
			<input type="hidden" name="page" value="<%=nowPage %>" /> <input
				type="hidden" name="REV_NUM" value="<%=article.getREV_NUM() %>">
			<input type="hidden" name="REV_RE_NUM"
				value="<%=article.getREV_RE_NUM() %>"> 
			<input type="hidden" name="REV_RE_DEPTH"
				value="<%=article.getREV_RE_DEPTH() %>">
			<input type="hidden" name="REV_ID" 
				value="${authUser.MEM_ID}" />
			<input type="hidden" name="REV_NAME" id="REV_NAME" 
				value="${authUser.MEM_NICKNAME}" readonly>	
			<table>
				<tr>
					<td class="td_left"><label for="REV_NAME">이름</label></td>
					<td class="td_right" colspan="3">${authUser.MEM_NICKNAME}</td>
				</tr>
				<tr>
					<td class="td_left"><label for="REV_SUBJECT">제 목</label></td>
					<td class="td_right"><input name="REV_SUBJECT" type="text"
						id="REV_SUBJECT" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="REV_OPTION"> 상품선택</label></td>
					<td class="td_right"><input name="REV_OPTION" type="text"
						id="REV_OPTION" required="required" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="REV_CONTENT">내 용</label></td>
					<td><textarea id="REV_CONTENT" name="REV_CONTENT"
							cols="40" rows="15"></textarea></td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" class="btn btn-dark" value="답변글등록" />&nbsp;&nbsp; 
				<input type="reset" class="btn btn-dark" value="다시작성" />
			</section>
		</form>
	</section>

<jsp:include page="footer.jsp" flush="true"/>	
</body>
</html>