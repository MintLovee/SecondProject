<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="util.PageInfo"%>
<%@ page import="javaBean.notice.NoticeBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<NoticeBean> noticeList = (ArrayList<NoticeBean>)request.getAttribute("noticeList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	int listCount=pageInfo.getListCount();
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
  padding-top: 15px;
  padding-bottom: 15px;
  font-weight: bold;
  vertical-align: top;
  color: #369;
  border-bottom: 3px solid #036;
  background: #f3f6f7;
}
td #name{
  padding-top: 15px;
  padding-bottom: 15px;
}
tbody td {
  width: 350px;
  padding: 10px;
  font-size: 0.9em;
  vertical-align: center;
  border-bottom: 1px solid #ccc;
}
tbody tr #num{width: 80px;}
tbody tr #title{width: 420px; text-align: left;}
tbody tr #name{width: 100px;}
tbody tr #date{width: 100px;}
#button{text-align: center;}
#writeButton{text-align: right;}
#pageList{margin: auto; width: 70%; text-align: center;}
#emptyArea{margin: auto; width: 70%; text-align: center;}
</style>

<title>캠핑카장</title>
</head>

<body>
<jsp:include page="header.jsp" flush="true"/>
	<br>
	<br>
	<div class="wrap">

		<div class="container">
	
	<section class="top">
	<h2>공지사항</h2>
	<p>도심을 벗어나 아름다운 자연환경 휴양시설을 갖춘 최적의 캠핑장, 캠핑카장입니다.</p>
	</section><br>
	<hr><br><br>
	
	<section class="middle">
	<div id="noticeList">
		<table class="noticeList">
		<thead>
		<% if (noticeList != null && listCount > 0) { %>
		<tr><th scope="row">번호</th>
			<th scope="row">제목</th>
			<th scope="row" width=20%>작성자</th>
			<th scope="row">등록일</th></tr>
		</thead>
		<tbody>
		<%	for (int i=0; i < noticeList.size(); i++) { %>
		<tr><td id="num"><%=noticeList.get(i).getNOTICE_NUM()%></td>
			<td id="title"><a title="상세보기" href="noticeDetail.camp?notice_num=<%=noticeList.get(i).getNOTICE_NUM()%>&page=<%=nowPage%>">
						<%=noticeList.get(i).getNOTICE_TITLE()%></a></td>
			<td id="name"><%=noticeList.get(i).getNOTICE_NAME()%></td>
			<td id="date"><%=noticeList.get(i).getNOTICE_DATE()%></td>
		</tr>	
		<%} %>
		</tbody>
		</table><br>
		
		<c:if test="${authUser.MEM_ID == 'admin'}">
		<div id="writeButton">
		<button class="btn btn-dark" type="button" onclick="location.href='noticeWriteForm.camp'">글쓰기</button>
		</div>
		</c:if>
	</div>
	
	<div id="pageList">
	<ul class="pagination pagination-sm justify-content-center">
	<% if(nowPage<=1 || nowPage<11){ %>
	<li class="page-item"><a title="이전" class="page-link" href="noticeList.camp?page=<%=nowPage-1%>"
		style="pointer-events: none; cursor: default; color: #000;">&#11164;</a></li>
	<% } else if(nowPage>=11) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="이전" class="page-link"
				href="noticeList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage-1 %>">&#11164;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="이전" class="page-link"
			  href="noticeList.camp?&page=<%=nowPage-1 %>">&#11164;</a>
		</c:if>
	<% } %>
					
	<% for(int a=startPage; a<=endPage;a++) {
		if(a==nowPage){ %>
	<li class="page-item"><a class="page-link" href="noticeList.camp?page=<%=a %>"
		style="pointer-events: none; cursor: default; color: #000;"><%=a %></a></li>
	<%} else { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a class="page-link"
				href="noticeList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=a %>"><%=a %></a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a class="page-link"
				href="noticeList.camp?page=<%=a %>"><%=a %></a>
		</c:if>
	<%} %>	
	<%} %>

	<% if (nowPage>=maxPage) { %>
	<li class="page-item"><a class="page-link" href="#"
		style="pointer-events: none; cursor: default; color: #000;">&#11166;</a></li>
	<% } else if ((nowPage+10)>=maxPage) { %>
		<c:if test = "${param.searchWord != null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="noticeList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=maxPage %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="noticeList.camp?page=<%=maxPage %>">&#11166;</a>
		</c:if>
	<%} else { %>
			<c:if test = "${param.searchWord != null}">
				<li class="page-item"><a title="다음" class="page-link"
					href="noticeList.camp?fieldName=${param.fieldName}&searchWord=${param.searchWord}&page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
		<c:if test = "${param.searchWord == null}">
			<li class="page-item"><a title="다음" class="page-link"
				href="managePageRez.camp?page=<%=nowPage+10 %>">&#11166;</a>
		</c:if>
	<%} %></ul><br><br>
			
	<form>
		<div class="form-row">
		<div class="form-group col-md-1"></div>
		<div class="form-group col-md-3">
			<select name="fieldName" id="fieldName" class="form-control">
    			<option ${(param.fieldName == "notice_title")? "selected" : ""} value = "notice_title">제목</option>
    			<option ${(param.fieldName == "notice_content")? "selected" : ""} value = "notice_content">내용</option>
			</select>
		</div>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" placeholder="Search" name="searchWord" value = "${param.searchWord}"/>
		</div>
		<div class="form-group col-md-1">
			<button class="btn btn-dark" type="submit">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				 fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
			</svg>
			</button>
		</div>
		<div class="form-group col-md-1"></div>
		</div>
	</form>
	</div>
	
<% } else { %>
<section id="emptyArea">등록된 글이 없습니다.</section><br>
<c:if test="${authUser.MEM_ID == 'admin'}">
	<div id="writeButton">
	<button class="btn btn-dark" type="button" onclick="location.href='noticeWriteForm.camp'">글쓰기</button>
	</div>
</c:if>
<c:if test="${authUser.MEM_ID != 'admin'}">
	<div id="button">
	<button class="btn btn-dark" type="button" onclick="history.back()">뒤로가기</button>
	</div>
</c:if>
<% } %>
</section>
</div>

<br>
<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>