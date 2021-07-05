<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javaBean.review.ReviewBean"%>
<%@ page import="javaBean.review.CommentBean"%>
<%@ page import="javaBean.auth.AuthBean" %>
<%@ page import="util.PageInfo"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	ReviewBean article = (ReviewBean) request.getAttribute("article");
	String revNum = (String) request.getParameter("rev_num");
	String nowListPage = (String) request.getParameter("page");
	ArrayList<CommentBean> articleList = (ArrayList<CommentBean>) request.getAttribute("comment");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int nowPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	AuthBean cib = (AuthBean)session.getAttribute("authUser");
	String comId = "";
	if (cib != null) {
		comId = cib.getMEM_ID(); 
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script>
	function check() {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			
		} else {
			return false;
		}
	}
</script>

<style>
.td_commentDelete{padding-left: 20px; text-align: left;}
.top {
   text-align: center;
}

.top p {
   font-size: 0.8em;
   color: gray;
}

#reviewView {
   width: 100%;
   border-collapse: collapse;
   text-align: center;
   line-height: 1.5;
}

#reviewView th {
   padding: 15px;
   font-weight: bold;
   vertical-align: top;
   color: #369;
   border-bottom: 3px solid #036;
   background: #f3f6f7;
}

#reviewView p {
   font-size: 0.8em;
   color: gray;
}

#reviewView td {
   width: 350px;
   padding: 10px;
   font-size: 0.9em;
   vertical-align: center;
   border-bottom: 1px solid #ccc;
}

#reviewView .td_left {
   font-weight: bold;
}

#reviewView .td_content {
   padding: 20px;
   text-align: left;
}

#reviewView #td_image {
   border-bottom: 0px;
}

.comment1 {
   display: inline;
}

.fontSizeUp {
   font-size: 1.2em;
}

#commentMain {
   text-align: left;
}


#commentView .td_commentName {
   
   text-align: left;
   white-space: pre;
   font-weight: bold;
   padding: 0 20px;
}

#commentView .td_commentContent{
   padding: 0 20px;
}
#commentView .td_commentDate {
   
   text-align: left;
   white-space: pre;
   color: #aaa;
   font-size: 0.8em;
   padding: 0 20px;
}

#commentBox {
   padding: 10px 10px 10px 30px;
   border: 0;
}

#RE_CONTENT {
   width: 100%;
   overflow: visible;
   resize: none;
}

#commentBtn {
   vertical-align: middle;
   padding-left: 10px;	
}

.td_reCommentName {
   text-align: left;
   white-space: pre;
   font-weight: bold;
}

.commentForm p {
   font-weight: bold;
   color: #369;
}

#commendList {
   margin: auto;
   width: 200x;
   text-align: center;
}

#adminButton {
   text-align: right;
}

#commentButton {
   text-align: right;
}

#commentBox p {
   font-weight: bold;
   color: #369;
}
img{ width:100%; max-width:600px; }
</style>

<title>캠핑카장</title>
</head>

<body>
	<jsp:include page="header.jsp" flush="true" />
	<br>
	<br>

	<section class="top">
		<h2>고객후기</h2>
		<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section>
	<br>
	<hr>
	<br>
	<br>

	<div class="container">
		<section id="review">
			<div id="reviewDetail">
				<table id="reviewView">
					<thead>
						<tr>
							<th scope="row" colspan="4"><%=article.getREV_SUBJECT()%></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="td_left">작성자</td>
							<td class="td_right">
								<%
									String revname = article.getREV_NAME();
									revname = revname.trim();
									StringBuffer sb = new StringBuffer();
									if (!revname.equals("관리자")) {
										sb.append(revname);
										sb.replace(1, 2, "*");
										
									} else{	sb.append("관리자"); }
									
								out.print(sb);
								%></td>
							<td class="td_left">등록일</td>
							<td class="td_right"><%=article.getREV_DATE()%></td>
						</tr>
						<tr>
							<td id="td_image" class="td_content" colspan="4">
							<%
									if (!(article.getREV_FILE() == null)) {
								%> <img src="<%=article.getREV_FILE()%>" title="고객 후기 사진"
								alt="캠핑카장 이용고객의 후기 사진"> <%
 									} else {
 									%><br>
								<p>첨부된 사진이 없습니다.</p> <%
 									}
									 %>
							</td>
						</tr>
						<tr>
							<td colspan="4" style="min-height: 350px; white-space: pre;"><textarea
									name="REV_CONTENT" class="form-control" id="REV_CONTENT"
									style="border: 0; resize: none; background-color: #fff;"
									readonly><%=article.getREV_CONTENT()%></textarea></td>
							<script>
								var textarea = $("#REV_CONTENT");
								if (textarea) {
									textarea.each(function() {
										$(this).height(this.scrollHeight);
									});
								}
							</script>
						</tr>
					</tbody>
				</table>
				<br>

				<section id="commendList">
					<c:if
						test="${authUser.MEM_ID == 'admin' && authUser.MEM_ID != article.REV_ID}">
						<div id="adminButton">
							<form action="/gaia/reviewDelete.camp" method="POST"
								onsubmit="return check();">
								<input type="hidden" id="page" name="page" value="<%=nowPage%>" />
								<input type="hidden" id="rev_num" name="rev_num" 
									value="<%=article.getREV_NUM()%>" /> <input type="submit"
									class="btn btn-outline-dark" id="revDeleteBt" value="삭제" />&nbsp;&nbsp;
							<button type="button" class="btn btn-dark"
								onclick="location.href='reviewList.camp?page=<%=nowPage%>'">목록</button>
							</form>
						</div>
					</c:if>

					<c:if test="${authUser.MEM_ID == article.REV_ID }">

						   
						
						 <form action="/gaia/reviewDelete.camp" method="POST"
							onsubmit="return check();">
							<input type="hidden" id="page" name="page" value="<%=nowPage%>" />
							<input type="hidden" id="rev_num" name="rev_num"
								value="<%=article.getREV_NUM()%>" /> <input type="submit"
								class="btn btn-outline-dark" id="revDeleteBt" value="삭제" />&nbsp;&nbsp;
						<button type="button" class="btn btn-outline-dark"
							onclick="location.href='reviewModify.camp?rev_num=<%=article.getREV_NUM()%>&page=<%=nowListPage%>'">수정</button>&nbsp;&nbsp;		
						<button type="button" class="btn btn-dark"
							onclick="location.href='reviewList.camp?page=<%=nowPage%>'">목록</button>
						</form>

					</c:if>

					<c:if
						test="${authUser.MEM_ID != article.REV_ID && authUser.MEM_ID != 'admin'}">
						<button type="button" class="btn btn-dark"
							onclick="location.href='reviewList.camp?page=<%=nowPage%>'">목록</button>
					</c:if>
				</section>
				<br>
			</div>
		</section>
		<br>

		<section class="commentForm">
			<div id="commentMain">
				<p class="comment1 fontSizeUp">댓글&nbsp;&nbsp;</p>
			</div>
			<div>
				<hr>
				<%
					if (articleList != null && listCount > 0) {
				%>
				<%
					for (int i = 0; i < articleList.size(); i++) {

							String name = articleList.get(i).getRE_NICKNAME();
							name = name.trim();
							StringBuffer sbb = new StringBuffer();
							if (!name.equals("관리자")) {
								sbb.append(name);
								sbb.replace(1, 2, "*");
								
							} else{	sbb.append("관리자"); }
							
							name = sbb.toString();
				%>
				<div id="comment">
					<table id="commentView">
						<tbody>
							<tr>
								<td class="td_left td_commentName"><%=name%></td>
							</tr>
							<tr>
								<td class="td_right td_commentContent"><%=articleList.get(i).getRE_CONTENT()%></td>
							</tr>
							<tr>
								<td class="td_right td_commentDate"><%=articleList.get(i).getRE_DATE()%></td>
							</tr>
						
					<tr><td class="td_right td_commentDelete">
					<% if (articleList.get(i).getRE_ID().equals(comId) || comId.equals("admin")) { %>
		         	<a href="commentDeletePro.camp?re_num=<%=articleList.get(i).getRE_NUM()%>&rev_num=<%=revNum%>&page=<%=nowListPage%>">[삭제] </a>
		         	<%} %>
		         	</td></tr>
		         	</tbody>
					</table>
					<hr>
					<%
						}
					%>
				</div>

				<div id="pageList">
					<ul class="pagination justify-content-center">
						<%
							if (nowPage <= 1 || nowPage < 11) {
						%>
						<li class="page-item"><a class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>
						<%
							} else if (nowPage >= 11) {
						%>
						<li class="page-item"><a class="page-link"
							href="reviewDetail.camp?rev_num=<%=article.getREV_NUM()%>&page=<%=nowPage - 1%>&listPage=<%=request.getParameter("listPage")%>">&#11164;</a>
							<%
								}
							%> <%
 	for (int a = startPage; a <= endPage; a++) {
 			if (a == nowPage) {
 %>
						<li class="page-item"><a class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;"><%=a%></a></li>
						<%
							} else {
						%>
						<li class="page-item"><a class="page-link"
							href="reviewDetail.camp?rev_num=<%=article.getREV_NUM()%>&page=<%=a%>&listPage=<%=request.getParameter("listPage")%>"><%=a%></a>
							<%
								}
							%> <%
 	}
 %> <%
 	if (nowPage >= maxPage) {
 %>
						<li class="page-item"><a class="page-link" href="#"
							style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
						<%
							} else if ((nowPage + 10) >= maxPage) {
						%>
						<li class="page-item"><a class="page-link"
							href="reviewDetail.camp?rev_num=<%=article.getREV_NUM()%>&page=<%=maxPage%>&listPage=<%=request.getParameter("listPage")%>">&#11166;</a>
							<%
								} else {
							%>
						<li class="page-item"><a class="page-link"
							href="reviewDetail.camp?rev_num=<%=article.getREV_NUM()%>&page=<%=nowPage + 10%>&listPage=<%=request.getParameter("listPage")%>">&#11166;</a>
							<%
								}
							%> <%
 	} else {
 %>
					</ul>
					<section id="emptyArea">등록된 댓글이 없습니다.</section>
					<hr>
					<br>
					<%
						}
					%>
				</div>
				<div id="commentBox">
					<c:if test="${empty authUser}">
						<div class="commentBox2">
							<form action="reviewReplyPro.camp" method="post"
								name="commentForm" class="commentForm">
								<input type="hidden" name="page" value="<%=nowPage%>" /> <input
									type="hidden" name="listPage"
									value="<%=request.getParameter("listPage")%>" /> <input
									type="hidden" name="RE_PT_NUM"
									value="<%=article.getREV_NUM()%>">
								<table class="cTable">
									<tr>
										<td class="td_right td_reCommentName" colspan="2" align="left"></td>
									</tr>
									<tr>
										<td><textarea rows="2" cols="150" class="form-control"
												name="RE_CONTENT" id="RE_CONTENT"
												placeholder="*댓글은 로그인 후 등록 가능합니다." readonly></textarea></td>
										<td id="commentBtn"><button type="button"
												class="btn btn-dark" style="white-space: nowrap;"
												onclick="location.href='login.camp'">로그인</button></td>
									</tr>
								</table>
							</form>
						</div>
					</c:if>
					<c:if test="${!empty authUser}">
						<div class="commentBox2">
							<form action="reviewReplyPro.camp" method="post"
								name="commentForm" class="commentForm">
								<input type="hidden" name="page" value="<%=nowPage%>" /> <input
									type="hidden" name="listPage"
									value="<%=request.getParameter("listPage")%>" /> <input
									type="hidden" name="RE_PT_NUM"
									value="<%=article.getREV_NUM()%>">
								<table class="cTable">
									<tr>
										<td class="td_right td_reCommentName" colspan="2" align="left">${authUser.MEM_NICKNAME}</td>
									</tr>
									<tr>
										<td><textarea rows="2" cols="150" class="form-control"
												name="RE_CONTENT" id="RE_CONTENT" placeholder="내용을 입력하세요."
												required></textarea></td>
										<td id="commentBtn"><input type="submit"
											class="btn btn-dark" value="댓글등록" /></td>
									</tr>
								</table>
							</form>
						</div>
						<br>
					</c:if>
				</div>
			</div>
		</section>
		<br>


	</div>
	<br>
	<br>



	<br>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>