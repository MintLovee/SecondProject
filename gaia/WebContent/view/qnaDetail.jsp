<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QnaBean article = (QnaBean) request.getAttribute("article");
	String nowPage = (String) request.getAttribute("page");
	Object isReply = request.getAttribute("isreply");
	if (nowPage == null)
		nowPage = "1";
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<script>

function check() {
	if (confirm("정말 삭제하시겠습니까?") == true) {
	} else {
		return false;
 	}
}
</script>
<style>
.top {
	text-align: center;
}

.top p {
	font-size: 0.8em;
	color: gray;
}

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
	width: 350px;
	padding: 10px;
	font-size: 0.9em;
	vertical-align: center;
	border-bottom: 1px solid #ccc;
}

tbody td.td_left {
	font-weight: bold;
}

tbody td.td_content {
	padding: 50px;
	text-align: left;
	white-space: pre;
}

form {
	display: inline;
}

#button {
	text-align: center;
}
</style>

</head>
<body>

	<jsp:include page="header.jsp" flush="true" />
	<br>
	<br>
	<div class="wrap">

		<div class="container">
			<section class="top">
				<h2>문의하기</h2>
				<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
			</section>
			<br>
			<hr>
			<br> <br>
			<div class="row">


				<c:if
					test="${article.QNA_SECRET == 1 && authUser.MEM_ID != article.QNA_ID && authUser.MEM_ID != 'admin'}">
					<script>
					alert("비공개 게시글입니다.");
					location.href='qnaList.camp?page=<%=nowPage%>';
					</script>
				</c:if>

				<table>
					<thead>
						<tr>
							<th scope="col" colspan="4">
								<%
									if (article.getQNA_SECRET() == 1)
										out.print("&#128274;");
								%> <%=article.getQNA_SUBJECT()%>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="td_left" colspan="1" style="width: 20%">
							<label for="QNA_NAME">작성자</label></td>
							<td class="td_right" colspan="1">
								<%
									String name = article.getQNA_NAME();
									StringBuffer sb = new StringBuffer();
									if (!name.equals("관리자")) {
										sb.append(name);
										sb.replace(1, 2, "*");
										
									} else{	sb.append("관리자"); }
									
									out.print(sb);
								%>
							</td>
							<td class="td_left" colspan="1" style="width: 20%">등록일</td>
							<td class="td_right" colspan="1"><%=article.getQNA_DATE()%></td>
						</tr>
						<tr style="text-align: left; min-height: 350px;">
							<td colspan="4" style="min-height: 350px; white-space:pre;"><textarea name="QNA_CONTENT" class="form-control" id="QNA_CONTENT" style="border: 0; resize: none; background-color: #fff;" readonly><%=article.getQNA_CONTENT() %></textarea></td>
								<script>
    								var textarea = $("#QNA_CONTENT");
    								if (textarea) {
        								textarea.each(function(){
            							$(this).height(this.scrollHeight);
        								});
    								}
								</script>
							

						</tr>
					</tbody>

				</table>
				<br>
				<div class="col text-center">
					<br>
					<c:if test="${authUser.MEM_ID == 'admin'}">
						<%
							if (isReply.equals(false)) {
						%>
						<c:if test="${article.QNA_RE_DEPTH == 0}">
							<button class="btn btn-outline-dark" type="button"
								onclick="location.href='qnaReplyForm.camp?qna_num=<%=article.getQNA_NUM()%>&page=<%=nowPage%>'">답변</button>
						</c:if>
						<%	} %>
						<%
							if (isReply.equals(true)) {
						%>
						<button class="btn btn-outline-dark" type="button" disabled />답변완료</button>&nbsp;
						<%
							}
						%>
						<c:if test="${article.QNA_RE_DEPTH == 1}">
							<button class="btn btn-outline-dark" type="button"
								onclick="location.href='qnaModifyForm.camp?qna_num=<%=article.getQNA_NUM()%>&page=<%=nowPage%>'">수정</button>
						</c:if>&nbsp;&nbsp;
						<form action="qnaDeletePro.camp" method="POST"
							onsubmit="return check();">
							<input type="hidden" id="page" name="page" value="<%=nowPage%>" />
							<input type="hidden" id="qna_num" name="qna_num"
								value="<%=article.getQNA_NUM()%>" /> <input type="hidden"
								id="qna_re_num" name="qna_re_num"
								value="<%=article.getQNA_RE_NUM()%>" /> <input type="hidden"
								id="qna_re_depth" name="qna_re_depth"
								value="<%=article.getQNA_RE_DEPTH()%>" /> <input type="submit"
								class="btn btn-outline-dark" value="삭제" />
						</form>&nbsp;&nbsp;
						<button class="btn btn-dark" type="button"
							onclick="location.href='qnaList.camp?page=<%=nowPage%>'">목록</button>

					</c:if>
					<c:if
						test="${authUser.MEM_ID == article.QNA_ID && authUser.MEM_ID != 'admin'}">

						<c:if test="${article.QNA_RE_DEPTH == 0}">
							<button class="btn btn-outline-dark" type="button"
								onclick="location.href='qnaModifyForm.camp?qna_num=<%=article.getQNA_NUM()%>&page=<%=nowPage%>'">수정</button>
							<form action="qnaDeletePro.camp" method="POST"
								onsubmit="return check();">
								<input type="hidden" id="page" name="page" value="<%=nowPage%>" />
								<input type="hidden" id="qna_num" name="qna_num"
									value="<%=article.getQNA_NUM()%>" /> <input type="hidden"
									id="qna_re_num" name="qna_re_num"
									value="<%=article.getQNA_RE_NUM()%>" /> <input type="hidden"
									id="qna_re_depth" name="qna_re_depth"
									value="<%=article.getQNA_RE_DEPTH()%>" /> <input type="submit"
									class="btn btn-outline-dark" value="삭제" />
							</form>
						</c:if>
						<button class="btn btn-dark" type="button"
							onclick="location.href='qnaList.camp?page=<%=nowPage%>'">목록</button>
							
					</c:if>
					<c:if
						test="${authUser.MEM_ID != article.QNA_ID && authUser.MEM_ID != 'admin'}">

						<button class="btn btn-dark" type="button"
							onclick="location.href='qnaList.camp?page=<%=nowPage%>'">목록</button>

					</c:if>
					<br><br>
				</div>
				<script>
					function list_click() {
						location.href = 'history.go(-2)';
						location.reload();
					}
				</script>



			</div>

		</div>
		<jsp:include page="footer.jsp" flush="true" />

	</div>
</body>
</html>