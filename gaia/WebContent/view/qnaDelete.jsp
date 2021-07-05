<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QnaBean article = (QnaBean)request.getAttribute("article");
	String qna_subject = article.getQNA_SUBJECT();
	int qna_re_num = article.getQNA_RE_NUM();
	int qna_re_depth = article.getQNA_RE_DEPTH();
	int qna_num=(Integer)request.getAttribute("qna_num");
    String nowPage = (String)request.getAttribute("page");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<br>
	<br>
<form name="deleteForm" action="qnaDeletePro.camp?qna_num=<%=qna_num %>" method="post">
	<div class="container" style="max-width: 500px">
		<div class="col"></div>
			<c:if test="${authUser.MEM_ID == null}">
				<script>
					alert("로그인이 필요합니다.");
					location.href='qnaList.camp?page=<%=nowPage%>';
				</script>
			</c:if>
		<div class="col">
			<div class="jumbotron" style="padding-top: 60px;">
				
					<input type = "hidden" name = "page" value = "<%=nowPage %>"/>
					<input type = "hidden" name = "qna_re_num" value = "<%=qna_re_num %>"/>
					<input type = "hidden" name = "qna_re_depth" value = "<%=qna_re_depth %>"/>
					
					<h3 style="text-align: center;">
					<% out.print(qna_subject); %><br><br>
					삭제하시겠습니까?</h3><br><br>
					<div align="center">
						<button class="btn btn-outline-info" type="button" onclick="history.go(-1);">뒤로가기</button>
						<input type="submit" class="btn btn-info" value="삭제하기">
					</div>
				
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</form>
<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>