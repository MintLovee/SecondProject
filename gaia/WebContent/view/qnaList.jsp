<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="util.PageInfo"%>
<%@ page import="javaBean.qna.QnaBean"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	ArrayList<QnaBean> articleList = (ArrayList<QnaBean>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	int listCount = pageInfo.getListCount();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
	padding-top: 15px;
	padding-bottom: 15px;
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

#emptyArea {
	text-align: center;
}

#writeButton {
	text-align: center;
}

.category {
	padding-left: 0;
	padding-right: 0;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<br>
	<br>

	<div class="wrap">

		<div class="container">
			<jsp:include page="faq.jsp" flush="true" />
			<div class="container">
				<div class="row">
					<table>
						<%
						if (articleList != null && listCount > 0) {
					%>
						<thead>
							<tr>
								<th scope="col" width=18%>분류</th>
								<th scope="col" width=2%></th>
								<th scope="col">제목</th>
								<th scope="col" width=18%>작성자</th>
								<th scope="col" width=18%>등록일</th>
							</tr>
						</thead>

						<%
							for (int i = 0; i < articleList.size(); i++) {
						%>
						<tbody>
							<tr>
								<td class="category"><%=articleList.get(i).getQNA_CATEGORY()%></td>
								<td style="padding-left: 0; padding-right: 0;">
									<%
										if (articleList.get(i).getQNA_SECRET() == 1)
													out.print("&#128274;");
									%>
								</td>
								<td style="text-align: left;">
									<%
										if (articleList.get(i).getQNA_RE_DEPTH() != 0) {
									%> <%
 	for (int a = 0; a <= articleList.get(i).getQNA_RE_DEPTH(); a++) {
 %> &nbsp; <%
 	}
 %>&#10551; &nbsp;<%
 	} else {
 %> <%
 	}
 %> <a title="상세보기"
									href="qnaDetail.camp?qna_num=<%=articleList.get(i).getQNA_NUM()%>&page=<%=nowPage%>">

										<%=articleList.get(i).getQNA_SUBJECT()%>

								</a>
								</td>

								<td>
									<%
										String name = articleList.get(i).getQNA_NAME();
										StringBuffer sb = new StringBuffer();
												if (!name.equals("관리자")) {
													sb.append(name);
													sb.replace(1, 2, "*");
													
												} else{	sb.append("관리자"); }
												
										out.print(sb);
									%>

								</td>
								<td><%=articleList.get(i).getQNA_DATE()%></td>

							</tr>

						</tbody>
						<%
							}
						%>
						<tfoot>
							<tr>
								<td><br></td>
							</tr>
							<c:if test="${authUser.MEM_ID != 'admin'}">
								<tr>
									<c:choose>
										<c:when
											test="${authUser.MEM_ID != null && authUser.MEM_ID != 'admin'}">
											<%
												if (request.getParameter("QNA_ID") == null && request.getParameter("searchWord") == null) {
											%>
											<td colspan="3" align="left"><button
													class="btn btn-outline-dark"
													onclick="location.href='qnaList.camp?fieldName=qna_id&searchWord=${authUser.MEM_ID}'">내
													문의현황</button></td>
											<%
												} else {
											%>
											<td colspan="3"></td>
											<%
												}
											%>
										</c:when>
										<c:otherwise>

										</c:otherwise>
									</c:choose>
									<td colspan="5" align="right"><button type="button"
											onclick="location.href='qnaWriteForm.camp'"
											class="btn btn-dark">글쓰기</button></td>
								</tr>
							</c:if>
						</tfoot>

					</table>
				</div>
				<br>
				<div id="pageList" align="center">
					<ul class="pagination pagination-sm justify-content-center">
						<%
							if (nowPage <= 1 || nowPage < 11) {
						%>

						<li class="page-item"><a title="이전" class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>

						<%
							} else if (nowPage >= 11) {
						%>
						<c:if test="${param.searchWord != null}">
							<li class="page-item"><a title="이전" class="page-link"
								href="qnaList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage-10 %>">&#11164;</a></li>
						</c:if>
						<c:if test="${param.searchWord == null}">
							<li class="page-item"><a title="이전" class="page-link"
								href="qnaList.camp?&page=<%=nowPage - 10%>">&#11164;</a></li>
						</c:if>
						<%
							}
						%>

						<%
							for (int a = startPage; a <= endPage; a++) {
									if (a == nowPage) {
						%>
						<li class="page-item"><a class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;"><%=a%></a></li>
						<%
							} else {
						%>
						<c:if test="${param.searchWord != null}">
							<li class="page-item"><a class="page-link"
								href="qnaList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=a %>"><%=a%></a></li>
						</c:if>
						<c:if test="${param.searchWord == null}">
							<li class="page-item"><a class="page-link"
								href="qnaList.camp?page=<%=a%>"><%=a%></a></li>
						</c:if>
						<%
							}
						%>
						<%
							}
						%>

						<%
							if (nowPage >= maxPage) {
						%>
						<li class="page-item"><a title="다음" class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
						<%
							} else if ((nowPage + 10) >= maxPage) {
						%>
						<c:if test="${param.searchWord != null}">
							<li class="page-item"><a title="다음" class="page-link"
								href="qnaList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=maxPage %>">&#11166;</a></li>
						</c:if>
						<c:if test="${param.searchWord == null}">
							<li class="page-item"><a title="다음" class="page-link"
								href="qnaList.camp?page=<%=maxPage%>">&#11166;</a></li>
						</c:if>
						<%
							} else {
						%>
						<c:if test="${param.searchWord != null}">
							<li class="page-item"><a title="다음" class="page-link"
								href="qnaList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage+10 %>">&#11166;</a></li>
						</c:if>
						<c:if test="${param.searchWord == null}">
							<li class="page-item"><a title="다음" class="page-link"
								href="qnaList.camp?page=<%=nowPage + 10%>">&#11166;</a></li>
						</c:if>
						<%
							}
						%>
					</ul>
				</div>

				<c:if test="${authUser.MEM_ID == 'admin'}">
					<br>
					<hr>
					<form>
						<div class="form-row">
							<div class="form-group col-md-2"></div>
							<div class="form-group col-md-2">
								<select name="fieldName" id="fieldName" class="form-control">
									<option ${(param.fieldName == "qna_id")? "selected" : ""}
										value="qna_id">아이디</option>
									<option ${(param.fieldName == "qna_name")? "selected" : ""}
										value="qna_name">이름</option>
									<option ${(param.fieldName == "qna_subject")? "selected" : ""}
										value="qna_subject">제목</option>
									<option ${(param.fieldName == "qna_content")? "selected" : ""}
										value="qna_content">내용</option>
								</select>
							</div>
							<div class="form-group col-md-5">
								<input type="text" class="form-control" placeholder="Search"
									name="searchWord" value="${param.searchWord}" />
							</div>
							<div class="form-group col-md-1">
								<button type="submit" class="btn btn-dark">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  							<path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
						</svg>
								</button>
							</div>
							<div class="form-group col-md-2"></div>
						</div>

					</form>
				</c:if>
			</div>
			<%
				} else {
			%>
			</table>
		</div>
		<div class="col">
			<div style="text-align: center;">
				<br><br><br><br> 등록된 글이 없습니다.
			</div>
			<br><br><br><br><br><br>

			<button type="button" style="float: right;"
				onclick="location.href='qnaWriteForm.camp'" class="btn btn-dark">글쓰기</button>
			<br> <br> <br>
		</div>
	</div>
	</div>
	<%
			}
		%>

	</div>
	<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>
</html>