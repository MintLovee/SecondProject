<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QnaBean article = (QnaBean) request.getAttribute("article");
	String nowPage = (String) request.getAttribute("page");
	if(nowPage == null) nowPage="1";
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

	<script type="text/javascript">
		window.onload = function() {
			var input = document.getElementById("QNA_CONTENT").focus();
		}
	</script>

	<form action="qnaReplyPro.camp" method="post" name="boardform">
		<div class="container">
			<div class="row">
			<c:if test="${authUser.MEM_ID == null}">
				<script>
					alert("로그인이 필요합니다.");
					history.go(-1);
				</script>
			</c:if>
				<input type="hidden" name="page" value="<%=nowPage%>" /> <input
					type="hidden" name="QNA_NUM" value="<%=article.getQNA_NUM()%>">
				<input type="hidden" name="QNA_ID" value="<%=article.getQNA_ID()%>">
				<input type="hidden" name="QNA_RE_NUM"
					value="<%=article.getQNA_RE_NUM()%>"> <input type="hidden"
					name="QNA_RE_DEPTH" value="<%=article.getQNA_RE_DEPTH()%>">
				<input type="hidden" name="QNA_SECRET"
					value="<%=article.getQNA_SECRET()%>"> <input type="hidden"
					name="QNA_NAME" value="관리자">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th scope="row" colspan="4"
								style="background-color: #eeeeee; text-align: center;">답변
								등록하기</th>
						</tr>
					</thead>

					<tr>
						<td class="td_left"><label for="QNA_SUBJECT">제 목</label></td>
						<td class="td_right"><input name="QNA_SUBJECT"
							class="form-control" type="text" id="QNA_SUBJECT"
							value="Re: <%=article.getQNA_SUBJECT()%>" /></td>
					</tr>
					<tr>
						<td class="td_left"><label for="QNA_CONTENT">내 용</label></td>
						<td><textarea id="QNA_CONTENT" class="form-control"
								name="QNA_CONTENT" style="height: 350px; resize: none;">



>> <%=article.getQNA_CONTENT()%></textarea></td>
					</tr>
				</table>
				<div class="col text-center">
					<button type="button" class="btn btn-outline-dark" onclick="history.go(-1);">뒤로가기</button>&nbsp;&nbsp;
					<input type="submit" class="btn btn-dark" value="답변등록">
				</div>

			</div>
		</div>
	</form>
	
	<br>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>