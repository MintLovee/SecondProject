<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	QnaBean article = (QnaBean) request.getAttribute("article");
	String nowPage = (String) request.getAttribute("page");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

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
	width: 200px;
	padding: 10px;
	font-size: 0.9em;
	vertical-align: center;
	border-bottom: 1px solid #ccc;
}

tbody td.td_left {
	font-weight: bold;
	padding-left: 0px;
	padding-right: 0px;
}

#NOTICE_CONTENT {
	height: 350px;
	resize: none;
}

#button {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<br><br>

	<script type="text/javascript">
		function modifyboard() {
			modifyform.submit();
		}
	</script>
	<div class="wrap">

		<div class="container">
			<form action="qnaModifyPro.camp" method="post" name="modifyform">
				<section class="top">
					<h2>문의사항</h2>
					<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
				</section>
				<br>
				<hr>
				<br>
				<br>
				<div class="row">
					<c:if test="${authUser.MEM_ID == null}">
						<script>
					alert("로그인이 필요합니다.");
					location.href='qnaList.camp?page=<%=nowPage%>';
						</script>
					</c:if>
					<input type="hidden" name="page" value="<%=nowPage%>" /> <input
						type="hidden" name="QNA_NUM" value="<%=article.getQNA_NUM()%>">
					<input type="hidden" name="QNA_RE_NUM"
						value="<%=article.getQNA_RE_NUM()%>"> <input type="hidden"
						name="QNA_NAME" id="QNA_NAME" value="<%=article.getQNA_NAME()%>"
						readonly />
					<table>
						<thead>
							<tr>
								<th scope="col" colspan="4">글 수정</th>
							</tr>
						</thead>
						<tr>
							<td class="td_left" colspan="1" style="width: 18%"><label for="QNA_NAME">작성자</label>
							</td>
							<td class="td_right" align="left" colspan="3"><%=article.getQNA_NAME()%>
							</td>
						</tr>
						<tr>
							<td class="td_left" colspan="1"><label for="QNA_CATEGORY">카테고리</label></td>
							<td class="td_right" colspan="1" style="max-width: 18%"><select name="QNA_CATEGORY"
								id="QNA_CATEGORY" class="form-control">
									<option ${(article.QNA_CATEGORY == "")? "selected" : ""}
										value="">분류선택</option>
									<option ${(article.QNA_CATEGORY == "예약관련")? "selected" : ""}
										value="예약관련">예약관련</option>
									<option ${(article.QNA_CATEGORY == "결제관련")? "selected" : ""}
										value="결제관련">결제관련</option>
									<option ${(article.QNA_CATEGORY == "기타")? "selected" : ""}
										value="기타">기타</option>
							</select></td>
							<td class="td_left" colspan="1" style="width: 18%"><label for="QNA_SECRET">공개여부</label></td>
							<td class="td_right" colspan="1" align="left" style="padding-right: 0"><input
								type="radio" id="QNA_SECRET" name="QNA_SECRET" value="0"
								${(article.QNA_SECRET == 0)? "checked" : ""}><label>&nbsp;공개</label>&nbsp;&nbsp;
								<input type="radio" id="QNA_SECRET" name="QNA_SECRET" value="1"
								${(article.QNA_SECRET == 1)? "checked" : ""}><label>&nbsp;비공개</label>
							</td>
						</tr>
						<tr>
							<td class="td_left" colspan="1"><label for="QNA_SUBJECT">제목</label></td>
							<td class="td_right" colspan="3"><input name="QNA_SUBJECT"
								class="form-control" type="text" id="QNA_SUBJECT"
								value="<%=article.getQNA_SUBJECT()%>" /></td>
						</tr>
						<tr>
							<td class="td_left" colspan="1"><label for="QNA_CONTENT">내용</label></td>
							<td colspan="3"><textarea id="QNA_CONTENT"
									class="form-control" name="QNA_CONTENT"
									style="height: 350px; resize: none;"><%=article.getQNA_CONTENT()%></textarea>
							</td>
						</tr>
					</table>

					<div class="col text-center">
						<br>
						<button type="button" class="btn btn-outline-dark" onclick="history.go(-1);">뒤로가기</button>&nbsp;&nbsp;
						<input type="submit" class="btn btn-dark pull-right" value="수정완료">
					</div>


				</div>

			</form>
		</div>
		<br>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>