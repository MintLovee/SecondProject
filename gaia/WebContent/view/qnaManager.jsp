<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="util.PageInfo"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ page import="java.util.*"%>
<%@ page import="service.qna.QnaManagerService"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	ArrayList<QnaBean> managerList = new ArrayList<QnaBean>();
	QnaManagerService managerListService = new QnaManagerService();
	managerList = managerListService.getManagerList();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
h2 {
	text-align: center;
}

#qnaListButton form {
	display: inline;
}

#qnaListButton {
	text-align: right;
}

.qnaListTable {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
}

.qnaListTable th {
	padding: 9px;
	font-weight: bold;
	vertical-align: center;
	border-bottom: 1px solid #ccc;
	background: #f3f6f7;
}

.qnaListTable td {
	padding: 9px;
	vertical-align: center;
	border-bottom: 1px solid #ccc;
}

#emptyArea {
	margin: auto;
	width: 70%;
	text-align: center;
}
</style>

</head>
<body>
<div class="wrap">
	<div class="container">
		<h2>문의내역</h2>
		<br>

		<div id="qnaListButton">
			<input type="submit" class="btn btn-info" value="새로고침"
				onClick="location.href='managePageQna.camp'" />
		</div>
		<br>

		<div id="qnaListTable">
				<%
					if (managerList.size() > 0) {
				%>
			<table class="qnaListTable">
				<tr id="tr_top">
					<th scope="col" width=10%>분류</th>
					<th scope="col" width=5%></th>
					<th scope="col">제목</th>
					<th scope="col" width=10%>아이디</th>
					<th scope="col" width=10%>이름</th>
					<th scope="col" width=10%>작성일</th>
					<th scope="col" width=10%>답변</th>
				</tr>

				<%
					for (int i = 0; i < managerList.size(); i++) {
				%>
				<tr>
					<td><%=managerList.get(i).getQNA_CATEGORY()%></td>
					<td>
						<%
							if (managerList.get(i).getQNA_SECRET() == 1)
										out.print("&#128274;");
						%>
					</td>
					<td style="text-align: left;">
						<%
							if (managerList.get(i).getQNA_RE_DEPTH() != 0) {
						%> <%
 	for (int a = 0; a <= managerList.get(i).getQNA_RE_DEPTH(); a++) {
 %>
						&nbsp; <%
 	}
 %>&#10551; &nbsp;<%
 	} else {
 %> <%
 	}
 %> <a
						href="qnaDetail.camp?qna_num=<%=managerList.get(i).getQNA_NUM()%>">
							<%=managerList.get(i).getQNA_SUBJECT()%></a>
					</td>
					<td><%=managerList.get(i).getQNA_ID()%></td>
					<td><%=managerList.get(i).getQNA_NAME()%></td>
					<td><%=managerList.get(i).getQNA_DATE()%></td>
					<td><a
						href="qnaReplyForm.camp?qna_num=<%=managerList.get(i).getQNA_NUM()%>"
						target="_blank" class="text-dark"><button type="button"
								class="btn btn-outline-dark btn-sm">답변하기</button></a></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<br>
		<br>
		<%
			} else {
		%>
		<section id="emptyArea" style="text-align: center">
			답변이 모두 완료되었습니다.<br>
			<br>
		</section>
		<% }%>

	</div>
</body>
</html>